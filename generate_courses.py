from pathlib import Path

DOCS = Path("user-documentation/docs")
OUT = Path("lib/courses/digital_marketing_courses.dart")


def esc(s):
    return s.replace("\\", "\\\\").replace('"', '\\"')


courses = []

for folder in sorted(DOCS.iterdir()):
    if not folder.is_dir():
        continue

    lessons = []

    for file in sorted(folder.glob("*.rst")):
        text = file.read_text(encoding="utf-8", errors="ignore")

        title = file.stem.replace("_", " ").replace("-", " ").title()

        body = []

        for line in text.splitlines():

            line = line.rstrip()

            if line.startswith(".. "):
                continue

            if line.startswith(":"):
                continue

            if set(line) <= {"=", "-", "~", "^", "*"}:
                continue

            body.append(line)

        content = "\n".join(body).strip()

        if len(content) < 100:
            continue

        lessons.append((title, content))

    if lessons:
        courses.append((folder.name.replace("_", " ").title(), lessons))


with OUT.open("w", encoding="utf-8") as f:

    f.write("import 'package:flutter/material.dart';\n")
    f.write("import '../models/app_course.dart';\n\n")

    f.write("final digitalMarketingCourses = <AppCourse>[\n\n")

    cid = 1

    for course_name, lessons in courses:

        f.write(f'''
AppCourse(
  id: "marketing_{cid}",
  title: "{esc(course_name)}",
  description: "{esc(course_name)}",
  instructor: "Hustle Academy",
  category: "Digital Marketing",
  difficulty: "Intermediate",
  icon: Icons.campaign,
  color: Colors.blue,
  duration: "{len(lessons)} Lessons",
  lessons: [
''')

        for title, body in lessons:

            body = esc(body)

            f.write(f'''
    AppLesson(
      title: "{title}",
      body: """{body}""",
    ),
''')

        f.write("""
  ],
),

""")

        cid += 1

    f.write("];\n")

print(f"Generated {OUT}")

