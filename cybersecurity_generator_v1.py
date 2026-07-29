#!/usr/bin/env python3
# freelancing_generator_v2.py
#
# Hustle Academy - Freelancing Course Generator (v2, Textbook Mode)
# =====================================================================
#
# MAJOR upgrade over the previous generator family. Adds:
#   - YAML front matter detection/skip, with a "title:" fallback when
#     the source document has no "#" heading at all.
#   - "##" as the lesson boundary; "###"/"####" are subsections that
#     merge naturally into the enclosing lesson instead of becoming
#     separate lessons.
#   - Aggressive repository-junk removal (GitHub/README/install/dev-
#     ops language, usernames, badges, licenses, etc.)
#   - An OPTIONAL textbook-rewrite stage that calls the Anthropic API
#     to turn cleaned source material into real, simple-English
#     teaching content for beginner/African/Nigerian learners, with
#     Hustle Academic callouts and a references section - because that
#     kind of rewriting requires actual language understanding, which
#     no regex pipeline can honestly provide. If no API key is set (or
#     the call fails for any reason), the generator falls back to the
#     cleaned-but-unrewritten text rather than crashing or fabricating
#     content.
#   - The same bulletproof base64 Dart string encoding + structural
#     validation + optional `dart analyze` pass as prior versions, so
#     the generated Dart can never fail to compile.
#
# Python 3 standard library only. Runs in Termux with:
#     python3 freelancing_generator_v2.py
#
# Optional environment variable:
#     ANTHROPIC_API_KEY   - if set, enables real textbook rewriting.

from __future__ import annotations

import base64
import json
import os
import re
import shutil
import subprocess
import sys
import tempfile
import time
import unicodedata
import urllib.error
import urllib.request
from pathlib import Path

# =============================================================================
# CONFIG
# =============================================================================

SOURCE_FILE = Path("cybersecurity/latest")
OUTPUT_FILE = Path("lib/courses/cybersecurity_courses.dart")

DART_VARIABLE_NAME = "cybersecurityCourses"

INSTRUCTOR = "Hustle Academy"
CATEGORY = "Cyber Security"
DIFFICULTY = "Beginner"
ICON = "Icons.security"
COLOR = "Colors.red"

# The in-lesson branding phrase requested ("Hustle Academic Tip" etc.)
# is deliberately kept separate from INSTRUCTOR above.
BRAND_NAME = "Hustle Academic"

WORDS_PER_MINUTE = 200
MIN_DURATION_MINUTES = 5

MAX_LESSON_WORDS = 700
MIN_LESSON_WORDS = 20
MAX_CLEAN_PASSES = 3

# Anthropic API config for the optional textbook-rewrite stage.
ANTHROPIC_API_URL = "https://api.anthropic.com/v1/messages"
ANTHROPIC_MODEL = "claude-sonnet-4-6"
ANTHROPIC_MAX_TOKENS = 2000
ANTHROPIC_TIMEOUT_SECONDS = 90
ANTHROPIC_REQUEST_DELAY_SECONDS = 0.5  # be polite between calls

# =============================================================================
# SECTION / LINE JUNK RULES
# =============================================================================

SKIP_SECTION_KEYWORDS = [
    "dedication",
    "praise",
    "contents",
    "table of contents",
    "introduction to this repository",
    "the author",
    "using this book",
    "acknowledg",
    "license",
    "licence",
    "changelog",
    "credits",
    "contributors",
    "contributor guide",
    "contributing",
    "appendix",
    "bibliography",
    "footnotes",
    "faq",
    "code of conduct",
    "security policy",
    "security",
    "readme",
    "installation instructions",
    "developer instructions",
    "maintenance notes",
    "repository navigation",
]

REPO_JUNK_LINE_PATTERNS = [
    r"\bgit\s+clone\b",
    r"\bgit\s+pull\b",
    r"\bgit\s+push\b",
    r"\bgit\s+commit\b",
    r"\bnpm\s+install\b",
    r"\byarn\s+install\b",
    r"\bpip\d?\s+install\b",
    r"\bsudo\s+apt\b",
    r"\bbrew\s+install\b",
    r"\bdocker\s+(run|build|compose)\b",
    r"\bmake\s+(install|build)\b",
    r"\bfork\s+this\s+(repo|repository|project)\b",
    r"\bclone\s+the\s+repo(sitory)?\b",
    r"\bopen\s+(a\s+)?(github|readme)\b",
    r"\bpull\s+request\b",
    r"\bsearch\s+this\s+repo(sitory)?\b",
    r"\bsearch\s+the\s+repo(sitory)?\b",
    r"\bstar\s+this\s+repo(sitory)?\b",
    r"\bwatch\s+this\s+repo(sitory)?\b",
    r"\bissue\s*#\d+\b",
    r"\bpr\s*#\d+\b",
    r"\bcommit\s+[0-9a-f]{7,40}\b",
    r"\b(main|master|dev|develop)\s+branch\b",
    r"^\s*adapted from\b",
    r"^\s*see also\b",
    r"^\s*read more\b",
    r"^\s*learn more\b",
    r"\bnavigate to\b",
    r"\bclick here\b",
    r"\bscreenshot\b",
    r"\bnumber of stars\b",
    r"\brepository\b",
    r"\bgithub\.com\b",
    r"\bfollow (us|me) on\b",
    r"\btwitter\b",
    r"\blinkedin\b",
    r"\binstagram\b",
]
REPO_JUNK_LINE_RE = re.compile("|".join(REPO_JUNK_LINE_PATTERNS), re.IGNORECASE)

