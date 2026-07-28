#!/usr/bin/env python3
"""
generate_flutter_courses.py

Reads Flutter/Dart documentation Markdown files from assets/flutter_docs/,
converts them into AppCourse / AppLesson data, and generates
lib/courses/flutter_courses.dart for Hustle Academy.

Usage:
    python3 tools/generate_flutter_courses.py

NOTE ON ASSUMPTIONS:
The exact field types of the existing `AppCourse` / `AppLesson` classes
were not available to this script, so the following reasonable defaults
are used and can be adjusted below if they don't match your models:
  - AppCourse.icon  -> IconData (Icons.*)
  - AppCourse.color -> Color(0xFFRRGGBB)
  - difficulty/duration are heuristically generated (see DIFFICULTY_MAP
    and format_duration()).
If your model import path differs from '../models/app_course.dart',
update MODEL_IMPORT_PATH below.
"""

from __future__ import annotations

import logging
import re
import sys
from dataclasses import dataclass, field
from datetime import datetime, timezone
from pathlib import Path
from typing import List, Optional

# --------------------------------------------------------------------------
# Configuration
# --------------------------------------------------------------------------

PROJECT_ROOT = Path(__file__).resolve().parent.parent
INPUT_DIR = PROJECT_ROOT / "assets" / "flutter_docs"
OUTPUT_DIR = PROJECT_ROOT / "lib" / "courses"
OUTPUT_FILE = OUTPUT_DIR / "flutter_courses.dart"

MODEL_IMPORT_PATH = "../models/app_course.dart"

INSTRUCTOR = "Flutter Team"
CATEGORY = "Mobile Development"
DEFAULT_DIFFICULTY = "Beginner to Advanced"
DEFAULT_ICON = "Icons.flutter_dash"
DEFAULT_COLOR_PALETTE = [
    "0xFF42A5F5",
    "0xFF66BB6A",
    "0xFFAB47BC",
    "0xFFFFA726",
    "0xFFEF5350",
    "0xFF26C6DA",
    "0xFF8D6E63",
    "0xFF7E57C2",
    "0xFFEC407A",
    "0xFF9CCC65",
]

DIFFICULTY_MAP = {
    "ui": "Beginner to Intermediate",
    "cookbook": "Beginner to Intermediate",
    "app-architecture": "Intermediate to Advanced",
    "data-and-backend": "Intermediate to Advanced",
    "testing": "Intermediate to Advanced",
    "deployment": "Intermediate to Advanced",
    "platform-integration": "Intermediate to Advanced",
}

ICON_MAP = {
    "ui": "Icons.widgets",
    "cookbook": "Icons.menu_book",
    "app-architecture": "Icons.architecture",
    "data-and-backend": "Icons.storage",
    "testing": "Icons.bug_report",
    "deployment": "Icons.rocket_launch",
    "platform-integration": "Icons.integration_instructions",
}

COLOR_MAP = {
    "ui": "0xFF42A5F5",
    "cookbook": "0xFF66BB6A",
    "app-architecture": "0xFFAB47BC",
    "data-and-backend": "0xFFFFA726",
    "testing": "0xFFEF5350",
    "deployment": "0xFF26C6DA",
    "platform-integration": "0xFF8D6E63",
}

MINOR_WORDS = {
    "and", "or", "of", "the", "in", "on", "to", "for", "a", "an", "with", "vs",
}

ACRONYMS = {
    "ui": "UI",
    "api": "API",
    "sql": "SQL",
    "http": "HTTP",
    "json": "JSON",
    "ios": "iOS",
}

logging.basicConfig(level=logging.INFO, format="%(message)s")
logger = logging.getLogger("generate_flutter_courses")


# --------------------------------------------------------------------------
# Data classes
# --------------------------------------------------------------------------

@dataclass
class Lesson:
    title: str
    body: str
    code_snippet: str
    has_image: bool
    rel_path: str


@dataclass
class Course:
    key: str
    title: str
    lessons: List[Lesson] = field(default_factory=list)


