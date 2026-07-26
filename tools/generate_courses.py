#!/usr/bin/env python3
"""
tools/generate_courses.py

Production-ready, fully OFFLINE generator for Hustler Academic's Flutter
course catalog. Reads the freeCodeCamp curriculum that already exists in
this repository under:

    assets/freecodecamp/structure/
    assets/freecodecamp/challenges/english/blocks/

No network access of any kind is performed (no requests, no HTTP, no
URLs, no GitHub API, no CDN). Everything is read from the local
filesystem with pathlib.

Output:

    lib/courses/web_development_courses.dart

containing:

    final List<AppCourse> webDevelopmentCourses = [ ... ];

Compatible with Python 3.11+.
"""

from __future__ import annotations

import json
import logging
import re
import sys
import unicodedata
from dataclasses import dataclass, field
from difflib import SequenceMatcher
from pathlib import Path
from typing import Any, Optional

# --------------------------------------------------------------------------- #
# Configuration
# --------------------------------------------------------------------------- #

REPO_ROOT = Path(__file__).resolve().parent.parent

ASSETS_ROOT = REPO_ROOT / "assets" / "freecodecamp"
STRUCTURE_DIR = ASSETS_ROOT / "structure"
SUPERBLOCKS_DIR = STRUCTURE_DIR / "superblocks"
BLOCKS_STRUCTURE_DIR = STRUCTURE_DIR / "blocks"
CURRICULUM_INDEX_PATH = STRUCTURE_DIR / "curriculum.json"
CHALLENGES_DIR = ASSETS_ROOT / "challenges" / "english" / "blocks"

OUTPUT_PATH = REPO_ROOT / "lib" / "courses" / "web_development_courses.dart"

DEFAULT_ICON = "Icons.code"
DEFAULT_COLOR = "Colors.blue"
DEFAULT_CATEGORY = "Web Development"
DEFAULT_DIFFICULTY = "Intermediate"
DEFAULT_DURATION = "4 weeks"
DEFAULT_INSTRUCTOR = "freeCodeCamp"

MAX_LESSONS_PER_COURSE = 60      # keep the generated Dart file to a sane size
MAX_BLOCKS_PER_COURSE = 25       # safety cap on how many blocks we walk
MIN_TITLE_MATCH_SCORE = 0.45     # minimum fuzzy-match score to accept a superblock

# Certifications we want to build courses for. These are DISPLAY NAMES only —
# they are matched at runtime against whatever superblock JSON files actually
# exist locally, never against a hardcoded path beyond the two allowed roots.
TARGET_CERTIFICATIONS: list[str] = [
    "Responsive Web Design",
    "JavaScript Algorithms and Data Structures",
    "Front End Development Libraries",
    "Data Visualization",
    "Back End Development and APIs",
    "Quality Assurance",
    "Scientific Computing with Python",
    "Data Analysis with Python",
    "Information Security",
    "Machine Learning with Python",
]

# --------------------------------------------------------------------------- #
# Logging
# --------------------------------------------------------------------------- #

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(message)s",
    datefmt="%H:%M:%S",
)
logger = logging.getLogger("generate_courses")


# --------------------------------------------------------------------------- #
# Data model
# --------------------------------------------------------------------------- #

@dataclass
class Lesson:
    title: str
    body: str
    code_snippet: Optional[str] = None
    has_image: bool = False


@dataclass
class Course:
    id: str
    title: str
    description: str
    instructor: str = DEFAULT_INSTRUCTOR
    category: str = DEFAULT_CATEGORY
    difficulty: str = DEFAULT_DIFFICULTY
    duration: str = DEFAULT_DURATION
    icon: str = DEFAULT_ICON
    color: str = DEFAULT_COLOR
    lessons: list[Lesson] = field(default_factory=list)


# --------------------------------------------------------------------------- #
# Local filesystem helpers (NO network access anywhere in this file)
# --------------------------------------------------------------------------- #

