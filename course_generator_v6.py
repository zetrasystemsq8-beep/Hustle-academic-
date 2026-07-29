#!/usr/bin/env python3
# course_generator_v2.py
#
# Hustle Academy - Course Generator V2 (Quality First)
# =======================================================
#
# This is not a Markdown-to-Dart copier. It is a cleaning + course-
# building pipeline that turns raw repository Markdown into lesson
# content suitable for a real course, then emits it as Dart using the
# same bulletproof string-encoding approach proven in v5 (every string
# is transmitted as base64, so no escaping bug can ever produce invalid
# Dart, regardless of what the source text contains).
#
# IMPORTANT HONEST LIMITATION (read this before relying on it)
# --------------------------------------------------------------
# This script can reliably STRIP junk (URLs, HTML, markdown syntax,
# badges, repo/GitHub instructions, licenses, changelogs, etc.) and
# reliably RESTRUCTURE content (extract code blocks, split oversized
# lessons, drop empty sections). That is all mechanical text
# processing and is done thoroughly below.
#
# It CANNOT genuinely rewrite prose into "textbook" language the way a
# human instructor would (e.g. turning "Run npm install" into "This
# command installs the project's dependencies"). That requires actual
# language understanding and generation, not pattern matching - a
# fixed set of regex substitutions cannot generalize to arbitrary
# sentences it has never seen. Rather than fabricate plausible-looking
# rewrites for sentences it doesn't understand (which would silently
# insert wrong or misleading "explanations"), this script instead
# DROPS sentences that match known repository-instruction patterns and
# leaves everything else as clean, well-organized prose. If you want
# genuine instructor-voice rewriting, that step needs an LLM call in
# the pipeline - this script does not fabricate one, but is structured
# so that stage could be added later without changing anything else.
#
# Python 3 standard library only. Runs in Termux with:
#     python3 course_generator_v2.py

from __future__ import annotations

import base64
import re
import shutil
import subprocess
import sys
import tempfile
import unicodedata
from pathlib import Path

# =============================================================================
# CONFIG
# =============================================================================

SOURCE_FILE = Path("marketing-skills/copywriting/SKILL.md")
OUTPUT_FILE = Path("lib/courses/copywriting_courses.dart")

DART_VARIABLE_NAME = "copywritingCourses"

INSTRUCTOR = "Hustle Academy"
CATEGORY = "Copywriting"
DIFFICULTY = "Beginner"
ICON = "Icons.edit_note"
COLOR = "Colors.deepPurple"

WORDS_PER_MINUTE = 200
MIN_DURATION_MINUTES = 5

MAX_LESSON_WORDS = 700
MIN_LESSON_WORDS = 20  # lessons thinner than this after cleaning are dropped
MAX_CLEAN_PASSES = 3   # how many times to re-run cleaning if validation fails

# Whole sections to skip entirely (heading text match), whether they
# appear as a course (#) heading or a lesson (##/###/####) heading.
# Skipping a heading also skips everything nested beneath it.
SKIP_SECTION_KEYWORDS = [
    "dedication",
    "praise",
    "contents",
    "table of contents",
    "introduction",
    "the author",
    "using this book",
    "acknowledg",
    "license",
    "licence",
    "changelog",
    "credits",
    "contributors",
    "contributing",
    "appendix",
    "references",
    "bibliography",
    "footnotes",
    "faq",
    "code of conduct",
    "security",
]

# Sentence-level junk: lines matching any of these (case-insensitive)
# are dropped rather than kept or "rewritten", per the limitation
# explained above.
REPO_JUNK_LINE_PATTERNS = [
    r"\bgit\s+clone\b",
    r"\bgit\s+pull\b",
    r"\bgit\s+push\b",
    r"\bgit\s+commit\b",
    r"\bnpm\s+install\b",
    r"\byarn\s+install\b",
    r"\bpip\s+install\b",
    r"\bpip3\s+install\b",
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
]
REPO_JUNK_LINE_RE = re.compile("|".join(REPO_JUNK_LINE_PATTERNS), re.IGNORECASE)

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


def detect_has_image(raw_text: str) -> bool:
    if IMAGE_MD_RE.search(raw_text):
        return True
    if re.search(r"<img\b", raw_text, re.IGNORECASE):
        return True
    return False


