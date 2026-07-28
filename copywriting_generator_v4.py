#!/usr/bin/env python3
# copywriting_generator_v4.py
#
# Hustle Academy - Copywriting Course Generator (v4)
# =====================================================
#
# Single-purpose generator (NOT universal). Built from scratch,
# independent of any previous version.
#
# Reads:
#     marketing-skills/copywriting/SKILL.md
#
# Writes:
#     lib/courses/copywriting_courses.dart
#
# Exports:
#     final copywritingCourses = <AppCourse>[ ... ];
#
# Rules:
#     - Each "#" (H1) heading becomes one AppCourse.
#     - Each "##", "###", "####" heading becomes one AppLesson inside
#       the current course.
#     - All lesson text is preserved (paragraphs, line breaks, blank
#       lines).
#     - Lesson body is generated as a normal escaped Dart string (never
#       a raw triple-quoted string) - every character that could break
#       Dart compilation is escaped.
#     - Output Dart is guaranteed syntactically valid regardless of what
#       the Markdown contains: code fences, HTML, JSON, YAML, XML, PHP,
#       shell scripts, Markdown tables, backticks, dollar signs, smart
#       quotes, apostrophes, emoji, and any run of quote characters.
#
# Python 3 standard library only. Runs in Termux with:
#     python3 copywriting_generator_v4.py

from __future__ import annotations

import re
import sys
import unicodedata
from pathlib import Path

# =============================================================================
# FIXED CONFIG - this generator is intentionally single-purpose
# =============================================================================

SOURCE_FILE = Path("marketing-skills/copywriting/SKILL.md")
OUTPUT_FILE = Path("lib/courses/copywriting_courses.dart")

# Must match what the Flutter app imports.
DART_VARIABLE_NAME = "copywritingCourses"

INSTRUCTOR = "Hustle Academy"
CATEGORY = "Copywriting"
DIFFICULTY = "Beginner"
ICON = "Icons.edit_note"
COLOR = "Colors.deepPurple"

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
    "acknowledg",
]

HEADING_RE = re.compile(r"^(#{1,4})\s+(.*?)\s*$")
CODE_FENCE_RE = re.compile(r"```[ \t]*[a-zA-Z0-9_+-]*\n(.*?)```", re.DOTALL)
IMAGE_MD_RE = re.compile(r"!\[[^\]]*\]\([^)]*\)")
IMAGE_HTML_RE = re.compile(r"<img\b", re.IGNORECASE)
NON_SLUG_CHARS_RE = re.compile(r"[^a-z0-9\-]+")
MULTI_DASH_RE = re.compile(r"-{2,}")


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


def extract_first_code_block(text: str):
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


def build_description(course_title: str, lessons: "list[Lesson]") -> str:
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
    return f"{course_title} - {lesson_count} {plural}."


def estimate_duration(lessons: "list[Lesson]") -> str:
    total_words = 0
    for lesson in lessons:
        total_words += len(lesson.body_text().split())
    minutes = max(MIN_DURATION_MINUTES, round(total_words / WORDS_PER_MINUTE))
    return f"{minutes} min"


# =============================================================================
# DART STRING ESCAPING - MUST NEVER PRODUCE INVALID DART
# =============================================================================
#
# escape_dart_string() turns arbitrary text into content that is safe to
# place inside a NORMAL (non-raw) Dart double-quoted string literal, kept
# on a single logical line. The steps run in this exact order:
#
#   1. Normalize every kind of line break - CRLF, lone CR, NEL, the
#      Unicode LINE SEPARATOR, and the Unicode PARAGRAPH SEPARATOR - down
#      to a plain "\n" marker BEFORE any escaping happens. This ensures no
#      raw line-break character of any kind can survive into the Dart
#      source.
#   2. Escape backslash characters first, so escape sequences added in
#      later steps are never themselves re-escaped.
#   3. Escape the dollar sign so Dart never attempts string
#      interpolation. This neutralizes shell-style variables, PHP-style
#      variables, and template placeholders alike.
#   4. Escape double-quote characters one at a time. Because each quote
#      is handled individually, any run of consecutive quote characters
#      - however many appear back to back in the source Markdown - is
#      made safe and can never terminate the Dart string early.
#   5. Convert the normalized newline and literal tab characters into
#      their escaped Dart equivalents, so the resulting Dart source
#      never contains a raw line break or raw tab inside the string.
#   6. Replace any remaining genuine Unicode control character (category
#      "Cc") with a plain space. This step deliberately leaves every
#      other codepoint untouched, including emoji, zero-width joiners,
#      variation selectors, combining marks, and smart quotes, so
#      multi-codepoint emoji sequences and typographic punctuation stay
#      fully intact.
#
# The result is safe for code fences, HTML tags, JSON, YAML, XML, PHP
# snippets, shell scripts, Markdown tables, backticks, dollar signs,
# single and double quotes (including smart/curly quotes), apostrophes,
# and any combination thereof.

def escape_dart_string(text) -> str:
    if text is None:
        return ""

    # 1. Normalize all line-break variants to a single "\n" concept.
    normalized = text.replace("\r\n", "\n").replace("\r", "\n")
    normalized = normalized.replace("\u2028", "\n")  # LINE SEPARATOR
    normalized = normalized.replace("\u2029", "\n")  # PARAGRAPH SEPARATOR
    normalized = normalized.replace("\u0085", "\n")  # NEXT LINE (NEL)

    # 2. Backslashes must be escaped first.
    escaped = normalized.replace("\\", "\\\\")

    # 3. Escape Dart string interpolation trigger.
    escaped = escaped.replace("$", "\\$")

    # 4. Escape the delimiter character, one quote at a time.
    escaped = escaped.replace('"', '\\"')

    # 5. Flatten real control characters into literal escape sequences.
    escaped = escaped.replace("\n", "\\n")
    escaped = escaped.replace("\t", "\\t")

    # 6. Strip ONLY genuine Unicode control characters ("Cc"); leave
    #    every other codepoint - including emoji, ZWJ, variation
    #    selectors, smart quotes, and non-Latin scripts - fully intact.
    escaped = "".join(
        ch if unicodedata.category(ch) != "Cc" else " "
        for ch in escaped
    )

    return escaped


def dart_string_literal(text: str) -> str:
    return '"' + escape_dart_string(text) + '"'


def dart_nullable_string_literal(text) -> str:
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


def parse_courses(markdown_text: str) -> "list[Course]":
    lines = markdown_text.split("\n")

    courses: "list[Course]" = []
    seen_course_ids: set = set()

    current_course = None
    current_lesson = None

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

                current_course = Course(heading_text, unique_id)
                courses.append(current_course)
                current_lesson = None
            else:
                if current_course is None:
                    current_lesson = None
                    continue
                current_lesson = Lesson(heading_text)
                current_course.lessons.append(current_lesson)

            continue

        if skip_active:
            continue
        if current_lesson is not None:
            current_lesson.body_lines.append(line)

    return courses


def finalize_courses(courses: "list[Course]") -> "list[Course]":
    finalized: "list[Course]" = []

    for course in courses:
        if not course.lessons:
            continue  # no lesson headings found under this course - skip it

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


def generate_dart_file(courses: "list[Course]") -> str:
    header = (
        "// GENERATED FILE - DO NOT EDIT BY HAND.\n"
        "// Produced by copywriting_generator_v4.py\n"
        f"// Source: {SOURCE_FILE.as_posix()}\n\n"
        "import 'package:flutter/material.dart';\n"
        "import '../models/app_course.dart';\n\n"
        f"final {DART_VARIABLE_NAME} = <AppCourse>[\n"
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

