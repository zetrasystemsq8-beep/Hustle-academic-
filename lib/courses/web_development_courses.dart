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
      AppLesson(
        title: '''Responsive Design Principles''',
        body: '''In the CSS course, you got your first taste of responsive design through media queries. In this course, we go much deeper, because this is one skill that genuinely separates a hobby coder from a professional developer.

Here is a truth you must carry with you forever: you do not know what device the next person opening your website will be using. It could be a small budget phone, a mid-range Android, an iPad, or a large desktop monitor. Your job as a developer is not to design for one screen — it is to design for all screens, using one single set of code.

Responsive web design rests on three core principles, and every technique you learn in this course is really just a deeper expression of these three ideas.

Fluidity means your layout should stretch and shrink smoothly, instead of breaking or overflowing awkwardly when the screen size changes. A fluid layout behaves like water poured into different shaped containers — it adapts, rather than cracking.

Flexibility means your content — text, images, buttons — should resize and rearrange itself sensibly, rather than staying rigid and forcing the user to scroll sideways or squint at tiny text.

Adaptability means your website can make bigger structural decisions at certain screen sizes — for example, hiding a sidebar on phones and showing it on larger screens, or changing a three-column layout into a single column.

Throughout this course, you will learn the specific tools that deliver these three principles: viewports, media queries, flexible units, mobile-first workflows, responsive images, and modern layout patterns. But always remember — the tools exist to serve these three ideas, not the other way around. A truly responsive website is one where the user, whether on the cheapest phone or the most expensive laptop, never feels like the site was designed for someone else.''',
        codeSnippet: '''''',
        hasImage: true,
      ),
      AppLesson(
        title: '''Viewports & Media Queries''',
        body: '''Before any of your responsive CSS can work correctly, there is one small but absolutely critical line of HTML that must exist in every single project you build. Without it, phones will completely ignore your responsive design.

<meta name="viewport" content="width=device-width, initial-scale=1.0">

This line goes inside your <head>, and it tells the phone's browser: "do not shrink this page down to fake a desktop view — instead, treat the actual width of this device as the real width of the page, and start at normal zoom." Many beginners write perfect responsive CSS, forget this one line, and cannot understand why their phone view looks broken. Always include it, every time, without exception.

Now let us go deeper into media queries, which you first met briefly in the CSS course. A media query is a conditional rule — CSS that only applies when a certain condition about the screen is true.

@media (min-width: 768px) {
  .container {
    flex-direction: row;
  }
}

min-width means "apply this rule when the screen is at least this wide, or wider." You can also use max-width, which means "apply this rule when the screen is at most this wide, or narrower":

@media (max-width: 480px) {
  .sidebar {
    display: none;
  }
}

You can combine conditions using and, for example, targeting a specific range of screen sizes:

@media (min-width: 600px) and (max-width: 900px) {
  .container {
    padding: 30px;
  }
}

Developers often refer to the specific widths where a layout changes as breakpoints. Common, widely used breakpoints roughly represent phones (below around 600px), tablets (around 600px to 900px), and desktops (above around 900px), though these numbers are guidelines, not strict laws — a good developer tests their actual design and chooses breakpoints based on where the content itself starts looking cramped or awkward, not just by memorizing standard numbers.''',
        codeSnippet: '''<meta name="viewport" content="width=device-width, initial-scale=1.0">

@media (max-width: 600px) {
  .sidebar {
    display: none;
  }
}''',
        hasImage: false,
      ),
      AppLesson(
        title: '''Mobile-First Design''',
        body: '''There are two possible ways to approach building a responsive website, and one of them is far better than the other.

The old way, called desktop-first, means designing everything for a large screen first, and then using media queries to squeeze and hide things down for smaller screens. This often leads to messy, bloated CSS, because you are constantly fighting to undo desktop styles for mobile.

The modern, professional way, called mobile-first, flips this completely. You design your base styles — the styles with no media query at all — for the smallest screen first. Then, as the screen grows, you use min-width media queries to progressively add more complexity: more columns, more spacing, bigger typography, side-by-side layouts.

/* Base styles — apply to phones, and to everyone, by default */
.container {
  display: flex;
  flex-direction: column;
  padding: 16px;
}

/* Enhance for tablets and above */
@media (min-width: 768px) {
  .container {
    flex-direction: row;
    padding: 32px;
  }
}

/* Enhance further for large desktops */
@media (min-width: 1200px) {
  .container {
    padding: 64px;
  }
}

Why is this the better approach? Two strong reasons. First, most of our students, and most people accessing the internet across Nigeria and Africa broadly, primarily use phones — so designing the phone experience first means you are designing for your actual majority audience first, not as an afterthought. Second, it is simply cleaner code — you write less CSS overall, because you are always adding enhancements as screens grow, instead of writing full desktop styles and then writing a second, separate set of rules to undo them for mobile.

From this course onward, always build mobile-first. Start narrow, start simple, and let your design grow more elaborate only as the screen gives you more room to work with.''',
        codeSnippet: '''.container {
  display: flex;
  flex-direction: column;
  padding: 16px;
}

@media (min-width: 768px) {
  .container {
    flex-direction: row;
    padding: 32px;
  }
}''',
        hasImage: true,
      ),
      AppLesson(
        title: '''Flexible Layouts''',
        body: '''A responsive layout depends heavily on the units you choose to measure things with. Some units are rigid and fixed; others stretch and adapt naturally. Understanding the difference is essential.

Pixels (px) are a fixed, absolute unit — an element sized in pixels stays exactly that size, no matter what. Pixels are useful for small, precise details, like a border thickness, but they are dangerous for main layout widths, because they refuse to adapt to different screens.

Percentages (%) size an element relative to its parent container. If a parent is 600px wide and a child has width: 50%;, the child becomes 300px — and if the parent's width changes, the child automatically recalculates too.

.column {
  width: 50%;
}

Viewport units, vw and vh, size elements relative to the entire browser window — 1vw equals one percent of the viewport's width, and 1vh equals one percent of its height. These are powerful for full-screen sections.

.hero {
  height: 100vh;
  padding: 5vw;
}

Beyond units, Flexbox and Grid (which you learned in the CSS course) are themselves inherently flexible layout tools, and they become even more powerful for responsiveness when combined with functions like minmax() and auto-fit in Grid, which let a layout automatically decide how many columns fit, without you writing a single media query:

.gallery {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 16px;
}

Read this carefully — it tells the browser: "create as many columns as will fit, with each column being at least 200px wide, but allow them to grow and share space equally (1fr) when there is extra room." On a phone, this might naturally produce one column. On a tablet, two or three. On a desktop, five or six — all without writing a single @media rule. This is one of the most elegant, modern responsive techniques available, and it is worth practicing until it feels natural.''',
        codeSnippet: '''.gallery {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 16px;
}''',
        hasImage: false,
      ),
      AppLesson(
        title: '''Responsive Typography''',
        body: '''Text that looks perfectly sized on a desktop monitor can feel either too small to read comfortably, or awkwardly huge, on a phone screen. Responsive typography solves this properly.

The most basic approach uses media queries directly on font-size:

h1 {
  font-size: 28px;
}

@media (min-width: 768px) {
  h1 {
    font-size: 48px;
  }
}

This works, but writing a media query for every single heading size across a whole website quickly becomes repetitive. A more elegant, modern solution is the clamp() function, which lets you define a minimum size, a flexible ideal size, and a maximum size, all in one line:

h1 {
  font-size: clamp(24px, 5vw, 48px);
}

Read this as: "never go smaller than 24px, never go bigger than 48px, and in between, size the text at 5% of the viewport width." As the screen grows or shrinks, the heading smoothly scales itself between those two boundaries, with zero media queries needed.

It is also worth remembering rem units here, which you briefly met in the CSS course. Because rem is based on the root font size of the entire page, you can resize your entire website's typography scale by changing just one value:

html {
  font-size: 100%;
}

@media (min-width: 1200px) {
  html {
    font-size: 112%;
  }
}

Because every rem-based size on the page is relative to this root value, increasing it slightly on large screens gently scales up every heading, paragraph, and button across your entire site at once, keeping everything proportional.

Beyond sizing, remember line-height and line length matter too — extremely wide lines of text on a large monitor become tiring to read. A comfortable line typically holds somewhere around 60 to 75 characters, which is why well-designed websites often limit text columns to a maximum width, even on very large screens, rather than letting paragraphs stretch edge to edge.''',
        codeSnippet: '''h1 {
  font-size: clamp(24px, 5vw, 48px);
}

p {
  max-width: 65ch;
  line-height: 1.6;
}''',
        hasImage: false,
      ),
      AppLesson(
        title: '''Responsive Images & Media''',
        body: '''Images are often the heaviest files on a webpage, and handling them carelessly is one of the most common reasons websites feel slow, especially on the kind of mobile data connections many of our students use daily.

The very first, most basic fix is making sure images never overflow their container, using this simple, essential rule:

img {
  max-width: 100%;
  height: auto;
}

This tells the browser: "never let this image become wider than its container, and automatically adjust the height to keep its natural proportions." This single rule alone solves the majority of basic image overflow problems.

Beyond that, professional developers use the srcset attribute to offer the browser multiple versions of the same image at different sizes, letting the browser intelligently choose which one to download based on the actual device's screen:

<img
  src="course-card-800.jpg"
  srcset="course-card-400.jpg 400w, course-card-800.jpg 800w, course-card-1200.jpg 1200w"
  sizes="(max-width: 600px) 400px, (max-width: 1000px) 800px, 1200px"
  alt="Web Development course card"
>

Read this carefully: we are giving the browser three versions of the same image, at three different widths. The sizes attribute then tells the browser roughly how large the image will actually be displayed at different screen widths. Using this information, a phone can automatically download the small 400px version instead of wastefully downloading the large 1200px version meant for desktop monitors — saving data and loading noticeably faster.

The same responsibility applies to video. Videos should also respect their container's width:

video {
  max-width: 100%;
  height: auto;
}

The guiding principle behind all of this is simple: never make a small-screen user pay, in data cost and loading time, for a large-screen experience they cannot even see properly. Respecting your users' bandwidth is part of being a responsible, professional developer.''',
        codeSnippet: '''img {
  max-width: 100%;
  height: auto;
}

<img
  src="card-800.jpg"
  srcset="card-400.jpg 400w, card-800.jpg 800w"
  sizes="(max-width: 600px) 400px, 800px"
  alt="Course card"
>''',
        hasImage: true,
      ),
      AppLesson(
        title: '''Advanced Responsive Patterns''',
        body: '''As you grow more confident, a few advanced responsive patterns become extremely useful, because they solve specific, common real-world layout problems very elegantly.

The hide-and-show pattern uses display: none; inside media queries to show completely different navigation on different screens — for example, a full horizontal menu on desktop, and a compact hamburger-style menu icon on mobile.

.desktop-menu {
  display: none;
}

@media (min-width: 768px) {
  .desktop-menu {
    display: flex;
  }
  .mobile-menu-icon {
    display: none;
  }
}

The reordering pattern uses Flexbox's order property, or Grid placement, to change the visual order of elements on different screens, without changing the actual order in your HTML — useful when, for example, an image should appear before text on mobile, but after text on desktop.

.image {
  order: 1;
}

@media (min-width: 768px) {
  .image {
    order: 2;
  }
}

Container queries are a newer, increasingly supported responsive technique. Where media queries respond to the size of the entire browser window, container queries respond to the size of a specific parent container itself — meaning the very same component can adapt its layout based on where it happens to be placed on the page, not just the overall screen size:

.card-container {
  container-type: inline-size;
}

@container (min-width: 400px) {
  .card {
    flex-direction: row;
  }
}

This is powerful for building genuinely reusable components that adapt intelligently wherever they are dropped — inside a narrow sidebar, or a wide main content area — without needing separate versions of the component for each context.

These advanced patterns are not something you need to master immediately, but recognizing them now means that when you encounter them again later in your journey, they will feel familiar rather than intimidating.''',
        codeSnippet: '''.image {
  order: 1;
}

@media (min-width: 768px) {
  .image {
    order: 2;
  }
}''',
        hasImage: false,
      ),
      AppLesson(
        title: '''Accessibility & Cross-Device Design''',
        body: '''We close this course the same way we closed HTML — with responsibility. Responsive design is not complete once your layout merely fits different screen widths. True responsiveness also means considering how different people, on different devices, actually experience your website.

Touch versus pointer: on a phone, users tap with a finger, which is far less precise than a mouse pointer. Buttons and links should be large enough to comfortably tap — a widely recommended minimum touch target size is around 44 by 44 pixels. A button that is easy to click with a mouse can be frustratingly small to tap accurately with a thumb.

.button {
  min-width: 44px;
  min-height: 44px;
  padding: 12px 20px;
}

Orientation: phones and tablets can be rotated between portrait (tall) and landscape (wide) at any moment. A genuinely responsive website should hold up reasonably in both orientations, not just the one you happened to test in.

Testing across real conditions: professional developers do not just resize their browser window and assume the job is done. They test on actual different devices where possible, check how a page behaves on a slower network connection, and verify that text remains readable and buttons remain tappable at every size in between the major breakpoints, not just exactly at them.

Respecting user preferences: modern CSS can even respond to system-level settings a user has chosen, such as preferring reduced motion (useful for users sensitive to animation) or preferring dark mode:

@media (prefers-color-scheme: dark) {
  body {
    background-color: #121212;
    color: #f0f0f0;
  }
}

You have now completed the Responsive Web Design course. You understand the core principles behind responsiveness, viewports and media queries, mobile-first workflow, flexible layouts, responsive typography and images, advanced adaptive patterns, and the deeper responsibility of designing for real people on real devices. Combined with everything you have learned in HTML and CSS, you can now build websites that hold their own on any screen, anywhere in the world — a standard every serious, competitive developer is expected to meet.''',
        codeSnippet: '''.button {
  min-width: 44px;
  min-height: 44px;
}

@media (prefers-color-scheme: dark) {
  body {
    background-color: #121212;
    color: #f0f0f0;
  }
}''',
        hasImage: true,
      ),
    ],
  