GITHUB_USERNAME_RE = re.compile(r"(?<!\w)@[A-Za-z0-9][A-Za-z0-9-]{0,38}(?!\w)")
SHELL_PROMPT_LINE_RE = re.compile(r"^\s*\$\s+\S")

URL_RE = re.compile(
    r"(https?://\S+|www\.\S+|\b[a-zA-Z0-9.-]+\.(?:com|org|net|io|dev)\S*)",
    re.IGNORECASE,
)
BADGE_LINE_RE = re.compile(r"shields\.io|badge\.fury\.io|travis-ci|circleci|codecov", re.IGNORECASE)

HEADING_RE = re.compile(r"^(#{1,4})\s+(.*?)\s*$")
CODE_FENCE_RE = re.compile(r"```[ \t]*[a-zA-Z0-9_+-]*\n(.*?)```", re.DOTALL)
IMAGE_MD_RE = re.compile(r"!\[[^\]]*\]\([^)]*\)")
MD_LINK_RE = re.compile(r"\[([^\]]*)\]\([^)]*\)")
HTML_TAG_RE = re.compile(r"</?[a-zA-Z][^<>]*>")
INLINE_CODE_RE = re.compile(r"`([^`\n]+)`")
BOLD_RE = re.compile(r"\*\*([^*\n]+)\*\*|__([^_\n]+)__")
ITALIC_RE = re.compile(r"(?<!\*)\*([^*\n]+)\*(?!\*)|(?<!_)_([^_\n]+)_(?!_)")
HR_LINE_RE = re.compile(r"^\s*([-_*])\1{2,}\s*$")
FOOTNOTE_MARK_RE = re.compile(r"\[\^[^\]]+\]")
LEADING_HASHES_RE = re.compile(r"^\s*#{1,6}\s*")
TRIPLE_QUOTE_RE = re.compile(r'"{2,}')
BULLET_MARKER_RE = re.compile(r"^\s*[-*+]\s+")
NON_SLUG_CHARS_RE = re.compile(r"[^a-z0-9\-]+")
MULTI_DASH_RE = re.compile(r"-{2,}")
MULTI_SPACE_RE = re.compile(r"[ \t]{2,}")
MULTI_BLANK_LINE_RE = re.compile(r"\n{3,}")

FRONT_MATTER_RE = re.compile(r"^---\s*\n(.*?)\n---\s*\n?", re.DOTALL)
FRONT_MATTER_TITLE_RE = re.compile(r"^\s*title\s*:\s*(.+?)\s*$", re.MULTILINE)


# =============================================================================
# DATA STRUCTURES
# =============================================================================

class Lesson:
    __slots__ = ("title", "body", "code_snippet", "has_image")

    def __init__(self, title: str, body: str, code_snippet, has_image: bool):
        self.title = title
        self.body = body
        self.code_snippet = code_snippet
        self.has_image = has_image


class Course:
    __slots__ = ("course_id", "title", "description", "duration", "lessons")

    def __init__(self, title: str, course_id: str):
        self.title = title
        self.course_id = course_id
        self.description = ""
        self.duration = ""
        self.lessons: list[Lesson] = []


class _RawLesson:
    __slots__ = ("title", "body_lines")

    def __init__(self, title: str):
        self.title = title
        self.body_lines: list[str] = []

    def raw_body(self) -> str:
        return "\n".join(self.body_lines).strip("\n")


class _RawCourse:
    __slots__ = ("title", "course_id", "lessons")

    def __init__(self, title: str, course_id: str):
        self.title = title
        self.course_id = course_id
        self.lessons: list[_RawLesson] = []


# =============================================================================
# BASIC HELPERS
# =============================================================================

def is_skip_heading(text: str) -> bool:
    normalized = text.strip().lower()
    for keyword in SKIP_SECTION_KEYWORDS:
        if keyword in normalized:
            return True
    return False


