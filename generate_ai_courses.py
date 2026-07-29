#!/usr/bin/env python3
"""
generate_ai_courses.py

Offline, stdlib-only generator that converts every README.md under
assets/ai_docs/ into a single Dart file:

    lib/courses/artificial_intelligence_courses.dart

No AI APIs are used anywhere in this script. Everything is done with
plain text processing (re, os, pathlib) from the Python standard library.

Each folder containing a README.md becomes one AppCourse. Each heading
inside that README becomes one AppLesson. Markdown formatting, links,
images, references/bibliography sections, quizzes, contributor/copyright
notices, and "learn more" / "further reading" sections are stripped so
only clean lesson prose and useful code examples remain.

Usage:
    python3 generate_ai_courses.py
    python3 generate_ai_courses.py --source assets/ai_docs --output lib/courses/artificial_intelligence_courses.dart
"""

from __future__ import annotations

import argparse
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

DEFAULT_SOURCE = "assets/ai_docs"
DEFAULT_OUTPUT = "lib/courses/artificial_intelligence_courses.dart"

CATEGORY = "Artificial Intelligence"
INSTRUCTOR = "Hustle Academy"
ICON = "Icons.smart_toy"
COLOR = "Colors.deepPurple"

# Folders to skip entirely (labs, exercises, repo plumbing).
IGNORE_DIR_PATTERNS = re.compile(
    r"^(\.git|\.github|node_modules|__pycache__|\.venv|venv|lab\d*|labs?|"
    r"exercises?|solutions?|assets|images|img|_site)$",
    re.IGNORECASE,
)

# Non-lesson files we never want to treat as a lesson source, even if
# somehow picked up by a broader scan.
IGNORE_FILE_NAMES = {
    "contributing.md", "license.md", "license", "changelog.md",
    "code_of_conduct.md", "security.md", "codeowners.md",
}

WORDS_PER_MINUTE = 200
MAX_LESSON_CHARS = 3000          # split lessons longer than this
SHORT_PARAGRAPH_CHARS = 160      # merge paragraphs shorter than this

# Headings whose entire section must be dropped (not lesson content).
JUNK_HEADING_RE = re.compile(
    r"^(references?|bibliography|further reading|learn more|"
    r"additional resources|quiz(zes)?|contributors?|acknowledge?ments?|"
    r"license|copyright|citation|citing)\b",
    re.IGNORECASE,
)

# Lines that are contributor/copyright noise even outside a junk section.
NOISE_LINE_RE = re.compile(
    r"^\s*(©|\(c\)|copyright\b|all rights reserved|contributors?:|"
    r"author(s)?:|maintainers?:)\b.*$",
    re.IGNORECASE,
)

BEGINNER_KEYWORDS = {
    "introduction", "overview", "basics", "getting started",
    "fundamentals", "what is", "glossary", "prerequisites",
}
ADVANCED_KEYWORDS = {
    "transformer", "backpropagation", "gradient descent", "attention mechanism",
    "reinforcement learning", "generative adversarial", "fine-tuning",
    "hyperparameter", "convolutional", "optimization", "regularization",
    "loss function", "embedding", "attention head",
}
INTERMEDIATE_KEYWORDS = {
    "neural network", "machine learning", "deep learning", "classification",
    "regression", "supervised learning", "unsupervised learning", "dataset",
    "model training", "algorithm",
}


# ==========================================================================
# Discovery
# ==========================================================================

def discover_readmes(source_folder: Path) -> List[Path]:
    """Recursively find every real README.md, skipping lab/junk folders."""
    results: List[Path] = []
    for root, dirs, files in os.walk(source_folder):
        dirs[:] = [d for d in dirs if not IGNORE_DIR_PATTERNS.match(d)]
        for filename in files:
            if filename.lower() != "readme.md":
                continue
            if filename.lower() in IGNORE_FILE_NAMES:
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
            words.append(w)  # keep acronyms: AI, NLP, GAN, CNN
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
BADGE_RE = re.compile(r"!\[[^\]]*\]\(https?://img\.shields\.io[^)]*\)")


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
    Convert markdown-formatted prose into clean plain English:
    remove hyperlinks (keep visible text), reference-link definitions,
    inline code backticks, bold/italic markers, blockquote/list markers,
    horizontal rules, table pipes, HTML tags, and leftover heading hashes.
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


