#!/usr/bin/env python3
"""
generate_cybersecurity_courses.py

Offline, stdlib-only generator that converts every .md file under
assets/cybersecurity_docs/ into a single Dart file:

    lib/courses/cybersecurity_courses.dart

No AI APIs are used anywhere in this script. Everything is done with
plain text processing (re, os, pathlib) from the Python standard library.

Each .md file becomes one AppCourse. Each heading (or paragraph group, if
there are no headings) inside that file becomes one short AppLesson.
Markdown formatting, links, HTML, images, emojis, badges, reference
sections, and quiz sections are stripped. Remaining text is rewritten
using simple word substitutions and sentence-splitting rules so the
result reads like a friendly, conversational explanation suitable for
Nigerian beginners and secondary school students, rather than an
academic security document.

Usage:
    python3 generate_cybersecurity_courses.py
    python3 generate_cybersecurity_courses.py \
        --source assets/cybersecurity_docs \
        --output lib/courses/cybersecurity_courses.dart
"""

from __future__ import annotations

import argparse
import hashlib
import os
import re
import sys
import unicodedata
from dataclasses import dataclass, field
from pathlib import Path
from typing import List, Optional, Tuple

# ==========================================================================
# Configuration
# ==========================================================================

DEFAULT_SOURCE = "assets/cybersecurity_docs"
DEFAULT_OUTPUT = "lib/courses/cybersecurity_courses.dart"

CATEGORY = "Cybersecurity"
INSTRUCTOR = "Hustle Academy"
ICON = "Icons.security"
COLOR = "Colors.deepOrange"

# Non-lesson files we never want to treat as a lesson source.
IGNORE_FILE_NAMES = {
    "contributing.md", "license.md", "changelog.md",
    "code_of_conduct.md", "security.md", "codeowners.md",
}

# Folders that are clearly not lesson content (repo plumbing, raw assets).
IGNORE_DIR_PATTERNS = re.compile(
    r"^(\.git|\.github|node_modules|__pycache__|\.venv|venv|assets|images|img|_site)$",
    re.IGNORECASE,
)

WORDS_PER_MINUTE = 180            # slightly slower, since text is simplified/conversational
MAX_LESSON_CHARS = 1400           # keep lessons short and digestible
SHORT_PARAGRAPH_CHARS = 140       # merge paragraphs shorter than this
MAX_SENTENCE_WORDS = 20           # split sentences longer than this

# Headings whose entire section must be dropped (not lesson content).
JUNK_HEADING_RE = re.compile(
    r"^(references?|bibliography|further reading|learn more|"
    r"additional resources|quiz(zes)?|test your knowledge|"
    r"contributors?|acknowledge?ments?|license|copyright|citation|citing)\b",
    re.IGNORECASE,
)

# Lines that are contributor/copyright/badge-caption noise even outside a
# junk section.
NOISE_LINE_RE = re.compile(
    r"^\s*(©|\(c\)|copyright\b|all rights reserved|contributors?:|"
    r"author(s)?:|maintainers?:)\b.*$",
    re.IGNORECASE,
)

BEGINNER_KEYWORDS = {
    "introduction", "overview", "basics", "getting started",
    "fundamentals", "what is", "glossary", "password", "phishing",
}
ADVANCED_KEYWORDS = {
    "exploit", "exploitation", "buffer overflow", "reverse engineering",
    "privilege escalation", "remote code execution", "penetration testing",
    "cryptanalysis", "zero-day", "rootkit",
}
INTERMEDIATE_KEYWORDS = {
    "encryption", "firewall", "vulnerability", "authentication",
    "authorization", "malware", "network security", "vpn", "sql injection",
    "cross-site scripting",
}


# ==========================================================================
# Discovery
# ==========================================================================