# --------------------------------------------------------------------------
# Filesystem helpers
# --------------------------------------------------------------------------

def is_hidden(name: str) -> bool:
    return name.startswith(".")


def should_skip_dir(name: str) -> bool:
    return is_hidden(name) or name.startswith("_")


def should_skip_file(name: str) -> bool:
    if is_hidden(name):
        return True
    if name.lower() == "readme.md":
        return True
    if not name.lower().endswith(".md"):
        return True
    return False


def find_markdown_files(root: Path) -> List[Path]:
    """Recursively walk `root`, pruning hidden/underscore folders."""
    results: List[Path] = []
    if not root.exists():
        logger.warning("Input directory does not exist: %s", root)
        return results

    for current_dir, dirnames, filenames in _walk(root):
        for filename in sorted(filenames):
            if should_skip_file(filename):
                continue
            results.append(current_dir / filename)
    return results


def _walk(root: Path):
    """os.walk-like generator using pathlib, pruning skip-worthy dirs."""
    import os

    for dirpath, dirnames, filenames in os.walk(root):
        # Prune in-place so os.walk does not descend into skipped dirs.
        dirnames[:] = sorted(d for d in dirnames if not should_skip_dir(d))
        yield Path(dirpath), dirnames, filenames


# --------------------------------------------------------------------------
# Markdown processing
# --------------------------------------------------------------------------

CODE_BLOCK_PATTERN = re.compile(r"```[ \t]*[A-Za-z0-9_+-]*\r?\n(.*?)```", re.DOTALL)
IMAGE_PATTERN = re.compile(r"!\[[^\]]*\]\([^)]*\)")
HEADING_PATTERN = re.compile(r"^\s{0,3}#\s+(.+?)\s*$", re.MULTILINE)


def extract_code_blocks(text: str) -> tuple[str, str]:
    """Return (joined_code_snippet, text_with_code_blocks_removed)."""
    matches = CODE_BLOCK_PATTERN.findall(text)
    code_snippet = "\n\n".join(m.strip("\n") for m in matches).strip()
    text_without_code = CODE_BLOCK_PATTERN.sub("", text)
    return code_snippet, text_without_code


def extract_title(text_without_code: str) -> Optional[str]:
    match = HEADING_PATTERN.search(text_without_code)
    if match:
        return match.group(1).strip()
    return None


def remove_first_heading(text: str) -> str:
    return HEADING_PATTERN.sub("", text, count=1)


def strip_markdown(text: str) -> str:
    """Strip common Markdown syntax while preserving readable text."""
    # Images (already captured via has_image detection before this call)
    text = IMAGE_PATTERN.sub("", text)
    # Links: [text](url) -> text
    text = re.sub(r"\[([^\]]*)\]\([^)]*\)", r"\1", text)
    # Reference-style link definitions: [id]: url
    text = re.sub(r"^\s*\[[^\]]+\]:\s*\S+.*$", "", text, flags=re.MULTILINE)
    # Inline code: `code` -> code
    text = re.sub(r"`([^`]*)`", r"\1", text)
    # Bold+italic (*** or ___)
    text = re.sub(r"(\*\*\*|___)(.+?)\1", r"\2", text, flags=re.DOTALL)
    # Bold (** or __)
    text = re.sub(r"(\*\*|__)(.+?)\1", r"\2", text, flags=re.DOTALL)
    # Italic (* or _)
    text = re.sub(r"(?<!\w)(\*|_)(.+?)\1(?!\w)", r"\2", text, flags=re.DOTALL)
    # Headings: strip leading #'s
    text = re.sub(r"^\s{0,3}#{1,6}\s*", "", text, flags=re.MULTILINE)
    # Blockquotes
    text = re.sub(r"^\s{0,3}>\s?", "", text, flags=re.MULTILINE)
    # Horizontal rules
    text = re.sub(r"^\s*([-*_]\s*){3,}$", "", text, flags=re.MULTILINE)
    # Unordered list markers
    text = re.sub(r"^\s*[-*+]\s+", "", text, flags=re.MULTILINE)
    # Ordered list markers
    text = re.sub(r"^\s*\d+\.\s+", "", text, flags=re.MULTILINE)
    # Table pipes
    text = text.replace("|", " ")
    # Raw HTML tags
    text = re.sub(r"<[^>]+>", "", text)
    # Collapse excessive blank lines
    text = re.sub(r"\n{3,}", "\n\n", text)
    # Trim trailing whitespace per line
    lines = [line.rstrip() for line in text.split("\n")]
    text = "\n".join(lines).strip()
    return text


