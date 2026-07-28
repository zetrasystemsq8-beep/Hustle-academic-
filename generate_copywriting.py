#!/usr/bin/env python3

from pathlib import Path

ROOT = Path("marketing-skills")

OUT = Path("lib/courses/copywriting_courses.dart")


SKILLS = [
    "copywriting",
    "copy-editing",
    "email-sequence",
    "content-strategy",
    "content-repurposing",
]

def esc(text):
    return (
        text.replace("\\", "\\\\")
            .replace("$", "\\$")
            .replace('"', '\\"')
            .replace("\r", "")
    )

courses = []

for skill in SKILLS:

    for skill_file in ROOT.rglob("SKILL.md"):

        if skill not in str(skill_file):
            continue

        lesson_files = [skill_file]

        ref = skill_file.parent / "references"

        if ref.exists():
            lesson_files.extend(sorted(ref.glob("*.md")))

        asset = skill_file.parent / "assets"

        if asset.exists():
            lesson_files.extend(sorted(asset.glob("*.md")))

        lessons = []

        for file in lesson_files:

            body = file.read_text(
                encoding="utf-8",
                errors="ignore",
            ).strip()

            if len(body) < 100:
                continue

            lessons.append(
                (
                    file.stem.replace("-", " ").replace("_", " ").title(),
                    body,
                )
            )

        if lessons:

            courses.append(
                (
                    skill.replace("-", " ").title(),
                    lessons,
                )
            )

            break

with OUT.open("w", encoding="utf-8") as f:

    f.write("import 'package:flutter/material.dart';\n")
    f.write("import '../models/app_course.dart';\n\n")

    f.write("final copywritingCourses = <AppCourse>[\n\n")

    cid = 1

    for course, lessons in courses:

        f.write(f'''AppCourse(
  id: "copy_{cid}",
  title: "{esc(course)}",
  description: "{esc(course)}",
  instructor: "Hustle Academy",
  category: "Copywriting",
  difficulty: "Intermediate",
  icon: Icons.edit,
  color: Colors.deepPurple,
  duration: "{len(lessons)} Lessons",
  lessons: [
''')

        for title, body in lessons:

            body = esc(body)

            f.write(f'''    AppLesson(
      title: "{esc(title)}",
      body: r"""{body}""",
    ),

''')

        f.write('''  ],
),

''')

        cid += 1

    f.write("];\n")

print("Generated:", OUT)
print("Courses:", len(courses))