def discover_markdown_files(source_folder: Path) -> List[Path]:
    """Recursively find every real lesson .md file."""
    results: List[Path] = []
    for root, dirs, files in os.walk(source_folder):
        dirs[:] = [d for d in dirs if not IGNORE_DIR_PATTERNS.match(d)]
        for filename in files:
            lower = filename.lower()
            if not lower.endswith(".md"):
                continue
            if lower in IGNORE_FILE_NAMES:
                continue
            results.append(Path(root) / filename)
    results.sort()
    return results


# ==========================================================================
# Naming / slugs / IDs
# ==========================================================================

def humanize_name(name: str) -> str:
    cleaned = re.sub(r"^\s*\d+[\s._-]+", "", name)
    cleaned = cleaned.replace("_", " ").replace("-", " ")
    cleaned = re.sub(r"\s+", " ", cleaned).strip() or name
    small_words = {"and", "or", "of", "the", "in", "on", "to", "a", "an", "for", "with"}
    words = []
    for i, w in enumerate(cleaned.split(" ")):
        if w.isupper() and len(w) > 1:
            words.append(w)  # keep acronyms: VPN, SQL, XSS
        elif i > 0 and w.lower() in small_words:
            words.append(w.lower())
        else:
            words.append(w[:1].upper() + w[1:] if w else w)
    return " ".join(words)


def slugify(text: str) -> str:
    text = unicodedata.normalize("NFKD", text).encode("ascii", "ignore").decode("ascii")
    text = re.sub(r"[^a-zA-Z0-9]+", "-", text).strip("-").lower()
    return text or "item"


class UniqueIdFactory:
    def __init__(self) -> None:
        self._seen: dict[str, int] = {}

    def make(self, base: str) -> str:
        base = base or "item"
        if base not in self._seen:
            self._seen[base] = 1
            return base
        self._seen[base] += 1
        return f"{base}-{self._seen[base]}"


# ==========================================================================
# Markdown cleaning
# ==========================================================================

FRONT_MATTER_RE = re.compile(r"\A---\s*\n.*?\n---\s*\n", re.DOTALL)
HTML_COMMENT_RE = re.compile(r"<!--.*?-->", re.DOTALL)
HTML_TAG_RE = re.compile(r"<[^>]+>")
CODE_BLOCK_RE = re.compile(r"```[a-zA-Z0-9_+-]*\n(.*?)```", re.DOTALL)
HEADING_RE = re.compile(r"^(#{1,6})\s+(.*?)\s*#*\s*$", re.MULTILINE)
IMAGE_MD_RE = re.compile(r"!\[[^\]]*\]\([^)]*\)")
IMAGE_HTML_RE = re.compile(r"<img\b[^>]*>", re.IGNORECASE)
LINK_MD_RE = re.compile(r"\[([^\]]+)\]\(([^)]*)\)")
REF_LINK_DEF_RE = re.compile(r"^\s*\[[^\]]+\]:\s*\S+.*$", re.MULTILINE)
INLINE_CODE_RE = re.compile(r"`([^`]*)`")
BOLD_ITALIC_RE = re.compile(r"(\*\*\*|___)(.+?)\1|(\*\*|__)(.+?)\3|(\*|_)(.+?)\5")
BLOCKQUOTE_RE = re.compile(r"^\s*>\s?", re.MULTILINE)
BULLET_RE = re.compile(r"^\s*[-*+]\s+", re.MULTILINE)
NUMBERED_LIST_RE = re.compile(r"^\s*\d+[.)]\s+", re.MULTILINE)
HR_RE = re.compile(r"^\s*([-*_]\s*){3,}\s*$", re.MULTILINE)
TABLE_PIPE_RE = re.compile(r"^\s*\|.*\|\s*$", re.MULTILINE)
TABLE_SEP_RE = re.compile(r"^\s*\|?[\s:|-]+\|[\s:|-]+\|?\s*$", re.MULTILINE)
MULTI_BLANK_RE = re.compile(r"\n{3,}")
BADGE_RE = re.compile(r"!\[[^\]]*\]\((https?://img\.shields\.io|https?://badgen\.net)[^)]*\)")

