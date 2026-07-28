#!/usr/bin/env python3
"""
Hustle Academy — Entrepreneurship Course Generator
====================================================

Single-purpose generator (NOT universal).

Reads:
    Startup-CTO-Handbook/StartupCTOHandbook.md

Writes:
    lib/courses/entrepreneurship_courses.dart

Rules:
    - Each "#" (H1) heading becomes one AppCourse.
    - Each "##", "###", "####" heading inside a course becomes one AppLesson.
    - Sections named Dedications, Praise, Contents, Introduction,
      The Author, and Using this Book are skipped entirely (including
      any sub-headings and content beneath them), whether they appear
      as a course heading or a lesson heading.
    - All lesson text is preserved.
    - Output Dart is escaped so it can never fail to compile.

Python 3 standard library only. Runs in Termux with:
    python3 generate_entrepreneurship.py
"""

from __future__ import annotations

import re
import sys
import unicodedata
from pathlib import Path

# =============================================================================
# FIXED CONFIG — this generator is intentionally single-purpose
# =============================================================================

SOURCE_FILE = Path("Startup-CTO-Handbook/StartupCTOHandbook.md")
OUTPUT_FILE = Path("lib/courses/entrepreneurship_courses.dart")

INSTRUCTOR = "Hustle Academy"
CATEGORY = "Entrepreneurship"
DIFFICULTY = "Intermediate"
ICON = "Icons.business_center"
COLOR = "Colors.orange"

WORDS_PER_MINUTE = 200
MIN_DURATION_MINUTES = 5

# Section names to skip entirely (case-insensitive substring match),
# whether they appear as a course (#) heading or a lesson (##/###/####)
# heading. Skipping a heading also skips everything nested beneath it.
SKIP_SECTION_KEYWORDS = [
    "dedication",
    "praise",
    "contents",
    "introduction",
    "the author",
    "using this book",
]

HEADING_RE = re.compile(r"^(#{1,4})\s+(.*?)\s*$")
CODE_FENCE_RE = re.compile(r"```[ \t]*[a-zA-Z0-9_+-]*\n(.*?)```", re.DOTALL)
IMAGE_MD_RE = re.compile(r"!\[[^\]]*\]\([^)]*\)")
IMAGE_HTML_RE = re.compile(r"<img\b", re.IGNORECASE)
NON_SLUG_CHARS_RE = re.compile(r"[^a-z0-9\-]+")
MULTI_DASH_RE = re.compile(r"-{2,}")
WHITESPACE_RE = re.compile(r"\s+")


# =============================================================================
# DATA STRUCTURES
# =============================================================================

class Lesson:
    __slots__ = ("title", "body_lines", "code_snippet", "has_image")

    def __init__(self, title: str):
        self.title = title
        self.body_lines: list[str] = []
        self.code_snippet = None
        self.has_image = False

    def body_text(self) -> str:
        return "\n".join(self.body_lines).strip("\n")


class Course:
    __slots__ = ("course_id", "title", "description", "duration", "lessons")

    def __init__(self, title: str, course_id: str):
        self.title = title
        self.course_id = course_id
        self.description = ""
        self.duration = ""
        self.lessons: list[Lesson] = []


# =============================================================================
# TEXT HELPERS
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


def extract_first_code_block(text: str) -> str | None:
    match = CODE_FENCE_RE.search(text)
    if not match:
        return None
    snippet = match.group(1).strip("\n")
    if not snippet.strip():
        return None
    return snippet


def detect_has_image(text: str) -> bool:
    if IMAGE_MD_RE.search(text):
        return True
    if IMAGE_HTML_RE.search(text):
        return True
    return False


def first_meaningful_line(text: str) -> str:
    for line in text.split("\n"):
        stripped = line.strip()
        if not stripped:
            continue
        stripped = re.sub(r"^#+\s*", "", stripped).strip()
        stripped = re.sub(r"[*_`>\[\]()!]", "", stripped).strip()
        if stripped:
            return stripped
    return ""


