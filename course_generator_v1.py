#!/usr/bin/env python3
"""
Hustle Academy — Universal Course Generator
=============================================

Reads a repository of Markdown files and converts it into a single Dart
file (lib/courses/generated_courses.dart) containing a list of
`AppCourse` objects that match the Hustle Academy Flutter models exactly:

    AppLesson(title, body, codeSnippet, hasImage)
    AppCourse(id, title, description, instructor, category, difficulty,
              icon, color, lessons, duration)

Only the CONFIG block below needs to change between repositories.

Python 3 standard library only. No external dependencies. Safe for
Termux / any POSIX or Windows environment.
"""

from __future__ import annotations

import os
import re
import sys
import unicodedata
from pathlib import Path

# =============================================================================
# CONFIG — CHANGE THESE VALUES ONLY
# =============================================================================

ROOT = Path("Startup-CTO-Handbook")            # folder containing markdown repo
OUTPUT = Path("lib/courses/generated_courses.dart")
CATEGORY = "Business"
INSTRUCTOR = "Hustle Academy"
DIFFICULTY = "Beginner"
ICON = "Icons.school"
COLOR = "Colors.blue"

# =============================================================================
# CONSTANTS — IGNORE RULES
# =============================================================================

IGNORED_DIR_NAMES = {
    ".git",
    ".github",
    ".vscode",
    ".idea",
    "node_modules",
    "templates",
    "template",
    "issue_template",
    "issue_templates",
    ".issue_template",
    "__pycache__",
}

IGNORED_FILE_STEMS = {
    "license",
    "changelog",
    "readme",
    "contributing",
    "code_of_conduct",
    "security",
    "claude",
    "automation",
    "template",
    "issue_template",
    "pull_request_template",
    "funding",
    "support",
}

MIN_FILE_LENGTH = 100  # characters; smaller files are skipped

WORDS_PER_MINUTE = 200
MIN_DURATION_MINUTES = 5

CODE_FENCE_RE = re.compile(r"```[ \t]*[a-zA-Z0-9_+-]*\n(.*?)```", re.DOTALL)
IMAGE_MD_RE = re.compile(r"!\[[^\]]*\]\([^)]*\)")
IMAGE_HTML_RE = re.compile(r"<img\b", re.IGNORECASE)
HEADING_STRIP_RE = re.compile(r"^#+\s*")
MD_INLINE_SYMBOLS_RE = re.compile(r"[*_`>#\[\]()!]")
MULTI_DASH_RE = re.compile(r"-{2,}")
NON_SLUG_CHARS_RE = re.compile(r"[^a-z0-9\-]+")
LEADING_NUMBER_PREFIX_RE = re.compile(r"^[0-9]+[\s._\-]+")
WHITESPACE_RE = re.compile(r"\s+")


# =============================================================================
# DATA STRUCTURES
# =============================================================================

class Lesson:
    __slots__ = ("title", "body", "code_snippet", "has_image", "source_path")

    def __init__(self, title: str, body: str, code_snippet, has_image: bool, source_path: Path):
        self.title = title
        self.body = body
        self.code_snippet = code_snippet
        self.has_image = has_image
        self.source_path = source_path


class Course:
    __slots__ = ("course_id", "title", "description", "duration", "lessons", "folder")

    def __init__(self, course_id: str, title: str, folder: Path):
        self.course_id = course_id
        self.title = title
        self.folder = folder
        self.description = ""
        self.duration = ""
        self.lessons: list[Lesson] = []


# =============================================================================
# FILESYSTEM HELPERS
# =============================================================================

def is_hidden(name: str) -> bool:
    """A path component counts as hidden if it starts with a dot."""
    return name.startswith(".")


def should_skip_dir(dir_name: str) -> bool:
    if is_hidden(dir_name):
        return True
    lowered = dir_name.strip().lower()
    if lowered in IGNORED_DIR_NAMES:
        return True
    if "template" in lowered:
        return True
    return False


def should_skip_file(file_path: Path) -> bool:
    if file_path.suffix.lower() != ".md":
        return True
    if is_hidden(file_path.name):
        return True
    stem = file_path.stem.strip().lower()
    if stem in IGNORED_FILE_STEMS:
        return True
    if "template" in stem:
        return True
    return False