def slugify(text: str) -> str:
    normalized = unicodedata.normalize("NFKD", text)
    ascii_text = normalized.encode("ascii", "ignore").decode("ascii")
    lowered = ascii_text.lower()
    lowered = lowered.replace("_", "-").replace(" ", "-")
    lowered = NON_SLUG_CHARS_RE.sub("-", lowered)
    lowered = MULTI_DASH_RE.sub("-", lowered)
    lowered = lowered.strip("-")
    return lowered or "course"


def humanize_filename(path: Path) -> str:
    stem = path.stem.replace("_", " ").replace("-", " ")
    stem = MULTI_SPACE_RE.sub(" ", stem).strip()
    words = stem.split(" ")
    return " ".join(w[:1].upper() + w[1:] if w else w for w in words) or "Untitled Course"


def detect_has_image(raw_text: str) -> bool:
    if IMAGE_MD_RE.search(raw_text):
        return True
    if re.search(r"<img\b", raw_text, re.IGNORECASE):
        return True
    return False


def extract_and_strip_code_fences(raw_text: str):
    matches = list(CODE_FENCE_RE.finditer(raw_text))
    first_snippet = None
    if matches:
        snippet = matches[0].group(1).strip("\n")
        if snippet.strip():
            first_snippet = snippet
    cleaned = CODE_FENCE_RE.sub("", raw_text)
    return cleaned, first_snippet


# =============================================================================
# YAML FRONT MATTER
# =============================================================================

def strip_front_matter(markdown_text: str):
    """
    Detects a leading YAML front matter block (--- ... ---), removes it
    entirely from the document, and returns (remaining_text, title_or_None)
    where title_or_None is the value of a "title:" key inside it, if any.
    """
    match = FRONT_MATTER_RE.match(markdown_text)
    if not match:
        return markdown_text, None

    front_matter_block = match.group(1)
    remaining_text = markdown_text[match.end():]

    title = None
    title_match = FRONT_MATTER_TITLE_RE.search(front_matter_block)
    if title_match:
        raw_title = title_match.group(1).strip()
        # Strip surrounding quotes if present ("Title" or 'Title').
        if len(raw_title) >= 2 and raw_title[0] == raw_title[-1] and raw_title[0] in "\"'":
            raw_title = raw_title[1:-1].strip()
        if raw_title:
            title = raw_title

    return remaining_text, title


# =============================================================================
# CLEANING PIPELINE
# =============================================================================

def clean_line_level_junk(text: str) -> str:
    out_lines = []
    for line in text.split("\n"):
        stripped = line.strip()
        if not stripped:
            out_lines.append("")
            continue
        if HR_LINE_RE.match(stripped):
            continue
        if BADGE_LINE_RE.search(stripped):
            continue
        if IMAGE_MD_RE.fullmatch(stripped):
            continue
        if SHELL_PROMPT_LINE_RE.match(stripped):
            continue
        if REPO_JUNK_LINE_RE.search(stripped):
            continue
        out_lines.append(line)
    return "\n".join(out_lines)


def strip_markdown_syntax(text: str) -> str:
    cleaned = text

    cleaned = IMAGE_MD_RE.sub("", cleaned)
    cleaned = MD_LINK_RE.sub(r"\1", cleaned)
    cleaned = FOOTNOTE_MARK_RE.sub("", cleaned)
    cleaned = HTML_TAG_RE.sub("", cleaned)
    cleaned = URL_RE.sub("", cleaned)
    cleaned = GITHUB_USERNAME_RE.sub("", cleaned)
    cleaned = INLINE_CODE_RE.sub(r"\1", cleaned)

    def _unwrap_bold(m):
        return m.group(1) if m.group(1) is not None else m.group(2)

    def _unwrap_italic(m):
        return m.group(1) if m.group(1) is not None else m.group(2)

    cleaned = BOLD_RE.sub(_unwrap_bold, cleaned)
    cleaned = ITALIC_RE.sub(_unwrap_italic, cleaned)
    cleaned = cleaned.replace("`", "")
    cleaned = "\n".join(LEADING_HASHES_RE.sub("", line) for line in cleaned.split("\n"))

    out_lines = []
    for line in cleaned.split("\n"):
        if BULLET_MARKER_RE.match(line):
            content = BULLET_MARKER_RE.sub("", line).strip()
            out_lines.append(f"- {content}" if content else "")
        else:
            out_lines.append(line)
    cleaned = "\n".join(out_lines)

    cleaned = TRIPLE_QUOTE_RE.sub("", cleaned)
    return cleaned


def normalize_whitespace(text: str) -> str:
    lines = [MULTI_SPACE_RE.sub(" ", line.rstrip()) for line in text.split("\n")]
    joined = "\n".join(lines)
    joined = MULTI_BLANK_LINE_RE.sub("\n\n", joined)
    return joined.strip("\n")


def clean_lesson_body(raw_text: str) -> str:
    text, _ = extract_and_strip_code_fences(raw_text)
    text = clean_line_level_junk(text)
    text = strip_markdown_syntax(text)
    text = normalize_whitespace(text)
    return text


