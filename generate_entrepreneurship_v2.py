from pathlib import Path
import re

INPUT = Path("Startup-CTO-Handbook/StartupCTOHandbook.md")
OUTPUT = Path("lib/courses/entrepreneurship_courses.dart")

SKIP = {
    "Dedications",
    "Praise",
    "Contents",
    "Introduction",
    "The Author",
    "Using this Book",
}

def esc(text):
    return (
        text.replace("\\", "\\\\")
            .replace('"', '\\"')
    )

lines = INPUT.read_text(encoding="utf-8").splitlines()

courses = []

current_course = None
current_lesson = None
lesson_body = []

for line in lines:

    if line.startswith("# "):
        if current_lesson and current_course:
            current_course["lessons"].append(
                (current_lesson, "\n".join(lesson_body).strip())
            )

        current_lesson = None
        lesson_body = []

        title = line[2:].strip()

        if title in SKIP:
            current_course = None
            continue

        current_course = {
            "title": title,
            "lessons": [],
        }

        courses.append(current_course)
        continue

    if current_course is None:
        continue

    if re.match(r"^#{2,4}\s", line):
        if current_lesson:
            current_course["lessons"].append(
                (current_lesson, "\n".join(lesson_body).strip())
            )

        current_lesson = re.sub(r"^#{2,4}\s*", "", line).strip()
        lesson_body = []
        continue

    if current_lesson:
        lesson_body.append(line)

if current_course and current_lesson:
    current_course["lessons"].append(
        (current_lesson, "\n".join(lesson_body).strip())
    )

with OUTPUT.open("w", encoding="utf-8") as f:

    f.write("import 'package:flutter/material.dart';\n")
    f.write("import '../models/app_course.dart';\n\n")

    f.write("final entrepreneurshipCourses = <AppCourse>[\n\n")

    for c, course in enumerate(courses, start=1):

        lessons = [l for l in course["lessons"] if l[1].strip()]

        if not lessons:
            continue

        f.write(f"""AppCourse(
  id: "entrepreneurship_{c}",
  title: "{esc(course['title'])}",
  description: "{esc(course['title'])}",
  instructor: "Hustle Academy",
  category: "Entrepreneurship",
  difficulty: "Intermediate",
  icon: Icons.business_center,
  color: Colors.orange,
  duration: "{len(lessons)} Lessons",
  lessons: [
""")

        for title, body in lessons:

            body = esc(body)

            f.write(f"""    AppLesson(
      title: "{esc(title)}",
      body: \"\"\"{body}\"\"\",
    ),

""")

        f.write("""  ],
),

""")

    f.write("];\n")

print(f"Done! Generated {OUTPUT}")

