// ============================================================
// PROGRAMMING COURSES
// lib/courses/programming_courses.dart
// ============================================================
// Add this import to main.dart:
// import 'courses/programming_courses.dart';
//
// Then inside kCourses, spread it in:
// final List<AppCourse> kCourses = [
//   ...programmingCourses,
//   ...otherCategoryCourses,
// ];
// ============================================================

import 'package:flutter/material.dart';
import '../main.dart';
import '../models/course_models.dart';
final List<AppCourse> programmingCourses = [
  // ============================================================
  // COURSE 1: PYTHON PROGRAMMING FUNDAMENTALS
  // ============================================================
  AppCourse(
    id: 'prog_python_101',
    title: 'Python Programming Fundamentals',
    description:
        'A complete beginner-friendly journey into Python — one of the most '
        'in-demand and beginner-friendly programming languages in the world. '
        'You will learn syntax, data types, control flow, functions, and how '
        'to structure real programs from the ground up.',
    instructor: 'Ada Nwosu',
    category: 'Programming',
    difficulty: 'Beginner',
    icon: Icons.code,
    color: Colors.indigo,
    duration: '6h 40m',
    lessons: [
      AppLesson(
        title: 'Why Python? Setting Up Your Environment',
        body:
            'Python is one of the most widely used programming languages on '
            'the planet, powering everything from websites and automation '
            'scripts to machine learning models and scientific research. Its '
            'biggest strength is readability — Python code often reads almost '
            'like plain English, which makes it an excellent first language.\n\n'
            'Before writing any code, you need an environment to run it in. '
            'You can install Python from python.org, or use an online editor '
            'like Replit if you want to skip installation entirely. Once '
            'installed, you can confirm everything works by opening a terminal '
            'and typing python --version.\n\n'
            'Throughout this course we will write small programs, run them, '
            'and build up your understanding one concept at a time. Do not '
            'worry about memorizing everything immediately — programming is '
            'learned by doing, not by reading alone.',
        hasImage: true,
        codeSnippet:
            '# Your very first Python program\n'
            'print("Hello, Hustle Academy!")\n'
            '\n'
            '# Check your Python version from the terminal:\n'
            '# python --version',
      ),
      AppLesson(
        title: 'Variables and Data Types',
        body:
            'A variable is simply a name that points to a value stored in '
            'memory. Unlike some other languages, Python does not require you '
            'to declare a type up front — the type is inferred automatically '
            'based on the value you assign.\n\n'
            'Python has several built-in data types you will use constantly: '
            'int for whole numbers, float for decimal numbers, str for text, '
            'and bool for True/False values. Understanding how these types '
            'behave — and how to convert between them — is one of the most '
            'important early skills in programming.\n\n'
            'Naming your variables clearly matters more than it seems. A '
            'variable called x tells the reader nothing, while a variable '
            'called total_price immediately communicates intent. Good naming '
            'is a habit worth building from day one.',
        codeSnippet:
            'name = "Hustler"        # str\n'
            'age = 22                # int\n'
            'height = 1.75           # float\n'
            'is_learning = True      # bool\n'
            '\n'
            'print(type(name))\n'
            'print(f"{name} is {age} years old")',
      ),
      AppLesson(
        title: 'Operators and Expressions',
        body:
            'Operators let you combine and compare values. Arithmetic '
            'operators (+, -, *, /, //, %, **) handle math, comparison '
            'operators (==, !=, <, >, <=, >=) compare values and return a '
            'boolean, and logical operators (and, or, not) combine boolean '
            'expressions together.\n\n'
            'One subtlety worth memorizing early: the single slash / always '
            'returns a float in Python, even when dividing two whole numbers '
            'evenly. If you want integer (floor) division, use the double '
            'slash // instead. The percent sign % gives you the remainder of '
            'a division, which is extremely useful for tasks like checking if '
            'a number is even.',
        codeSnippet:
            'a = 17\n'
            'b = 5\n'
            '\n'
            'print(a / b)   # 3.4 (float division)\n'
            'print(a // b)  # 3 (floor division)\n'
            'print(a % b)   # 2 (remainder)\n'
            'print(a > b and b > 0)  # True',
      ),
      AppLesson(
        title: 'Strings and String Formatting',
        body:
            'Strings are sequences of characters, and Python gives you a rich '
            'toolkit for working with them. You can slice strings to extract '
            'portions, use methods like .upper(), .lower(), .strip(), and '
            '.replace() to transform them, and join or split strings to move '
            'between lists and text.\n\n'
            'The most readable way to build strings with embedded values is '
            'an f-string — prefixing a string with f and wrapping variables in '
            'curly braces. This has become the standard approach in modern '
            'Python code because it is concise and easy to read at a glance, '
            'compared to older concatenation-based approaches.',
        codeSnippet:
            'first = "Hustle"\n'
            'second = "Academy"\n'
            'full = f"{first} {second}"\n'
            '\n'
            'print(full.upper())\n'
            'print(full.replace("Academy", "Hub"))\n'
            'print(full[0:6])  # slicing: "Hustle"',
      ),
      AppLesson(
        title: 'Lists, Tuples, and Sets',
        body:
            'A list is an ordered, changeable collection — probably the most '
            'commonly used data structure in Python. You can add, remove, and '
            'reorder items freely. A tuple looks similar but is immutable, '
            'meaning once created it cannot be changed, which makes it useful '
            'for fixed collections of data like coordinates.\n\n'
            'A set is an unordered collection of unique values, and it '
            'automatically removes duplicates. Sets are extremely fast for '
            'checking whether an item exists inside them, which makes them a '
            'great choice when you care about membership rather than order.',
        codeSnippet:
            'skills = ["python", "flutter", "sql"]\n'
            'skills.append("react")\n'
            'skills.remove("sql")\n'
            '\n'
            'coordinates = (6.5244, 3.3792)  # tuple, immutable\n'
            'unique_tags = {"beginner", "beginner", "coding"}\n'
            'print(unique_tags)  # duplicates removed automatically',
      ),
      AppLesson(
        title: 'Dictionaries',
        body:
            'A dictionary stores data as key-value pairs, similar to a '
            'real-world dictionary where a word (the key) maps to its '
            'definition (the value). Dictionaries are extremely fast at '
            'looking up a value once you know its key, and they are used '
            'everywhere in real applications — from configuration settings to '
            'representing JSON data returned by an API.\n\n'
            'You can loop through a dictionary's keys, values, or both '
            'together using .items(). Learning to reach for a dictionary '
            'instead of nested lists is a big step toward writing cleaner, '
            'more maintainable Python code.',
        codeSnippet:
            'student = {\n'
            '    "name": "Chidi",\n'
            '    "age": 21,\n'
            '    "courses": ["python", "sql"]\n'
            '}\n'
            '\n'
            'for key, value in student.items():\n'
            '    print(f"{key}: {value}")',
      ),
      AppLesson(
        title: 'Conditionals: if, elif, else',
        body:
            'Conditionals let your program make decisions. Python evaluates '
            'an if condition, and if it is truthy, runs the indented block '
            'beneath it. If not, it checks any elif conditions in order, and '
            'finally falls back to else if none of them matched.\n\n'
            'Indentation is not just a style preference in Python — it is how '
            'the language knows which lines belong to which block. This can '
            'trip up beginners coming from other languages that use curly '
            'braces, so pay close attention to consistent spacing.',
        codeSnippet:
            'score = 72\n'
            '\n'
            'if score >= 90:\n'
            '    grade = "A"\n'
            'elif score >= 70:\n'
            '    grade = "B"\n'
            'elif score >= 50:\n'
            '    grade = "C"\n'
            'else:\n'
            '    grade = "F"\n'
            '\n'
            'print(f"Your grade is {grade}")',
      ),
      AppLesson(
        title: 'Loops: for and while',
        body:
            'Loops let you repeat an action without rewriting the same code '
            'over and over. A for loop iterates over a sequence — a list, a '
            'string, a range of numbers — running the block once per item. A '
            'while loop instead keeps running as long as a condition remains '
            'true, which is useful when you don't know in advance how many '
            'times you need to repeat something.\n\n'
            'Two keywords are worth remembering: break exits a loop '
            'immediately, and continue skips straight to the next iteration. '
            'Combined with conditionals, these give you fine-grained control '
            'over exactly how your loop behaves.',
        codeSnippet:
            'for i in range(5):\n'
            '    if i == 3:\n'
            '        continue\n'
            '    print(i)\n'
            '\n'
            'count = 0\n'
            'while count < 3:\n'
            '    print("Counting:", count)\n'
            '    count += 1',
      ),
      AppLesson(
        title: 'Functions and Parameters',
        body:
            'Functions let you package a block of logic under a name so it '
            'can be reused instead of rewritten. Parameters let a function '
            'accept input, and a return statement lets it hand back a result '
            'to whatever code called it.\n\n'
            'Python also supports default parameter values, keyword '
            'arguments, and functions that accept a variable number of '
            'arguments using *args and **kwargs. Writing small, focused '
            'functions that do one thing well is one of the most valuable '
            'habits you can build as a programmer.',
        codeSnippet:
            'def greet(name, greeting="Hello"):\n'
            '    return f"{greeting}, {name}!"\n'
            '\n'
            'print(greet("Amaka"))\n'
            'print(greet("Tunde", greeting="Welcome"))\n'
            '\n'
            'def total(*numbers):\n'
            '    return sum(numbers)\n'
            '\n'
            'print(total(1, 2, 3, 4))',
      ),
      AppLesson(
        title: 'Error Handling with try/except',
        body:
            'Real programs encounter unexpected situations: a file that '
            'doesn't exist, a user typing text where a number was expected, a '
            'network request that fails. Python lets you handle these '
            'gracefully with try/except blocks instead of letting your entire '
            'program crash.\n\n'
            'You can catch specific exception types like ValueError or '
            'ZeroDivisionError, and optionally use a finally block to run '
            'cleanup code regardless of whether an error occurred. Writing '
            'defensive code that anticipates failure is a mark of a mature '
            'programmer.',
        codeSnippet:
            'def divide(a, b):\n'
            '    try:\n'
            '        return a / b\n'
            '    except ZeroDivisionError:\n'
            '        return "Cannot divide by zero"\n'
            '    finally:\n'
            '        print("Division attempted")\n'
            '\n'
            'print(divide(10, 2))\n'
            'print(divide(10, 0))',
      ),
      AppLesson(
        title: 'Working with Files',
        body:
            'Reading and writing files is a fundamental skill — configuration '
            'files, logs, and exported data all rely on it. Python's built-in '
            'open() function returns a file object you can read from or write '
            'to, and using the with statement ensures the file is properly '
            'closed afterward, even if an error occurs partway through.\n\n'
            'You will commonly work with plain text files as well as CSV '
            'files for tabular data. Understanding file modes — "r" for read, '
            '"w" for write (which overwrites), and "a" for append — prevents '
            'a lot of accidental data loss.',
        codeSnippet:
            'with open("notes.txt", "w") as f:\n'
            '    f.write("Learning Python at Hustle Academy\\n")\n'
            '\n'
            'with open("notes.txt", "r") as f:\n'
            '    content = f.read()\n'
            '    print(content)',
      ),
      AppLesson(
        title: 'Mini Project: Simple To-Do List',
        body:
            'It is time to combine everything you have learned into a small, '
            'complete program. We will build a command-line to-do list that '
            'lets a user add tasks, view them, and mark them as complete, '
            'using a list of dictionaries to represent each task.\n\n'
            'This kind of project — small in scope but touching many '
            'concepts at once — is exactly how real skill is built. Try '
            'extending it yourself afterward: add the ability to delete '
            'tasks, or save the list to a file so it persists between runs.',
        codeSnippet:
            'tasks = []\n'
            '\n'
            'def add_task(title):\n'
            '    tasks.append({"title": title, "done": False})\n'
            '\n'
            'def complete_task(index):\n'
            '    tasks[index]["done"] = True\n'
            '\n'
            'add_task("Finish Python course")\n'
            'add_task("Build a portfolio project")\n'
            'complete_task(0)\n'
            '\n'
            'for i, t in enumerate(tasks):\n'
            '    status = "✅" if t["done"] else "⬜"\n'
            '    print(f"{status} {t[\'title\']}")',
      ),
    ],
  ),

  // ============================================================
  // COURSE 2: JAVA PROGRAMMING FUNDAMENTALS
  // ============================================================
  AppCourse(
    id: 'prog_java_101',
    title: 'Java Programming Fundamentals',
    description:
        'Learn Java, the backbone of Android development and enterprise '
        'software worldwide. This course covers syntax, object-oriented '
        'programming, and how the Java Virtual Machine lets your code run '
        'almost anywhere.',
    instructor: 'Emeka Obi',
    category: 'Programming',
    difficulty: 'Beginner',
    icon: Icons.coffee,
    color: Colors.brown,
    duration: '7h 10m',
    lessons: [
      AppLesson(
        title: 'Introduction to Java and the JVM',
        body:
            'Java was built around the philosophy of "write once, run '
            'anywhere." Your source code is compiled into bytecode, which '
            'runs inside the Java Virtual Machine (JVM) on any device that '
            'has one installed — meaning the same compiled program runs '
            'identically on Windows, macOS, or Linux.\n\n'
            'Java is statically typed, which means you must declare the type '
            'of every variable up front, and the compiler checks those types '
            'before your program ever runs. This catches a whole category of '
            'bugs early, at the cost of a bit more typing compared to '
            'dynamically typed languages like Python.',
        hasImage: true,
        codeSnippet:
            'public class Main {\n'
            '    public static void main(String[] args) {\n'
            '        System.out.println("Hello, Hustle Academy!");\n'
            '    }\n'
            '}',
      ),
      AppLesson(
        title: 'Variables, Types, and Casting',
        body:
            'Java has primitive types like int, double, boolean, and char, '
            'along with reference types like String and arrays. Because Java '
            'is statically typed, you declare both the type and the name '
            'when creating a variable, and the compiler enforces that type '
            'for the variable's entire lifetime.\n\n'
            'Sometimes you need to convert between types — this is called '
            'casting. Widening casts, like int to double, happen '
            'automatically. Narrowing casts, like double to int, must be '
            'done explicitly because they can lose information.',
        codeSnippet:
            'int age = 22;\n'
            'double price = 19.99;\n'
            'boolean isActive = true;\n'
            'String name = "Hustler";\n'
            '\n'
            'double widened = age;       // automatic\n'
            'int narrowed = (int) price; // explicit cast, becomes 19',
      ),
      AppLesson(
        title: 'Control Flow: if, switch, loops',
        body:
            'Java supports the familiar if/else if/else chain, along with a '
            'switch statement that is often cleaner when comparing one '
            'variable against many possible fixed values. Modern Java also '
            'supports a more concise switch expression syntax using arrows.\n\n'
            'For loops, Java gives you the classic for loop with an '
            'initializer, condition, and increment, a while loop, and a '
            'for-each loop for iterating cleanly over arrays and collections '
            'without manually tracking an index.',
        codeSnippet:
            'int day = 3;\n'
            'switch (day) {\n'
            '    case 1 -> System.out.println("Monday");\n'
            '    case 2 -> System.out.println("Tuesday");\n'
            '    default -> System.out.println("Another day");\n'
            '}\n'
            '\n'
            'int[] scores = {70, 85, 90};\n'
            'for (int s : scores) {\n'
            '    System.out.println(s);\n'
            '}',
      ),
      AppLesson(
        title: 'Classes and Objects',
        body:
            'Java is an object-oriented language at its core — almost '
            'everything you write lives inside a class. A class is a '
            'blueprint describing what data (fields) and behavior (methods) '
            'an object of that type will have. An object is a concrete '
            'instance created from that blueprint using the new keyword.\n\n'
            'Understanding the distinction between a class and an object is '
            'foundational: the class Student describes what a student looks '
            'like in general, while a specific object like a student named '
            '"Amaka" is one particular instance of that class.',
        codeSnippet:
            'class Student {\n'
            '    String name;\n'
            '    int age;\n'
            '\n'
            '    void introduce() {\n'
            '        System.out.println("Hi, I am " + name);\n'
            '    }\n'
            '}\n'
            '\n'
            'Student s = new Student();\n'
            's.name = "Amaka";\n'
            's.introduce();',
      ),
      AppLesson(
        title: 'Constructors and Encapsulation',
        body:
            'A constructor is a special method that runs automatically when '
            'an object is created, typically used to set up its initial '
            'state. Encapsulation is the practice of keeping a class's '
            'internal fields private, and exposing controlled access through '
            'public getter and setter methods.\n\n'
            'This matters because it lets you change how data is stored '
            'internally without breaking any code that uses your class, as '
            'long as the public methods keep behaving the same way. It also '
            'lets you validate data before it is ever stored.',
        codeSnippet:
            'class BankAccount {\n'
            '    private double balance;\n'
            '\n'
            '    public BankAccount(double startingBalance) {\n'
            '        this.balance = startingBalance;\n'
            '    }\n'
            '\n'
            '    public void deposit(double amount) {\n'
            '        if (amount > 0) balance += amount;\n'
            '    }\n'
            '\n'
            '    public double getBalance() {\n'
            '        return balance;\n'
            '    }\n'
            '}',
      ),
      AppLesson(
        title: 'Inheritance and Polymorphism',
        body:
            'Inheritance lets one class (a subclass) reuse and extend the '
            'behavior of another (a superclass), using the extends keyword. '
            'This avoids duplicating code across related classes that share '
            'common behavior, such as different types of employees who all '
            'share a base set of attributes.\n\n'
            'Polymorphism means a subclass can override a method from its '
            'superclass to provide its own specific behavior, while still '
            'being usable anywhere the superclass type is expected. This is '
            'one of the most powerful ideas in object-oriented design.',
        codeSnippet:
            'class Animal {\n'
            '    void speak() {\n'
            '        System.out.println("Some generic sound");\n'
            '    }\n'
            '}\n'
            '\n'
            'class Dog extends Animal {\n'
            '    @Override\n'
            '    void speak() {\n'
            '        System.out.println("Woof!");\n'
            '    }\n'
            '}\n'
            '\n'
            'Animal a = new Dog();\n'
            'a.speak(); // prints "Woof!"',
      ),
      AppLesson(
        title: 'Interfaces and Abstract Classes',
        body:
            'An interface defines a contract — a set of methods that any '
            'implementing class must provide, without specifying how they '
            'work. This lets unrelated classes share common behavior '
            'expectations without needing to inherit from a common parent.\n\n'
            'An abstract class sits somewhere in between a regular class and '
            'an interface: it can contain both fully implemented methods and '
            'abstract ones that subclasses must fill in. Choosing between the '
            'two often comes down to whether you need shared implementation '
            'code or just a shared contract.',
        codeSnippet:
            'interface Payable {\n'
            '    double calculatePay();\n'
            '}\n'
            '\n'
            'class Freelancer implements Payable {\n'
            '    double hours, rate;\n'
            '    Freelancer(double hours, double rate) {\n'
            '        this.hours = hours;\n'
            '        this.rate = rate;\n'
            '    }\n'
            '    public double calculatePay() {\n'
            '        return hours * rate;\n'
            '    }\n'
            '}',
      ),
      AppLesson(
        title: 'Collections: ArrayList and HashMap',
        body:
            'Java's array size is fixed once created, which is often '
            'inconvenient. The Collections framework solves this — ArrayList '
            'behaves like a resizable array, letting you add and remove '
            'elements freely, while HashMap stores key-value pairs similar to '
            'a Python dictionary.\n\n'
            'These two collection types cover the overwhelming majority of '
            'everyday data storage needs in Java applications, and learning '
            'their common methods well will make you dramatically more '
            'productive than working with raw arrays.',
        codeSnippet:
            'import java.util.ArrayList;\n'
            'import java.util.HashMap;\n'
            '\n'
            'ArrayList<String> skills = new ArrayList<>();\n'
            'skills.add("Java");\n'
            'skills.add("SQL");\n'
            '\n'
            'HashMap<String, Integer> scores = new HashMap<>();\n'
            'scores.put("Amaka", 95);\n'
            'System.out.println(scores.get("Amaka"));',
      ),
      AppLesson(
        title: 'Exception Handling',
        body:
            'Java uses try/catch/finally blocks to handle runtime errors '
            'gracefully. Exceptions in Java are organized into a class '
            'hierarchy — checked exceptions must be either caught or declared '
            'in a method signature, while unchecked exceptions, like '
            'NullPointerException, do not require this.\n\n'
            'Writing your own custom exception classes by extending '
            'Exception is common in larger applications, letting you '
            'represent domain-specific error conditions clearly instead of '
            'relying only on generic exception types.',
        codeSnippet:
            'try {\n'
            '    int[] nums = {1, 2, 3};\n'
            '    System.out.println(nums[5]);\n'
            '} catch (ArrayIndexOutOfBoundsException e) {\n'
            '    System.out.println("Index does not exist");\n'
            '} finally {\n'
            '    System.out.println("Done checking array");\n'
            '}',
      ),
      AppLesson(
        title: 'Mini Project: Student Grade Manager',
        body:
            'We will bring together classes, collections, and control flow '
            'into a small grade management program. It stores a list of '
            'student objects, each with a name and a list of scores, and '
            'calculates each student's average and letter grade.\n\n'
            'Try extending this afterward by sorting students by average '
            'score, or adding the ability to remove a student. Small '
            'projects like this are where object-oriented concepts finally '
            'click into place.',
        codeSnippet:
            'class Student {\n'
            '    String name;\n'
            '    ArrayList<Integer> scores = new ArrayList<>();\n'
            '\n'
            '    Student(String name) {\n'
            '        this.name = name;\n'
            '    }\n'
            '\n'
            '    double average() {\n'
            '        int sum = 0;\n'
            '        for (int s : scores) sum += s;\n'
            '        return scores.isEmpty() ? 0 : (double) sum / scores.size();\n'
            '    }\n'
            '}',
      ),
    ],
  ),

  // ============================================================
  // COURSE 3: C PROGRAMMING BASICS
  // ============================================================
  AppCourse(
    id: 'prog_c_101',
    title: 'C Programming Basics',
    description:
        'Understand how computers really work by learning C — the language '
        'behind operating systems, embedded devices, and most other '
        'programming languages themselves. A foundational course for '
        'serious programmers.',
    instructor: 'Ibrahim Musa',
    category: 'Programming',
    difficulty: 'Intermediate',
    icon: Icons.memory,
    color: Colors.blueGrey,
    duration: '5h 30m',
    lessons: [
      AppLesson(
        title: 'Why Learn C in 2026?',
        body:
            'C is over five decades old, yet it remains foundational to '
            'nearly every layer of modern computing. Operating systems, '
            'device drivers, and the runtimes of higher-level languages are '
            'commonly written in C, because it gives you direct, low-level '
            'control over memory and hardware with almost no runtime '
            'overhead.\n\n'
            'Learning C forces you to understand exactly what your code is '
            'doing under the hood — there is no garbage collector, no hidden '
            'abstractions. This makes C an excellent language for building a '
            'deep, transferable understanding of how computers actually '
            'work.',
        hasImage: true,
        codeSnippet:
            '#include <stdio.h>\n'
            '\n'
            'int main() {\n'
            '    printf("Hello, Hustle Academy!\\n");\n'
            '    return 0;\n'
            '}',
      ),
      AppLesson(
        title: 'Variables, Types, and Memory',
        body:
            'C requires you to declare a variable's type explicitly, and '
            'that type determines exactly how many bytes of memory it '
            'occupies. An int is typically 4 bytes, a char is 1 byte, and a '
            'double is 8 bytes — understanding this is essential because C '
            'gives you no protection against writing outside those '
            'boundaries.\n\n'
            'The sizeof operator lets you check exactly how much memory a '
            'type or variable consumes, which becomes especially important '
            'once you start working with arrays, structs, and pointers later '
            'in this course.',
        codeSnippet:
            'int age = 22;\n'
            'char grade = \'A\';\n'
            'double gpa = 3.85;\n'
            '\n'
            'printf("Size of int: %lu bytes\\n", sizeof(age));\n'
            'printf("Grade: %c, GPA: %.2f\\n", grade, gpa);',
      ),
      AppLesson(
        title: 'Control Flow and Loops',
        body:
            'C's control flow will feel familiar if you have seen any '
            'C-derived language before — if/else, switch, for, while, and '
            'do-while all exist here in essentially their original form, '
            'since most modern languages borrowed this syntax directly from '
            'C.\n\n'
            'One quirk worth remembering: C does not have a true boolean '
            'type in older standards — zero is treated as false, and any '
            'nonzero value is treated as true. Modern C (C99 and later) adds '
            'a bool type via stdbool.h, which is worth using for clarity.',
        codeSnippet:
            '#include <stdbool.h>\n'
            '\n'
            'int i = 0;\n'
            'bool isEven;\n'
            '\n'
            'while (i < 5) {\n'
            '    isEven = (i % 2 == 0);\n'
            '    printf("%d is even: %d\\n", i, isEven);\n'
            '    i++;\n'
            '}',
      ),
      AppLesson(
        title: 'Functions and the Stack',
        body:
            'Functions in C must have their return type and parameter types '
            'declared explicitly. When a function is called, its local '
            'variables are placed on the call stack, and that memory is '
            'automatically released the moment the function returns.\n\n'
            'Understanding this stack-based lifecycle matters enormously once '
            'you begin working with pointers — returning a pointer to a '
            'local variable is a classic beginner bug, because that memory '
            'becomes invalid the instant the function ends.',
        codeSnippet:
            'int square(int x) {\n'
            '    return x * x;\n'
            '}\n'
            '\n'
            'int main() {\n'
            '    int result = square(6);\n'
            '    printf("Result: %d\\n", result);\n'
            '    return 0;\n'
            '}',
      ),
      AppLesson(
        title: 'Pointers: The Heart of C',
        body:
            'A pointer is a variable that stores a memory address rather '
            'than a value directly. The & operator gets the address of a '
            'variable, and the * operator, when used on a pointer, '
            'dereferences it to access the value stored at that address.\n\n'
            'Pointers are intimidating at first but incredibly powerful — '
            'they let you pass large data structures to functions '
            'efficiently, build dynamic data structures, and directly '
            'manipulate memory. Nearly every advanced C concept builds on a '
            'solid understanding of pointers.',
        codeSnippet:
            'int age = 22;\n'
            'int *ptr = &age;\n'
            '\n'
            'printf("Value: %d\\n", *ptr);\n'
            'printf("Address: %p\\n", ptr);\n'
            '\n'
            '*ptr = 23; // modifies age through the pointer\n'
            'printf("New age: %d\\n", age);',
      ),
      AppLesson(
        title: 'Arrays and Strings',
        body:
            'An array in C is a fixed-size block of contiguous memory '
            'holding elements of the same type. Crucially, C strings are not '
            'a distinct type — they are simply arrays of characters '
            'terminated by a special null character, \\0, which marks where '
            'the string ends.\n\n'
            'This is why C string handling can be error-prone: forgetting '
            'the null terminator, or writing past the end of an array, leads '
            'to undefined behavior. The string.h library provides functions '
            'like strlen, strcpy, and strcat to work with strings more '
            'safely.',
        codeSnippet:
            '#include <string.h>\n'
            '\n'
            'char name[20] = "Hustler";\n'
            'printf("Length: %lu\\n", strlen(name));\n'
            '\n'
            'strcat(name, "!");\n'
            'printf("Now: %s\\n", name);',
      ),
      AppLesson(
        title: 'Dynamic Memory with malloc and free',
        body:
            'Arrays declared normally have a fixed size known at compile '
            'time. When you need memory whose size is only known while the '
            'program is running, you use malloc to request a block of heap '
            'memory, and free to release it once you are finished.\n\n'
            'Every malloc call should have a matching free call. Forgetting '
            'to free memory causes a memory leak, while freeing memory twice '
            'or using it after freeing causes serious, hard-to-debug crashes. '
            'Discipline here is essential.',
        codeSnippet:
            'int *numbers = (int *) malloc(5 * sizeof(int));\n'
            '\n'
            'for (int i = 0; i < 5; i++) {\n'
            '    numbers[i] = i * i;\n'
            '    printf("%d\\n", numbers[i]);\n'
            '}\n'
            '\n'
            'free(numbers);',
      ),
      AppLesson(
        title: 'Structs: Grouping Related Data',
        body:
            'A struct lets you group several related variables of '
            'potentially different types under one name, similar to a '
            'lightweight object without any methods attached. This is how C '
            'represents structured data like a point in space, or a student '
            'record with a name and a set of grades.\n\n'
            'Structs become especially powerful once combined with pointers, '
            'letting you build linked data structures like linked lists and '
            'trees — a topic covered in the Data Structures & Algorithms '
            'course.',
        codeSnippet:
            'struct Student {\n'
            '    char name[30];\n'
            '    int age;\n'
            '    float gpa;\n'
            '};\n'
            '\n'
            'struct Student s1 = {"Amaka", 21, 3.9};\n'
            'printf("%s is %d with GPA %.1f\\n", s1.name, s1.age, s1.gpa);',
      ),
      AppLesson(
        title: 'Mini Project: Simple Grade Calculator',
        body:
            'We will build a small command-line program that reads a fixed '
            'number of scores into an array, calculates the average using a '
            'loop, and prints a letter grade based on that average — pulling '
            'together arrays, loops, and conditionals into one working '
            'program.\n\n'
            'Once complete, try modifying it to read the number of scores '
            'dynamically from the user and allocate the array with malloc '
            'instead of a fixed size.',
        codeSnippet:
            'int scores[5] = {78, 85, 92, 67, 88};\n'
            'int sum = 0;\n'
            '\n'
            'for (int i = 0; i < 5; i++) {\n'
            '    sum += scores[i];\n'
            '}\n'
            '\n'
            'float avg = sum / 5.0;\n'
            'printf("Average: %.2f\\n", avg);\n'
            'printf("Grade: %c\\n", avg >= 70 ? \'A\' : \'B\');',
      ),
    ],
  ),

  // ============================================================
  // COURSE 4: JAVASCRIPT FUNDAMENTALS
  // ============================================================
  AppCourse(
    id: 'prog_js_101',
    title: 'JavaScript Fundamentals',
    description:
        'JavaScript is the language of the web — and increasingly, of '
        'servers, mobile apps, and desktop apps too. This course builds a '
        'rock-solid foundation in modern JavaScript (ES6+) syntax and '
        'concepts.',
    instructor: 'Blessing Okonkwo',
    category: 'Programming',
    difficulty: 'Beginner',
    icon: Icons.javascript,
    color: Colors.amber,
    duration: '6h 20m',
    lessons: [
      AppLesson(
        title: 'JavaScript in the Browser and Beyond',
        body:
            'JavaScript began as a language for adding interactivity to '
            'websites, but it has since grown into one of the most versatile '
            'languages in existence — running on servers through Node.js, '
            'inside mobile apps through frameworks like React Native, and '
            'even on microcontrollers.\n\n'
            'Unlike many languages on this list, JavaScript runs directly in '
            'your browser, so you can open your browser's developer console '
            'right now and start experimenting without installing anything '
            'at all.',
        hasImage: true,
        codeSnippet:
            'console.log("Hello, Hustle Academy!");\n'
            '\n'
            '// Run this in your browser console (F12),\n'
            '// or save it in a .js file and run with Node.',
      ),
      AppLesson(
        title: 'Variables: let, const, and var',
        body:
            'Modern JavaScript uses let for variables that may change, and '
            'const for variables that should never be reassigned once set. '
            'The older var keyword still works but has confusing scoping '
            'rules, so modern code avoids it almost entirely.\n\n'
            'JavaScript is dynamically typed, meaning a variable's type is '
            'determined by its current value and can change over its '
            'lifetime. This flexibility is powerful, but it also means '
            'unexpected type conversions are a common source of bugs — '
            'something you will want to watch closely.',
        codeSnippet:
            'let age = 22;\n'
            'const name = "Hustler";\n'
            '\n'
            'age = 23; // fine, let allows reassignment\n'
            '// name = "New"; // error! const cannot be reassigned\n'
            '\n'
            'console.log(`${name} is ${age} years old`);',
      ),
      AppLesson(
        title: 'Data Types and Type Coercion',
        body:
            'JavaScript's primitive types include number, string, boolean, '
            'undefined, and null, along with object and array as reference '
            'types. Because JavaScript is loosely typed, it will often try '
            'to convert values automatically when combining different types '
            '— this is called type coercion.\n\n'
            'This is exactly why JavaScript strongly recommends using the '
            'strict equality operator === instead of ==, since == performs '
            'coercion before comparing, which frequently leads to confusing, '
            'unexpected results.',
        codeSnippet:
            'console.log("5" + 3);     // "53" (coercion to string)\n'
            'console.log("5" - 3);     // 2 (coercion to number)\n'
            'console.log(5 == "5");    // true (loose equality)\n'
            'console.log(5 === "5");   // false (strict equality)',
      ),
      AppLesson(
        title: 'Functions and Arrow Functions',
        body:
            'JavaScript functions can be declared in several ways: named '
            'function declarations, anonymous function expressions, and the '
            'more modern arrow function syntax introduced in ES6. Arrow '
            'functions are more compact and, importantly, handle the this '
            'keyword differently than regular functions.\n\n'
            'Functions in JavaScript are "first-class citizens" — they can be '
            'stored in variables, passed as arguments to other functions, '
            'and returned from other functions. This capability underlies '
            'many of JavaScript's most powerful patterns.',
        codeSnippet:
            'function add(a, b) {\n'
            '    return a + b;\n'
            '}\n'
            '\n'
            'const multiply = (a, b) => a * b;\n'
            '\n'
            'console.log(add(2, 3));\n'
            'console.log(multiply(2, 3));',
      ),
      AppLesson(
        title: 'Arrays and Array Methods',
        body:
            'Arrays in JavaScript come with a rich set of built-in methods '
            'that let you transform data without writing manual loops. '
            'map() transforms each element into something new, filter() '
            'keeps only elements matching a condition, and reduce() combines '
            'all elements into a single value.\n\n'
            'These methods are foundational to writing clean, modern '
            'JavaScript, and they show up constantly in real-world code — '
            'especially when working with data returned from an API.',
        codeSnippet:
            'const scores = [70, 85, 92, 55, 88];\n'
            '\n'
            'const passed = scores.filter(s => s >= 60);\n'
            'const doubled = scores.map(s => s * 2);\n'
            'const total = scores.reduce((sum, s) => sum + s, 0);\n'
            '\n'
            'console.log(passed, doubled, total);',
      ),
      AppLesson(
        title: 'Objects and Destructuring',
        body:
            'An object in JavaScript stores data as key-value pairs, similar '
            'to a dictionary in Python. Objects are used everywhere — to '
            'represent a user, a product, or configuration settings passed '
            'into a function.\n\n'
            'Destructuring lets you unpack values from an object or array '
            'directly into variables in a single line, which dramatically '
            'reduces boilerplate when working with objects that have many '
            'properties.',
        codeSnippet:
            'const student = {\n'
            '    name: "Chidi",\n'
            '    age: 21,\n'
            '    skills: ["JS", "HTML", "CSS"]\n'
            '};\n'
            '\n'
            'const { name, age } = student;\n'
            'console.log(`${name} is ${age}`);',
      ),
      AppLesson(
        title: 'Asynchronous JavaScript: Promises and Async/Await',
        body:
            'JavaScript is single-threaded, but it handles long-running '
            'operations like network requests without freezing the whole '
            'program by using an event loop and asynchronous patterns. A '
            'Promise represents a value that may not be available yet, but '
            'will resolve (succeed) or reject (fail) at some point.\n\n'
            'The async/await syntax, built on top of Promises, lets you '
            'write asynchronous code that reads almost like synchronous '
            'code, which is far easier to follow than chains of .then() '
            'calls.',
        codeSnippet:
            'async function fetchUser() {\n'
            '    try {\n'
            '        const response = await fetch("https://api.example.com/user");\n'
            '        const data = await response.json();\n'
            '        console.log(data);\n'
            '    } catch (error) {\n'
            '        console.log("Something went wrong:", error);\n'
            '    }\n'
            '}',
      ),
      AppLesson(
        title: 'The DOM: Manipulating Web Pages',
        body:
            'The Document Object Model (DOM) is a tree-like representation '
            'of everything on a web page, and JavaScript can read and modify '
            'it in real time. This is how buttons respond to clicks, forms '
            'validate input, and content updates without reloading the page.\n\n'
            'Methods like document.querySelector() find elements on the '
            'page, and properties like .textContent or .innerHTML let you '
            'change what they display. Event listeners let your code react '
            'the moment a user interacts with something.',
        codeSnippet:
            'const button = document.querySelector("#myButton");\n'
            '\n'
            'button.addEventListener("click", () => {\n'
            '    document.querySelector("#message").textContent = \n'
            '        "You clicked the button!";\n'
            '});',
      ),
      AppLesson(
        title: 'Mini Project: Interactive Counter',
        body:
            'We will build a small interactive counter with increment, '
            'decrement, and reset buttons, tying together DOM manipulation, '
            'event listeners, and state stored in a plain variable — a '
            'classic first JavaScript project that every developer builds at '
            'some point.\n\n'
            'Afterward, try extending it: disable the decrement button when '
            'the count reaches zero, or add a step size the user can '
            'configure.',
        codeSnippet:
            'let count = 0;\n'
            'const display = document.querySelector("#count");\n'
            '\n'
            'document.querySelector("#increment").addEventListener("click", () => {\n'
            '    count++;\n'
            '    display.textContent = count;\n'
            '});\n'
            '\n'
            'document.querySelector("#reset").addEventListener("click", () => {\n'
            '    count = 0;\n'
            '    display.textContent = count;\n'
            '});',
      ),
    ],
  ),

  // ============================================================
  // COURSE 5: DART PROGRAMMING FOR FLUTTER
  // ============================================================
  AppCourse(
    id: 'prog_dart_101',
    title: 'Dart Programming for Flutter',
    description:
        'Dart is the language behind Flutter, the toolkit powering this '
        'very app. This course teaches Dart syntax and concepts from the '
        'ground up — essential preparation before diving into Flutter app '
        'development.',
    instructor: 'Chidi Okafor',
    category: 'Programming',
    difficulty: 'Beginner',
    icon: Icons.flutter_dash,
    color: Colors.lightBlue,
    duration: '5h 00m',
    lessons: [
      AppLesson(
        title: 'What Makes Dart Special',
        body:
            'Dart was created by Google and is optimized for building fast, '
            'beautiful user interfaces across mobile, web, and desktop. It '
            'compiles to native machine code for mobile apps, which is why '
            'Flutter apps feel so responsive compared to many cross-platform '
            'alternatives.\n\n'
            'Dart is a statically typed language, but it supports type '
            'inference, meaning you often don't need to write the type '
            'explicitly — the compiler can figure it out from the value you '
            'assign, similar to using var while still getting full type '
            'safety.',
        hasImage: true,
        codeSnippet:
            'void main() {\n'
            '  print("Hello, Hustle Academy!");\n'
            '}',
      ),
      AppLesson(
        title: 'Variables and Null Safety',
        body:
            'Dart variables can be declared with var (type inferred), or an '
            'explicit type like String or int. One of Dart's most important '
            'features is sound null safety: by default, a variable cannot '
            'be null unless you explicitly mark its type as nullable using a '
            'question mark.\n\n'
            'This eliminates an entire category of runtime crashes that '
            'plague many other languages, because the compiler forces you to '
            'handle the possibility of a missing value before your code can '
            'even run.',
        codeSnippet:
            'String name = "Hustler";      // cannot be null\n'
            'String? nickname;              // can be null\n'
            '\n'
            'nickname ??= "Anonymous";      // assign only if null\n'
            'print(nickname);',
      ),
      AppLesson(
        title: 'Collections: List, Map, and Set',
        body:
            'Dart's core collection types mirror what you have likely seen '
            'in other languages: List for ordered collections, Map for '
            'key-value pairs, and Set for unique unordered values. Dart also '
            'supports collection literals with type inference, making them '
            'quick to create.\n\n'
            'Spread operators (...) and collection-if / collection-for let '
            'you build up lists conditionally or from loops directly inside '
            'a literal, which you will see constantly when building Flutter '
            'widget trees.',
        codeSnippet:
            'List<String> skills = ["Dart", "Flutter"];\n'
            'Map<String, int> scores = {"Amaka": 95, "Tunde": 88};\n'
            'Set<String> tags = {"beginner", "mobile"};\n'
            '\n'
            'List<String> allSkills = [...skills, "Firebase"];\n'
            'print(allSkills);',
      ),
      AppLesson(
        title: 'Functions and Arrow Syntax',
        body:
            'Dart functions can be written the traditional way with a full '
            'body, or using arrow syntax for a single expression, which you '
            'will see used constantly inside Flutter's build methods and '
            'callbacks.\n\n'
            'Dart also supports named parameters, marked with curly braces, '
            'which is one reason Flutter widget constructors read so '
            'clearly — you can see exactly what each argument represents '
            'just from the parameter name at the call site.',
        codeSnippet:
            'int add(int a, int b) => a + b;\n'
            '\n'
            'String greet({required String name, String greeting = "Hi"}) {\n'
            '  return "$greeting, $name!";\n'
            '}\n'
            '\n'
            'print(add(2, 3));\n'
            'print(greet(name: "Chidi"));',
      ),
      AppLesson(
        title: 'Classes and Constructors',
        body:
            'Dart classes support several constructor styles, including a '
            'concise shorthand where constructor parameters are assigned '
            'directly to fields using this.fieldName syntax, avoiding the '
            'need to manually write assignment statements in the body.\n\n'
            'Dart also supports named constructors, letting a class offer '
            'multiple distinct ways to create an instance — for example, a '
            'default constructor alongside a Course.fromJson constructor '
            'that builds an object from parsed data.',
        codeSnippet:
            'class Course {\n'
            '  final String title;\n'
            '  final int lessons;\n'
            '\n'
            '  Course(this.title, this.lessons);\n'
            '\n'
            '  Course.empty() : title = "Untitled", lessons = 0;\n'
            '}\n'
            '\n'
            'var c = Course("Dart Basics", 10);\n'
            'print(c.title);',
      ),
      AppLesson(
        title: 'Inheritance, Mixins, and Interfaces',
        body:
            'Dart supports single inheritance using extends, similar to '
            'Java, but adds a distinctive feature called mixins using the '
            'with keyword — letting you reuse a chunk of behavior across '
            'multiple unrelated classes without forcing them into a single '
            'inheritance hierarchy.\n\n'
            'Dart doesn't have a separate interface keyword; instead, any '
            'class can serve as an interface simply by using the implements '
            'keyword, which requires the implementing class to provide '
            'concrete versions of all its methods.',
        codeSnippet:
            'mixin Timestamped {\n'
            '  DateTime get createdAt => DateTime.now();\n'
            '}\n'
            '\n'
            'class Post with Timestamped {\n'
            '  String title;\n'
            '  Post(this.title);\n'
            '}\n'
            '\n'
            'var p = Post("Hello Dart");\n'
            'print(p.createdAt);',
      ),
      AppLesson(
        title: 'Futures and async/await',
        body:
            'A Future in Dart represents a value that will be available at '
            'some point in the future — the result of a network call, a '
            'file read, or a delay. Flutter apps rely heavily on Futures for '
            'anything that takes time, since the UI must never be blocked '
            'while waiting.\n\n'
            'The async/await syntax lets you write this asynchronous logic '
            'in a straightforward, top-to-bottom style, rather than nesting '
            'callback functions inside each other.',
        codeSnippet:
            'Future<String> fetchGreeting() async {\n'
            '  await Future.delayed(const Duration(seconds: 1));\n'
            '  return "Hello after 1 second!";\n'
            '}\n'
            '\n'
            'void main() async {\n'
            '  print("Loading...");\n'
            '  String result = await fetchGreeting();\n'
            '  print(result);\n'
            '}',
      ),
      AppLesson(
        title: 'Mini Project: Course Catalog Model',
        body:
            'We will model a small course catalog using classes, lists, and '
            'named constructors — very close to how the data structures '
            'inside this very app are organized. This is a great bridge '
            'exercise before moving into full Flutter development.\n\n'
            'Try extending it by adding a method that filters courses by '
            'difficulty, or one that calculates the total number of lessons '
            'across the whole catalog.',
        codeSnippet:
            'class Lesson {\n'
            '  final String title;\n'
            '  Lesson(this.title);\n'
            '}\n'
            '\n'
            'class CourseModel {\n'
            '  final String title;\n'
            '  final List<Lesson> lessons;\n'
            '\n'
            '  CourseModel(this.title, this.lessons);\n'
            '\n'
            '  int get lessonCount => lessons.length;\n'
            '}\n'
            '\n'
            'var course = CourseModel("Dart Basics", [\n'
            '  Lesson("Intro"),\n'
            '  Lesson("Variables"),\n'
            ']);\n'
            'print(course.lessonCount);',
      ),
    ],
  ),

  // ============================================================
  // COURSE 6: DATA STRUCTURES & ALGORITHMS
  // ============================================================
  AppCourse(
    id: 'prog_dsa_101',
    title: 'Data Structures & Algorithms Essentials',
    description:
        'The concepts every serious programmer eventually needs — how to '
        'organize data efficiently and reason clearly about how fast your '
        'code runs. Language-agnostic explanations with pseudocode-style '
        'examples.',
    instructor: 'Tunde Bakare',
    category: 'Programming',
    difficulty: 'Intermediate',
    icon: Icons.account_tree,
    color: Colors.deepPurple,
    duration: '8h 15m',
    lessons: [
      AppLesson(
        title: 'Why Data Structures and Algorithms Matter',
        body:
            'Two programs can solve the exact same problem and produce '
            'identical output, yet one might run in milliseconds while the '
            'other takes minutes on the same input. That difference almost '
            'always comes down to the choice of data structure and '
            'algorithm, not the programming language used.\n\n'
            'As your programs work with more data — thousands or millions '
            'of records instead of a handful — inefficient choices that '
            'seemed harmless in small tests start to matter enormously. This '
            'course builds the intuition to spot those choices before they '
            'become a problem.',
        hasImage: true,
      ),
      AppLesson(
        title: 'Big O Notation: Measuring Efficiency',
        body:
            'Big O notation describes how an algorithm's running time or '
            'memory usage grows as the input size grows, ignoring '
            'machine-specific constants. O(1) means constant time '
            'regardless of input size, O(n) means time grows linearly with '
            'input size, and O(n²) means time grows with the square of the '
            'input size — often from nested loops over the same data.\n\n'
            'You don't need to calculate exact Big O values by hand for '
            'every piece of code you write, but developing an instinct for '
            'roughly how a piece of code scales is one of the highest-value '
            'skills in programming.',
        codeSnippet:
            '// O(1): constant time\n'
            'first = list[0]\n'
            '\n'
            '// O(n): linear time\n'
            'for item in list: print(item)\n'
            '\n'
            '// O(n^2): quadratic time\n'
            'for item in list:\n'
            '    for other in list: compare(item, other)',
      ),
      AppLesson(
        title: 'Arrays and Linked Lists',
        body:
            'An array stores elements in contiguous memory, giving you '
            'constant-time access to any element by index, but insertion or '
            'deletion in the middle requires shifting every following '
            'element. A linked list stores elements as separate nodes '
            'connected by pointers, making insertion and deletion at any '
            'point fast, at the cost of losing constant-time random access.\n\n'
            'Choosing between them comes down to your access pattern: if you '
            'mostly read by index, arrays win; if you mostly insert and '
            'remove from arbitrary positions, linked lists often win.',
        codeSnippet:
            'class Node:\n'
            '    def __init__(self, value):\n'
            '        self.value = value\n'
            '        self.next = None\n'
            '\n'
            'head = Node(1)\n'
            'head.next = Node(2)\n'
            'head.next.next = Node(3)',
      ),
      AppLesson(
        title: 'Stacks and Queues',
        body:
            'A stack follows Last-In-First-Out (LIFO) order — think of a '
            'stack of plates, where you can only add or remove from the '
            'top. It powers things like the "undo" feature in editors and '
            'the call stack that tracks function calls in every program you '
            'run.\n\n'
            'A queue follows First-In-First-Out (FIFO) order — like a line '
            'at a checkout counter. Queues are essential for handling tasks '
            'in the order they arrive, such as processing print jobs or '
            'messages in a chat application.',
        codeSnippet:
            'stack = []\n'
            'stack.append(1)\n'
            'stack.append(2)\n'
            'print(stack.pop())  # 2 (last in, first out)\n'
            '\n'
            'from collections import deque\n'
            'queue = deque()\n'
            'queue.append(1)\n'
            'queue.append(2)\n'
            'print(queue.popleft())  # 1 (first in, first out)',
      ),
      AppLesson(
        title: 'Hash Tables',
        body:
            'A hash table (the underlying structure behind dictionaries and '
            'maps) uses a hash function to convert a key into an index into '
            'an internal array, allowing average constant-time lookups, '
            'insertions, and deletions — dramatically faster than searching '
            'through a list one item at a time.\n\n'
            'Hash collisions — two different keys mapping to the same index '
            '— are handled internally by the data structure, but a poor '
            'hash function can degrade performance significantly, which is '
            'why choosing good, well-distributed keys matters in practice.',
        codeSnippet:
            'user_ages = {}\n'
            'user_ages["amaka"] = 21\n'
            'user_ages["tunde"] = 24\n'
            '\n'
            'print(user_ages["amaka"])  # O(1) average lookup',
      ),
      AppLesson(
        title: 'Trees and Binary Search Trees',
        body:
            'A tree is a hierarchical structure where each node can have '
            'child nodes, starting from a single root. A binary search tree '
            '(BST) is a special kind of tree where each node's left subtree '
            'contains only smaller values, and its right subtree contains '
            'only larger values — enabling fast searching, similar to how a '
            'binary search works on a sorted array.\n\n'
            'Trees show up everywhere: file systems, HTML/DOM structures, '
            'and database indexes are all fundamentally tree-shaped. '
            'Understanding traversal order (in-order, pre-order, post-order) '
            'is key to working with them correctly.',
        codeSnippet:
            'class TreeNode:\n'
            '    def __init__(self, value):\n'
            '        self.value = value\n'
            '        self.left = None\n'
            '        self.right = None\n'
            '\n'
            'def insert(root, value):\n'
            '    if root is None:\n'
            '        return TreeNode(value)\n'
            '    if value < root.value:\n'
            '        root.left = insert(root.left, value)\n'
            '    else:\n'
            '        root.right = insert(root.right, value)\n'
            '    return root',
      ),
      AppLesson(
        title: 'Sorting Algorithms',
        body:
            'Sorting is one of the most studied problems in computer '
            'science. Simple algorithms like bubble sort and insertion sort '
            'are easy to understand but run in O(n²) time, making them '
            'impractical for large datasets. More efficient algorithms like '
            'merge sort and quicksort achieve O(n log n) time by dividing '
            'the problem into smaller pieces.\n\n'
            'In practice, you will almost always use your language's '
            'built-in sort function rather than implementing your own — but '
            'understanding how these algorithms work builds intuition for '
            'algorithmic thinking that transfers to countless other '
            'problems.',
        codeSnippet:
            'def merge_sort(arr):\n'
            '    if len(arr) <= 1:\n'
            '        return arr\n'
            '    mid = len(arr) // 2\n'
            '    left = merge_sort(arr[:mid])\n'
            '    right = merge_sort(arr[mid:])\n'
            '    return merge(left, right)\n'
            '\n'
            'def merge(left, right):\n'
            '    result = []\n'
            '    i = j = 0\n'
            '    while i < len(left) and j < len(right):\n'
            '        if left[i] <= right[j]:\n'
            '            result.append(left[i]); i += 1\n'
            '        else:\n'
            '            result.append(right[j]); j += 1\n'
            '    return result + left[i:] + right[j:]',
      ),
      AppLesson(
        title: 'Searching Algorithms',
        body:
            'Linear search checks every element one by one until it finds a '
            'match, running in O(n) time — simple, but slow for large '
            'datasets. Binary search, on the other hand, works only on '
            'sorted data, and repeatedly cuts the search space in half, '
            'achieving O(log n) time — dramatically faster as data grows '
            'larger.\n\n'
            'This is a perfect illustration of why data structure choice '
            'matters: the exact same search problem can be solved in '
            'radically different amounts of time depending purely on '
            'whether your data is sorted.',
        codeSnippet:
            'def binary_search(arr, target):\n'
            '    low, high = 0, len(arr) - 1\n'
            '    while low <= high:\n'
            '        mid = (low + high) // 2\n'
            '        if arr[mid] == target:\n'
            '            return mid\n'
            '        elif arr[mid] < target:\n'
            '            low = mid + 1\n'
            '        else:\n'
            '            high = mid - 1\n'
            '    return -1',
      ),
      AppLesson(
        title: 'Recursion',
        body:
            'Recursion is when a function calls itself to solve a smaller '
            'version of the same problem, until it reaches a base case '
            'simple enough to answer directly. Many problems involving '
            'trees, nested structures, or divide-and-conquer strategies are '
            'far more naturally expressed recursively than iteratively.\n\n'
            'Every recursive function needs a clear base case to avoid '
            'infinite recursion, which would eventually crash your program '
            'with a stack overflow. Tracing through a recursive call by '
            'hand, step by step, is the best way to build confidence with '
            'it.',
        codeSnippet:
            'def factorial(n):\n'
            '    if n <= 1:  # base case\n'
            '        return 1\n'
            '    return n * factorial(n - 1)  # recursive case\n'
            '\n'
            'print(factorial(5))  # 120',
      ),
      AppLesson(
        title: 'Mini Project: Word Frequency Counter',
        body:
            'We will combine hash tables and sorting to build a word '
            'frequency counter that reads a block of text, counts how many '
            'times each word appears using a dictionary, and prints the top '
            'results sorted by frequency — a common real-world use of the '
            'data structures covered in this course.\n\n'
            'Try extending it to ignore punctuation and capitalization '
            'differences, or to exclude common filler words like "the" and '
            '"and".',
        codeSnippet:
            'text = "the quick fox the lazy fox the dog"\n'
            'words = text.split()\n'
            '\n'
            'counts = {}\n'
            'for word in words:\n'
            '    counts[word] = counts.get(word, 0) + 1\n'
            '\n'
            'sorted_counts = sorted(counts.items(), key=lambda x: -x[1])\n'
            'for word, count in sorted_counts:\n'
            '    print(f"{word}: {count}")',
      ),
    ],
  ),

  // ============================================================
  // COURSE 7: OBJECT-ORIENTED PROGRAMMING PRINCIPLES
  // ============================================================
  AppCourse(
    id: 'prog_oop_101',
    title: 'Object-Oriented Programming Principles',
    description:
        'A language-agnostic deep dive into the four pillars of OOP — '
        'encapsulation, inheritance, polymorphism, and abstraction — plus '
        'the design principles that separate clean code from messy code.',
    instructor: 'Emeka Obi',
    category: 'Programming',
    difficulty: 'Intermediate',
    icon: Icons.hub,
    color: Colors.deepOrange,
    duration: '4h 45m',
    lessons: [
      AppLesson(
        title: 'The Four Pillars of OOP',
        body:
            'Object-oriented programming is built around four core ideas: '
            'encapsulation (bundling data with the methods that operate on '
            'it, and hiding internal details), abstraction (exposing only '
            'what's necessary while hiding complexity), inheritance '
            '(reusing and extending behavior from existing classes), and '
            'polymorphism (treating different types uniformly through a '
            'shared interface).\n\n'
            'These four ideas apply across nearly every OOP language — Java, '
            'Python, Dart, C++ — even though the exact syntax differs. Once '
            'you understand the concepts deeply, switching languages becomes '
            'largely a matter of learning new syntax, not new thinking.',
        hasImage: true,
      ),
      AppLesson(
        title: 'Encapsulation in Practice',
        body:
            'Encapsulation means keeping an object's internal state private, '
            'and only allowing controlled access through public methods. '
            'This protects your data from being put into an invalid state '
            'by outside code, and lets you change your internal '
            'implementation later without breaking anything that depends on '
            'your public interface.\n\n'
            'A classic example is a BankAccount class exposing deposit() '
            'and withdraw() methods rather than a public balance field — '
            'this way, you can enforce rules like "balance cannot go '
            'negative" in one central place.',
        codeSnippet:
            'class BankAccount {\n'
            '  double _balance = 0;\n'
            '\n'
            '  void deposit(double amount) {\n'
            '    if (amount > 0) _balance += amount;\n'
            '  }\n'
            '\n'
            '  bool withdraw(double amount) {\n'
            '    if (amount <= _balance) {\n'
            '      _balance -= amount;\n'
            '      return true;\n'
            '    }\n'
            '    return false;\n'
            '  }\n'
            '\n'
            '  double get balance => _balance;\n'
            '}',
      ),
      AppLesson(
        title: 'Inheritance: Sharing Behavior',
        body:
            'Inheritance lets a subclass reuse fields and methods from a '
            'parent class, avoiding duplicated logic across related types. '
            'For example, a base Employee class might define common fields '
            'like name and salary, while Manager and Developer subclasses '
            'add their own specialized behavior on top.\n\n'
            'A common mistake is overusing inheritance to model '
            'relationships that aren't truly "is-a" relationships. If a '
            'relationship is better described as "has-a" — a Car has an '
            'Engine, rather than a Car is an Engine — composition is usually '
            'the better tool.',
        codeSnippet:
            'class Employee {\n'
            '  String name;\n'
            '  double baseSalary;\n'
            '  Employee(this.name, this.baseSalary);\n'
            '\n'
            '  double calculatePay() => baseSalary;\n'
            '}\n'
            '\n'
            'class Manager extends Employee {\n'
            '  double bonus;\n'
            '  Manager(String name, double baseSalary, this.bonus)\n'
            '      : super(name, baseSalary);\n'
            '\n'
            '  @override\n'
            '  double calculatePay() => baseSalary + bonus;\n'
            '}',
      ),
      AppLesson(
        title: 'Polymorphism: One Interface, Many Behaviors',
        body:
            'Polymorphism lets you write code that works with a general '
            'type, while each specific subtype provides its own version of '
            'that behavior. This is what allows you to store a list of '
            'different Employee subtypes together and call '
            'calculatePay() on each one, without needing to know at compile '
            'time which specific subtype each one is.\n\n'
            'This is one of the most practically useful ideas in OOP — it '
            'lets you add entirely new subtypes later without touching any '
            'of the code that already works with the general Employee type.',
        codeSnippet:
            'List<Employee> team = [\n'
            '  Employee("Amaka", 3000),\n'
            '  Manager("Tunde", 4000, 1000),\n'
            '];\n'
            '\n'
            'for (var e in team) {\n'
            '  print("${e.name}: ${e.calculatePay()}");\n'
            '}',
      ),
      AppLesson(
        title: 'Abstraction: Hiding Complexity',
        body:
            'Abstraction means exposing only the essential details someone '
            'needs to use something, while hiding the complicated '
            'implementation behind it. When you call a sort() method, you '
            'don't need to know which sorting algorithm runs internally — '
            'the interface hides that complexity from you entirely.\n\n'
            'Abstract classes and interfaces are the primary tools for '
            'enforcing abstraction in OOP languages: they let you define '
            'what a class must be able to do, without dictating exactly how '
            'it does it.',
        codeSnippet:
            'abstract class Shape {\n'
            '  double area(); // no implementation here\n'
            '}\n'
            '\n'
            'class Circle extends Shape {\n'
            '  double radius;\n'
            '  Circle(this.radius);\n'
            '\n'
            '  @override\n'
            '  double area() => 3.14159 * radius * radius;\n'
            '}',
      ),
      AppLesson(
        title: 'Composition Over Inheritance',
        body:
            'While inheritance is powerful, overusing it tends to create '
            'deep, fragile class hierarchies that are hard to change safely. '
            'Composition — building complex objects out of smaller, simpler '
            'objects held as fields — is often more flexible, because you '
            'can swap out a component without restructuring an entire class '
            'hierarchy.\n\n'
            'A common design guideline is to favor composition by default, '
            'and reach for inheritance only when there is a genuine, stable '
            '"is-a" relationship that is unlikely to need restructuring '
            'later.',
        codeSnippet:
            'class Engine {\n'
            '  void start() => print("Engine starting");\n'
            '}\n'
            '\n'
            'class Car {\n'
            '  final Engine engine; // composition: Car "has-a" Engine\n'
            '  Car(this.engine);\n'
            '\n'
            '  void drive() {\n'
            '    engine.start();\n'
            '    print("Car is driving");\n'
            '  }\n'
            '}',
      ),
      AppLesson(
        title: 'SOLID Principles Overview',
        body:
            'SOLID is a set of five design guidelines widely used in '
            'object-oriented software: Single Responsibility (a class '
            'should have one clear purpose), Open/Closed (code should be '
            'extendable without modifying existing working code), Liskov '
            'Substitution (subtypes should be usable anywhere their parent '
            'type is expected), Interface Segregation (prefer small, '
            'focused interfaces over large general ones), and Dependency '
            'Inversion (depend on abstractions, not concrete '
            'implementations).\n\n'
            'You don't need to apply all five perfectly on every project, '
            'but keeping them in mind as you design classes tends to produce '
            'noticeably more maintainable code over time.',
      ),
      AppLesson(
        title: 'Mini Project: Simple Shape Calculator',
        body:
            'We will design a small shape hierarchy using abstraction and '
            'polymorphism: an abstract Shape class, with Circle, Rectangle, '
            'and Triangle subclasses each implementing their own area() '
            'method, and a function that calculates the total area of a '
            'mixed list of shapes.\n\n'
            'This project directly demonstrates why polymorphism is useful '
            '— the total-area function never needs to know which specific '
            'shape types it is dealing with.',
        codeSnippet:
            'abstract class Shape {\n'
            '  double area();\n'
            '}\n'
            '\n'
            'class Rectangle extends Shape {\n'
            '  double w, h;\n'
            '  Rectangle(this.w, this.h);\n'
            '  @override\n'
            '  double area() => w * h;\n'
            '}\n'
            '\n'
            'double totalArea(List<Shape> shapes) {\n'
            '  return shapes.fold(0, (sum, s) => sum + s.area());\n'
            '}',
      ),
    ],
  ),
];