def build_description(course_title: str, lessons: list[Lesson]) -> str:
    seed = ""
    for lesson in lessons:
        seed = first_meaningful_line(lesson.body_text())
        if seed:
            break
    if seed:
        if len(seed) > 160:
            seed = seed[:157].rstrip() + "..."
        return seed
    lesson_count = len(lessons)
    plural = "lesson" if lesson_count == 1 else "lessons"
    return f"{course_title} — {lesson_count} {plural}."


def estimate_duration(lessons: list[Lesson]) -> str:
    total_words = 0
    for lesson in lessons:
        total_words += len(lesson.body_text().split())
    minutes = max(MIN_DURATION_MINUTES, round(total_words / WORDS_PER_MINUTE))
    return f"{minutes} min"


# =============================================================================
# DART STRING ESCAPING — MUST NEVER PRODUCE INVALID DART
# =============================================================================

def escape_dart_string(text: str) -> str:
    """
    Escape arbitrary text for safe embedding inside a Dart double-quoted
    string literal on a single line. Safe for markdown tables, HTML, PHP,
    JSON, YAML, code fences, emoji, unicode, and any control characters.
    Nothing here can terminate the Dart string literal early.
    """
    if text is None:
        return ""

    normalized = text.replace("\r\n", "\n").replace("\r", "\n")

    # 1. Backslashes must be escaped first.
    escaped = normalized.replace("\\", "\\\\")

    # 2. Escape Dart string interpolation trigger.
    escaped = escaped.replace("$", "\\$")

    # 3. Escape the delimiter character we wrap the string in.
    escaped = escaped.replace('"', '\\"')

    # 4. Flatten real control characters into literal escape sequences.
    escaped = escaped.replace("\n", "\\n")
    escaped = escaped.replace("\t", "\\t")

    # 5. Strip any other stray control characters (keep unicode/emoji intact).
    escaped = "".join(
        ch if (ch == " " or ch.isprintable()) else " "
        for ch in escaped
    )

    return escaped


def dart_string_literal(text: str) -> str:
    return '"' + escape_dart_string(text) + '"'


def dart_nullable_string_literal(text: str | None) -> str:
    if text is None:
        return "null"
    return dart_string_literal(text)


# =============================================================================
# PARSING
# =============================================================================

def read_source_file(path: Path) -> str:
    if not path.exists():
        print(f"ERROR: source file not found: {path}", file=sys.stderr)
        sys.exit(1)
    raw = path.read_bytes()
    text = raw.decode("utf-8", errors="replace")
    text = text.replace("\r\n", "\n").replace("\r", "\n")
    return text


def parse_courses(markdown_text: str) -> list[Course]:
    lines = markdown_text.split("\n")

    courses: list[Course] = []
    seen_course_ids: set = set()

    current_course: Course | None = None
    current_lesson: Lesson | None = None

    # Skip-tracking: when a heading matches the skip list, everything
    # nested beneath it (deeper heading levels + content) is ignored
    # until a heading of equal-or-shallower level appears.
    skip_active = False
    skip_level = 0

    for line in lines:
        match = HEADING_RE.match(line)

        if match:
            level = len(match.group(1))
            heading_text = match.group(2).strip()

            # Determine whether a currently-active skip has ended.
            if skip_active and level <= skip_level:
                skip_active = False

            if is_skip_heading(heading_text):
                skip_active = True
                skip_level = level
                if level == 1:
                    current_course = None
                    current_lesson = None
                else:
                    current_lesson = None
                continue

            if skip_active:
                # Still nested under an active skip; ignore this heading.
                continue

            if level == 1:
                # New course.
                base_id = slugify(heading_text)
                unique_id = base_id
                suffix = 2
                while unique_id in seen_course_ids:
                    unique_id = f"{base_id}-{suffix}"
                    suffix += 1
                seen_course_ids.add(unique_id)

                current_course = Course(heading_text, unique_id)
                courses.append(current_course)
                current_lesson = None
            else:
                # New lesson (##, ###, ####) inside the current course.
                if current_course is None:
                    # Heading appears before any H1 course — ignore it,
                    # there is nowhere to attach a lesson.
                    current_lesson = None
                    continue
                current_lesson = Lesson(heading_text)
                current_course.lessons.append(current_lesson)

            continue

        # Non-heading content line.
        if skip_active:
            continue
        if current_lesson is not None:
            current_lesson.body_lines.append(line)
        # Content before any lesson heading (e.g. text directly under an
        # H1 with no ## yet) is intentionally not captured as a lesson,
        # since every AppLesson must come from a ##/###/#### heading.

    return courses


