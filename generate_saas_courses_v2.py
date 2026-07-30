#!/usr/bin/env python3
"""
generate_saas_courses.py

Converts ~/SaaS4Devs/README.md into lib/courses/saas_courses.dart

Run with: python generate_saas_courses.py

IMPORTANT REMINDER:
The people reading these lessons in the app are mostly children and
people who never went to school. Every rewrite MUST use very plain,
everyday English. No big grammar, no long sentences, no jargon left
unexplained. If a word is not something a child on the street would
understand, explain it immediately in simple words.

Output matches these EXACT existing Flutter models (no invented fields):

class AppLesson {
  final String title;
  final String body;
  final String? codeSnippet;
  final bool hasImage;
}

class AppCourse {
  final String id;
  final String title;
  final String description;
  final String instructor;
  final String category;
  final String difficulty;
  final IconData icon;
  final Color color;
  final List<AppLesson> lessons;
  final String duration;
}
"""

import re
from pathlib import Path

SOURCE_PATH = Path.home() / "SaaS4Devs" / "README.md"
OUTPUT_PATH = Path("lib/courses/saas_courses.dart")

CATEGORY = "SaaS"
DIFFICULTY = "Beginner"
INSTRUCTOR = "Hustle Academy"

BRAND_EXAMPLES = ["Zetra", "Connect", "ZTC", "NaijaLearn", "NigerGram", "NAI"]
BRAND_PERSON = "Toluwani"

SKIP_HEADING_KEYWORDS = [
    "disclaimer", "credit", "roadmap", "contribut", "license",
    "tool", "tooling", "community", "resource", "book", "blog",
    "reference", "further reading", "links", "acknowledg", "sponsor",
    "star history", "table of contents", "faq", "read more",
]

BRAND_MAP = {
    "stripe": "ZTC Pay",
    "salesforce": "Connect CRM",
    "slack": "Connect Chat",
    "dropbox": "ZTC Cloud",
    "netflix": "NigerGram Play",
    "airbnb": "NaijaLearn Stays",
    "shopify": "Zetra Store",
    "hubspot": "Connect Hub",
    "zoom": "Connect Meet",
    "mailchimp": "ZTC Mail",
    "twilio": "Zetra Messaging",
    "google cloud": "Zetra Cloud",
    "amazon web services": "Zetra Cloud",
    "microsoft azure": "Zetra Cloud",
    "aws": "Zetra Cloud",
    "notion": "NaijaLearn Notes",
    "trello": "Hustle Academy Boards",
    "intercom": "Connect Support",
    "zendesk": "Connect Support",
    "segment": "Zetra Insights",
    "amplitude": "Zetra Insights",
    "mixpanel": "Zetra Insights",
    "github": "ZTC Code Hub",
    "chatgpt": "NAI",
    "openai": "NAI",
}

GLOSSARY = {
    "saas": "SaaS (Software as a Service, meaning software that people use online, usually by paying every month, instead of installing it on one computer)",
    "mrr": "MRR (Monthly Recurring Revenue, the money a business expects to receive every month from customers who pay again and again)",
    "arr": "ARR (Annual Recurring Revenue, the money a business expects to receive in one full year from its paying customers)",
    "churn": "churn (customers who stop paying and leave a service)",
    "onboarding": "onboarding (helping a new customer learn how to use a product the first time they open it)",
    "api": "API, short for Application Programming Interface (a way that two different pieces of software send information to each other)",
    "mvp": "MVP, short for Minimum Viable Product (the simplest version of a product that a business can release to see if people actually want it)",
    "b2b": "B2B, short for Business to Business (a company that sells its product to other companies, not to ordinary people)",
    "b2c": "B2C, short for Business to Consumer (a company that sells its product directly to ordinary people)",
    "cac": "CAC, short for Customer Acquisition Cost (how much money a business spends to win one new customer)",
    "ltv": "LTV, short for Lifetime Value (the total money a business expects to earn from one customer over the whole time that customer stays)",
    "freemium": "freemium (a pricing plan where the basic version of an app is free, but extra features cost money)",
    "paywall": "paywall (a point in an app where a user must pay before continuing)",
    "webhook": "webhook (a way for one app to automatically tell another app the moment something happens)",
    "devops": "DevOps (combining software building and server management so updates go out smoothly)",
    "ci/cd": "CI/CD, short for Continuous Integration and Continuous Deployment (tools that automatically test and release new code)",
    "kpi": "KPI, short for Key Performance Indicator (a number a business watches closely to know if it is doing well)",
    "landing page": "landing page (the first web page a visitor sees, usually built to convince them to sign up or buy)",
}