def read_json_file(path: Path) -> Optional[Any]:
    """Read and parse a local JSON file. Returns None on any failure."""
    try:
        with path.open("r", encoding="utf-8") as handle:
            return json.load(handle)
    except FileNotFoundError:
        logger.debug("File not found: %s", path)
        return None
    except (json.JSONDecodeError, OSError, UnicodeDecodeError) as exc:
        logger.warning("Could not parse JSON file '%s': %s", path, exc)
        return None


def read_text_file(path: Path) -> Optional[str]:
    """Read a local text file. Returns None on any failure."""
    try:
        with path.open("r", encoding="utf-8") as handle:
            return handle.read()
    except FileNotFoundError:
        logger.debug("File not found: %s", path)
        return None
    except (OSError, UnicodeDecodeError) as exc:
        logger.warning("Could not read file '%s': %s", path, exc)
        return None


# --------------------------------------------------------------------------- #
# Curriculum discovery (local-only — no hardcoded certification URLs/paths)
# --------------------------------------------------------------------------- #

def discover_superblock_names() -> list[str]:
    """Read structure/curriculum.json to list all superblocks present locally."""
    index = read_json_file(CURRICULUM_INDEX_PATH)
    names: list[str] = []

    if isinstance(index, dict):
        superblocks = index.get("superblocks")
        if isinstance(superblocks, list):
            names = [str(s) for s in superblocks if isinstance(s, (str, int))]

    if names:
        # Keep only superblocks whose structure file actually exists on disk.
        existing = [name for name in names if (SUPERBLOCKS_DIR / f"{name}.json").is_file()]
        logger.info(
            "curriculum.json lists %d superblock(s); %d have local structure files.",
            len(names), len(existing),
        )
        if existing:
            return existing

    # Fallback: if curriculum.json is missing/unusable, discover superblocks
    # directly from whatever *.json files exist in the superblocks directory.
    if SUPERBLOCKS_DIR.is_dir():
        discovered = sorted(p.stem for p in SUPERBLOCKS_DIR.glob("*.json"))
        logger.warning(
            "Falling back to scanning '%s' directly: found %d superblock file(s).",
            SUPERBLOCKS_DIR, len(discovered),
        )
        return discovered

    logger.error("Could not locate any superblocks under '%s'.", SUPERBLOCKS_DIR)
    return []


def _normalize_title(text: str) -> str:
    """Lowercase and strip non-alphanumeric characters for fuzzy comparison."""
    text = unicodedata.normalize("NFKD", text)
    return re.sub(r"[^a-z0-9]+", "", text.lower())


def _match_score(candidate: str, target_name: str) -> float:
    """Score how well a candidate name matches a desired certification name."""
    norm_candidate = _normalize_title(candidate)
    norm_target = _normalize_title(target_name)
    if not norm_candidate or not norm_target:
        return 0.0

    base_score = SequenceMatcher(None, norm_candidate, norm_target).ratio()

    if norm_target in norm_candidate or norm_candidate in norm_target:
        base_score = max(base_score, 0.9)

    return base_score


def match_superblock_for_certification(
    target_name: str,
    superblock_names: list[str],
) -> Optional[str]:
    """Find the best-matching local superblock dashedName for a certification name."""
    best_name: Optional[str] = None
    best_score = 0.0

    for dashed_name in superblock_names:
        score = _match_score(dashed_name.replace("-", " "), target_name)
        if score > best_score:
            best_score = score
            best_name = dashed_name

    if best_name is not None and best_score >= MIN_TITLE_MATCH_SCORE:
        logger.info(
            "Matched certification '%s' -> superblock '%s' (score %.2f).",
            target_name, best_name, best_score,
        )
        return best_name

    logger.warning(
        "No confident local superblock match found for certification '%s' (best score %.2f).",
        target_name, best_score,
    )
    return None