def filename_to_title(path: Path) -> str:
    stem = path.stem.replace("_", " ").replace("-", " ")
    return " ".join(word.capitalize() for word in stem.split())


def process_markdown_file(path: Path, rel_path: str) -> Optional[Lesson]:
    try:
        raw_text = path.read_text(encoding="utf-8")
    except UnicodeDecodeError:
        logger.warning("Skipping non-UTF-8 file: %s", rel_path)
        return None

    if not raw_text.strip():
        logger.info("Skipping empty file: %s", rel_path)
        return None

    has_image = bool(IMAGE_PATTERN.search(raw_text))
    code_snippet, text_without_code = extract_code_blocks(raw_text)

    title = extract_title(text_without_code)
    if title:
        body_source = remove_first_heading(text_without_code)
    else:
        title = filename_to_title(path)
        body_source = text_without_code

    body = strip_markdown(body_source)

    return Lesson(
        title=title,
        body=body,
        code_snippet=code_snippet,
        has_image=has_image,
        rel_path=rel_path,
    )


# --------------------------------------------------------------------------
# Course grouping / title casing
# --------------------------------------------------------------------------

def folder_key_to_title(key: str) -> str:
    lower_key = key.lower()
    if lower_key in ACRONYMS:
        return ACRONYMS[lower_key]

    words = re.split(r"[-_]+", lower_key)
    titled_words = []
    for index, word in enumerate(words):
        if word in ACRONYMS:
            titled_words.append(ACRONYMS[word])
        elif index > 0 and word in MINOR_WORDS:
            titled_words.append(word)
        else:
            titled_words.append(word.capitalize())
    return " ".join(titled_words)


def format_duration(total_minutes: int) -> str:
    if total_minutes <= 0:
        return "0m"
    hours, minutes = divmod(total_minutes, 60)
    if hours and minutes:
        return f"{hours}h {minutes}m"
    if hours:
        return f"{hours}h"
    return f"{minutes}m"


def color_for(course_key: str, index: int) -> str:
    if course_key in COLOR_MAP:
        return COLOR_MAP[course_key]
    return DEFAULT_COLOR_PALETTE[index % len(DEFAULT_COLOR_PALETTE)]


def icon_for(course_key: str) -> str:
    return ICON_MAP.get(course_key, DEFAULT_ICON)


def difficulty_for(course_key: str) -> str:
    return DIFFICULTY_MAP.get(course_key, DEFAULT_DIFFICULTY)


# --------------------------------------------------------------------------
# Dart code generation
# --------------------------------------------------------------------------

def escape_dart_string(text: str) -> str:
    """Escape a Python string for safe embedding in a Dart double-quoted string."""
    text = text.replace("\\", "\\\\")
    text = text.replace("$", "\\$")
    text = text.replace('"', '\\"')
    text = text.replace("\r\n", "\n")
    text = text.replace("\n", "\\n")
    text = text.replace("\t", "\\t")
    return text


def dart_string_literal(text: str) -> str:
    return f'"{escape_dart_string(text)}"'


def render_lesson(lesson: Lesson, indent: str = "      ") -> str:
    return (
        f"{indent}AppLesson(\n"
        f"{indent}  title: {dart_string_literal(lesson.title)},\n"
        f"{indent}  body: {dart_string_literal(lesson.body)},\n"
        f"{indent}  codeSnippet: {dart_string_literal(lesson.code_snippet)},\n"
        f"{indent}  hasImage: {str(lesson.has_image).lower()},\n"
        f"{indent}),\n"
    )