# Emoji / pictograph ranges (covers the common emoji blocks used in READMEs).
EMOJI_RE = re.compile(
    "["
    "\U0001F300-\U0001FAFF"
    "\U00002600-\U000027BF"
    "\U0001F1E6-\U0001F1FF"
    "\U00002190-\U000021FF"
    "\U00002B00-\U00002BFF"
    "\U0000FE0F"
    "]+",
    flags=re.UNICODE,
)


def strip_front_matter_and_comments(text: str) -> str:
    text = FRONT_MATTER_RE.sub("", text)
    text = HTML_COMMENT_RE.sub("", text)
    return text


def remove_noise_lines(text: str) -> str:
    lines = text.split("\n")
    kept = [ln for ln in lines if not NOISE_LINE_RE.match(ln)]
    return "\n".join(kept)


def split_into_sections(text: str, fallback_title: str) -> List[Tuple[str, str]]:
    """
    Split the document on headings (levels 1-3). Returns a list of
    (heading_title, section_body) tuples in document order. If no
    headings are found, the whole document is a single section.
    """
    matches = [m for m in HEADING_RE.finditer(text) if len(m.group(1)) <= 3]
    if not matches:
        return [(fallback_title, text)]

    sections: List[Tuple[str, str]] = []
    for i, m in enumerate(matches):
        title = m.group(2).strip()
        start = m.end()
        end = matches[i + 1].start() if i + 1 < len(matches) else len(text)
        body = text[start:end]
        if title:
            sections.append((title, body))
    return sections


def extract_code_blocks(section_text: str) -> Tuple[str, str]:
    """Pull fenced code blocks out; returns (text_without_code, code_snippet)."""
    blocks = [m.group(1).strip("\n") for m in CODE_BLOCK_RE.finditer(section_text)]
    code_snippet = "\n\n".join(b for b in blocks if b.strip())
    text_without_code = CODE_BLOCK_RE.sub("", section_text)
    return text_without_code, code_snippet


def detect_and_strip_images(text: str) -> Tuple[str, bool]:
    has_image = bool(IMAGE_MD_RE.search(text)) or bool(IMAGE_HTML_RE.search(text))
    text = BADGE_RE.sub("", text)
    text = IMAGE_MD_RE.sub("", text)
    text = IMAGE_HTML_RE.sub("", text)
    return text, has_image


def strip_markdown_formatting(text: str) -> str:
    """
    Convert markdown-formatted text into clean plain text: remove
    hyperlinks (keep visible text), reference-link definitions, inline
    code backticks, bold/italic markers, blockquote/list markers,
    horizontal rules, table pipes, HTML tags, emojis, and leftover
    heading hashes.
    """
    text = REF_LINK_DEF_RE.sub("", text)
    text = LINK_MD_RE.sub(r"\1", text)          # [text](url) -> text
    text = HTML_TAG_RE.sub("", text)
    text = INLINE_CODE_RE.sub(r"\1", text)       # `code` -> code
    text = BOLD_ITALIC_RE.sub(
        lambda m: next(g for g in (m.group(2), m.group(4), m.group(6)) if g is not None), text
    )
    text = HR_RE.sub("", text)
    text = TABLE_SEP_RE.sub("", text)
    text = TABLE_PIPE_RE.sub(lambda m: m.group(0).replace("|", " "), text)
    text = BLOCKQUOTE_RE.sub("", text)
    text = BULLET_RE.sub("", text)
    text = NUMBERED_LIST_RE.sub("", text)
    text = HEADING_RE.sub(r"\2", text)
    text = EMOJI_RE.sub("", text)
    # Remove any remaining stray markdown symbols.
    text = re.sub(r"[#>*_`]", "", text)
    text = re.sub(r"\[\s*\]", "", text)
    text = re.sub(r"\(\s*\)", "", text)
    return text


def normalize_whitespace(text: str) -> str:
    lines = [ln.rstrip() for ln in text.split("\n")]
    text = "\n".join(lines)
    text = MULTI_BLANK_RE.sub("\n\n", text)
    return text.strip()