def extract_and_strip_code_fences(raw_text: str):
    """
    Returns (text_with_fences_removed, first_code_snippet_or_None).
    The first fenced code block becomes codeSnippet; ALL fenced code
    blocks (not just the first) are removed from the body, since large
    code dumps must never be left in lesson prose.
    """
    matches = list(CODE_FENCE_RE.finditer(raw_text))
    first_snippet = None
    if matches:
        snippet = matches[0].group(1).strip("\n")
        if snippet.strip():
            first_snippet = snippet
    cleaned = CODE_FENCE_RE.sub("", raw_text)
    return cleaned, first_snippet


# =============================================================================
# CLEANING PIPELINE
# =============================================================================

def clean_line_level_junk(text: str) -> str:
    """Drop whole lines that are pure junk: badges, horizontal rules,
    repo-instruction sentences, footnote markers on their own line."""
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
        if REPO_JUNK_LINE_RE.search(stripped):
            continue
        out_lines.append(line)
    return "\n".join(out_lines)


def strip_markdown_syntax(text: str) -> str:
    """Convert markdown formatting into plain readable text."""
    cleaned = text

    # Images (inline, not just full-line) - drop entirely, no alt text
    # kept, since alt text on repo images is usually not lesson content.
    cleaned = IMAGE_MD_RE.sub("", cleaned)

    # Markdown links [text](url) -> just the visible text.
    cleaned = MD_LINK_RE.sub(r"\1", cleaned)

    # Footnote markers like [^1].
    cleaned = FOOTNOTE_MARK_RE.sub("", cleaned)

    # Raw HTML tags -> remove the tags, keep any inner text as-is
    # (the tags themselves carry no lesson content).
    cleaned = HTML_TAG_RE.sub("", cleaned)

    # Bare URLs anywhere in the text.
    cleaned = URL_RE.sub("", cleaned)

    # Inline code `like this` -> unwrap to plain text.
    cleaned = INLINE_CODE_RE.sub(r"\1", cleaned)

    # Bold / italic emphasis -> unwrap to plain text.
    def _unwrap_bold(m):
        return m.group(1) if m.group(1) is not None else m.group(2)

    def _unwrap_italic(m):
        return m.group(1) if m.group(1) is not None else m.group(2)

    cleaned = BOLD_RE.sub(_unwrap_bold, cleaned)
    cleaned = ITALIC_RE.sub(_unwrap_italic, cleaned)

    # Any stray leftover backticks (unbalanced inline code, code fence
    # remnants) - just remove the character.
    cleaned = cleaned.replace("`", "")

    # Stray leading heading markers on any line (should be rare since
    # headings define lesson structure, but content sometimes contains
    # a demoted heading-like line).
    cleaned = "\n".join(LEADING_HASHES_RE.sub("", line) for line in cleaned.split("\n"))

    # Bullet markers -> keep the text, drop the raw "-"/"*"/"+" marker,
    # replace with a simple, readable "- " list marker.
    out_lines = []
    for line in cleaned.split("\n"):
        if BULLET_MARKER_RE.match(line):
            content = BULLET_MARKER_RE.sub("", line).strip()
            out_lines.append(f"- {content}" if content else "")
        else:
            out_lines.append(line)
    cleaned = "\n".join(out_lines)

    # Collapse any run of 2+ double-quotes (broken/triple quotes) down
    # to nothing - these are formatting artifacts, not real content.
    cleaned = TRIPLE_QUOTE_RE.sub("", cleaned)

    return cleaned


def normalize_whitespace(text: str) -> str:
    lines = [MULTI_SPACE_RE.sub(" ", line.rstrip()) for line in text.split("\n")]
    joined = "\n".join(lines)
    joined = MULTI_BLANK_LINE_RE.sub("\n\n", joined)
    return joined.strip("\n")


def clean_lesson_body(raw_text: str) -> str:
    """Full cleaning pipeline for one lesson's raw body text."""
    text = raw_text
    text, _ = extract_and_strip_code_fences(text)  # snippet already grabbed earlier
    text = clean_line_level_junk(text)
    text = strip_markdown_syntax(text)
    text = normalize_whitespace(text)
    return text