def read_markdown_file(file_path: Path) -> str | None:
    """Read a markdown file safely as UTF-8, tolerating bad bytes."""
    try:
        raw = file_path.read_bytes()
    except (OSError, IOError):
        return None
    # Normalize line endings (CRLF / CR -> LF) at the byte-decoded level.
    text = raw.decode("utf-8", errors="replace")
    text = text.replace("\r\n", "\n").replace("\r", "\n")
    return text


def find_markdown_files(root: Path):
    """
    Walk the repository tree, yielding (folder, file_path, content) tuples
    for every valid, non-ignored markdown file.
    """
    if not root.exists():
        print(f"ERROR: ROOT path does not exist: {root}", file=sys.stderr)
        sys.exit(1)

    for current_dir, sub_dirs, file_names in os.walk(root):
        # Prune ignored / hidden directories in-place so os.walk skips them.
        sub_dirs[:] = [d for d in sub_dirs if not should_skip_dir(d)]

        current_path = Path(current_dir)

        for file_name in sorted(file_names):
            file_path = current_path / file_name
            if should_skip_file(file_path):
                continue

            content = read_markdown_file(file_path)
            if content is None:
                continue

            if len(content.strip()) < MIN_FILE_LENGTH:
                continue

            yield current_path, file_path, content


# =============================================================================
# TEXT / NAMING HELPERS
# =============================================================================

def humanize(name: str) -> str:
    """
    Turn a filename or folder name into a readable title.
    e.g. "01-intro_to_marketing.md" -> "Intro To Marketing"
    """
    stem = name
    stem = LEADING_NUMBER_PREFIX_RE.sub("", stem)
    stem = stem.replace("_", " ").replace("-", " ")
    stem = WHITESPACE_RE.sub(" ", stem).strip()
    if not stem:
        stem = name
    words = stem.split(" ")
    titled = " ".join(w[:1].upper() + w[1:] if w else w for w in words)
    return titled


def slugify(text: str) -> str:
    """Create a safe, deterministic identifier from arbitrary text."""
    normalized = unicodedata.normalize("NFKD", text)
    ascii_text = normalized.encode("ascii", "ignore").decode("ascii")
    lowered = ascii_text.lower()
    lowered = lowered.replace(os.sep, "-").replace("/", "-").replace("\\", "-")
    lowered = lowered.replace("_", "-").replace(" ", "-")
    lowered = NON_SLUG_CHARS_RE.sub("-", lowered)
    lowered = MULTI_DASH_RE.sub("-", lowered)
    lowered = lowered.strip("-")
    return lowered or "item"


def extract_first_code_block(text: str) -> str | None:
    """Return the contents of the first fenced code block, if any."""
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
    """Find the first non-empty, non-heading-only line to use as a description seed."""
    for line in text.split("\n"):
        stripped = line.strip()
        if not stripped:
            continue
        stripped = HEADING_STRIP_RE.sub("", stripped).strip()
        if not stripped:
            continue
        stripped = MD_INLINE_SYMBOLS_RE.sub("", stripped).strip()
        if stripped:
            return stripped
    return ""


def build_description(course_title: str, lessons: list[Lesson]) -> str:
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
    return f"{course_title} — {lesson_count} {plural}."


def estimate_duration(lessons: list[Lesson]) -> str:
    total_words = 0
    for lesson in lessons:
        total_words += len(lesson.body.split())
    minutes = max(MIN_DURATION_MINUTES, round(total_words / WORDS_PER_MINUTE))
    return f"{minutes} min"


# =============================================================================
# DART STRING ESCAPING — MUST NEVER PRODUCE INVALID DART
# =============================================================================

def escape_dart_string(text: str) -> str:
    """
    Escape arbitrary text for safe embedding inside a Dart double-quoted
    string literal on a single line.

    Strategy (order matters):
      1. Normalize newlines to \\n (already done at read time, re-asserted here).
      2. Escape backslashes first (so later inserted backslashes aren't re-escaped).
      3. Escape '$' so Dart never attempts string interpolation.
      4. Escape double quotes (the delimiter we use for the Dart string).
      5. Convert real newline / tab characters into literal escape sequences
         so the resulting Dart source stays on one line and can never be
         terminated early by an embedded raw newline inside the string.

    This is safe for markdown tables, HTML, JSON, YAML, XML, PHP, code
    fences, emoji, unicode, and any other content — nothing here can break
    out of the Dart string literal.
    """
    if text is None:
        return ""

    normalized = text.replace("\r\n", "\n").replace("\r", "\n")

    # 1. Backslashes must be escaped first.
    escaped = normalized.replace("\\", "\\\\")

    # 2. Escape Dart string interpolation trigger.
    escaped = escaped.replace("$", "\\$")

    # 3. Escape the delimiter character we will wrap the string in.
    escaped = escaped.replace('"', '\\"')

    # 4. Flatten real control characters into literal escape sequences.
    escaped = escaped.replace("\n", "\\n")
    escaped = escaped.replace("\t", "\\t")

    # 5. Strip any other stray control characters that could corrupt output
    #    (keeping printable unicode, including emoji, fully intact).
    escaped = "".join(
        ch if (ch == " " or ch.isprintable()) else " "
        for ch in escaped
    )

    return escaped


