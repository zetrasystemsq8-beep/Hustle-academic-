import re
from pathlib import Path

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
            .replace("\n", "\\n")
    )


lines = INPUT.read_text(encoding="utf-8").splitlines()

courses = []

course = None
lesson_title = None
lesson_body = []

for line in lines:

    if line.startswith("# "):

        if lesson_title:
            course["lessons"].append(
                (lesson_title, "\n".join(lesson_body).strip())
            )
            lesson_title = None
            lesson_body = []

        title = line[2:].strip()

        if title in SKIP:
            course = None
            continue

        course = {
            "title": title,
            "lessons": [],
        }

        courses.append(course)
        continue

    if course is None:
        continue

    if line.startswith("## ") or line.startswith("### ") or line.startswith("#### "):

        if lesson_title:
            course["lessons"].append(
                (lesson_title, "\n".join(lesson_body).strip())
            )

        lesson_title = re.sub(r"^#+\s*", "", line).strip()
        lesson_body = []
        continue

    if lesson_title:
        lesson_body.append(line)

if course and lesson_title:
    course["lessons"].append(
        (lesson_title, "\n".join(lesson_body).strip())
    )

with OUTPUT.open("w", encoding="utf-8") as f:

    f.write("import '../models/app_course.dart';\n\n")

    f.write("final entrepreneurshipCourses = <AppCourse>[\n")

    cid = 1

    for course in courses:

        if not course["lessons"]:
            continue

        f.write(
            f'''
AppCourse(
id: "entrepreneurship_{cid}",
title: "{esc(course["title"])}",
description: "{esc(course["title"])}",
category: AppCategory.business,
lessons: [
'''
        )

        lid = 1

        for title, body in course["lessons"]:

            body = body.strip()

            if not body:
                continue

            f.write(
                f'''
AppLesson(
id: "l{lid}",
title: "{esc(title)}",
content: """{body}""",
),
'''
            )

            lid += 1

        f.write("],\n),\n")

        cid += 1

    f.write("];\n")

print(f"Generated {OUTPUT}")