def render_course(course: Course, index: int) -> str:
    lessons_dart = "".join(render_lesson(lesson) for lesson in course.lessons)
    total_minutes = len(course.lessons) * 15
    description = (
        f"Official Flutter documentation lessons covering {course.title}."
    )

    return (
        "  AppCourse(\n"
        f"    id: {dart_string_literal(course.key)},\n"
        f"    title: {dart_string_literal(course.title)},\n"
        f"    description: {dart_string_literal(description)},\n"
        f"    instructor: {dart_string_literal(INSTRUCTOR)},\n"
        f"    category: {dart_string_literal(CATEGORY)},\n"
        f"    difficulty: {dart_string_literal(difficulty_for(course.key))},\n"
        f"    icon: {icon_for(course.key)},\n"
        f"    color: const Color({color_for(course.key, index)}),\n"
        f"    duration: {dart_string_literal(format_duration(total_minutes))},\n"
        "    lessons: [\n"
        f"{lessons_dart}"
        "    ],\n"
        "  ),\n"
    )


def render_dart_file(courses: List[Course]) -> str:
    timestamp = datetime.now(timezone.utc).strftime("%Y-%m-%d %H:%M:%S UTC")
    header = (
        "// GENERATED FILE - DO NOT EDIT MANUALLY.\n"
        "//\n"
        "// This file was automatically generated by\n"
        "// tools/generate_flutter_courses.py\n"
        f"// Generated on: {timestamp}\n"
        "//\n"
        "// Source: assets/flutter_docs/\n"
        "// To regenerate, run: python3 tools/generate_flutter_courses.py\n\n"
        "import 'package:flutter/material.dart';\n"
        f"import '{MODEL_IMPORT_PATH}';\n\n"
    )

    courses_dart = "".join(render_course(course, i) for i, course in enumerate(courses))

    body = (
        "final List<AppCourse> flutterCourses = [\n"
        f"{courses_dart}"
        "];\n"
    )

    return header + body


# --------------------------------------------------------------------------
# Main pipeline
# --------------------------------------------------------------------------

def build_courses(input_dir: Path) -> List[Course]:
    md_files = find_markdown_files(input_dir)
    logger.info("Found %d candidate Markdown file(s) under %s", len(md_files), input_dir)

    courses_by_key: dict[str, Course] = {}

    for path in md_files:
        rel_path = path.relative_to(input_dir).as_posix()
        parts = rel_path.split("/")
        if len(parts) < 2:
            # File directly under assets/flutter_docs/ with no subfolder
            # cannot be grouped by "first folder" — skip with a warning.
            logger.warning("Skipping file with no top-level folder: %s", rel_path)
            continue

        course_key = parts[0]
        if should_skip_dir(course_key):
            continue

        lesson = process_markdown_file(path, rel_path)
        if lesson is None:
            continue

        course = courses_by_key.setdefault(
            course_key,
            Course(key=course_key, title=folder_key_to_title(course_key)),
        )
        course.lessons.append(lesson)

    for course in courses_by_key.values():
        course.lessons.sort(key=lambda lesson: lesson.rel_path)

    courses = sorted(courses_by_key.values(), key=lambda c: c.title)
    return courses


def main() -> int:
    logger.info("Scanning %s ...", INPUT_DIR)
    courses = build_courses(INPUT_DIR)

    if not courses:
        logger.warning("No courses were generated. Check %s for content.", INPUT_DIR)

    total_lessons = sum(len(course.lessons) for course in courses)

    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
    dart_code = render_dart_file(courses)
    OUTPUT_FILE.write_text(dart_code, encoding="utf-8")

    logger.info("-" * 60)
    logger.info("Generated %d course(s) and %d lesson(s).", len(courses), total_lessons)
    for course in courses:
        logger.info("  - %s: %d lesson(s)", course.title, len(course.lessons))
    logger.info("Output written to: %s", OUTPUT_FILE)
    logger.info("-" * 60)

    return 0


if __name__ == "__main__":
    sys.exit(main())