def merge_short_paragraphs(text: str) -> str:
    """Join consecutive short paragraphs into readable blocks."""
    paragraphs = [p.strip() for p in text.split("\n\n") if p.strip()]
    merged: List[str] = []
    buffer = ""
    for p in paragraphs:
        if not buffer:
            buffer = p
        elif len(buffer) < SHORT_PARAGRAPH_CHARS:
            buffer = f"{buffer} {p}"
        else:
            merged.append(buffer)
            buffer = p
    if buffer:
        merged.append(buffer)
    return "\n\n".join(merged)


# ==========================================================================
# Simple-English rewriting (rule-based, fully offline)
# ==========================================================================

# Jargon -> plain, conversational replacements. Applied as whole-word,
# case-insensitive matches so "Authentication" and "authentication" both
# get simplified, while words like "authenticator" are left untouched.
SIMPLE_WORD_MAP: dict[str, str] = {
    "authentication": "proving who you are",
    "authenticate": "prove who you are",
    "authorization": "permission",
    "authorized": "allowed",
    "unauthorized": "not allowed",
    "malicious": "harmful",
    "malware": "harmful software",
    "vulnerability": "weakness",
    "vulnerabilities": "weaknesses",
    "exploit": "attack",
    "exploitation": "attack",
    "encryption": "scrambling data so others can't read it",
    "encrypted": "scrambled so others can't read it",
    "decrypt": "unscramble",
    "credentials": "your username and password",
    "phishing": "tricking people into giving away their information",
    "firewall": "a security guard for your network",
    "vpn": "a private, protected internet connection",
    "cybercriminal": "online criminal",
    "cybercriminals": "online criminals",
    "attacker": "the person trying to break in",
    "attackers": "the people trying to break in",
    "adversary": "the attacker",
    "mitigate": "reduce",
    "mitigation": "a way to reduce the risk",
    "utilize": "use",
    "utilizing": "using",
    "leverage": "use",
    "obtain": "get",
    "facilitate": "help",
    "prior to": "before",
    "subsequently": "after that",
    "in order to": "to",
    "individual": "person",
    "individuals": "people",
    "sufficient": "enough",
    "additional": "extra",
    "numerous": "many",
    "therefore": "so",
    "however": "but",
    "furthermore": "also",
    "moreover": "also",
    "regarding": "about",
    "endeavor": "try",
    "commence": "start",
    "terminate": "stop",
    "requisite": "needed",
    "aforementioned": "mentioned before",
    "constitutes": "is",
    "comprises": "includes",
    "demonstrate": "show",
    "implement": "set up",
    "implementation": "setup",
    "configuration": "settings",
    "vulnerable": "at risk",
    "compromise": "break into",
    "compromised": "broken into",
    "breach": "break-in",
    "reconnaissance": "gathering information about a target",
    "social engineering": "tricking people instead of hacking computers",
}

SIMPLE_WORD_RE = re.compile(
    r"\b(" + "|".join(sorted((re.escape(k) for k in SIMPLE_WORD_MAP), key=len, reverse=True)) + r")\b",
    re.IGNORECASE,
)

SENTENCE_SPLIT_RE = re.compile(r"(?<=[.!?])\s+")
CLAUSE_SPLIT_RE = re.compile(r",\s+(?=(?:and|but|which|so|because|since)\b)", re.IGNORECASE)


def simplify_words(text: str) -> str:
    def _replace(m: "re.Match[str]") -> str:
        original = m.group(0)
        replacement = SIMPLE_WORD_MAP[original.lower()]
        if original[0].isupper():
            replacement = replacement[0].upper() + replacement[1:]
        return replacement

    return SIMPLE_WORD_RE.sub(_replace, text)