def load_superblock_structure(superblock_name: str) -> Optional[dict]:
    """Read structure/superblocks/<superblock>.json."""
    return read_json_file(SUPERBLOCKS_DIR / f"{superblock_name}.json")


def extract_block_names(superblock_json: dict) -> list[str]:
    """Flatten a superblock structure file into an ordered list of block dashedNames."""
    block_names: list[str] = []

    flat_blocks = superblock_json.get("blocks")
    if isinstance(flat_blocks, list):
        block_names.extend(str(b) for b in flat_blocks if isinstance(b, (str, int)))
        return block_names

    chapters = superblock_json.get("chapters")
    if isinstance(chapters, list):
        for chapter in chapters:
            if not isinstance(chapter, dict):
                continue
            modules = chapter.get("modules")
            if not isinstance(modules, list):
                continue
            for module in modules:
                if not isinstance(module, dict):
                    continue
                if module.get("comingSoon"):
                    continue
                module_blocks = module.get("blocks")
                if isinstance(module_blocks, list):
                    block_names.extend(
                        str(b) for b in module_blocks if isinstance(b, (str, int))
                    )

    return block_names


def load_block_structure(block_name: str) -> Optional[dict]:
    """Read structure/blocks/<block>.json."""
    return read_json_file(BLOCKS_STRUCTURE_DIR / f"{block_name}.json")


def extract_challenge_refs(block_json: dict) -> list[dict]:
    """Extract the ordered {id, title} challenge references from a block structure file."""
    challenge_order = block_json.get("challengeOrder")
    if isinstance(challenge_order, list):
        return [c for c in challenge_order if isinstance(c, dict) and c.get("id")]
    return []


def load_challenge_markdown(block_name: str, challenge_id: str) -> Optional[str]:
    """Read challenges/english/blocks/<block>/<id>.md from disk."""
    return read_text_file(CHALLENGES_DIR / block_name / f"{challenge_id}.md")


# --------------------------------------------------------------------------- #
# Challenge Markdown parsing
# --------------------------------------------------------------------------- #

FRONTMATTER_RE = re.compile(r"^---\s*\n(.*?)\n---\s*\n", re.DOTALL)
SECTION_HEADER_RE = re.compile(r"^#{1,3}\s*--([a-zA-Z0-9_-]+)--\s*$", re.MULTILINE)
FENCE_RE = re.compile(r"```(?:[a-zA-Z0-9_-]*)\n(.*?)```", re.DOTALL)
HTML_TAG_RE = re.compile(r"<[^>]+>")
MULTI_BLANK_RE = re.compile(r"\n{3,}")
MULTI_SPACE_RE = re.compile(r"[ \t]{2,}")


def parse_frontmatter(raw_markdown: str) -> tuple[dict[str, str], str]:
    """Split a challenge file into its (simple key: value) frontmatter and body."""
    match = FRONTMATTER_RE.match(raw_markdown)
    if not match:
        return {}, raw_markdown

    frontmatter_block = match.group(1)
    body = raw_markdown[match.end():]

    fields: dict[str, str] = {}
    for line in frontmatter_block.splitlines():
        if ":" not in line:
            continue
        key, _, value = line.partition(":")
        fields[key.strip()] = value.strip().strip('"').strip("'")

    return fields, body


def split_sections(body: str) -> dict[str, str]:
    """Split the challenge body into named sections keyed by their `--name--` header."""
    matches = list(SECTION_HEADER_RE.finditer(body))
    sections: dict[str, str] = {}

    for index, match in enumerate(matches):
        name = match.group(1).strip().lower()
        start = match.end()
        end = matches[index + 1].start() if index + 1 < len(matches) else len(body)
        content = body[start:end].strip("\n")
        if name not in sections:
            sections[name] = content

    return sections


def strip_html(text: str) -> str:
    return HTML_TAG_RE.sub("", text)