def finalize_courses(courses: list[Course]) -> list[Course]:
    finalized: list[Course] = []

    for course in courses:
        if not course.lessons:
            continue  # no lesson headings found under this course — skip it

        for lesson in course.lessons:
            body_text = lesson.body_text()
            lesson.code_snippet = extract_first_code_block(body_text)
            lesson.has_image = detect_has_image(body_text)

        course.description = build_description(course.title, course.lessons)
        course.duration = estimate_duration(course.lessons)
        finalized.append(course)

    return finalized


# =============================================================================
# DART CODE GENERATION
# =============================================================================

def generate_lesson_dart(lesson: Lesson, indent: str) -> str:
    lines = []
    lines.append(f"{indent}AppLesson(")
    lines.append(f"{indent}  title: {dart_string_literal(lesson.title)},")
    lines.append(f"{indent}  body: {dart_string_literal(lesson.body_text())},")
    lines.append(f"{indent}  codeSnippet: {dart_nullable_string_literal(lesson.code_snippet)},")
    lines.append(f"{indent}  hasImage: {'true' if lesson.has_image else 'false'},")
    lines.append(f"{indent}),")
    return "\n".join(lines)


def generate_course_dart(course: Course) -> str:
    lines = []
    lines.append("  AppCourse(")
    lines.append(f"    id: {dart_string_literal(course.course_id)},")
    lines.append(f"    title: {dart_string_literal(course.title)},")
    lines.append(f"    description: {dart_string_literal(course.description)},")
    lines.append(f"    instructor: {dart_string_literal(INSTRUCTOR)},")
    lines.append(f"    category: {dart_string_literal(CATEGORY)},")
    lines.append(f"    difficulty: {dart_string_literal(DIFFICULTY)},")
    lines.append(f"    icon: {ICON},")
    lines.append(f"    color: {COLOR},")
    lines.append(f"    duration: {dart_string_literal(course.duration)},")
    lines.append("    lessons: [")
    for lesson in course.lessons:
        lines.append(generate_lesson_dart(lesson, "      "))
    lines.append("    ],")
    lines.append("  ),")
    return "\n".join(lines)


def generate_dart_file(courses: list[Course]) -> str:
    header = (
        "// GENERATED FILE — DO NOT EDIT BY HAND.\n"
        "// Produced by generate_entrepreneurship.py\n"
        "// Source: Startup-CTO-Handbook/StartupCTOHandbook.md\n\n"
        "import 'package:flutter/material.dart';\n"
        "import '../models/app_course.dart';\n\n"
        "final generatedCourses = <AppCourse>[\n"
    )
    body_parts = [generate_course_dart(course) for course in courses]
    footer = "\n];\n"
    return header + "\n".join(body_parts) + footer


# =============================================================================
# MAIN
# =============================================================================

def main() -> None:
    markdown_text = read_source_file(SOURCE_FILE)

    raw_courses = parse_courses(markdown_text)
    courses = finalize_courses(raw_courses)

    if not courses:
        print("No valid courses found in source file.", file=sys.stderr)
        sys.exit(1)

    dart_code = generate_dart_file(courses)

    OUTPUT_FILE.parent.mkdir(parents=True, exist_ok=True)
    OUTPUT_FILE.write_text(dart_code, encoding="utf-8")

    total_lessons = sum(len(course.lessons) for course in courses)

    print(f"Number of courses: {len(courses)}")
    print(f"Number of lessons: {total_lessons}")
    print(f"Output filename: {OUTPUT_FILE}")
    print("Generation complete")


if __name__ == "__main__":
    main()

