#!/usr/bin/env python3

from pathlib import Path
import re

DOCS = Path("user-documentation/docs")
OUT = Path("lib/courses/digital_marketing_courses.dart")

CATEGORY = "Digital Marketing"
INSTRUCTOR = "Hustle Academy"
DIFFICULTY = "Intermediate"

IGNORE = {
    "README",
    "index",
    "license",
    "contributing",
    "pull_request_template",
}

ICON = "Icons.campaign"
COLOR = "Colors.blue"


def esc(text):
    if not text:
        return ""

    return (
        text.replace("\\", "\\\\")
            .replace("$", "\\$")
            .replace('"', '\\"')
            .replace("\r", "")
    )


def clean_rst(text):

    out = []

    for line in text.splitlines():

        s = line.rstrip()

        if s.startswith(".. "):
            continue

        if s.startswith(":"):
            continue

        if re.fullmatch(r"[=\-~^*`#]{3,}", s):
            continue

        out.append(s)

    return "\n".join(out).strip()


courses = []

for folder in sorted(DOCS.iterdir()):

    if not folder.is_dir():
        continue

    lessons = []

    for file in sorted(folder.glob("*.rst")):

        if file.stem.lower() in IGNORE:
            continue

        raw = file.read_text(
            encoding="utf-8",
            errors="ignore",
        )

        raw = clean_rst(raw)

        if len(raw) < 100:
            continue

        title = (
            file.stem
            .replace("_", " ")
            .replace("-", " ")
            .title()
        )

        lessons.append(
            (
                title,
                raw,
            )
        )

    if lessons:

        courses.append(
            (
                folder.name
                    .replace("_", " ")
                    .replace("-", " ")
                    .title(),
                lessons,
            )
        )
with OUT.open("w", encoding="utf-8") as f:

    f.write("import 'package:flutter/material.dart';\n")
    f.write("import '../models/app_course.dart';\n\n")

    f.write("final digitalMarketingCourses = <AppCourse>[\n\n")

    cid = 1

    for course_name, lessons in courses:

        f.write(f'''AppCourse(
  id: "marketing_{cid}",
  title: "{esc(course_name)}",
  description: "{esc(course_name)}",
  instructor: "{INSTRUCTOR}",
  category: "{CATEGORY}",
  difficulty: "{DIFFICULTY}",
  icon: {ICON},
  color: {COLOR},
  duration: "{len(lessons)} Lessons",
  lessons: [
''')

        for lesson_title, lesson_body in lessons:

            lesson_body = esc(lesson_body)

            f.write(f'''    AppLesson(
      title: "{esc(lesson_title)}",
      body: r"""{lesson_body}""",
    ),

''')

        f.write('''  ],
),

''')

        cid += 1

    f.write("];\n")

print("=" * 50)
print("Generation complete!")
print(f"Courses generated : {len(courses)}")
print(f"Output file       : {OUT}")
print("=" * 50)