def clean_markdown_body(text: str) -> str:
    """Strip code fences and HTML from a body, collapse whitespace, keep readability."""
    if not text:
        return ""
    without_fences = FENCE_RE.sub("", text)
    without_html = strip_html(without_fences)
    normalized = unicodedata.normalize("NFC", without_html)
    normalized = MULTI_SPACE_RE.sub(" ", normalized)
    normalized = MULTI_BLANK_RE.sub("\n\n", normalized)
    return normalized.strip()


def extract_first_code_snippet(*texts: Optional[str]) -> Optional[str]:
    """Extract the first fenced Markdown code block found across the given texts,
    preserving its original internal formatting."""
    for text in texts:
        if not text:
            continue
        match = FENCE_RE.search(text)
        if match:
            snippet = match.group(1).strip("\n")
            if snippet.strip():
                return snippet
    return None


def parse_challenge_markdown(raw_markdown: str, fallback_title: str) -> Optional[Lesson]:
    """Parse a single local challenge Markdown file into a Lesson.

    Returns None (never raises) for malformed/unusable content so the caller
    can skip it and continue.
    """
    try:
        if not raw_markdown or not raw_markdown.strip():
            return None

        frontmatter, body = parse_frontmatter(raw_markdown)
        sections = split_sections(body)

        title = frontmatter.get("title") or fallback_title
        if not title or not title.strip():
            return None

        description = sections.get("description", "")
        instructions = sections.get("instructions", "")
        hints = sections.get("hints", "")
        seed_section = sections.get("seed", "")
        solutions_section = sections.get("solutions", "")

        body_parts = [
            clean_markdown_body(description),
            clean_markdown_body(instructions),
        ]
        if hints:
            hint_text = clean_markdown_body(hints)
            if hint_text:
                body_parts.append(f"Hint: {hint_text}")

        lesson_body = "\n\n".join(part for part in body_parts if part).strip()
        if not lesson_body:
            lesson_body = clean_markdown_body(title)

        code_snippet = extract_first_code_snippet(
            solutions_section, seed_section, description, instructions,
        )

        has_image = bool(
            re.search(r"\.(png|jpe?g|gif|svg|webp)", description, re.IGNORECASE)
        )

        return Lesson(
            title=clean_markdown_body(title) or title.strip(),
            body=lesson_body,
            code_snippet=code_snippet,
            has_image=has_image,
        )
    except (AttributeError, TypeError, KeyError, re.error) as exc:
        logger.debug("Ignoring malformed challenge markdown: %s", exc)
        return None


# --------------------------------------------------------------------------- #
# Course assembly
# --------------------------------------------------------------------------- #

def remove_invalid_characters(text: str) -> str:
    """Remove control characters that would break Dart source, keep valid Unicode."""
    if not text:
        return text
    cleaned_chars = []
    for ch in text:
        category = unicodedata.category(ch)
        if ch in ("\n", "\t"):
            cleaned_chars.append(ch)
        elif category == "Cc":
            continue
        else:
            cleaned_chars.append(ch)
    return "".join(cleaned_chars)


def sanitize_id(text: str) -> str:
    """Produce a safe, stable identifier string usable as an AppCourse.id value."""
    slug = re.sub(r"[^a-zA-Z0-9\-]+", "-", text.strip().lower())
    slug = re.sub(r"-{2,}", "-", slug).strip("-")
    return slug or "course"