SIMPLE_WORDS = {
    "utilize": "use", "utilise": "use", "leverage": "use",
    "facilitate": "help", "subsequently": "after that",
    "prior to": "before", "in order to": "to",
    "approximately": "about", "sufficient": "enough",
    "numerous": "many", "acquire": "get", "implement": "set up",
    "optimal": "best", "methodology": "method", "commence": "start",
    "terminate": "end", "endeavor": "try", "endeavour": "try",
    "demonstrate": "show", "ascertain": "find out",
    "in the event that": "if", "a plethora of": "many",
    "with regard to": "about", "constitutes": "is",
}

USED_GLOSSARY_TERMS = set()


def slugify(text: str) -> str:
    text = text.lower().strip()
    text = re.sub(r"[^a-z0-9]+", "-", text)
    return text.strip("-") or "section"


def should_skip(title: str) -> bool:
    t = title.lower()
    return any(k in t for k in SKIP_HEADING_KEYWORDS)


def strip_markdown_links(text: str) -> str:
    text = re.sub(r"!\[[^\]]*\]\([^)]*\)", "", text)
    text = re.sub(r"\[([^\]]+)\]\([^)]+\)", r"\1", text)
    return text


def strip_urls(text: str) -> str:
    text = re.sub(r"https?://\S+", "", text)
    text = re.sub(r"github\.com/\S+", "", text, flags=re.I)
    return text


def strip_markdown_formatting(text: str) -> str:
    text = re.sub(r"`{1,3}([^`]*)`{1,3}", r"\1", text)
    text = re.sub(r"\*\*\*(.+?)\*\*\*", r"\1", text)
    text = re.sub(r"\*\*(.+?)\*\*", r"\1", text)
    text = re.sub(r"\*(.+?)\*", r"\1", text)
    text = re.sub(r"__(.+?)__", r"\1", text)
    text = re.sub(r"_(.+?)_", r"\1", text)
    text = re.sub(r"<[^>]+>", "", text)
    text = re.sub(r"^>\s?", "", text, flags=re.M)
    return text.strip()


def clean_heading_text(text: str) -> str:
    text = strip_markdown_links(text)
    text = strip_urls(text)
    text = strip_markdown_formatting(text)
    text = re.sub(r"[:#]+$", "", text).strip()
    return text


def apply_brand_map(text: str) -> str:
    for real, fake in BRAND_MAP.items():
        text = re.sub(re.escape(real), fake, text, flags=re.I)
    return text


def apply_simple_words(text: str) -> str:
    for complex_word, simple_word in SIMPLE_WORDS.items():
        text = re.sub(r"\b" + re.escape(complex_word) + r"\b", simple_word, text, flags=re.I)
    return text


def apply_glossary(text: str) -> str:
    def repl(match):
        word = match.group(0)
        key = word.lower()
        if key in USED_GLOSSARY_TERMS:
            return word
        USED_GLOSSARY_TERMS.add(key)
        return GLOSSARY[key]

    for term in sorted(GLOSSARY, key=len, reverse=True):
        pattern = r"\b" + re.escape(term) + r"\b"
        text = re.sub(pattern, repl, text, count=1, flags=re.I)
    return text


def looks_like_resource_line(raw_line: str) -> bool:
    """Bullet lines that point to an external tool/blog/book/community link."""
    stripped = raw_line.strip()
    if not re.match(r"^[-*+]\s+", stripped):
        return False
    return bool(re.search(r"\[[^\]]+\]\(https?://[^)]+\)", stripped))


