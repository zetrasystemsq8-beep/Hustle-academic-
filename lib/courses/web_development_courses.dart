// GENERATED FILE — Hustle Academy Original Curriculum
// Course 1 of 12: Web Development Fundamentals
// Written in simple language for students learning outside the classroom.
// Pure knowledge only — no projects, no labs, no coding challenges.
// (Practical work lives in the Web Lab / Innovation Engine.)

import 'package:flutter/material.dart';
import '../models/app_course.dart';

final List<AppCourse> webDevelopmentCourses = [
  AppCourse(
    id: 'web-fundamentals',
    title: '''Web Development Fundamentals''',
    description: '''Start your journey the right way. Learn what web development really is, how the internet and the web work behind the scenes, the tools developers use every day, and the modern world you are stepping into — explained in plain, simple language by Hustle Academy.''',
    instructor: '''Connect Baba''',
    duration: '25 min',
    difficulty: 'Beginner',
    category: '''Web Development''',
    icon: Icons.language,
    color: Colors.blue,
    lessons: [
      AppLesson(
        title: '''What is Web Development?''',
        body: '''Welcome to Hustle Academy. My name is Connect Baba, and I will be your teacher for this course. Before you touch any code, we need to answer one simple question: what is web development?

Web development is the work of building websites and web applications — the things you open using a browser like Chrome or Opera Mini. Every time you check your ZetraMail, scroll on Nigergram, or use NaijaLearn to study, you are using something a web developer built.

Think about it like building a house. Before a house exists, someone has to plan it, lay the foundation, put up the walls, add the roof, then paint and decorate it. Web development works the same way. Someone plans what the website will do, someone builds the structure, someone makes it look beautiful, and someone makes sure everything works properly.

A web developer is simply the person who does this building work — but instead of bricks and cement, they use code.

You do not need a fancy laptop, a big school, or rich parents to become a web developer. You only need three things: a device you can practice on, a hunger to learn, and consistency. Many of the biggest developers in the world today started exactly like you — curious, with no background in tech, just willing to learn one small thing at a time.

By the end of this course, you will understand the full picture of what web development is, so that everything else you learn after this — HTML, CSS, JavaScript — will make complete sense, because you will already understand why it matters.''',
        codeSnippet: '''''',
        hasImage: true,
      ),
      AppLesson(
        title: '''How the Web Works''',
        body: '''Let us pull back the curtain and see what actually happens when you visit a website.

Imagine you send a letter to your cousin in another city. You write the letter, put it in an envelope, write the address, and post it. The postman carries it, finds the correct house, and delivers it. Your cousin opens it, reads it, and maybe replies.

The web works in almost the same way, except everything happens in less than one second.

When you type a website address (like naijalearn.com) into your browser and press enter, here is what happens:

1. Your browser (this is like you writing the letter) sends a request asking, "Please, can I see this page?"
2. This request travels through the internet — a giant network of cables, towers, and satellites connecting the whole world.
3. It arrives at a server (this is like your cousin's house) — a powerful computer somewhere in the world that stores the website's files.
4. The server replies by sending back the files that make up the website.
5. Your browser receives those files and displays them beautifully on your screen — as text, images, buttons, and colors.

All of this happens in a blink. That is the basic story of the web: a request goes out, a response comes back, and your browser turns that response into the page you see.

Understanding this cycle — request and response — is one of the most important ideas in web development. Every website you will ever build follows this same pattern.''',
        codeSnippet: '''''',
        hasImage: true,
      ),
      AppLesson(
        title: '''Browsers, Servers & HTTP''',
        body: '''Now let us go a little deeper into three words you will hear again and again: browser, server, and HTTP.

A browser is the software you use to view websites. Chrome, Opera Mini, Firefox, and Safari are all browsers. The browser's job is to take the files it receives from a server and turn them into something you can see and use — pictures, buttons, text, colors, everything.

A server is a computer that stores website files and "serves" them to anyone who asks for them, day and night, without sleeping. A single server can serve millions of people at the same time. Companies like Zetra Company run and maintain servers so that websites and apps stay available every second of the day.

HTTP stands for HyperText Transfer Protocol. Do not let the big grammar scare you — it simply means "the agreed set of rules that browsers and servers use to talk to each other." Just like two people need to speak the same language to understand each other, browsers and servers need to follow the same rules (HTTP) to exchange information correctly.

You may also see HTTPS, which is the same thing but with an extra "S" for Secure. It means the conversation between your browser and the server is locked and protected, so nobody in between can spy on it. This is why you should always trust websites that show HTTPS, especially when entering personal information like passwords or account numbers.

So remember this simple chain: Browser asks → Server answers → HTTP is the language they both understand.''',
        codeSnippet: '''''',
        hasImage: false,
      ),
      AppLesson(
        title: '''Websites vs Web Applications''',
        body: '''People often use the words "website" and "web application" as if they mean the same thing, but there is a difference, and understanding it will help you think like a real developer.

A website is mostly about information. It exists mainly for you to read, look, and learn. Think of a school notice board — it tells you something, but you do not really interact with it deeply. A blog, a news page, or a company's "About Us" page are good examples of websites.

A web application (often called a "web app") is interactive. It lets you do something, not just read something. When you send a message, transfer money, post a photo, or chat with a friend, you are using a web application. Nigergram and ZetraMail are examples of web applications — you are not just reading, you are acting: typing, sending, uploading, replying.

Here is a simple way to remember it:
- Website = you read it.
- Web Application = you use it, like a tool.

In real life, many products are actually a mixture of both. A shopping website, for example, has pages that describe products (website behavior) and also lets you add items to a cart and pay (web application behavior).

As you grow in this course, you will find that the same building blocks — HTML, CSS, and JavaScript — are used to build both websites and web applications. The difference is not in the tools, but in what the final product allows people to do.''',
        codeSnippet: '''''',
        hasImage: false,
      ),
      AppLesson(
        title: '''Frontend, Backend & Full Stack''',
        body: '''If you have heard developers talk about "frontend" and "backend," here is exactly what those words mean, explained simply.

Imagine a restaurant. There is a dining area where customers sit, look at the menu, and enjoy their food — that is the part customers see and interact with directly. Then there is the kitchen, hidden from customers, where the cooking, planning, and organizing actually happens.

The frontend of a website is the dining area — everything the user sees and touches: the colors, the buttons, the layout, the text, the images. Frontend developers focus on making things look good and easy to use.

The backend is the kitchen — the hidden part that handles the real work: storing information, checking passwords, saving your messages, processing payments, and making decisions. Users never see the backend directly, but they depend on it completely.

A full stack developer is someone who can work comfortably in both the dining area and the kitchen — they understand frontend and backend, and can build a complete product from start to finish.

None of these roles is "better" than the other. Some developers love making things beautiful and choose frontend. Some developers love solving logic problems and choose backend. Some enjoy both and become full stack. As you continue this course, pay attention to which part excites you the most — that is a hint about where your strength may lie.''',
        codeSnippet: '''''',
        hasImage: true,
      ),
      AppLesson(
        title: '''Web Development Tools''',
        body: '''Every skilled worker has tools. A tailor has a needle and a measuring tape. A carpenter has a hammer and a saw. A web developer also has tools, and knowing them by name will help you feel at home as you continue learning.

Code Editor: This is the software where developers actually type their code. It is like a notebook, but smarter — it can highlight your code in colors, warn you about mistakes, and help you work faster. Popular ones include VS Code.

Browser Developer Tools: Every browser has a hidden set of tools built inside it that let developers inspect a webpage, see its structure, and find mistakes. It is like being able to look under the bonnet of a car to see how the engine works.

Version Control: This is a way of saving different versions of your work as you build, so that if you make a mistake, you can always go back to an earlier, working version — like having "save points" in a video game. Git is the most common tool used for this.

Terminal / Command Line: This is a way of giving instructions to your computer by typing text commands instead of clicking with a mouse. It looks intimidating at first, but developers use it daily and it quickly becomes normal.

Design & Planning Tools: Before code is even written, many developers sketch out how a website should look and behave, similar to how a tailor first measures and sketches a design before cutting cloth.

You do not need to master all these tools today. Just knowing they exist, and what they are for, prepares your mind for when you meet them properly later in your journey.''',
        codeSnippet: '''''',
        hasImage: false,
      ),
      AppLesson(
        title: '''Developer Workflow''',
        body: '''Workflow simply means "the normal order in which work gets done." Every skilled developer follows a workflow, whether they realize it or not, and understanding it now will save you a lot of confusion later.

A typical workflow looks like this:

1. Understand the problem. Before writing anything, a good developer first asks: what exactly needs to be built, and for who? Building without understanding is like cooking without knowing who you are cooking for.

2. Plan. This can be as simple as thinking through the steps, or sketching how the final result should look and behave.

3. Build in small steps. Nobody builds a whole website in one shot. Developers build one small piece, check that it works, then move to the next piece. This is far less overwhelming than trying to do everything at once.

4. Test. After building something, a developer checks it carefully to make sure it behaves the way it should, and fixes anything that looks wrong.

5. Improve. Even after something works, developers often go back to make it faster, cleaner, or easier to understand.

This cycle — understand, plan, build, test, improve — repeats itself constantly, on small tasks and on huge projects alike. Learning to think this way, patiently and in small steps, is honestly more valuable than memorizing any single tool. It is the mindset that separates someone who is only copying code from someone who is truly becoming a developer.''',
        codeSnippet: '''''',
        hasImage: false,
      ),
      AppLesson(
        title: '''Modern Web Development Landscape''',
        body: '''To close this course, let us zoom out and look at the bigger picture — the world of web development as it exists today, so you understand exactly where you are stepping into.

The web has grown enormously. In its early days, websites were simple pages of text. Today, the web powers banking, education, business, entertainment, and communication for billions of people, including everything you use daily on your phone, from NaijaLearn lessons to ZetraMail messages.

A few important shifts have shaped modern web development:

Mobile-first thinking: More people now access the web through phones than through computers, especially across Africa. This means modern developers must always think about how something looks and works on a small screen first.

Reusable building blocks: Instead of writing everything from scratch every time, modern developers reuse trusted pieces of code (called libraries and frameworks) to build faster and with fewer mistakes — much like a tailor reusing a trusted pattern instead of designing from zero each time.

Speed and accessibility matter: A modern website is expected to load quickly, even on a slow network, and to be usable by everyone, including people with disabilities. This is now seen as a basic requirement, not an extra feature.

Constant learning: Web development changes often — new tools appear, old ones fade. The most successful developers are not the ones who know everything today, but the ones who stay curious and keep learning, one topic at a time, throughout their career.

You have now completed the Web Development Fundamentals course. You understand what web development is, how the web works, the difference between frontend and backend, the tools developers rely on, and the mindset that carries a developer through their whole career. This foundation will make everything you learn next — starting with HTML — click into place far more easily. Well done, and see you in the next course.''',
        codeSnippet: '''''',
        hasImage: true,
      ),
    ],
  ),
];