def clean_section_body(raw_body: str) -> Tuple[str, str, bool]:
    """Full cleaning pipeline for one section. Returns (body, code, has_image)."""
    text, code_snippet = extract_code_blocks(raw_body)
    text, has_image = detect_and_strip_images(text)
    text = remove_noise_lines(text)
    text = strip_markdown_formatting(text)
    text = normalize_whitespace(text)
    text = merge_short_paragraphs(text)
    return text, code_snippet, has_image


def split_long_lesson(title: str, body: str, code_snippet: str, has_image: bool) -> List[Tuple[str, str, str, bool]]:
    """Split a body longer than MAX_LESSON_CHARS into multiple readable parts."""
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
        # Only attach code/image flags to the first part to avoid duplication.
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
    return "Intermediate"


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
        f"Explore {course_title} through {count} focused lesson"
        f"{'s' if count != 1 else ''}, covering {sample}."
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


@dataclass
class Course:
    id: str
    title: str
    description: str
    duration: str
    difficulty: str
    lessons: List[Lesson] = field(default_factory=list)


# ==========================================================================
# Build pipeline
# ==========================================================================

def build_course_from_readme(path: Path, id_factory: UniqueIdFactory) -> Optional[Course]:
    try:
        raw = path.read_text(encoding="utf-8", errors="replace")
    except OSError as exc:
        print(f"  WARNING: could not read {path}: {exc}")
        return None

    try:
        text = strip_front_matter_and_comments(raw)
        folder_title = humanize_name(path.parent.name)

        sections = split_into_sections(text, fallback_title=folder_title)

        lessons: List[Lesson] = []
        for heading, section_raw in sections:
            if JUNK_HEADING_RE.match(heading.strip()):
                continue  # drop references/bibliography/quiz/contributors/etc.

            body, code_snippet, has_image = clean_section_body(section_raw)
            if not body.strip() and not code_snippet.strip():
                continue  # nothing left worth teaching after cleaning

            lesson_title = humanize_name(heading) if heading != folder_title else heading
            for part_title, part_body, part_code, part_has_image in split_long_lesson(
                lesson_title, body, code_snippet, has_image
            ):
                if not part_body.strip() and not part_code.strip():
                    continue
                lessons.append(Lesson(
                    title=part_title,
                    body=part_body,
                    code_snippet=part_code,
                    has_image=part_has_image,
                ))

        if not lessons:
            print(f"  WARNING: no usable lessons found in {path}, skipping course")
            return None

        course_id = id_factory.make(slugify(folder_title))
        total_minutes = sum(estimate_reading_minutes(l.body, l.code_snippet) for l in lessons)
        difficulties = [estimate_difficulty(l.title, l.body) for l in lessons]
        overall_difficulty = max(set(difficulties), key=difficulties.count)

        return Course(
            id=course_id,
            title=folder_title,
            description=generate_description(folder_title, [l.title for l in lessons]),
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
        "// Produced by generate_ai_courses.py\n\n"
        "import 'package:flutter/material.dart';\n"
        "import '../models/course_models.dart';\n\n"
    )
    course_blocks = ",\n".join(render_course(c) for c in courses)
    body = (
        "final List<AppCourse> artificialIntelligenceCourses = [\n"
        f"{course_blocks}\n"
        "];\n"
    )
    return header + body


# ==========================================================================
# CLI / orchestration
# ==========================================================================

def parse_args(argv: Optional[List[str]] = None) -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Offline generator: assets/ai_docs README.md files -> Flutter AI course catalog."
    )
    parser.add_argument("--source", default=DEFAULT_SOURCE,
                         help="Folder to scan for README.md files (default: %(default)s)")
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

    readme_paths = discover_readmes(source_folder)
    total = len(readme_paths)
    if total == 0:
        print(f"ERROR: no README.md files found under {source_folder}")
        return 1

    id_factory = UniqueIdFactory()
    courses: List[Course] = []

    for i, path in enumerate(readme_paths, start=1):
        print(f"Reading {i}/{total}: {path}")
        course = build_course_from_readme(path, id_factory)
        if course is not None:
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