def split_long_sentences(paragraph: str) -> str:
    """Break sentences over MAX_SENTENCE_WORDS into shorter, simpler ones."""
    sentences = SENTENCE_SPLIT_RE.split(paragraph)
    rewritten: List[str] = []
    for sentence in sentences:
        sentence = sentence.strip()
        if not sentence:
            continue
        if len(sentence.split()) > MAX_SENTENCE_WORDS:
            pieces = CLAUSE_SPLIT_RE.split(sentence)
            for piece in pieces:
                piece = piece.strip().rstrip(",")
                if piece:
                    if not piece[0].isupper():
                        piece = piece[0].upper() + piece[1:]
                    if not piece.endswith((".", "!", "?")):
                        piece += "."
                    rewritten.append(piece)
        else:
            rewritten.append(sentence)
    return " ".join(rewritten)


def make_conversational(text: str) -> str:
    """Rewrite formal/academic phrasing into a friendly, practical tone."""
    text = re.sub(r"\bone should\b", "you should", text, flags=re.IGNORECASE)
    text = re.sub(r"\bone must\b", "you must", text, flags=re.IGNORECASE)
    text = re.sub(r"\bit is (important|recommended|advisable) to\b",
                   r"you should", text, flags=re.IGNORECASE)
    text = re.sub(r"\busers are advised to\b", "you should", text, flags=re.IGNORECASE)
    text = re.sub(r"\bit is possible to\b", "you can", text, flags=re.IGNORECASE)
    return text


def rewrite_simple_english(text: str) -> str:
    """Full simple-English pass applied paragraph by paragraph."""
    paragraphs = [p.strip() for p in text.split("\n\n") if p.strip()]
    result: List[str] = []
    for p in paragraphs:
        p = simplify_words(p)
        p = make_conversational(p)
        p = split_long_sentences(p)
        result.append(p)
    return "\n\n".join(result)


def clean_section_body(raw_body: str) -> Tuple[str, str, bool]:
    """Full cleaning + simplification pipeline for one section."""
    text, code_snippet = extract_code_blocks(raw_body)
    text, has_image = detect_and_strip_images(text)
    text = remove_noise_lines(text)
    text = strip_markdown_formatting(text)
    text = normalize_whitespace(text)
    text = merge_short_paragraphs(text)
    text = rewrite_simple_english(text)
    text = normalize_whitespace(text)
    return text, code_snippet, has_image


def split_long_lesson(title: str, body: str, code_snippet: str, has_image: bool) -> List[Tuple[str, str, str, bool]]:
    """Split a body longer than MAX_LESSON_CHARS into short, readable lessons."""
    if len(body) <= MAX_LESSON_CHARS:
        return [(title, body, code_snippet, has_image)]

    paragraphs = body.split("\n\n")
    parts: List[str] = []
    buffer = ""
    for p in paragraphs:
        candidate = f"{buffer}\n\n{p}" if buffer else p
        if len(candidate) > MAX_LESSON_CHARS and buffer:
            parts.append(buffer)
            buffer = p
        else:
            buffer = candidate
    if buffer:
        parts.append(buffer)

    result: List[Tuple[str, str, str, bool]] = []
    for i, part in enumerate(parts, start=1):
        part_title = f"{title} (Part {i})" if len(parts) > 1 else title
        result.append((part_title, part, code_snippet if i == 1 else "", has_image if i == 1 else False))
    return result


# ==========================================================================
# Metadata estimation
# ==========================================================================

def estimate_reading_minutes(body: str, code_snippet: str) -> int:
    words = len(body.split()) + len(code_snippet.split())
    return max(1, round(words / WORDS_PER_MINUTE))


def estimate_difficulty(title: str, body: str) -> str:
    haystack = f"{title}\n{body}".lower()
    if any(kw in haystack for kw in ADVANCED_KEYWORDS):
        return "Advanced"
    inter = sum(1 for kw in INTERMEDIATE_KEYWORDS if kw in haystack)
    begin = sum(1 for kw in BEGINNER_KEYWORDS if kw in haystack)
    if inter and inter >= begin:
        return "Intermediate"
    if begin:
        return "Beginner"
    return "Beginner"