def parse_markdown(md_text: str):
    lines = md_text.splitlines()
    heading_re = re.compile(r"^(#{1,6})\s+(.*)$")

    courses = []
    current_course = None
    current_lesson = None
    skip_course = False
    skip_lesson = False

    for raw_line in lines:
        m = heading_re.match(raw_line)
        if m:
            level = len(m.group(1))
            title = clean_heading_text(m.group(2))
            if not title:
                continue

            if level == 1:
                if should_skip(title):
                    skip_course, current_course, current_lesson = True, None, None
                    continue
                skip_course = False
                current_course = {"title": title, "lessons": []}
                courses.append(current_course)
                current_lesson = None

            elif level == 2:
                if skip_course:
                    continue
                if should_skip(title):
                    skip_lesson, current_lesson = True, None
                    continue
                skip_lesson = False
                if current_course is None:
                    current_course = {"title": "Getting Started", "lessons": []}
                    courses.append(current_course)
                current_lesson = {"title": title, "prose": [], "bullets": []}
                current_course["lessons"].append(current_lesson)

            else:
                if skip_course or skip_lesson:
                    continue
                if current_lesson is None:
                    if current_course is None:
                        current_course = {"title": "Getting Started", "lessons": []}
                        courses.append(current_course)
                    current_lesson = {"title": title, "prose": [], "bullets": []}
                    current_course["lessons"].append(current_lesson)
                else:
                    current_lesson["prose"].append(f"Also: {title}.")
            continue

        if skip_course or skip_lesson:
            continue

        if looks_like_resource_line(raw_line):
            continue

        stripped = raw_line.strip()
        if not stripped:
            continue

        if re.match(r"^[-*+]\s+", stripped):
            bullet_text = re.sub(r"^[-*+]\s+", "", stripped)
            bullet_text = strip_markdown_links(bullet_text)
            bullet_text = strip_urls(bullet_text)
            bullet_text = strip_markdown_formatting(bullet_text)
            if bullet_text.strip():
                target = current_lesson
                if target is None and current_course is not None:
                    current_lesson = {"title": "Overview", "prose": [], "bullets": []}
                    current_course["lessons"].append(current_lesson)
                    target = current_lesson
                if target is not None:
                    target["bullets"].append(bullet_text.strip())
            continue

        para = strip_markdown_links(stripped)
        para = strip_urls(para)
        para = strip_markdown_formatting(para)
        if not para.strip():
            continue

        target = current_lesson
        if target is None and current_course is not None:
            current_lesson = {"title": "Overview", "prose": [], "bullets": []}
            current_course["lessons"].append(current_lesson)
            target = current_lesson
        if target is not None:
            target["prose"].append(para.strip())

    return [c for c in courses if c["lessons"]]


def rewrite_simple_english(text: str) -> str:
    text = apply_glossary(text)
    text = apply_brand_map(text)
    text = apply_simple_words(text)
    text = re.sub(r"\s+", " ", text).strip()
    return text


def generate_example_paragraph(topic: str, index: int) -> str:
    brand = BRAND_EXAMPLES[index % len(BRAND_EXAMPLES)]
    templates = [
        f"Let's look at a simple example. Imagine {brand} is building a small online service. "
        f"When {brand} thinks about {topic.lower()}, the goal is to keep things simple for the customer "
        f"and still make the business healthy and profitable.",
        f"Here is how this works in real life. {BRAND_PERSON} is planning to launch a product with "
        f"{brand}. Understanding {topic.lower()} helps {BRAND_PERSON} make better decisions early, "
        f"before spending too much money.",
        f"Think of it this way: {brand} wants more Nigerian users to trust and use its product. "
        f"Getting {topic.lower()} right is one of the ways {brand} keeps customers happy and coming back.",
    ]
    return templates[index % len(templates)]


def build_lesson_body(lesson: dict, index: int) -> str:
    title = lesson["title"]
    intro = rewrite_simple_english(f"In this lesson, we will talk about {title.lower()}.")

    prose_parts = [rewrite_simple_english(p) for p in lesson["prose"] if p.strip()]
    bullet_parts = [rewrite_simple_english(b) for b in lesson["bullets"] if b.strip()]

    body_text = " ".join(prose_parts)
    word_count = len(body_text.split()) + sum(len(b.split()) for b in bullet_parts)

    paragraphs = [intro]
    if body_text:
        paragraphs.append(body_text)
    if bullet_parts:
        paragraphs.append("Here are the key points to remember:")
        paragraphs.extend(f"- {b}" for b in bullet_parts)

    if word_count < 40:
        paragraphs.append(generate_example_paragraph(title, index))
        paragraphs.append(
            rewrite_simple_english(
                f"To sum up, {title.lower()} is something every beginner building a SaaS "
                f"(a paid online service) should understand well before moving to the next lesson."
            )
        )

    return "\n\n".join(paragraphs)


def estimate_minutes(word_count: int) -> int:
    """Roughly 130 words per minute of reading/learning, rounded to nearest 5, min 5."""
    minutes = max(5, round(word_count / 130) * 5)
    return minutes


def format_duration(total_minutes: int) -> str:
    hours = total_minutes // 60
    minutes = total_minutes % 60
    if hours and minutes:
        return f"{hours}h {minutes}m"
    if hours:
        return f"{hours}h"
    return f"{minutes}m"