def dart_string_literal(text: str) -> str:
    """Wrap escaped text in double quotes as a Dart string literal."""
    return '"' + escape_dart_string(text) + '"'


def dart_nullable_string_literal(text: str | None) -> str:
    if text is None:
        return "null"
    return dart_string_literal(text)


# =============================================================================
# COURSE BUILDING
# =============================================================================

def build_courses(root: Path) -> list[Course]:
    courses_by_folder: dict[Path, Course] = {}
    order: list[Path] = []

    seen_lesson_keys_per_course: dict[Path, set] = {}

    for folder, file_path, content in find_markdown_files(root):
        if folder not in courses_by_folder:
            rel = folder.relative_to(root) if folder != root else Path(root.name)
            rel_str = str(rel) if str(rel) != "." else root.name
            folder_display_name = folder.name if folder != root else root.name
            course_id = slugify(rel_str)
            course_title = humanize(folder_display_name)
            courses_by_folder[folder] = Course(course_id, course_title, folder)
            seen_lesson_keys_per_course[folder] = set()
            order.append(folder)

        course = courses_by_folder[folder]

        lesson_key = file_path.stem.strip().lower()
        if lesson_key in seen_lesson_keys_per_course[folder]:
            continue  # duplicate lesson within the same course
        seen_lesson_keys_per_course[folder].add(lesson_key)

        lesson_title = humanize(file_path.stem)
        code_snippet = extract_first_code_block(content)
        has_image = detect_has_image(content)

        lesson = Lesson(
            title=lesson_title,
            body=content,
            code_snippet=code_snippet,
            has_image=has_image,
            source_path=file_path,
        )
        course.lessons.append(lesson)

    courses: list[Course] = []
    seen_course_ids: set = set()

    for folder in order:
        course = courses_by_folder[folder]
        if not course.lessons:
            continue  # skip empty courses (all files filtered out)

        # De-duplicate course ids across the whole run.
        base_id = course.course_id
        unique_id = base_id
        suffix = 2
        while unique_id in seen_course_ids:
            unique_id = f"{base_id}-{suffix}"
            suffix += 1
        seen_course_ids.add(unique_id)
        course.course_id = unique_id

        course.lessons.sort(key=lambda l: l.source_path.name.lower())
        course.description = build_description(course.title, course.lessons)
        course.duration = estimate_duration(course.lessons)

        courses.append(course)

    return courses


# =============================================================================
# DART CODE GENERATION
# =============================================================================

def generate_lesson_dart(lesson: Lesson, indent: str) -> str:
    lines = []
    lines.append(f"{indent}AppLesson(")
    lines.append(f"{indent}  title: {dart_string_literal(lesson.title)},")
    lines.append(f"{indent}  body: {dart_string_literal(lesson.body)},")
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
        "// Produced by the Hustle Academy universal course generator.\n"
        "// Regenerate by re-running the Python generator script.\n\n"
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
    root = ROOT
    output_path = OUTPUT

    courses = build_courses(root)

    if not courses:
        print("No valid courses found. Check ROOT path and ignore rules.", file=sys.stderr)
        sys.exit(1)

    dart_code = generate_dart_file(courses)

    output_path.parent.mkdir(parents=True, exist_ok=True)
    output_path.write_text(dart_code, encoding="utf-8")

    total_lessons = sum(len(course.lessons) for course in courses)

    print(f"Number of courses: {len(courses)}")
    print(f"Number of lessons: {total_lessons}")
    print(f"Output filename: {output_path}")
    print("Generation complete")


if __name__ == "__main__":
    main()