def format_duration(total_minutes: int) -> str:
    if total_minutes < 60:
        return f"{total_minutes} min"
    hours, minutes = divmod(total_minutes, 60)
    if minutes == 0:
        return f"{hours} hr" if hours == 1 else f"{hours} hrs"
    return f"{hours}h {minutes}m"


def generate_description(course_title: str, lesson_titles: List[str]) -> str:
    count = len(lesson_titles)
    sample = ", ".join(lesson_titles[:3])
    if count > 3:
        sample += f", and {count - 3} more"
    return (
        f"Learn {course_title} in plain, everyday language. This course has "
        f"{count} short lesson{'s' if count != 1 else ''} covering {sample}."
    )


# ==========================================================================
# Data model
# ==========================================================================

@dataclass
class Lesson:
    title: str
    body: str
    code_snippet: str
    has_image: bool
    content_hash: str = ""


@dataclass
class Course:
    id: str
    title: str
    description: str
    duration: str
    difficulty: str
    lessons: List[Lesson] = field(default_factory=list)


def lesson_hash(title: str, body: str) -> str:
    return hashlib.sha256(f"{title.lower().strip()}|{body.lower().strip()}".encode("utf-8", "ignore")).hexdigest()


# ==========================================================================
# Build pipeline
# ==========================================================================

def build_course_from_markdown(path: Path, id_factory: UniqueIdFactory) -> Optional[Course]:
    try:
        raw = path.read_text(encoding="utf-8", errors="replace")
    except OSError as exc:
        print(f"  WARNING: could not read {path}: {exc}")
        return None

    try:
        text = strip_front_matter_and_comments(raw)
        file_title = humanize_name(path.stem)

        sections = split_into_sections(text, fallback_title=file_title)

        lessons: List[Lesson] = []
        seen_hashes: set[str] = set()

        for heading, section_raw in sections:
            if JUNK_HEADING_RE.match(heading.strip()):
                continue  # drop references/bibliography/quiz/contributors/etc.

            body, code_snippet, has_image = clean_section_body(section_raw)
            if not body.strip() and not code_snippet.strip():
                continue  # nothing left worth teaching after cleaning

            lesson_title = humanize_name(heading) if heading != file_title else heading
            for part_title, part_body, part_code, part_has_image in split_long_lesson(
                lesson_title, body, code_snippet, has_image
            ):
                if not part_body.strip() and not part_code.strip():
                    continue

                h = lesson_hash(part_title, part_body)
                if h in seen_hashes:
                    continue  # never generate duplicate lessons within a course
                seen_hashes.add(h)

                lessons.append(Lesson(
                    title=part_title,
                    body=part_body,
                    code_snippet=part_code,
                    has_image=part_has_image,
                    content_hash=h,
                ))

        if not lessons:
            print(f"  WARNING: no usable lessons found in {path}, skipping course")
            return None

        course_id = id_factory.make(slugify(file_title))
        total_minutes = sum(estimate_reading_minutes(l.body, l.code_snippet) for l in lessons)
        difficulties = [estimate_difficulty(l.title, l.body) for l in lessons]
        overall_difficulty = max(set(difficulties), key=difficulties.count)

        return Course(
            id=course_id,
            title=file_title,
            description=generate_description(file_title, [l.title for l in lessons]),
            duration=format_duration(total_minutes),
            difficulty=overall_difficulty,
            lessons=lessons,
        )
    except Exception as exc:  # a single bad file must never crash the run
        print(f"  WARNING: failed to process {path}: {exc}")
        return None


# ==========================================================================
# Dart rendering
# ==========================================================================

def dart_escape(text: str) -> str:
    text = "".join(ch for ch in text if ch in "\n\t" or unicodedata.category(ch)[0] != "C")
    text = text.replace("\\", "\\\\").replace("$", "\\$").replace("'", "\\'")
    return text


def dart_str(text: str) -> str:
    return f"'''{dart_escape(text)}'''"