MARKDOWN_LEFTOVER_RE = re.compile(r"(\*\*|__|```|^\s*#{1,6}\s|~~~)", re.MULTILINE)


def find_quality_issues(text: str) -> list[str]:
    issues = []
    if URL_RE.search(text):
        issues.append("contains a URL")
    if HTML_TAG_RE.search(text):
        issues.append("contains raw HTML")
    if MARKDOWN_LEFTOVER_RE.search(text):
        issues.append("contains leftover markdown syntax")
    if "`" in text:
        issues.append("contains a stray backtick")
    if TRIPLE_QUOTE_RE.search(text):
        issues.append("contains a broken/triple quote sequence")
    if REPO_JUNK_LINE_RE.search(text):
        issues.append("contains repository/GitHub instruction language")
    if GITHUB_USERNAME_RE.search(text):
        issues.append("contains a GitHub-style username")
    word_count = len(text.split())
    if word_count > MAX_LESSON_WORDS:
        issues.append(f"exceeds max lesson word count ({word_count} > {MAX_LESSON_WORDS})")
    return issues


def force_strip_remaining_issues(text: str) -> str:
    text = URL_RE.sub("", text)
    text = HTML_TAG_RE.sub("", text)
    text = GITHUB_USERNAME_RE.sub("", text)
    text = re.sub(r"\*\*|__|```|~~~", "", text)
    text = re.sub(r"^\s*#{1,6}\s*", "", text, flags=re.MULTILINE)
    text = text.replace("`", "")
    text = TRIPLE_QUOTE_RE.sub("", text)
    lines = [ln for ln in text.split("\n") if not REPO_JUNK_LINE_RE.search(ln)]
    text = "\n".join(lines)
    return normalize_whitespace(text)


def clean_until_valid(raw_text: str) -> tuple[str, bool]:
    text = clean_lesson_body(raw_text)
    forced = False

    for _ in range(MAX_CLEAN_PASSES):
        issues = [i for i in find_quality_issues(text) if "word count" not in i]
        if not issues:
            return text, forced
        text = clean_lesson_body(text)

    issues = [i for i in find_quality_issues(text) if "word count" not in i]
    if issues:
        text = force_strip_remaining_issues(text)
        forced = True

    return text, forced


# =============================================================================
# LESSON SPLITTING (word-count limit)
# =============================================================================

def split_lesson_if_needed(title: str, body: str, code_snippet, has_image: bool) -> "list[Lesson]":
    word_count = len(body.split())
    if word_count <= MAX_LESSON_WORDS:
        return [Lesson(title, body, code_snippet, has_image)]

    paragraphs = [p for p in body.split("\n\n") if p.strip()]
    chunks: list[str] = []
    current_words: list[str] = []

    for paragraph in paragraphs:
        paragraph_words = paragraph.split()
        if len(current_words) + len(paragraph_words) > MAX_LESSON_WORDS and current_words:
            chunks.append(" ".join(current_words))
            current_words = []
        if len(paragraph_words) > MAX_LESSON_WORDS:
            for i in range(0, len(paragraph_words), MAX_LESSON_WORDS):
                if current_words:
                    chunks.append(" ".join(current_words))
                    current_words = []
                chunks.append(" ".join(paragraph_words[i:i + MAX_LESSON_WORDS]))
        else:
            current_words.extend(paragraph_words)

    if current_words:
        chunks.append(" ".join(current_words))

    if not chunks:
        return [Lesson(title, body, code_snippet, has_image)]

    lessons = []
    total_parts = len(chunks)
    for index, chunk in enumerate(chunks, start=1):
        part_title = f"{title} (Part {index} of {total_parts})"
        snippet = code_snippet if index == 1 else None
        image_flag = has_image if index == 1 else False
        lessons.append(Lesson(part_title, chunk, snippet, image_flag))

    return lessons


# =============================================================================
# DESCRIPTION / DURATION
# =============================================================================

def first_meaningful_line(text: str) -> str:
    for line in text.split("\n"):
        stripped = line.strip()
        if stripped:
            return stripped
    return ""


def build_description(course_title: str, lessons: "list[Lesson]") -> str:
    seed = ""
    for lesson in lessons:
        seed = first_meaningful_line(lesson.body)
        if seed:
            break
    if seed:
        if len(seed) > 160:
            seed = seed[:157].rstrip() + "..."
        return seed
    lesson_count = len(lessons)
    plural = "lesson" if lesson_count == 1 else "lessons"
    return f"{course_title} - {lesson_count} {plural}."


def estimate_duration(lessons: "list[Lesson]") -> str:
    total_words = sum(len(lesson.body.split()) for lesson in lessons)
    minutes = max(MIN_DURATION_MINUTES, round(total_words / WORDS_PER_MINUTE))
    return f"{minutes} min"