# =============================================================================
# QUALITY VALIDATION (text content, not Dart syntax)
# =============================================================================

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
    word_count = len(text.split())
    if word_count > MAX_LESSON_WORDS:
        issues.append(f"exceeds max lesson word count ({word_count} > {MAX_LESSON_WORDS})")
    return issues


def force_strip_remaining_issues(text: str) -> str:
    """
    Last-resort cleanup if a lesson still fails validation after
    MAX_CLEAN_PASSES. Deletes offending fragments outright rather than
    risk leaving broken formatting or repo junk in a shipped lesson.
    """
    text = URL_RE.sub("", text)
    text = HTML_TAG_RE.sub("", text)
    text = re.sub(r"\*\*|__|```|~~~", "", text)
    text = re.sub(r"^\s*#{1,6}\s*", "", text, flags=re.MULTILINE)
    text = text.replace("`", "")
    text = TRIPLE_QUOTE_RE.sub("", text)
    lines = [ln for ln in text.split("\n") if not REPO_JUNK_LINE_RE.search(ln)]
    text = "\n".join(lines)
    return normalize_whitespace(text)


def clean_until_valid(raw_text: str) -> tuple[str, bool]:
    """
    Runs the cleaning pipeline, re-checks quality, and re-cleans up to
    MAX_CLEAN_PASSES times. Returns (final_text, forced_cleanup_used).
    Word-count overflow is handled separately by lesson splitting, so
    it is excluded from the "needs re-clean" trigger here.
    """
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
            # A single paragraph is itself too long - hard-split it.
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
        # Only the first part keeps the extracted code snippet / image
        # flag, since those were detected from the original single body.
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
# MARKDOWN PARSING -> RAW COURSES/LESSONS (before cleaning)
# =============================================================================

def read_source_file(path: Path) -> str:
    if not path.exists():
        print(f"ERROR: source file not found: {path}", file=sys.stderr)
        sys.exit(1)
    raw = path.read_bytes()
    text = raw.decode("utf-8", errors="replace")
    text = text.replace("\r\n", "\n").replace("\r", "\n")
    return text


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


def parse_raw_courses(markdown_text: str) -> "list[_RawCourse]":
    lines = markdown_text.split("\n")

    courses: "list[_RawCourse]" = []
    seen_course_ids: set = set()

    current_course = None
    current_lesson = None

    skip_active = False
    skip_level = 0

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
                if level == 1:
                    current_course = None
                current_lesson = None
                continue

            if skip_active:
                continue

            if level == 1:
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
            else:
                if current_course is None:
                    current_lesson = None
                    continue
                current_lesson = _RawLesson(heading_text)
                current_course.lessons.append(current_lesson)

            continue

        if skip_active:
            continue
        if current_lesson is not None:
            current_lesson.body_lines.append(line)

    return courses


# =============================================================================
# BUILD FINAL, CLEANED COURSES
# =============================================================================

def build_courses(markdown_text: str) -> tuple[list[Course], list[str]]:
    raw_courses = parse_raw_courses(markdown_text)
    courses: list[Course] = []
    forced_cleanup_notes: list[str] = []

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
                forced_cleanup_notes.append(
                    f"{raw_course.title} / {raw_lesson.title}"
                )

            if len(cleaned_body.split()) < MIN_LESSON_WORDS:
                continue  # too thin after cleaning to be a real lesson

            for lesson in split_lesson_if_needed(
                raw_lesson.title, cleaned_body, code_snippet, has_image
            ):
                course.lessons.append(lesson)

        if not course.lessons:
            continue  # nothing left worth teaching in this course

        course.description = build_description(course.title, course.lessons)
        course.duration = estimate_duration(course.lessons)
        courses.append(course)

    return courses, forced_cleanup_notes


# =============================================================================
# DART STRING GENERATION - base64 payload wrapper (bulletproof, from v5)
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
        "// Produced by course_generator_v2.py\n"
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

    courses, forced_cleanup_notes = build_courses(markdown_text)

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
        prefix=".copywriting_courses.",
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
    print(f"Output filename: {OUTPUT_FILE}")
    if forced_cleanup_notes:
        print(f"Note: {len(forced_cleanup_notes)} lesson(s) needed forced cleanup:")
        for note in forced_cleanup_notes:
            print(f"  - {note}")
    print("Generation complete")


if __name__ == "__main__":
    main()