def render_lesson(lesson: Lesson) -> str:
    return (
        "      AppLesson(\n"
        f"        title: {dart_str(lesson.title)},\n"
        f"        body: {dart_str(lesson.body)},\n"
        f"        codeSnippet: {dart_str(lesson.code_snippet)},\n"
        f"        hasImage: {'true' if lesson.has_image else 'false'},\n"
        "      )"
    )


def render_course(course: Course) -> str:
    lessons_dart = ",\n".join(render_lesson(l) for l in course.lessons)
    return (
        "  AppCourse(\n"
        f"    id: '{course.id}',\n"
        f"    title: {dart_str(course.title)},\n"
        f"    description: {dart_str(course.description)},\n"
        f"    instructor: {dart_str(INSTRUCTOR)},\n"
        f"    duration: '{course.duration}',\n"
        f"    difficulty: '{course.difficulty}',\n"
        f"    category: {dart_str(CATEGORY)},\n"
        f"    icon: {ICON},\n"
        f"    color: {COLOR},\n"
        "    lessons: [\n"
        f"{lessons_dart}\n"
        "    ],\n"
        "  )"
    )


def render_dart_file(courses: List[Course]) -> str:
    header = (
        "// GENERATED FILE - DO NOT EDIT BY HAND\n"
        "// Produced by generate_cybersecurity_courses.py\n\n"
        "import 'package:flutter/material.dart';\n"
        "import '../models/course_models.dart';\n\n"
    )
    course_blocks = ",\n".join(render_course(c) for c in courses)
    body = (
        "final List<AppCourse> cybersecurityCourses = [\n"
        f"{course_blocks}\n"
        "];\n"
    )
    return header + body


# ==========================================================================
# CLI / orchestration
# ==========================================================================

def parse_args(argv: Optional[List[str]] = None) -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Offline generator: assets/cybersecurity_docs .md files -> Flutter cybersecurity course catalog."
    )
    parser.add_argument("--source", default=DEFAULT_SOURCE,
                         help="Folder to scan for .md files (default: %(default)s)")
    parser.add_argument("--output", default=DEFAULT_OUTPUT,
                         help="Path to write the generated Dart file (default: %(default)s)")
    return parser.parse_args(argv)


def main(argv: Optional[List[str]] = None) -> int:
    args = parse_args(argv)
    source_folder = Path(args.source)
    output_path = Path(args.output)

    if not source_folder.exists():
        print(f"ERROR: source folder does not exist: {source_folder}")
        return 1

    md_paths = discover_markdown_files(source_folder)
    total = len(md_paths)
    if total == 0:
        print(f"ERROR: no .md files found under {source_folder}")
        return 1

    id_factory = UniqueIdFactory()
    courses: List[Course] = []
    global_lesson_hashes: set[str] = set()

    for i, path in enumerate(md_paths, start=1):
        print(f"Reading {i}/{total}: {path}")
        course = build_course_from_markdown(path, id_factory)
        if course is None:
            continue

        # Never generate duplicate lessons across the whole catalog, not
        # just within one course (e.g. the same explanation repeated in
        # two different source files).
        unique_lessons = []
        for lesson in course.lessons:
            if lesson.content_hash in global_lesson_hashes:
                continue
            global_lesson_hashes.add(lesson.content_hash)
            unique_lessons.append(lesson)

        if not unique_lessons:
            print(f"  WARNING: all lessons in {path} were duplicates, skipping course")
            continue

        course.lessons = unique_lessons
        courses.append(course)

    if not courses:
        print("ERROR: no courses could be generated; nothing to write.")
        return 1

    print("Generating Dart...")
    dart_source = render_dart_file(courses)

    output_path.parent.mkdir(parents=True, exist_ok=True)
    output_path.write_text(dart_source, encoding="utf-8")

    total_lessons = sum(len(c.lessons) for c in courses)
    print()
    print("Courses generated:", len(courses))
    print("Lessons generated:", total_lessons)
    print("Output file:", output_path)
    return 0


if __name__ == "__main__":
    sys.exit(main())