def build_course_from_certification(display_name: str, superblock_name: str) -> Optional[Course]:
    """Walk a matched superblock's local blocks/challenges and assemble a Course."""
    superblock_json = load_superblock_structure(superblock_name)
    if superblock_json is None:
        logger.warning("Could not load local superblock structure for '%s' — skipping.", display_name)
        return None

    block_names = extract_block_names(superblock_json)
    if not block_names:
        logger.warning("No blocks found for superblock '%s' — skipping.", superblock_name)
        return None

    block_names = block_names[:MAX_BLOCKS_PER_COURSE]
    total_blocks = len(block_names)
    lessons: list[Lesson] = []
    skipped = 0

    for block_index, block_name in enumerate(block_names, start=1):
        if len(lessons) >= MAX_LESSONS_PER_COURSE:
            break

        logger.info("  [%s] block %d/%d: %s", display_name, block_index, total_blocks, block_name)

        block_json = load_block_structure(block_name)
        if block_json is None:
            logger.debug("  Skipping block '%s' (local structure file missing).", block_name)
            continue

        challenge_refs = extract_challenge_refs(block_json)
        total_challenges = len(challenge_refs)

        for challenge_index, ref in enumerate(challenge_refs, start=1):
            if len(lessons) >= MAX_LESSONS_PER_COURSE:
                break

            challenge_id = str(ref.get("id", "")).strip()
            fallback_title = str(ref.get("title", "")).strip() or "Untitled Challenge"
            if not challenge_id:
                skipped += 1
                continue

            logger.info("    - challenge %d/%d: %s", challenge_index, total_challenges, fallback_title)

            raw_markdown = load_challenge_markdown(block_name, challenge_id)
            if raw_markdown is None:
                skipped += 1
                continue

            lesson = parse_challenge_markdown(raw_markdown, fallback_title)
            if lesson is None:
                skipped += 1
                continue

            lessons.append(lesson)

    if not lessons:
        logger.warning("No usable lessons extracted for '%s' — skipping.", display_name)
        return None

    if skipped:
        logger.info("Skipped %d malformed/missing challenge(s) in '%s'.", skipped, display_name)

    description = (
        f"A freeCodeCamp curriculum covering {display_name}, "
        f"with {len(lessons)} lessons extracted from the local curriculum assets."
    )

    return Course(
        id=sanitize_id(superblock_name),
        title=display_name,
        description=description,
        lessons=lessons,
    )


def build_all_courses() -> list[Course]:
    if not STRUCTURE_DIR.is_dir():
        logger.error("Structure directory not found: '%s'. Aborting.", STRUCTURE_DIR)
        return []
    if not CHALLENGES_DIR.is_dir():
        logger.error("Challenges directory not found: '%s'. Aborting.", CHALLENGES_DIR)
        return []

    superblock_names = discover_superblock_names()
    if not superblock_names:
        logger.error("Could not discover any local superblocks. Aborting.")
        return []

    courses: list[Course] = []
    total = len(TARGET_CERTIFICATIONS)

    for index, display_name in enumerate(TARGET_CERTIFICATIONS, start=1):
        logger.info("[%d/%d] Processing certification: %s", index, total, display_name)
        try:
            matched_superblock = match_superblock_for_certification(display_name, superblock_names)
            if matched_superblock is None:
                logger.warning("Skipping '%s' — no matching local superblock found.", display_name)
                continue

            course = build_course_from_certification(display_name, matched_superblock)
            if course is None:
                continue

            courses.append(course)
            logger.info("Finished '%s': %d lessons extracted.", display_name, len(course.lessons))
        except Exception as exc:  # noqa: BLE001 - keep the pipeline alive on any failure
            logger.error("Unexpected error processing '%s': %s", display_name, exc)
            continue

    return courses


# --------------------------------------------------------------------------- #
# Dart code generation
# --------------------------------------------------------------------------- #

def dart_escape(text: Optional[str]) -> str:
    """Escape a string for safe embedding inside a Dart triple-quoted string literal."""
    if not text:
        return ""
    safe = remove_invalid_characters(text)
    safe = safe.replace("\\", "\\\\")
    safe = safe.replace("$", "\\$")
    safe = safe.replace('"""', '\\"\\"\\"')
    if safe.endswith('"'):
        safe = safe[:-1] + '\\"'
    return safe


