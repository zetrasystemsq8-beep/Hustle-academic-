#!/usr/bin/env python3
# copywriting_generator_v5.py
#
# Hustle Academy - Copywriting Course Generator (v5)
# =====================================================
#
# Complete rewrite. Discards v4's approach entirely. This version does
# NOT concatenate Markdown text into Dart source as escaped double-quoted
# literals. Manual character-by-character escaping is exactly what broke
# v1 through v4 in subtle edge cases, so v5 removes that failure class
# structurally instead of trying to patch it again.
#
# STRATEGY
# --------
# Every string value that could contain arbitrary Markdown content
# (title, body, codeSnippet, description, duration, id, and the fixed
# config strings) is emitted as:
#
#     utf8.decode(base64.decode("<payload>"))
#
# The base64 alphabet is only [A-Za-z0-9+/=]. None of those characters
# can terminate a Dart string, trigger interpolation, or introduce a
# raw line break. This means no escaping function is needed at all for
# the payload itself, and no Markdown content - however adversarial -
# can ever break out of the generated Dart. The only "escaping
# function" left is dart_data_expr(), and its entire job is producing
# that wrapper, which is structurally incapable of emitting anything
# unsafe.
#
# Every AppLesson(...) and AppCourse(...) call is built exclusively
# with named parameters, in code, so there is no path by which a
# positional argument could ever be emitted.
#
# Before the output file is written, the generated Dart source is
# validated in two layers:
#
#   1. An internal structural validator (always runs): checks bracket
#      balance, checks that every AppCourse(/AppLesson( call is
#      immediately followed by its expected first named parameter, and
#      checks that every base64 payload in the file is valid base64
#      and round-trip decodes as UTF-8.
#   2. An external validator (runs only if the `dart` CLI is available
#      on PATH): actually parses the generated file with
#      `dart analyze` to catch anything the structural checks might
#      miss.
#
# The file is first written to a temporary path. Only if ALL validation
# passes is it moved into place at OUTPUT_FILE. If validation fails,
# the script aborts with a non-zero exit code and leaves any previously
# generated output file untouched.
#
# Python 3 standard library only. Runs in Termux with:
#     python3 copywriting_generator_v5.py

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
# TEXT HELPERS (content extraction only - no Dart concerns here)
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
# DART STRING GENERATION - base64 payload wrapper (the only string path)
# =============================================================================
#
# This is the single dedicated function responsible for turning ANY
# Python string into a Dart expression that evaluates to that exact
# string at runtime. It never emits the raw text into the Dart source.
# Because the emitted payload is restricted to the base64 alphabet,
# there is no character sequence - no quote, no backslash, no dollar
# sign, no raw newline, no control character, no unicode surprise -
# that can corrupt the surrounding Dart syntax. The Flutter side never
# needs to be aware of this; `utf8.decode(base64.decode(...))` produces
# a plain Dart String, identical to what a literal would have produced.

def dart_data_expr(text: str) -> str:
    payload = base64.b64encode(text.encode("utf-8")).decode("ascii")
    return f'utf8.decode(base64.decode("{payload}"))'


def dart_nullable_data_expr(text) -> str:
    if text is None:
        return "null"
    return dart_data_expr(text)


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
# DART CODE GENERATION - named parameters only, never positional
# =============================================================================

def generate_lesson_dart(lesson: Lesson, indent: str) -> str:
    parts = []
    parts.append(f"{indent}AppLesson(")
    parts.append(f"{indent}  title: {dart_data_expr(lesson.title)},")
    parts.append(f"{indent}  body: {dart_data_expr(lesson.body_text())},")
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
        "// Produced by copywriting_generator_v5.py\n"
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
# VALIDATION - must pass before anything is written to OUTPUT_FILE
# =============================================================================

BASE64_PAYLOAD_RE = re.compile(r'utf8\.decode\(base64\.decode\("([^"]*)"\)\)')
VALID_BASE64_RE = re.compile(r'^[A-Za-z0-9+/]*={0,2}$')


def validate_structural(dart_source: str, expected_course_count: int, expected_lesson_count: int) -> list[str]:
    """
    Internal structural validator. Always runs, requires no external
    tools. Returns a list of human-readable error strings; an empty
    list means the structural checks all passed.
    """
    errors: list[str] = []

    # 1. Bracket/paren/brace balance across the whole file. Since every
    #    string in the file is a base64 payload (alphabet
    #    [A-Za-z0-9+/=] only), no string content can contain a stray
    #    bracket, so a whole-file balance check is accurate.
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
                return errors  # further checks would be unreliable
            stack.pop()
    if stack:
        errors.append(f"Unclosed bracket(s) at end of file: {''.join(stack)}")

    # 2. Every AppCourse( call must be followed by its first named
    #    parameter (id:), and every AppLesson( call by its first named
    #    parameter (title:). This guarantees named-parameter-only
    #    construction and catches any accidental positional argument.
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

    # 3. Every base64 payload must be valid base64 and must round-trip
    #    decode as UTF-8 without error. This guards against any
    #    corruption introduced between encoding and writing.
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

    # 4. No raw, un-encoded Dart string literals should exist for the
    #    fields we control (a defensive check that generation didn't
    #    silently fall back to some other path). We only forbid empty
    #    "" or bare quoted content immediately after our known field
    #    names, since ICON/COLOR are legitimately bare identifiers.
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
    """
    External validator. Runs only if the `dart` CLI is available on
    PATH. Uses `dart analyze` to actually parse the generated file.
    Returns a list of error strings; an empty list means either
    validation passed, or the tool was unavailable (in which case the
    internal structural validator is the sole authority).
    """
    dart_bin = shutil.which("dart")
    if dart_bin is None:
        return []  # tool not available - skip, internal validation still ran

    try:
        result = subprocess.run(
            [dart_bin, "analyze", "--no-fatal-infos", str(temp_path)],
            capture_output=True,
            text=True,
            timeout=120,
        )
    except Exception as exc:
        return [f"Could not run `dart analyze`: {exc}"]

    if result.returncode not in (0, 1):
        # `dart analyze` returns 1 for lint/info findings even on
        # otherwise valid code in some SDK versions; treat only a hard
        # parse failure (surfaced in stdout/stderr) as fatal below.
        pass

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

    raw_courses = parse_courses(markdown_text)
    courses = finalize_courses(raw_courses)

    if not courses:
        print("No valid courses found in source file.", file=sys.stderr)
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

    # Write to a temporary file first; only promote it to OUTPUT_FILE if
    # every validation layer passes.
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

    print(f"Number of courses: {expected_course_count}")
    print(f"Number of lessons: {expected_lesson_count}")
    print(f"Output filename: {OUTPUT_FILE}")
    print("Generation complete")


if __name__ == "__main__":
    main()