# =============================================================================
# MARKDOWN PARSING -> RAW COURSES/LESSONS
# =============================================================================

def read_source_file(path: Path) -> str:
    if not path.exists():
        print(f"ERROR: source file not found: {path}", file=sys.stderr)
        sys.exit(1)
    raw = path.read_bytes()
    text = raw.decode("utf-8", errors="replace")
    text = text.replace("\r\n", "\n").replace("\r", "\n")
    return text


def document_has_h1(markdown_text: str) -> bool:
    for line in markdown_text.split("\n"):
        match = HEADING_RE.match(line)
        if match and len(match.group(1)) == 1:
            if not is_skip_heading(match.group(2).strip()):
                return True
    return False


def parse_raw_courses(markdown_text: str, fallback_title: str) -> "list[_RawCourse]":
    """
    Parses the document into raw courses/lessons.

    If the document contains at least one usable "#" heading, that
    heading level defines course boundaries, "##" defines lesson
    boundaries, and "###"/"####" merge into the current lesson as
    subsections (never becoming separate lessons).

    If the document has NO usable "#" heading at all, the whole
    document becomes a single course (titled from YAML front matter,
    or the fallback title), with "##" as the top-level lesson boundary
    and "###"/"####" merging into the current lesson exactly as above.
    This case must never cause the generator to fail.
    """
    lines = markdown_text.split("\n")
    has_h1 = document_has_h1(markdown_text)

    courses: "list[_RawCourse]" = []
    seen_course_ids: set = set()

    current_course = None
    current_lesson = None

    skip_active = False
    skip_level = 0

    if not has_h1:
        # Single implicit course for the whole document.
        base_id = slugify(fallback_title)
        current_course = _RawCourse(fallback_title, base_id)
        courses.append(current_course)
        seen_course_ids.add(base_id)

    for line in lines:
        match = HEADING_RE.match(line)

        if match:
            level = len(match.group(1))
            heading_text = match.group(2).strip()

            if skip_active and level <= skip_level:
                skip_active = False

            if is_skip_heading(heading_text):
                skip_active = True
                skip_level = level
                if has_h1 and level == 1:
                    current_course = None
                current_lesson = None
                continue

            if skip_active:
                continue

            is_course_boundary = has_h1 and level == 1
            is_lesson_boundary = (level == 2) if has_h1 else (level == 2)
            is_subsection = (level >= 3)

            if is_course_boundary:
                base_id = slugify(heading_text)
                unique_id = base_id
                suffix = 2
                while unique_id in seen_course_ids:
                    unique_id = f"{base_id}-{suffix}"
                    suffix += 1
                seen_course_ids.add(unique_id)

                current_course = _RawCourse(heading_text, unique_id)
                courses.append(current_course)
                current_lesson = None
                continue

            if is_lesson_boundary:
                if current_course is None:
                    current_lesson = None
                    continue
                current_lesson = _RawLesson(heading_text)
                current_course.lessons.append(current_lesson)
                continue

            if is_subsection:
                # Merge as a plain-text subheading line into the
                # CURRENT lesson's content instead of creating a new
                # lesson. If there is no current lesson yet (a ### or
                # #### appearing before any ##), start one implicitly
                # using the subsection heading as its title, so content
                # is never silently dropped.
                if current_course is None:
                    continue
                if current_lesson is None:
                    current_lesson = _RawLesson(heading_text)
                    current_course.lessons.append(current_lesson)
                else:
                    current_lesson.body_lines.append("")
                    current_lesson.body_lines.append(heading_text)
                continue

            continue

        if skip_active:
            continue
        if current_lesson is not None:
            current_lesson.body_lines.append(line)

    return courses


# =============================================================================
# TEXTBOOK REWRITE STAGE (optional - requires ANTHROPIC_API_KEY)
# =============================================================================

TEXTBOOK_SYSTEM_PROMPT = f"""You are a textbook author for {BRAND_NAME}, a learning \
platform whose audience is secondary school students, university students, and \
complete beginners in Nigeria and across Africa who are learning freelancing for \
the first time.

Rewrite the given source material into a real, self-contained textbook chapter. Do \
not copy or lightly paraphrase repository documentation - teach the underlying idea \
from scratch, in your own words.

Rules:
- Use simple, everyday English. Avoid unnecessarily difficult grammar or vocabulary.
- The very first time you use a technical or business term, explain what it means in \
plain language before using it again.
- Structure the chapter with these sections, using clear plain-text headings (no \
markdown symbols, no asterisks, no hashes): Introduction, Main Explanation, \
Examples, Tips, Common Mistakes, Summary, Key Takeaways.
- Where it helps understanding, include a real-life example or a simple everyday \
analogy, and step-by-step explanations for any process.
- Naturally weave in ONE short callout using the exact phrase "{BRAND_NAME} Tip", \
"{BRAND_NAME} Note", or "{BRAND_NAME} Reminder" - use at most one such callout per \
chapter, placed where it is genuinely useful, never as decoration.
- End with a short section called "Further Reading" that names general categories \
of trustworthy resources (for example: a local library, a national small-business \
support agency, a certified business mentor, a reputable freelancing platform's \
official help center). Do NOT invent specific book titles, article titles, author \
names, or any URL - only describe resource TYPES.
- Never include any raw URL, markdown syntax, HTML tag, code fence, GitHub \
reference, or repository instruction anywhere in your answer.
- Output plain prose only. No markdown formatting characters at all.
"""


