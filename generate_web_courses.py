
    return Course( id=sanitize_id(slug), 
        title=display_name, 
        description=description, lessons=lessons,

# --------------------------------------------------------------------------- 
# # Dart code generation 
# --------------------------------------------------------------------------- 
# #

def render_lesson(lesson: Lesson, indent: str = " 
    ") -> str: code_literal = (
        to_dart_string_literal(lesson.code_snippet) 
        if lesson.code_snippet else "null"
    ) return (
        "// Produced by generate_web_courses.py from the freeCodeCamp curriculum.\n\n"
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
        logger.info("Wrote Dart output to '%s' (%d bytes).", output_path, len(content.encode("utf-8")))
#!/usr/bin/env python3
"""
generate_web_courses.py

Dynamically discovers the CURRENT freeCodeCamp curriculum structure straight
from the official freeCodeCamp/freeCodeCamp GitHub repository (no hardcoded
per-certification JSON/CDN URLs), downloads the relevant challenge content
for a fixed set of certifications, and generates a Flutter/Dart source file:

    lib/courses/web_development_courses.dart

containing a `List<AppCourse>` named `webDevelopmentCourses`.

How discovery works (all dynamic, nothing certification-specific is
hardcoded as a URL):

    1. curriculum/structure/curriculum.json
       -> lists every current superBlock dashedName.
    2. client/i18n/locales/english/intro.json
       -> maps each superBlock dashedName to its human-readable title,
          which we fuzzy-match against the certification names we want.
    3. curriculum/structure/superblocks/<superblock>.json
       -> lists the blocks that belong to the matched superBlock
          (either a flat `blocks` array, or `chapters` -> `modules` ->
          `blocks`).
    4. curriculum/structure/blocks/<block>.json
       -> lists the ordered `challengeOrder` ({id, title}) for that block.
    5. curriculum/challenges/english/blocks/<block>/<id>.md
       -> the actual challenge Markdown (frontmatter + `--description--`,
          `--instructions--`, `--hints--`, `--seed--`, `--solutions--`
          sections), which we parse for lesson content and code snippets.

Compatible with Python 3.11+.
"""

from __future__ import annotations

import json
import logging
import re
import sys
import time
import unicodedata
from dataclasses import dataclass, field
from difflib import SequenceMatcher
from pathlib import Path
from typing import Any, Optional

import requests

# --------------------------------------------------------------------------- #
# Configuration
# --------------------------------------------------------------------------- #

REPO_OWNER = "freeCodeCamp"
REPO_NAME = "freeCodeCamp"
REPO_BRANCH = "main"

RAW_BASE_URL = f"https://raw.githubusercontent.com/{REPO_OWNER}/{REPO_NAME}/{REPO_BRANCH}"

CURRICULUM_INDEX_PATH = "curriculum/structure/curriculum.json"
INTRO_JSON_PATH = "client/i18n/locales/english/intro.json"
SUPERBLOCKS_DIR = "curriculum/structure/superblocks"
BLOCKS_STRUCTURE_DIR = "curriculum/structure/blocks"
CHALLENGES_DIR = "curriculum/challenges/english/blocks"

OUTPUT_PATH = Path("lib/courses/web_development_courses.dart")

REQUEST_TIMEOUT = 30
REQUEST_RETRIES = 3
REQUEST_RETRY_DELAY = 2.0
REQUEST_HEADERS = {
    "User-Agent": "hustler-academic-course-generator/1.0",
    "Accept": "application/vnd.github.raw+json, text/plain, application/json;q=0.9,*/*;q=0.8",
}

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
# they are matched at runtime against whatever superBlock titles currently
# exist in the live curriculum, never against a hardcoded slug/URL.
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
logger = logging.getLogger("generate_web_courses")


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
# Low-level networking helpers
# --------------------------------------------------------------------------- #

_session = requests.Session()
_session.headers.update(REQUEST_HEADERS)


def _raw_url(repo_path: str) -> str:
    """Build a raw.githubusercontent.com URL for a path inside the repo."""
    return f"{RAW_BASE_URL}/{repo_path}"


def fetch_text(repo_path: str) -> Optional[str]:
    """Download a raw text file from the repository, with retries.

    Returns None (never raises) if the file cannot be retrieved after
    REQUEST_RETRIES attempts, so callers can skip/continue gracefully.
    """
    url = _raw_url(repo_path)
    last_error: Optional[Exception] = None

    for attempt in range(1, REQUEST_RETRIES + 1):
        try:
            response = _session.get(url, timeout=REQUEST_TIMEOUT)
            if response.status_code == 404:
                logger.debug("Not found (404): %s", repo_path)
                return None
            response.raise_for_status()
            response.encoding = "utf-8"
            return response.text
        except requests.exceptions.RequestException as exc:
            last_error = exc
            logger.debug(
                "Network error fetching '%s' (attempt %d/%d): %s",
                repo_path, attempt, REQUEST_RETRIES, exc,
            )
            if attempt < REQUEST_RETRIES:
                time.sleep(REQUEST_RETRY_DELAY)

    logger.warning("Giving up on '%s' after %d attempts: %s", repo_path, REQUEST_RETRIES, last_error)
    return None


def fetch_json(repo_path: str) -> Optional[Any]:
    """Download and parse a JSON file from the repository."""
    text = fetch_text(repo_path)
    if text is None:
        return None
    try:
        return json.loads(text)
    except (json.JSONDecodeError, ValueError) as exc:
        logger.warning("Invalid JSON in '%s': %s", repo_path, exc)
        return None


# --------------------------------------------------------------------------- #
# Curriculum discovery (dynamic — no hardcoded certification URLs)
# --------------------------------------------------------------------------- #

def discover_superblock_names() -> list[str]:
    """Read curriculum/structure/curriculum.json to list all current superBlocks."""
    index = fetch_json(CURRICULUM_INDEX_PATH)
    if not isinstance(index, dict):
        logger.error("Could not load curriculum index from '%s'.", CURRICULUM_INDEX_PATH)
        return []

    superblocks = index.get("superblocks")
    if isinstance(superblocks, list):
        names = [str(s) for s in superblocks if isinstance(s, (str, int))]
        logger.info("Discovered %d superBlock(s) in the current curriculum index.", len(names))
        return names

    logger.error("curriculum.json did not contain a 'superblocks' array.")
    return []


def discover_superblock_titles() -> dict[str, str]:
    """Read intro.json to map superBlock dashedName -> human-readable title."""
    intro = fetch_json(INTRO_JSON_PATH)
    titles: dict[str, str] = {}

    if not isinstance(intro, dict):
        logger.warning("Could not load '%s'; title matching will be limited.", INTRO_JSON_PATH)
        return titles

    for key, value in intro.items():
        if isinstance(value, dict):
            title = value.get("title")
            if isinstance(title, str) and title.strip():
                titles[key] = title.strip()

    logger.info("Loaded %d superBlock title(s) from intro.json.", len(titles))
    return titles


def _normalize_title(text: str) -> str:
    """Lowercase and strip non-alphanumeric characters for fuzzy comparison."""
    text = unicodedata.normalize("NFKD", text)
    return re.sub(r"[^a-z0-9]+", "", text.lower())


def _match_score(candidate_title: str, target_name: str) -> float:
    """Score how well a superBlock title matches a desired certification name."""
    norm_candidate = _normalize_title(candidate_title)
    norm_target = _normalize_title(target_name)
    if not norm_candidate or not norm_target:
        return 0.0

    base_score = SequenceMatcher(None, norm_candidate, norm_target).ratio()

    # Strongly reward containment in either direction (handles suffixes like
    # "Certification", version markers like "v9", etc.).
    if norm_target in norm_candidate or norm_candidate in norm_target:
        base_score = max(base_score, 0.9)

    return base_score


def match_superblock_for_certification(
    target_name: str,
    superblock_names: list[str],
    superblock_titles: dict[str, str],
) -> Optional[str]:
    """Find the best-matching superBlock dashedName for a desired certification name."""
    best_name: Optional[str] = None
    best_score = 0.0

    for dashed_name in superblock_names:
        display_title = superblock_titles.get(dashed_name, dashed_name)
        score = max(
            _match_score(display_title, target_name),
            _match_score(dashed_name.replace("-", " "), target_name),
        )
        if score > best_score:
            best_score = score
            best_name = dashed_name

    if best_name is not None and best_score >= MIN_TITLE_MATCH_SCORE:
        logger.info(
            "Matched certification '%s' -> superBlock '%s' (score %.2f).",
            target_name, best_name, best_score,
        )
        return best_name

    logger.warning(
        "No confident superBlock match found for certification '%s' (best score %.2f).",
        target_name, best_score,
    )
    return None


def fetch_superblock_structure(superblock_name: str) -> Optional[dict]:
    """Download curriculum/structure/superblocks/<superblock>.json."""
    return fetch_json(f"{SUPERBLOCKS_DIR}/{superblock_name}.json")


def extract_block_names(superblock_json: dict) -> list[str]:
    """Flatten a superBlock structure file into an ordered list of block dashedNames."""
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
                    block_names.extend(str(b) for b in module_blocks if isinstance(b, (str, int)))

    return block_names


def fetch_block_structure(block_name: str) -> Optional[dict]:
    """Download curriculum/structure/blocks/<block>.json."""
    return fetch_json(f"{BLOCKS_STRUCTURE_DIR}/{block_name}.json")


def extract_challenge_refs(block_json: dict) -> list[dict]:
    """Extract the ordered {id, title} challenge references from a block structure file."""
    challenge_order = block_json.get("challengeOrder")
    if isinstance(challenge_order, list):
        return [c for c in challenge_order if isinstance(c, dict) and c.get("id")]
    return []


def fetch_challenge_markdown(block_name: str, challenge_id: str) -> Optional[str]:
    """Download the raw Markdown for a single challenge."""
    return fetch_text(f"{CHALLENGES_DIR}/{block_name}/{challenge_id}.md")


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
        # Keep the first occurrence of a section name if duplicated.
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
    """Extract the first fenced Markdown code block found across the given texts."""
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
    """Parse a single challenge Markdown file into a Lesson, or None if malformed."""
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
        logger.debug("Skipping malformed challenge markdown: %s", exc)
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


def build_course_from_certification(
    display_name: str,
    superblock_name: str,
) -> Optional[Course]:
    """Walk a matched superBlock's blocks/challenges and assemble a Course."""
    superblock_json = fetch_superblock_structure(superblock_name)
    if superblock_json is None:
        logger.warning("Could not load superBlock structure for '%s' — skipping.", display_name)
        return None

    block_names = extract_block_names(superblock_json)
    if not block_names:
        logger.warning("No blocks found for superBlock '%s' — skipping.", superblock_name)
        return None

    block_names = block_names[:MAX_BLOCKS_PER_COURSE]
    total_blocks = len(block_names)
    lessons: list[Lesson] = []
    skipped = 0

    for block_index, block_name in enumerate(block_names, start=1):
        if len(lessons) >= MAX_LESSONS_PER_COURSE:
            break

        logger.info(
            "  [%s] block %d/%d: %s", display_name, block_index, total_blocks, block_name,
        )

        block_json = fetch_block_structure(block_name)
        if block_json is None:
            logger.debug("  Skipping block '%s' (structure unavailable).", block_name)
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

            logger.info(
                "    - challenge %d/%d: %s", challenge_index, total_challenges, fallback_title,
            )

            raw_markdown = fetch_challenge_markdown(block_name, challenge_id)
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
        logger.info("Skipped %d malformed/unavailable challenge(s) in '%s'.", skipped, display_name)

    description = (
        f"A freeCodeCamp curriculum covering {display_name}, "
        f"with {len(lessons)} lessons extracted from the live curriculum."
    )

    return Course(
        id=sanitize_id(superblock_name),
        title=display_name,
        description=description,
        lessons=lessons,
    )


def build_all_courses() -> list[Course]:
    superblock_names = discover_superblock_names()
    if not superblock_names:
        logger.error("Could not discover any superBlocks from the curriculum index. Aborting.")
        return []

    superblock_titles = discover_superblock_titles()

    courses: list[Course] = []
    total = len(TARGET_CERTIFICATIONS)

    for index, display_name in enumerate(TARGET_CERTIFICATIONS, start=1):
        logger.info("[%d/%d] Processing certification: %s", index, total, display_name)
        try:
            matched_superblock = match_superblock_for_certification(
                display_name, superblock_names, superblock_titles,
            )
            if matched_superblock is None:
                logger.warning("Skipping '%s' — no matching superBlock found.", display_name)
                continue

            course = build_course_from_certification(display_name, matched_superblock)
            if course is None:
                continue

            courses.append(course)
            logger.info(
                "Finished '%s': %d lessons extracted.", display_name, len(course.lessons),
            )
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
        "// Produced by generate_web_courses.py from the live freeCodeCamp curriculum\n"
        "// (freeCodeCamp/freeCodeCamp GitHub repository, discovered dynamically).\n\n"
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
    logger.info("Discovering the live freeCodeCamp curriculum structure from GitHub...")
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