ICON_KEYWORDS = [
    (["pricing", "money", "revenue", "billing", "payment"], "Icons.payments"),
    (["market", "growth", "customer", "acquisition"], "Icons.trending_up"),
    (["product", "build", "develop", "mvp"], "Icons.build"),
    (["security", "auth", "privacy"], "Icons.security"),
    (["design", "ux", "ui"], "Icons.design_services"),
    (["support", "onboarding", "success"], "Icons.support_agent"),
    (["metric", "analytic", "data", "kpi"], "Icons.bar_chart"),
    (["team", "hiring", "culture"], "Icons.groups"),
    (["launch", "start", "getting started"], "Icons.rocket_launch"),
    (["cloud", "infrastructure", "server", "devops"], "Icons.cloud"),
]

DEFAULT_ICON = "Icons.school"

COLOR_PALETTE = [
    "0xFF2ECC71", "0xFF3498DB", "0xFFE67E22", "0xFF9B59B6",
    "0xFF1ABC9C", "0xFFF39C12", "0xFFE74C3C", "0xFF2980B9",
]


def pick_icon(title: str) -> str:
    t = title.lower()
    for keywords, icon in ICON_KEYWORDS:
        if any(k in t for k in keywords):
            return icon
    return DEFAULT_ICON


def escape_dart_string(text: str) -> str:
    text = text.replace("\\", "\\\\")
    text = text.replace("$", "\\$")
    text = re.sub(r"'{3,}", "''", text)
    return text


def build_lesson_dart(title: str, body: str, indent: str) -> str:
    safe_title = escape_dart_string(title)
    safe_body = escape_dart_string(body)
    return (
        f"{indent}AppLesson(\n"
        f"{indent}  title: '{safe_title}',\n"
        f"{indent}  body: '''{safe_body}''',\n"
        f"{indent}),\n"
    )


def build_course_dart(course_id: str, title: str, description: str, icon: str,
                       color_hex: str, lessons_dart: str, duration: str) -> str:
    safe_title = escape_dart_string(title)
    safe_description = escape_dart_string(description)
    return (
        f"  AppCourse(\n"
        f"    id: '{course_id}',\n"
        f"    title: '{safe_title}',\n"
        f"    description: '{safe_description}',\n"
        f"    instructor: '{INSTRUCTOR}',\n"
        f"    category: '{CATEGORY}',\n"
        f"    difficulty: '{DIFFICULTY}',\n"
        f"    icon: {icon},\n"
        f"    color: const Color({color_hex}),\n"
        f"    lessons: [\n"
        f"{lessons_dart}"
        f"    ],\n"
        f"    duration: '{duration}',\n"
        f"  ),\n"
    )


def main():
    if not SOURCE_PATH.exists():
        raise SystemExit(f"Source file not found: {SOURCE_PATH}")

    md_text = SOURCE_PATH.read_text(encoding="utf-8")
    courses = parse_markdown(md_text)

    dart_courses = []
    total_lessons = 0

    for c_index, course in enumerate(courses):
        course_title = rewrite_simple_english(course["title"])
        course_id = f"saas-{slugify(course_title)}-{c_index}"
        icon = pick_icon(course_title)
        color_hex = COLOR_PALETTE[c_index % len(COLOR_PALETTE)]

        lessons_dart_str = ""
        course_total_words = 0

        for l_index, lesson in enumerate(course["lessons"]):
            lesson_title = rewrite_simple_english(lesson["title"])
            body = build_lesson_body(lesson, c_index + l_index)
            course_total_words += len(body.split())
            lessons_dart_str += build_lesson_dart(lesson_title, body, "      ")
            total_lessons += 1

        course_duration = format_duration(estimate_minutes(course_total_words))

        description = rewrite_simple_english(
            f"A beginner-friendly guide to {course_title.lower()}, "
            f"explained in simple English with real examples from {BRAND_EXAMPLES[c_index % len(BRAND_EXAMPLES)]}."
        )

        dart_courses.append(
            build_course_dart(
                course_id, course_title, description, icon,
                color_hex, lessons_dart_str, course_duration,
            )
        )

    header = (
        "import 'package:flutter/material.dart';\n"
        "import '../models/app_course.dart';\n\n"
        "final List<AppCourse> saasCourses = [\n"
    )
    footer = "];\n"

    dart_output = header + "".join(dart_courses) + footer

    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)
    OUTPUT_PATH.write_text(dart_output, encoding="utf-8")

    print(f"Courses generated: {len(courses)}")
    print(f"Lessons generated: {total_lessons}")
    print(f"Written to: {OUTPUT_PATH.resolve()}")


if __name__ == "__main__":
    main()