def call_anthropic_api(api_key: str, system_prompt: str, user_content: str) -> str:
    payload = {
        "model": ANTHROPIC_MODEL,
        "max_tokens": ANTHROPIC_MAX_TOKENS,
        "system": system_prompt,
        "messages": [
            {"role": "user", "content": user_content},
        ],
    }
    request = urllib.request.Request(
        ANTHROPIC_API_URL,
        data=json.dumps(payload).encode("utf-8"),
        headers={
            "Content-Type": "application/json",
            "x-api-key": api_key,
            "anthropic-version": "2023-06-01",
        },
        method="POST",
    )
    with urllib.request.urlopen(request, timeout=ANTHROPIC_TIMEOUT_SECONDS) as response:
        body = json.loads(response.read().decode("utf-8"))

    text_parts = [
        block.get("text", "")
        for block in body.get("content", [])
        if block.get("type") == "text"
    ]
    return "\n".join(text_parts).strip()


def rewrite_lesson_textbook(api_key: str, course_title: str, lesson_title: str, cleaned_body: str) -> str:
    user_content = (
        f"Course topic: {course_title}\n"
        f"Chapter topic: {lesson_title}\n\n"
        f"Source material to teach from (already stripped of links/markdown, may "
        f"still be rough or incomplete - use it as raw material, not as text to "
        f"copy):\n\n{cleaned_body}"
    )
    return call_anthropic_api(api_key, TEXTBOOK_SYSTEM_PROMPT, user_content)


def fallback_further_reading() -> str:
    """
    Generic, non-fabricated "Further Reading" section used only when the
    textbook rewrite stage is unavailable. Names resource TYPES only -
    no invented titles, authors, or URLs.
    """
    return (
        "Further Reading\n"
        "To learn more about this topic, consider these types of resources: "
        "a local library or community learning center, a certified business "
        "mentor or small-business support office in your area, and the "
        "official help center of a reputable freelancing platform."
    )


def apply_textbook_stage(
    api_key,
    course_title: str,
    lesson_title: str,
    cleaned_body: str,
) -> tuple[str, bool]:
    """
    Returns (final_body, was_rewritten). If api_key is falsy, or the API
    call fails for any reason, falls back to the cleaned text plus a
    generic, honestly-labeled Further Reading section rather than
    crashing or fabricating content.
    """
    if not api_key:
        return cleaned_body + "\n\n" + fallback_further_reading(), False

    try:
        rewritten = rewrite_lesson_textbook(api_key, course_title, lesson_title, cleaned_body)
        if rewritten.strip():
            return rewritten, True
    except (urllib.error.URLError, urllib.error.HTTPError, TimeoutError, ValueError, KeyError) as exc:
        print(
            f"WARNING: textbook rewrite failed for '{lesson_title}' "
            f"({exc}); using cleaned source text instead.",
            file=sys.stderr,
        )
    except Exception as exc:  # last-resort safety net - never let this crash the run
        print(
            f"WARNING: unexpected error during textbook rewrite for "
            f"'{lesson_title}' ({exc}); using cleaned source text instead.",
            file=sys.stderr,
        )

    return cleaned_body + "\n\n" + fallback_further_reading(), False


# =============================================================================
# BUILD FINAL COURSES
# =============================================================================

def build_courses(markdown_text: str, fallback_title: str) -> tuple[list[Course], list[str], int]:
    api_key = os.environ.get("ANTHROPIC_API_KEY", "").strip()

    raw_courses = parse_raw_courses(markdown_text, fallback_title)
    courses: list[Course] = []
    forced_cleanup_notes: list[str] = []
    rewritten_count = 0

    for raw_course in raw_courses:
        course = Course(raw_course.title, raw_course.course_id)

        for raw_lesson in raw_course.lessons:
            raw_body = raw_lesson.raw_body()
            if not raw_body.strip():
                continue

            has_image = detect_has_image(raw_body)
            body_no_fences, code_snippet = extract_and_strip_code_fences(raw_body)

            cleaned_body, forced = clean_until_valid(body_no_fences)
            if forced:
                forced_cleanup_notes.append(f"{raw_course.title} / {raw_lesson.title}")

            if len(cleaned_body.split()) < MIN_LESSON_WORDS:
                continue

            final_body, was_rewritten = apply_textbook_stage(
                api_key, raw_course.title, raw_lesson.title, cleaned_body
            )
            if was_rewritten:
                rewritten_count += 1
                time.sleep(ANTHROPIC_REQUEST_DELAY_SECONDS)

            for lesson in split_lesson_if_needed(
                raw_lesson.title, final_body, code_snippet, has_image
            ):
                course.lessons.append(lesson)

        if not course.lessons:
            continue

        course.description = build_description(course.title, course.lessons)
        course.duration = estimate_duration(course.lessons)
        courses.append(course)

    return courses, forced_cleanup_notes, rewritten_count