def to_dart_string_literal(text: Optional[str]) -> str:
    """Return a Dart triple-quoted string literal, or 'null' if text is empty/None."""
    if text is None or text.strip() == "":
        return "null"
    return f'"""{dart_escape(text)}"""'


def to_dart_required_string_literal(text: Optional[str], fallback: str = "") -> str:
    """Like to_dart_string_literal but never returns null (for required fields)."""
    value = text if (text and text.strip()) else fallback
    return f'"""{dart_escape(value)}"""'


def render_lesson(lesson: Lesson, indent: str = "      ") -> str:
    code_literal = (
        to_dart_string_literal(lesson.code_snippet) if lesson.code_snippet else "null"
    )
    return (
        f"{indent}AppLesson(\n"
        f"{indent}  title: {to_dart_required_string_literal(lesson.title, fallback='Untitled Lesson')},\n"
        f"{indent}  body: {to_dart_required_string_literal(lesson.body, fallback='No description available.')},\n"
        f"{indent}  codeSnippet: {code_literal},\n"
        f"{indent}  hasImage: {'true' if lesson.has_image else 'false'},\n"
        f"{indent})"
    )


def render_course(course: Course, indent: str = "  ") -> str:
    lessons_dart = ",\n".join(render_lesson(lesson) for lesson in course.lessons)
    return (
        f"{indent}AppCourse(\n"
        f"{indent}  id: '{sanitize_id(course.id)}',\n"
        f"{indent}  title: {to_dart_required_string_literal(course.title, fallback='Untitled Course')},\n"
        f"{indent}  description: {to_dart_required_string_literal(course.description, fallback='')},\n"
        f"{indent}  instructor: '{course.instructor}',\n"
        f"{indent}  category: '{course.category}',\n"
        f"{indent}  difficulty: '{course.difficulty}',\n"
        f"{indent}  icon: {course.icon},\n"
        f"{indent}  color: {course.color},\n"
        f"{indent}  duration: '{course.duration}',\n"
        f"{indent}  lessons: [\n"
        f"{lessons_dart}\n"
        f"{indent}  ],\n"
        f"{indent})"
    )


def generate_dart_source(courses: list[Course]) -> str:
    header = (
        "// GENERATED FILE - DO NOT EDIT BY HAND.\n"
        "// Produced by tools/generate_courses.py from the local freeCodeCamp\n"
        "// curriculum assets under assets/freecodecamp/. No network access used.\n\n"
        "import 'package:flutter/material.dart';\n"
        "import '../main.dart';\n\n"
        "final List<AppCourse> webDevelopmentCourses = [\n"
    )
    body = ",\n".join(render_course(course) for course in courses)
    footer = "\n];\n"
    return header + body + footer


# --------------------------------------------------------------------------- #
# Output
# --------------------------------------------------------------------------- #

def write_dart_file(content: str, output_path: Path) -> None:
    try:
        output_path.parent.mkdir(parents=True, exist_ok=True)
        output_path.write_text(content, encoding="utf-8")
        logger.info(
            "Wrote Dart output to '%s' (%d bytes).", output_path, len(content.encode("utf-8")),
        )
    except OSError as exc:
        logger.error("Failed to write output file '%s': %s", output_path, exc)
        raise


# --------------------------------------------------------------------------- #
# Orchestration
# --------------------------------------------------------------------------- #

def main() -> int:
    logger.info("Reading local freeCodeCamp curriculum assets from '%s'...", ASSETS_ROOT)
    courses = build_all_courses()

    if not courses:
        logger.error("No courses were successfully built. Aborting without writing output.")
        return 1

    logger.info("Generating Dart source for %d course(s)...", len(courses))
    dart_source = generate_dart_source(courses)

    try:
        write_dart_file(dart_source, OUTPUT_PATH)
    except OSError:
        return 1

    logger.info(
        "Done. Total lessons across all courses: %d",
        sum(len(c.lessons) for c in courses),
    )
    return 0


if __name__ == "__main__":
    sys.exit(main())

