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

    lessons: [
      AppLesson(
        title: '''HTML Fundamentals''',
        body: '''Welcome back. Now that you understand what web development is, it is time to build your first real skill: HTML.

HTML stands for HyperText Markup Language. Do not worry about that big name — here is what it really means. "Markup" simply means labeling pieces of content so a browser knows what each piece is. HTML is not a programming language that makes decisions or does calculations; it is a labeling language. It tells the browser, "this is a heading," "this is a paragraph," "this is a picture," "this is a button." Nothing more, nothing less. That is its entire job, and it does it very well.

Every label in HTML is called a tag. Tags are written inside angle brackets, like this: <p>. Most tags come in pairs — an opening tag and a closing tag — and whatever sits between them is the content being labeled.

Look at this example:

<p>This is my first paragraph.</p>

Here, <p> is the opening tag, </p> is the closing tag (notice the forward slash), and the sentence in between is the content. Together, the opening tag, the content, and the closing tag are called an element.

Some tags do not wrap around content and do not need a closing tag. These are called self-closing tags. A common example is the line break tag: <br>. It simply tells the browser "start a new line here," and it needs no content and no partner closing tag.

Tags can also carry extra information called attributes. An attribute lives inside the opening tag and gives more detail about the element. For example:

<p title="greeting">Welcome to Hustle Academy</p>

Here, title="greeting" is an attribute. Attributes always come in a name="value" format.

That is the whole foundation of HTML: tags label content, elements are tags plus their content, and attributes add extra detail. Every single webpage you have ever visited — Nigergram, ZetraMail, NaijaLearn, anything — is built from thousands of these same simple building blocks, arranged carefully together. In the next lesson, you will learn how these building blocks are organized into a full, working document.''',
        codeSnippet: '''<p>This is my first paragraph.</p>
<br>
<p title="greeting">Welcome to Hustle Academy</p>''',
        hasImage: true,
      ),
      AppLesson(
        title: '''Document Structure''',
        body: '''Every HTML page, no matter how simple or advanced, follows the same basic skeleton. Once you understand this skeleton, you will recognize it in every website you ever open.

Here is the skeleton:

<!DOCTYPE html>
<html>
  <head>
    <title>My Page</title>
  </head>
  <body>
    <p>Hello, world!</p>
  </body>
</html>

Let us break this down piece by piece, like a doctor examining a body.

<!DOCTYPE html> is always the very first line. It is not really a tag — it is a short message to the browser saying, "this document is written in modern HTML, please read it correctly." Without it, older browsers may misbehave.

<html> is the container for the entire page. Everything else lives inside it. Notice it closes at the very bottom with </html> — the first tag opened is always the last tag closed, like nesting boxes inside boxes.

Inside <html>, there are two major sections: <head> and <body>.

The <head> is like the backstage of a theatre — the audience (the user) never sees it directly, but it controls important things: the page title shown on the browser tab, links to styling files, and information used by search engines. The <title> tag you see inside it decides what text shows up at the top of the browser tab.

The <body> is the stage itself — everything the user actually sees and interacts with lives here: text, images, buttons, forms, everything.

A helpful way to remember this: head = information about the page, body = the actual content of the page.

Every website, whether it is a one-page personal profile or a huge platform like ZetraMail, is built starting from this exact same skeleton. Master this structure, and you already understand the shape of every website that has ever existed.''',
        codeSnippet: '''<!DOCTYPE html>
<html>
  <head>
    <title>My Page</title>
  </head>
  <body>
    <p>Hello, world!</p>
  </body>
</html>''',
        hasImage: true,
      ),
      AppLesson(
        title: '''Text & Content''',
        body: '''Text is the heart of most webpages, so HTML gives us many different tags to organize text properly, instead of throwing everything into plain paragraphs.

Headings: HTML has six levels of headings, from <h1> (the biggest, most important) down to <h6> (the smallest). Think of <h1> as the main title of a page — there should usually be only one per page — and the smaller headings as sub-titles that organize sections underneath it.

<h1>Hustle Academy</h1>
<h2>Our Courses</h2>
<h3>Web Development</h3>

Paragraphs: The <p> tag wraps a block of normal text, exactly as you learned in the first lesson.

Lists: HTML gives us two kinds of lists. An unordered list (<ul>) is for items where order does not matter, shown with bullet points. An ordered list (<ol>) is for items where order matters, shown with numbers. Inside both, each item is wrapped in <li> (list item).

<ul>
  <li>HTML</li>
  <li>CSS</li>
  <li>JavaScript</li>
</ul>

<ol>
  <li>Sign up</li>
  <li>Choose a course</li>
  <li>Start learning</li>
</ol>

Emphasis: To make text bold, we use <strong> (which also tells the browser this text is important). To make text italic, we use <em> (which tells the browser this text should be emphasized).

<p>This offer is <strong>completely free</strong> for all students.</p>

Quotes: The <blockquote> tag is used when you are quoting someone else's words as a separate block.

<blockquote>Consistency beats talent when talent refuses to be consistent.</blockquote>

Notice a pattern here: HTML almost never asks you to describe how something should look (that job belongs to CSS, which you will meet in the next course). Instead, HTML asks you to describe what something means — this is a heading, this is a list, this is important text. This idea of meaning over appearance is one of the most important habits a serious developer builds early, and it will make far more sense once you compare it with CSS.''',
        codeSnippet: '''<h1>Hustle Academy</h1>
<p>This offer is <strong>completely free</strong> for all students.</p>
<ul>
  <li>HTML</li>
  <li>CSS</li>
  <li>JavaScript</li>
</ul>''',
        hasImage: false,
      ),
      AppLesson(
        title: '''Links & Navigation''',
        body: '''The "Hyper" in HyperText comes from one powerful idea: pages can link to other pages. This is what makes the web a "web" in the first place — millions of pages connected to each other through links.

Links are created with the anchor tag, <a>. The most important attribute on this tag is href (short for "hypertext reference"), which tells the browser where the link should go.

<a href="https://naijalearn.com">Visit NaijaLearn</a>

There are two kinds of links you should understand:

An absolute link is a full web address, including https:// and the domain name. It is used when linking to a completely different website.

<a href="https://naijalearn.com">NaijaLearn</a>

A relative link points to another page within the same website, without repeating the full address. It is used when linking between pages that belong to the same project.

<a href="about.html">About Us</a>

You can also control how a link opens using the target attribute. Setting target="_blank" tells the browser to open the link in a new tab, instead of leaving the current page.

<a href="https://naijalearn.com" target="_blank">Open in new tab</a>

For grouping links together — like a menu at the top of a website — HTML gives us the <nav> tag, which wraps a group of navigation links so both browsers and screen readers understand, "this section is for moving around the site."

<nav>
  <a href="index.html">Home</a>
  <a href="courses.html">Courses</a>
  <a href="contact.html">Contact</a>
</nav>

Without links, every website would be a lonely island. Links are what connect Hustle Academy's pages to each other, and what connects the entire internet together as one giant, interconnected web.''',
        codeSnippet: '''<nav>
  <a href="index.html">Home</a>
  <a href="courses.html">Courses</a>
  <a href="https://naijalearn.com" target="_blank">NaijaLearn</a>
</nav>''',
        hasImage: false,
      ),
      AppLesson(
        title: '''Images & Multimedia''',
        body: '''Text alone cannot always tell the full story. HTML also lets us bring in images, videos, and audio, to make pages richer and more engaging.

Images are added using the <img> tag. Unlike most tags, <img> does not wrap around content and has no closing tag — it is self-closing. It relies entirely on attributes to work:

<img src="logo.png" alt="Hustle Academy logo">

The src attribute (short for "source") tells the browser where to find the image file. The alt attribute is extremely important, and beginners often ignore it — it provides a text description of the image, which is used in two critical situations: when the image fails to load, and when a visually impaired user is using a screen reader to browse the page. A good developer never skips the alt attribute.

For video, HTML gives us the <video> tag:

<video src="lesson1.mp4" controls></video>

The controls attribute adds play, pause, and volume buttons automatically, so users can control playback themselves.

For audio, there is a very similar <audio> tag:

<audio src="podcast.mp3" controls></audio>

Both video and audio also support a more flexible pattern using the <source> tag inside them, which allows you to offer multiple file formats in case a browser cannot play one of them:

<video controls>
  <source src="lesson1.mp4" type="video/mp4">
  <source src="lesson1.webm" type="video/webm">
</video>

A golden rule to remember: images, video, and audio make a page powerful, but they also make it heavier and slower to load, especially on the kind of slower networks many of our students use daily. A responsible developer always thinks about file size and always writes proper alt text — never skip it out of laziness.''',
        codeSnippet: '''<img src="logo.png" alt="Hustle Academy logo">
<video controls>
  <source src="lesson1.mp4" type="video/mp4">
</video>''',
        hasImage: true,
      ),
      AppLesson(
        title: '''Forms & User Input''',
        body: '''So far, everything we have learned lets a page speak to the user. Forms are how the user speaks back. Every time someone signs up on ZetraMail, logs in, or searches for a course on NaijaLearn, they are using a form.

A form starts with the <form> tag, and inside it, we place different types of input fields, depending on what kind of information we want from the user.

The most common tag is <input>, and its behavior changes completely depending on its type attribute:

<input type="text" placeholder="Enter your name">
<input type="email" placeholder="Enter your email">
<input type="password" placeholder="Enter your password">
<input type="checkbox"> I agree to the terms
<input type="radio" name="gender"> Male
<input type="radio" name="gender"> Female

Notice placeholder — it shows faint hint text inside an empty input, which disappears once the user starts typing.

For longer pieces of text, like a message or a comment, we use <textarea> instead of <input>, because it allows multiple lines:

<textarea placeholder="Write your message here"></textarea>

For choosing one option out of many, like selecting a course category, we use <select> together with <option>:

<select>
  <option>Web Development</option>
  <option>Cybersecurity</option>
  <option>Digital Marketing</option>
</select>

Finally, to let the user submit the form, we use a <button>:

<button>Submit</button>

One important habit: every input should be paired with a <label>, so the user (and screen readers) clearly understand what each field is asking for:

<label for="username">Username</label>
<input type="text" id="username">

Notice how the for attribute on the label matches the id attribute on the input — this connection is what makes them officially linked together, not just visually placed near each other.

Forms are the doorway through which real information flows from your users into your website. Learning to build them properly is one of the most practical skills in all of web development.''',
        codeSnippet: '''<form>
  <label for="username">Username</label>
  <input type="text" id="username" placeholder="Enter your name">

  <label for="email">Email</label>
  <input type="email" id="email" placeholder="Enter your email">

  <button>Submit</button>
</form>''',
        hasImage: false,
      ),
      AppLesson(
        title: '''Semantic HTML''',
        body: '''By now you know tags like <div> exist as a plain, general-purpose container with no special meaning. But relying only on <div> for everything is a habit that weak developers fall into. Strong developers use semantic HTML instead.

"Semantic" simply means "carrying meaning." A semantic tag does not just group content — it also tells the browser, search engines, and screen readers exactly what role that content plays on the page.

Here are the major semantic tags every developer should know:

<header> — represents the introductory section of a page, often containing a logo, title, or navigation.

<nav> — represents a block of navigation links, as you saw earlier.

<main> — represents the single, central content of the page — the main reason the page exists. A page should only have one <main>.

<section> — represents a distinct, themed group of content, usually with its own heading.

<article> — represents a self-contained piece of content that could stand alone, like a blog post or a course description.

<aside> — represents content that is related but secondary, like a sidebar or a tip box.

<footer> — represents the closing section of a page, often containing copyright information or contact links.

Here is how a page might use them together:

<header>
  <h1>Hustle Academy</h1>
  <nav>...</nav>
</header>
<main>
  <section>
    <h2>Our Courses</h2>
    <article>HTML Course details...</article>
    <article>CSS Course details...</article>
  </section>
</main>
<footer>
  <p>Copyright Hustle Academy</p>
</footer>

Why does this matter so much? Two big reasons. First, search engines read semantic structure to understand what a page is actually about, which affects how easily people find your website. Second, screen readers used by visually impaired users rely heavily on semantic tags to describe a page correctly out loud. Writing semantic HTML is not decoration — it is respect, both for the machines reading your code and for every human who visits your page.''',
        codeSnippet: '''<header>
  <h1>Hustle Academy</h1>
  <nav>...</nav>
</header>
<main>
  <section>
    <h2>Our Courses</h2>
    <article>HTML Course details...</article>
  </section>
</main>
<footer>
  <p>Copyright Hustle Academy</p>
</footer>''',
        hasImage: true,
      ),
      AppLesson(
        title: '''Accessibility & Modern HTML''',
        body: '''We end this course with one of the most important, and most overlooked, ideas in web development: accessibility.

Accessibility means building websites that everyone can use, including people who are blind, partially sighted, deaf, or who have difficulty using a mouse. It is not a bonus feature for advanced developers — it is a basic responsibility of every developer, from your very first project.

Here are habits you should carry with you from today onward:

Always write meaningful alt text for images, describing what the image shows, not just "image" or "picture."

Always pair form inputs with proper labels, as you learned in the forms lesson, so every field is clearly announced to assistive technology.

Always use headings in the correct order (h1, then h2, then h3, and so on) rather than skipping levels just because a smaller heading looks nicer — screen reader users navigate pages by jumping between headings, and a broken order confuses them.

Always use semantic tags where they fit, instead of wrapping everything in generic <div> tags, because semantic tags carry built-in meaning that assistive technology depends on.

Beyond accessibility, it is also worth knowing that HTML continues to evolve. What you have learned in this course is often called modern HTML, or HTML5 — the current, widely used version that introduced semantic tags, native video and audio support, and better form controls, replacing older, messier ways of writing markup.

You have now completed the HTML course. You understand tags, elements, and attributes; you can structure a full document; you can format text, add links, images, and multimedia; you can build forms that collect real information; and you understand how to write your HTML with meaning and accessibility in mind — the same standard expected of professional developers anywhere in the world, including the very best coming out of India and beyond. This is the skeleton every website is built on. In the next course, we bring that skeleton to life with color, style, and layout, using CSS.''',
        codeSnippet: '''''',
        hasImage: true,
      ),
    ],
  ),