# =============================================================================
# DART STRING GENERATION - base64 payload wrapper (bulletproof)
# =============================================================================

def dart_data_expr(text: str) -> str:
    payload = base64.b64encode(text.encode("utf-8")).decode("ascii")
    return f'utf8.decode(base64.decode("{payload}"))'


def dart_nullable_data_expr(text) -> str:
    if text is None:
        return "null"
    return dart_data_expr(text)


def generate_lesson_dart(lesson: Lesson, indent: str) -> str:
    parts = []
    parts.append(f"{indent}AppLesson(")
    parts.append(f"{indent}  title: {dart_data_expr(lesson.title)},")
    parts.append(f"{indent}  body: {dart_data_expr(lesson.body)},")
    parts.append(f"{indent}  codeSnippet: {dart_nullable_data_expr(lesson.code_snippet)},")
    parts.append(f"{indent}  hasImage: {'true' if lesson.has_image else 'false'},")
    parts.append(f"{indent}),")
    return "\n".join(parts)


def generate_course_dart(course: Course) -> str:
    parts = []
    parts.append("  AppCourse(")
    parts.append(f"    id: {dart_data_expr(course.course_id)},")
    parts.append(f"    title: {dart_data_expr(course.title)},")
    parts.append(f"    description: {dart_data_expr(course.description)},")
    parts.append(f"    instructor: {dart_data_expr(INSTRUCTOR)},")
    parts.append(f"    category: {dart_data_expr(CATEGORY)},")
    parts.append(f"    difficulty: {dart_data_expr(DIFFICULTY)},")
    parts.append(f"    icon: {ICON},")
    parts.append(f"    color: {COLOR},")
    parts.append(f"    duration: {dart_data_expr(course.duration)},")
    parts.append("    lessons: [")
    for lesson in course.lessons:
        parts.append(generate_lesson_dart(lesson, "      "))
    parts.append("    ],")
    parts.append("  ),")
    return "\n".join(parts)


def generate_dart_file(courses: "list[Course]") -> str:
    header = (
        "// GENERATED FILE - DO NOT EDIT BY HAND.\n"
        "// Produced by freelancing_generator_v2.py\n"
        f"// Source: {SOURCE_FILE.as_posix()}\n\n"
        "import 'dart:convert';\n"
        "import 'package:flutter/material.dart';\n"
        "import '../models/app_course.dart';\n\n"
        f"final {DART_VARIABLE_NAME} = <AppCourse>[\n"
    )
    body_parts = [generate_course_dart(course) for course in courses]
    footer = "\n];\n"
    return header + "\n".join(body_parts) + footer


# =============================================================================
# DART SYNTAX VALIDATION (structural + optional `dart analyze`)
# =============================================================================

BASE64_PAYLOAD_RE = re.compile(r'utf8\.decode\(base64\.decode\("([^"]*)"\)\)')
VALID_BASE64_RE = re.compile(r'^[A-Za-z0-9+/]*={0,2}$')


def validate_structural(dart_source: str, expected_course_count: int, expected_lesson_count: int) -> list[str]:
    errors: list[str] = []

    pairs = {"(": ")", "[": "]", "{": "}"}
    closers = {v: k for k, v in pairs.items()}
    stack = []
    for i, ch in enumerate(dart_source):
        if ch in pairs:
            stack.append(ch)
        elif ch in closers:
            if not stack or stack[-1] != closers[ch]:
                errors.append(
                    f"Bracket mismatch near character index {i}: "
                    f"found '{ch}' without matching '{closers[ch]}'."
                )
                return errors
            stack.pop()
    if stack:
        errors.append(f"Unclosed bracket(s) at end of file: {''.join(stack)}")

    course_calls = list(re.finditer(r"AppCourse\(\s*", dart_source))
    for m in course_calls:
        tail = dart_source[m.end():m.end() + 20]
        if not tail.lstrip().startswith("id:"):
            errors.append(
                f"AppCourse( at position {m.start()} is not immediately "
                f"followed by a named 'id:' parameter (found: {tail!r})."
            )

    lesson_calls = list(re.finditer(r"AppLesson\(\s*", dart_source))
    for m in lesson_calls:
        tail = dart_source[m.end():m.end() + 20]
        if not tail.lstrip().startswith("title:"):
            errors.append(
                f"AppLesson( at position {m.start()} is not immediately "
                f"followed by a named 'title:' parameter (found: {tail!r})."
            )

    if len(course_calls) != expected_course_count:
        errors.append(
            f"Expected {expected_course_count} AppCourse( calls, "
            f"found {len(course_calls)}."
        )
    if len(lesson_calls) != expected_lesson_count:
        errors.append(
            f"Expected {expected_lesson_count} AppLesson( calls, "
            f"found {len(lesson_calls)}."
        )

    for m in BASE64_PAYLOAD_RE.finditer(dart_source):
        payload = m.group(1)
        if not VALID_BASE64_RE.match(payload):
            errors.append(
                f"Payload at position {m.start()} contains characters "
                f"outside the base64 alphabet."
            )
            continue
        try:
            decoded_bytes = base64.b64decode(payload, validate=True)
        except Exception as exc:
            errors.append(f"Payload at position {m.start()} failed to base64-decode: {exc}")
            continue
        try:
            decoded_bytes.decode("utf-8")
        except Exception as exc:
            errors.append(f"Payload at position {m.start()} is not valid UTF-8 once decoded: {exc}")

    forbidden_pattern = re.compile(
        r'\b(title|body|codeSnippet|description|duration|id|instructor|category|difficulty):\s*"'
    )
    if forbidden_pattern.search(dart_source):
        errors.append(
            "Found a raw double-quoted string literal directly assigned "
            "to a text field instead of the base64 data expression."
        )

    return errors


def validate_with_dart_cli(temp_path: Path) -> list[str]:
    dart_bin = shutil.which("dart")
    if dart_bin is None:
        return []

    try:
        result = subprocess.run(
            [dart_bin, "analyze", "--no-fatal-infos", str(temp_path)],
            capture_output=True,
            text=True,
            timeout=120,
        )
    except Exception as exc:
        return [f"Could not run `dart analyze`: {exc}"]

    combined_output = (result.stdout or "") + (result.stderr or "")
    if "Error:" in combined_output or "SyntaxError" in combined_output:
        return [
            "`dart analyze` reported syntax errors in the generated file:",
            combined_output.strip(),
        ]

    return []


# =============================================================================
# MAIN
# =============================================================================

def main() -> None:
    markdown_text = read_source_file(SOURCE_FILE)

    markdown_text, front_matter_title = strip_front_matter(markdown_text)
    fallback_title = front_matter_title or humanize_filename(SOURCE_FILE)

    courses, forced_cleanup_notes, rewritten_count = build_courses(markdown_text, fallback_title)

    if not courses:
        print("No valid courses found after cleaning source file.", file=sys.stderr)
        sys.exit(1)

    dart_code = generate_dart_file(courses)

    expected_course_count = len(courses)
    expected_lesson_count = sum(len(course.lessons) for course in courses)

    structural_errors = validate_structural(
        dart_code, expected_course_count, expected_lesson_count
    )
    if structural_errors:
        print("ABORTED: generated Dart failed structural validation:", file=sys.stderr)
        for err in structural_errors:
            print(f"  - {err}", file=sys.stderr)
        sys.exit(1)

    OUTPUT_FILE.parent.mkdir(parents=True, exist_ok=True)
    with tempfile.NamedTemporaryFile(
        mode="w",
        encoding="utf-8",
        dir=str(OUTPUT_FILE.parent),
        prefix=".freelancing_courses.",
        suffix=".dart.tmp",
        delete=False,
    ) as tmp:
        tmp.write(dart_code)
        temp_path = Path(tmp.name)

    cli_errors = validate_with_dart_cli(temp_path)
    if cli_errors:
        temp_path.unlink(missing_ok=True)
        print("ABORTED: `dart analyze` reported problems with the generated file:", file=sys.stderr)
        for err in cli_errors:
            print(f"  - {err}", file=sys.stderr)
        sys.exit(1)

    temp_path.replace(OUTPUT_FILE)

    total_lessons = sum(len(course.lessons) for course in courses)

    print(f"Number of courses: {expected_course_count}")
    print(f"Number of lessons: {total_lessons}")
    print(f"Lessons rewritten in textbook mode: {rewritten_count}")
    print(f"Output filename: {OUTPUT_FILE}")
    if not os.environ.get("ANTHROPIC_API_KEY", "").strip():
        print("Note: ANTHROPIC_API_KEY not set - textbook rewriting was skipped; cleaned source text was used instead.")
    if forced_cleanup_notes:
        print(f"Note: {len(forced_cleanup_notes)} lesson(s) needed forced cleanup:")
        for note in forced_cleanup_notes:
            print(f"  - {note}")
    print("Generation complete")


if __name__ == "__main__":
    main()

