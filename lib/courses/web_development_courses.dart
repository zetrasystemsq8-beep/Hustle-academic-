// ============================================================
// WEB DEVELOPMENT COURSES
// lib/courses/web_development_courses.dart
// ============================================================
// Add this import to main.dart:
// import 'courses/web_development_courses.dart';
// Then spread it inside kCourses:
// ...webDevelopmentCourses,
// ============================================================

import 'package:flutter/material.dart';
import '../main.dart';

final List<AppCourse> webDevelopmentCourses = [
  AppCourse(
    id: 'web_development_html_101',
    title: 'HTML5 & Web Structure Mastery',
    description: 'Learn the foundational building blocks of the web. This course covers everything from basic document structure to semantic HTML and forms.',
    instructor: 'Chinedu Eze',
    category: 'Web Development',
    difficulty: 'Beginner',
    icon: Icons.language,
    color: Colors.orange,
    duration: '5h 30m',
    lessons: [
      AppLesson(
        title: 'Introduction to the World Wide Web',
        body: '''The World Wide Web is a vast, interconnected network of documents and resources, linked by hyperlinks and URLs. It operates on a client-server model where your browser acts as the client requesting information. When you type a web address, a request is sent to a server, which processes it and sends back the necessary files to display the page. This seamless exchange of data is what makes modern internet browsing possible.

HTML, which stands for HyperText Markup Language, is the standard markup language used to create web pages. It is not a programming language in the traditional sense, but rather a structural language that tells the browser how to display text and media content. By using various tags, you define headings, paragraphs, images, and links. Understanding HTML is the absolute first step in your journey to becoming a professional web developer.

In this course, we will focus exclusively on HTML5, the latest evolution of the standard that brings enhanced capabilities for modern web applications. You will learn how to structure content semantically, ensuring that your websites are accessible to all users and easily indexable by search engines. By the end of our journey, you will have the skills needed to build robust web page structures from scratch.''',
        hasImage: true,
      ),
      AppLesson(
        title: 'Setting Up Your Development Environment',
        body: '''Before we write a single line of code, we need to set up a robust development environment tailored for web creation. The most important tool in a web developer\'s arsenal is the code editor. While you can technically write HTML in simple text editors like Notepad, dedicated code editors provide features that make development faster and less error-prone. These essential features include syntax highlighting, auto-completion, and integrated terminals.

We highly recommend using Visual Studio Code (VS Code), a free, open-source editor developed by Microsoft that has become the industry standard. It is lightweight, incredibly fast, and boasts a massive ecosystem of extensions created by the community. Once downloaded and installed, you can customize it with themes and tools specifically tailored for web development. We will also install an extension called Live Server, which allows you to see your HTML changes in the browser in real-time without constantly refreshing.

Another crucial aspect of your setup is organizing your digital workspace effectively. Create a dedicated folder on your computer for all your web development projects to keep everything centralized. Inside this master folder, you will create sub-folders for each individual project, keeping your HTML, CSS, and image files neatly organized. Good file management from day one prevents a chaotic and unmanageable codebase as your projects inevitably grow in complexity.''',
      ),
      AppLesson(
        title: 'HTML Boilerplate and Document Structure',
        body: '''Every HTML document requires a foundational structure, often referred to as the boilerplate. This boilerplate acts as the skeletal framework upon which your entire web page is built. It starts with the document type declaration, which informs the web browser exactly which version of HTML the page is written in. For modern websites, we always use the HTML5 declaration to ensure broad compatibility and access to the newest features.

Immediately following the declaration is the root html element, which wraps all the content on the page and typically includes a language attribute. Inside the root, the document is split into two primary sections: the head and the body. The head contains metadata, title information, and links to external resources like stylesheets. The body contains all the visible content that users will actually see and interact with on the page.

Understanding the separation between the head and the body is critical for structuring your documents correctly. Metadata in the head tells search engines what your page is about and dictates how it scales on mobile devices via viewport settings. Meanwhile, everything you want the user to experience—text, images, videos, and buttons—must reside exclusively within the body tags.''',
        codeSnippet: '''<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My First Document</title>
</head>
<body>
    <!-- Visible content goes here -->
</body>
</html>''',
      ),
      AppLesson(
        title: 'Working with Text and Headings',
        body: '''Text is the primary medium of information on the web, and HTML provides specific tags to structure it logically. Headings are used to define the hierarchy and structure of your content, much like the outline of a book. HTML offers six levels of headings, ranging from h1 to h6, with h1 being the most important and h6 the least. Proper use of headings is essential for both accessibility screen readers and search engine optimization (SEO).

The paragraph tag is used to define blocks of text, separating distinct thoughts or topics. Browsers automatically add some space, known as margin, before and after paragraphs to make the text readable. Beyond basic paragraphs, HTML provides formatting tags to emphasize text. For instance, the strong tag is used for important text that usually renders bold, while the em tag is used for emphasized text that usually renders in italics.

It is crucial to remember that HTML formatting tags should be used for semantic meaning, not just visual styling. If you merely want text to look bold or italicized without imparting special importance, that should be handled later with CSS. By focusing on semantic meaning in your HTML, you create web pages that are easily digestible by both human readers and automated web crawlers analyzing your site.''',
        codeSnippet: '''<h1>Main Article Title</h1>
<h2>Section Overview</h2>
<p>This is a standard paragraph introducing the section topic.</p>
<p>This paragraph contains <strong>highly important information</strong> that needs emphasis.</p>
<h3>Sub-section Details</h3>
<p>We can also use <em>emphasis</em> to change the tone of a sentence.</p>''',
      ),
      AppLesson(
        title: 'Creating Lists and Semantic Elements',
        body: '''Lists are fundamental for organizing related items in a highly readable format. HTML supports three main types of lists: unordered lists, ordered lists, and description lists. Unordered lists are used when the sequence of items does not matter, and they typically render with bullet points. Ordered lists are used when the sequence is important, such as a step-by-step recipe, and they render with numbers or letters.

Within both unordered and ordered lists, individual list items are defined using the li tag. Description lists are slightly different; they are used for name-value pairs, such as terms and definitions. Beyond lists, modern HTML5 introduced semantic container elements to replace the generic div tag for structural grouping. These include tags like header, footer, article, section, and nav.

Semantic elements clearly describe their meaning to both the browser and the developer. Using a nav tag instead of a plain div for a navigation menu explicitly states the purpose of that section. This practice dramatically improves accessibility for visually impaired users relying on screen readers, as the software can easily identify and navigate to the major sections of your web application.''',
        codeSnippet: '''<!-- Unordered List -->
<ul>
    <li>Apples</li>
    <li>Bananas</li>
    <li>Oranges</li>
</ul>

<!-- Ordered List -->
<ol>
    <li>Preheat the oven</li>
    <li>Mix the ingredients</li>
    <li>Bake for 30 minutes</li>
</ol>

<!-- Semantic Structure -->
<article>
    <header>
        <h2>Blog Post Title</h2>
    </header>
    <section>
        <p>Content of the blog post...</p>
    </section>
</article>''',
      ),
      AppLesson(
        title: 'Adding Links and Navigation',
        body: '''Hyperlinks are the defining feature of the World Wide Web, allowing users to navigate between vast quantities of connected documents. In HTML, links are created using the anchor tag, denoted by the letter 'a'. The most important attribute of an anchor tag is the 'href' (hypertext reference), which specifies the destination URL the link points to. Without an href attribute, the anchor tag is practically useless.

Links can point to external websites, other pages within your own website, or even specific sections on the current page. When linking to an external site, you provide the full, absolute URL including the protocol (like https). When linking to pages within your own site, you use relative URLs that describe the path to the file based on the current page\'s location. You can also use the 'target' attribute to force a link to open in a new browser tab.

To link to a specific section on the same page, you use an anchor link pointing to an element\'s ID. This is incredibly useful for long, single-page layouts or tables of contents. Understanding how to wire up navigation correctly ensures users can fluidly explore your application without hitting dead ends or broken paths.''',
        hasImage: true,
        codeSnippet: '''<!-- External Link -->
<a href="https://www.google.com" target="_blank">Visit Google</a>

<!-- Relative Link to another page -->
<a href="/about.html">About Us</a>

<!-- Link to an ID on the same page -->
<a href="#contact-section">Jump to Contact</a>

<section id="contact-section">
    <h2>Contact Information</h2>
    <p>Reach us here.</p>
</section>''',
      ),
      AppLesson(
        title: 'Embedding Images and Media',
        body: '''A web page consisting solely of text can be quite monotonous, so embedding images and multimedia is vital for engaging users. The HTML image tag (img) is a self-closing tag used to embed images directly into the document flow. It requires two primary attributes to function correctly: the 'src' (source) attribute, which points to the image file location, and the 'alt' (alternative text) attribute.

The 'alt' attribute is critically important for two main reasons. First, if the image fails to load due to a broken link or slow connection, the browser will display the alt text in its place. Second, screen readers rely entirely on the alt text to describe images to visually impaired users. Therefore, writing descriptive, concise alt text is a non-negotiable best practice in professional web development.

In addition to images, HTML5 provides native elements for embedding audio and video content without needing third-party plugins like the defunct Adobe Flash. The video and audio tags allow you to provide multiple source files in different formats to ensure cross-browser compatibility. You can easily add built-in controls so the user can play, pause, and adjust the volume of the media right from the web page.''',
        codeSnippet: '''<!-- Embedding an Image -->
<img src="images/profile-picture.jpg" alt="A professional headshot of the author">

<!-- Embedding a Video -->
<video width="320" height="240" controls>
    <source src="movie.mp4" type="video/mp4">
    <source src="movie.ogg" type="video/ogg">
    Your browser does not support the video tag.
</video>''',
      ),
      AppLesson(
        title: 'Building HTML Forms',
        body: '''Forms are the primary method for collecting input and data from users on a web page. Whether it is a simple search bar, a login screen, or a complex multi-page survey, HTML forms provide the necessary interactive elements. The form element acts as a container for various input controls and includes attributes that specify where and how the collected data should be sent when the user submits it.

The most versatile element inside a form is the input tag, which changes its behavior drastically based on its 'type' attribute. You can create text fields, password fields, checkboxes, radio buttons, and submit buttons all by changing a single word. Other essential form elements include the textarea for multi-line text input and the select element for creating dropdown menus.

To make forms accessible and user-friendly, every input element should be paired with a corresponding label element. The label is linked to the input via the 'for' attribute matching the input\'s 'id'. This not only helps screen readers understand the purpose of the input but also allows users to click the text label to activate the associated input field, greatly improving usability on mobile devices.''',
        codeSnippet: '''<form action="/submit-data" method="POST">
    <div>
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" required>
    </div>
    
    <div>
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required>
    </div>
    
    <div>
        <button type="submit">Log In</button>
    </div>
</form>''',
      ),
      AppLesson(
        title: 'Working with Tables',
        body: '''HTML tables are used to display tabular data, meaning data that is logically organized into rows and columns. While tables were incorrectly used in the 1990s and early 2000s for page layout, they should now strictly be used for displaying actual data sets like schedules, financial reports, or feature comparisons. The structure of a table begins with the main table tag wrapping the entire component.

Inside the table, data is structured sequentially by rows using the tr (table row) tag. Within each row, you define individual cells. For the header row at the top of the table, you use the th (table header) tag, which by default renders the text bold and centered. For standard data cells in the subsequent rows, you use the td (table data) tag.

To further improve the semantic structure and accessibility of complex tables, you can group rows together using the thead, tbody, and tfoot tags. This explicitly defines which part of the table acts as the header, the main body of data, and the concluding summary or footer. Structuring tables this way also makes them easier to style systematically with CSS later on.''',
        codeSnippet: '''<table>
    <thead>
        <tr>
            <th>Product</th>
            <th>Price</th>
            <th>Stock Status</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>Mechanical Keyboard</td>
            <td>\$120.00</td>
            <td>In Stock</td>
        </tr>
        <tr>
            <td>Wireless Mouse</td>
            <td>\$45.50</td>
            <td>Out of Stock</td>
        </tr>
    </tbody>
</table>''',
      ),
      AppLesson(
        title: 'Mini Project: Building a Personal Portfolio Page',
        body: '''It is time to bring together everything you have learned in this course to build a practical, real-world project. You will create a single-page personal portfolio structured entirely with semantic HTML. This project will test your ability to combine document structure, text formatting, media embedding, and list creation into a cohesive whole. Do not worry about the visual styling yet; focus solely on the structural markup.

Start by setting up your HTML5 boilerplate and giving the page an appropriate title. Use semantic elements like header, nav, main, section, and footer to divide the layout logically. In the header, add an h1 tag with your name and a brief introductory paragraph. Create a navigation menu using an unordered list populated with anchor links that jump to different sections of the page using ID attributes.

In the main body, include an "About Me" section with a profile picture and paragraphs describing your background. Next, build a "Skills" section utilizing an unordered list, and an "Experience" section utilizing a semantic table to list your job history. Finally, create a "Contact" section containing a functional HTML form asking for a user\'s name, email, and a message. Congratulations, you have built a structurally sound web page!''',
        codeSnippet: '''<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Portfolio</title>
</head>
<body>
    <header>
        <h1>Jane Doe - Web Developer</h1>
        <nav>
            <ul>
                <li><a href="#about">About</a></li>
                <li><a href="#skills">Skills</a></li>
                <li><a href="#contact">Contact</a></li>
            </ul>
        </nav>
    </header>
    
    <main>
        <section id="about">
            <h2>About Me</h2>
            <img src="jane.jpg" alt="Jane Doe smiling">
            <p>I am a passionate beginner web developer eager to learn.</p>
        </section>
        
        <section id="contact">
            <h2>Get In Touch</h2>
            <form action="#">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email">
                <button type="submit">Send</button>
            </form>
        </section>
    </main>
</body>
</html>''',
      ),
    ],
  ),
  AppCourse(
    id: 'web_development_css_101',
    title: 'CSS3 Styling and Responsive Design',
    description: 'Transform plain HTML into stunning, responsive websites. Master the box model, flexbox, grid, and modern styling techniques.',
    instructor: 'Amina Yusuf',
    category: 'Web Development',
    difficulty: 'Beginner',
    icon: Icons.color_lens,
    color: Colors.blue,
    duration: '6h 15m',
    lessons: [
      AppLesson(
        title: 'Introduction to Cascading Style Sheets',
        body: '''If HTML is the skeleton of a web page, Cascading Style Sheets (CSS) represent the skin, clothing, and makeup. CSS is the language used to dictate how HTML elements should be presented visually to the user. Without CSS, the web would be a very boring place consisting only of black text on white backgrounds. CSS allows you to control colors, typography, spacing, positioning, and even complex animations.

The term "Cascading" refers to the specific rules that determine which styles are applied when multiple conflicting rules target the same element. Styles can cascade down from global stylesheets to specific, targeted rules. There are three ways to apply CSS to a document: inline styles directly on the HTML tag, internal styles placed in the document head, and external stylesheets linked as a separate file.

In modern web development, external stylesheets are the absolute standard. Keeping your CSS in a separate '.css' file ensures a clean separation of concerns between structure (HTML) and presentation (CSS). This approach allows you to style an entire website of hundreds of pages by linking to a single CSS file, making global design changes incredibly efficient and easy to manage.''',
        hasImage: true,
        codeSnippet: '''/* styles.css */
/* This is an external stylesheet */

body {
    background-color: #f4f4f9;
    color: #333333;
    font-family: Arial, sans-serif;
}

h1 {
    color: #0056b3;
}''',
      ),
      AppLesson(
        title: 'CSS Selectors and Colors',
        body: '''To style an HTML element, you first need a way to target it. This is where CSS selectors come in. The most basic selectors target elements by their HTML tag name, such as styling all 'p' or 'h1' tags. However, styling all paragraphs identically is rarely what you want. To be more specific, we use class and ID selectors. Classes allow you to group multiple elements together, while IDs are strictly unique to a single element.

In CSS syntax, a class selector is preceded by a period (e.g., '.button-primary'), and an ID selector is preceded by a hash symbol (e.g., '#main-header'). It is a best practice to use class selectors for almost all styling to ensure your CSS is reusable across different parts of the page. Once an element is selected, you define a declaration block consisting of properties and values to change its appearance.

One of the first properties you will use is color, which changes text color, and background-color, which changes the element\'s background. CSS supports several ways to define colors. You can use standard color names like 'red' or 'blue', Hexadecimal codes like '#FF5733', or RGB/RGBA values which allow for specific color mixing and alpha transparency control. Mastering color application is the first step in visual design.''',
        codeSnippet: '''/* Tag Selector */
p {
    line-height: 1.6;
}

/* Class Selector (Reusable) */
.highlight-text {
    background-color: #ffff00;
    color: #000000;
}

/* ID Selector (Unique) */
#hero-section {
    background-color: rgba(0, 0, 0, 0.8);
}''',
      ),
      AppLesson(
        title: 'Understanding the Box Model',
        body: '''The CSS Box Model is arguably the most important concept to master when learning web design. Every single element on a web page, regardless of its shape, is technically a rectangular box. The box model dictates how these boxes are sized and how they interact with each other. It consists of four distinct layers from the inside out: Content, Padding, Border, and Margin.

The Content area is where your text or image actually sits. Surrounding the content is the Padding, which generates empty space inside the element\'s border. Next is the Border itself, which can be styled with various thicknesses, colors, and styles (solid, dashed). Finally, the Margin generates empty space outside the border, pushing other elements away and creating layout spacing.

By default, the width and height you assign to an element only apply to the Content area. This means adding padding and borders will increase the actual physical footprint of the element, often breaking layouts. To fix this, modern CSS universally uses the 'box-sizing: border-box' rule. This forces the browser to include padding and borders within the specified width, making layout math much more predictable.''',
        codeSnippet: '''/* The universal border-box fix */
* {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
}

.content-box {
    width: 300px;
    padding: 20px;       /* Space inside the border */
    border: 2px solid #333;
    margin-bottom: 15px; /* Space outside the border */
}''',
      ),
      AppLesson(
        title: 'Typography in Web Design',
        body: '''Typography forms the backbone of web communication. Good typography makes your site readable and visually appealing, while poor typography can drive users away instantly. In CSS, the 'font-family' property determines the typeface used. Because you cannot guarantee which fonts a user has installed on their device, you always define a font stack—a prioritized list of fonts ending with a generic fallback like 'sans-serif' or 'serif'.

Beyond typeface selection, CSS provides granular control over text sizing and spacing. The 'font-size' property dictates how large the text is. While you can use pixels (px), it is highly recommended to use relative units like 'rem' (root em) for better accessibility and scaling. The 'line-height' property adjusts the vertical spacing between lines of text, which is crucial for preventing dense, unreadable paragraphs.

Additionally, properties like 'font-weight' adjust the boldness of the text, while 'text-align' aligns text to the left, right, center, or justifies it. You can even control letter spacing and text transformation (forcing text to uppercase or lowercase). By thoughtfully adjusting these properties, you can create a clear visual hierarchy that guides the reader\'s eye smoothly down the page.''',
        codeSnippet: '''body {
    /* Utilizing a font stack */
    font-family: 'Helvetica Neue', Arial, sans-serif;
    font-size: 16px;
    line-height: 1.5;
}

h1 {
    font-size: 2.5rem;   /* 40px if root is 16px */
    font-weight: 700;
    text-align: center;
    letter-spacing: -0.5px;
    text-transform: uppercase;
}''',
      ),
      AppLesson(
        title: 'Flexbox Layouts',
        body: '''For years, positioning elements on a web page was a frustrating endeavor involving floats, clearfix hacks, and rigid tables. The Flexible Box Layout module, commonly known as Flexbox, revolutionized web design by providing a highly efficient way to lay out, align, and distribute space among items within a container. Flexbox is primarily designed for one-dimensional layouts—meaning it handles either a single row or a single column at a time.

To activate Flexbox, you simply apply 'display: flex' to a parent container. Immediately, all direct children of that container become flex items and align side-by-side in a row by default. You can change this main axis from horizontal to vertical using the 'flex-direction' property. This makes it incredibly easy to switch between a horizontal navigation bar on desktop and a vertical menu on mobile.

The true power of Flexbox lies in its alignment properties. 'justify-content' aligns items along the main axis, allowing you to easily center items or distribute space evenly between them. 'align-items' controls alignment along the cross axis, making the notoriously difficult task of vertical centering a one-line solution. Flexbox is an indispensable tool in every modern developer\'s toolkit.''',
        codeSnippet: '''.navbar {
    display: flex;
    flex-direction: row;
    justify-content: space-between; /* Pushes items to opposite edges */
    align-items: center;            /* Vertically centers items */
    background-color: #222;
    padding: 1rem;
}

.nav-links {
    display: flex;
    gap: 20px; /* Creates consistent spacing between flex items */
}''',
      ),
      AppLesson(
        title: 'The CSS Grid System',
        body: '''While Flexbox excels at one-dimensional layouts, CSS Grid is designed for complex two-dimensional layouts, allowing you to manipulate both rows and columns simultaneously. Grid provides a level of layout control that was previously impossible without relying on heavy CSS frameworks. You activate it by setting 'display: grid' on a parent container, converting its direct children into grid items.

Once Grid is active, you define the structure using the 'grid-template-columns' and 'grid-template-rows' properties. A powerful feature of Grid is the 'fr' (fractional) unit, which represents a fraction of the available space in the grid container. For example, setting three columns to '1fr 1fr 1fr' creates three perfectly equal columns that fluidly resize based on the screen width.

Grid also introduces the 'gap' property to easily manage spacing between rows and columns without fiddling with margins. Furthermore, you can precisely position individual items across multiple rows or columns using the 'grid-column' and 'grid-row' properties. By combining the macro-layout power of CSS Grid with the micro-layout flexibility of Flexbox, you can build practically any user interface imaginable.''',
        hasImage: true,
        codeSnippet: '''.grid-container {
    display: grid;
    /* Creates 3 columns: 25%, 50%, 25% of available space */
    grid-template-columns: 1fr 2fr 1fr;
    grid-gap: 20px;
    padding: 20px;
}

.header-item {
    /* Spans across all 3 columns */
    grid-column: 1 / -1; 
    background-color: #4CAF50;
    color: white;
    padding: 20px;
    text-align: center;
}''',
      ),
      AppLesson(
        title: 'Responsive Design and Media Queries',
        body: '''In today\'s device landscape, your website will be viewed on everything from giant 4K monitors to tiny smartwatches. Responsive Web Design is the practice of ensuring your application looks and functions perfectly across all screen sizes. The cornerstone of responsive design is the CSS Media Query. Media queries allow you to conditionally apply CSS rules only when certain viewport conditions, such as screen width, are met.

A standard media query block uses the '@media' rule followed by a condition, like '(max-width: 768px)'. Any CSS written inside this block will only execute when the browser window is 768 pixels wide or smaller. The industry standard approach is "Mobile First" design. This means you write your default CSS for mobile devices first, and then use 'min-width' media queries to progressively enhance the layout as the screen gets wider.

Beyond media queries, responsive design relies heavily on fluid sizing. Instead of using fixed pixel widths for layout containers, you should use percentages or relative viewport units (like 'vw' and 'vh'). Combining fluid widths, flexible media like images that scale, and robust media queries ensures your web application provides a seamless experience regardless of how the user accesses it.''',
        codeSnippet: '''/* Base styles (Mobile First) */
.container {
    width: 100%;
    padding: 10px;
}
.sidebar {
    display: none; /* Hide sidebar on small screens */
}

/* Tablet and larger screens */
@media (min-width: 768px) {
    .container {
        display: flex;
        padding: 20px;
    }
    .sidebar {
        display: block; /* Show sidebar */
        width: 250px;
    }
}''',
      ),
      AppLesson(
        title: 'CSS Transitions and Animations',
        body: '''Static web pages can feel rigid and unresponsive. Adding subtle animations and transitions provides vital user feedback and dramatically improves the overall user experience. CSS Transitions allow you to change property values smoothly over a specified duration, rather than instantaneously. The most common use case is animating a button when a user hovers over it with their mouse.

To create a transition, you must specify two things on the base element: the CSS property you want to animate (like 'background-color' or 'transform') and the duration of the effect (like '0.3s'). You can also define an easing function to make the animation accelerate or decelerate naturally. When the state changes, such as when the ':hover' pseudo-class is triggered, the transition handles the smooth interpolation between the old and new states.

For more complex, multi-step animations that play continuously or on loop, CSS provides Keyframe Animations. Using the '@keyframes' rule, you define exactly what styles should be applied at various percentages of the animation\'s timeline. You then bind this keyframe sequence to an element using the 'animation' property. When used tastefully, animations guide user attention and add a polished, professional feel to your work.''',
        codeSnippet: '''/* CSS Transition Example */
.button {
    background-color: #3498db;
    color: white;
    padding: 10px 20px;
    /* Transition background-color over 0.3 seconds */
    transition: background-color 0.3s ease-in-out, transform 0.2s;
}

.button:hover {
    background-color: #2980b9;
    transform: translateY(-2px); /* Slight lift effect */
}

/* Keyframe Animation Example */
@keyframes spin {
    from { transform: rotate(0deg); }
    to { transform: rotate(360deg); }
}

.loader {
    animation: spin 2s linear infinite;
}''',
      ),
      AppLesson(
        title: 'Variables and Custom Properties',
        body: '''As your CSS files grow, you will find yourself repeating the same values over and over—particularly brand colors, font families, and standard spacing measurements. In the past, developers had to rely on preprocessors like Sass to handle variables. Today, native CSS Custom Properties, often just called CSS Variables, provide a powerful built-in way to store and reuse specific values throughout your entire stylesheet.

CSS variables are defined by prefixing a custom name with two dashes (e.g., '--primary-color') and are typically placed within the ':root' pseudo-class to make them globally accessible across the document. To use the variable later, you wrap the custom name in the 'var()' function. If your brand\'s primary color ever changes, you only have to update the variable in one single place, and the change cascades instantly across the entire site.

What makes native CSS variables incredibly powerful compared to preprocessor variables is that they can be updated dynamically at runtime via JavaScript or media queries. This is the exact mechanism modern websites use to implement feature-rich Dark Mode toggles. By simply switching out the variable values for background and text colors based on a user\'s preference, the entire theme of the application shifts seamlessly.''',
        codeSnippet: ''':root {
    --primary-color: #6200ea;
    --text-main: #333333;
    --bg-main: #ffffff;
    --spacing-unit: 8px;
}

/* Dark mode theme override */
@media (prefers-color-scheme: dark) {
    :root {
        --text-main: #ffffff;
        --bg-main: #121212;
    }
}

body {
    background-color: var(--bg-main);
    color: var(--text-main);
    padding: calc(var(--spacing-unit) * 2);
}

h1 {
    color: var(--primary-color);
}''',
      ),
      AppLesson(
        title: 'Mini Project: Styling a Responsive Landing Page',
        body: '''It is time to apply all your CSS knowledge to a practical challenge. Your mini project is to style a full responsive landing page from scratch. Start by writing the HTML structure: a navigation bar, a hero section with a headline and call-to-action button, a feature grid showcasing three services, and a standard footer. Once the HTML skeleton is solid, link an external stylesheet and begin styling.

Begin with a global reset and establish your root variables for colors and typography. Use Flexbox to align the links in your navigation bar and vertically center the content inside your large hero section. For the features section, utilize CSS Grid to create a flexible three-column layout that evenly distributes the feature cards. Ensure you apply transitions to your buttons to make them interactive on hover.

The most critical part of this project is responsiveness. Implement a Mobile First approach, ensuring the site looks good on small screens with elements stacking vertically. Then, introduce a media query for tablet and desktop widths to activate your Grid and Flexbox horizontal layouts. When you finish, you will have a beautiful, professional-grade landing page that adapts flawlessly to any device viewport.''',
        codeSnippet: '''/* Final Project Structural CSS Hint */
:root {
    --brand-blue: #007bff;
    --surface: #f8f9fa;
}

/* Hero Section */
.hero {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    min-height: 70vh;
    text-align: center;
    padding: 2rem;
}

/* Feature Grid */
.features {
    display: grid;
    grid-template-columns: 1fr; /* Mobile view */
    gap: 2rem;
    padding: 2rem;
}

/* Desktop layout enhancement */
@media (min-width: 768px) {
    .features {
        grid-template-columns: repeat(3, 1fr);
    }
}''',
      ),
    ],
  ),
  AppCourse(
    id: 'web_development_javascript_101',
    title: 'JavaScript Programming Fundamentals',
    description: 'Learn the programming language of the web. Master variables, functions, logic, and DOM manipulation to make interactive websites.',
    instructor: 'Oluwaseun Adeyemi',
    category: 'Web Development',
    difficulty: 'Beginner',
    icon: Icons.code,
    color: Colors.amber,
    duration: '7h 00m',
    lessons: [
      AppLesson(
        title: 'What is JavaScript?',
        body: '''If HTML provides the structure and CSS provides the styling, JavaScript provides the interactive behavior of a website. JavaScript is a high-level, dynamic programming language that was originally created specifically to run inside web browsers. Today, it is arguably the most popular and versatile programming language in the world, powering complex frontend applications, server-side backends, and even mobile applications.

When a browser loads a web page, it parses the HTML and CSS, but it also executes any JavaScript code it finds. This code can dynamically change the HTML content, alter CSS styles, react to user inputs like clicks and keyboard presses, and communicate with external servers in the background. Without JavaScript, web pages are essentially static documents; with it, they become fully functioning software applications.

Throughout this course, you will learn the core fundamentals of programming using JavaScript. We will cover how to store data, make logical decisions, write reusable blocks of code, and eventually interact directly with the web page itself. Whether you want to build simple interactive widgets or complex Single Page Applications, a rock-solid understanding of vanilla JavaScript is absolutely mandatory.''',
        hasImage: true,
        codeSnippet: '''// Your first JavaScript code
// This logs a message to the browser's developer console
console.log("Hello, World!");

// This triggers a popup alert in the browser window
alert("Welcome to JavaScript Programming!");''',
      ),
      AppLesson(
        title: 'Variables and Data Types',
        body: '''At its core, programming is about storing, reading, and manipulating data. In JavaScript, we store data in memory using variables. You can think of a variable as a labeled box where you can put a specific value, and later retrieve or change that value by referencing the label. In modern JavaScript, we declare variables using the 'let' and 'const' keywords. The older 'var' keyword is considered outdated and should generally be avoided.

Use 'let' when you expect the value of the variable to change later in the program. Use 'const' (short for constant) when the value should never be reassigned after its initial declaration. Defaulting to 'const' is a widely accepted best practice as it prevents accidental data overwrites and makes your code more predictable. Only switch to 'let' when a reassignment is explicitly necessary.

JavaScript variables can hold different types of data. The primitive data types include Strings for text, Numbers for both integers and decimals, Booleans for true/false values, Undefined for variables that have been declared but not assigned a value, and Null for intentional absence of value. Because JavaScript is dynamically typed, you do not have to declare what type of data a variable will hold; the language figures it out automatically at runtime.''',
        codeSnippet: '''// Declaring variables
const greeting = "Hello there!"; // String
let currentScore = 100;          // Number
const isGameOver = false;        // Boolean

// Reassigning a 'let' variable
currentScore = 150; 

// The following would cause an error because greeting is a const
// greeting = "Hi!"; 

console.log(greeting, currentScore);''',
      ),
      AppLesson(
        title: 'Operators and Expressions',
        body: '''Once you have data stored in variables, you need ways to manipulate and evaluate that data. JavaScript provides a wide array of operators to perform these tasks. The most familiar are the arithmetic operators, which perform basic math. These include addition (+), subtraction (-), multiplication (*), division (/), and the modulo operator (%) which returns the remainder of a division operation.

In addition to math, we frequently need to compare values, which is where Comparison Operators come in. These operators evaluate two values and return a Boolean (true or false). They include greater than (>), less than (<), and equality. In JavaScript, it is crucial to understand the difference between loose equality (==) and strict equality (===). Loose equality attempts to convert types before comparing, which can lead to bizarre bugs. Strict equality compares both value AND type.

We also use Logical Operators to combine multiple boolean expressions together. The AND operator (&&) returns true only if both sides are true. The OR operator (||) returns true if at least one side is true. The NOT operator (!) simply flips a boolean value to its opposite. Mastering these operators allows you to build complex logical expressions that drive the decision-making capabilities of your applications.''',
        codeSnippet: '''const a = 10;
const b = "10";

// Arithmetic
const sum = a + 5; // 15
const remainder = a % 3; // 1

// Comparison
console.log(a == b);  // true (Loose equality converts string to number)
console.log(a === b); // false (Strict equality checks type, Number !== String)

// Logical
const isAdult = true;
const hasTicket = false;
console.log(isAdult && hasTicket); // false
console.log(isAdult || hasTicket); // true''',
      ),
      AppLesson(
        title: 'Control Flow and Conditionals',
        body: '''Programs rarely execute in a straight line from top to bottom. Based on user input or incoming data, your code needs to make decisions and execute different blocks of logic accordingly. This concept is called Control Flow. The fundamental tool for controlling flow in JavaScript is the 'if' statement. It evaluates a condition in parentheses, and if that condition is true, it executes the code block inside the curly braces.

You can extend this logic using 'else if' to check secondary conditions, and 'else' to provide a default fallback block if none of the preceding conditions were met. For scenarios where you need to check a single variable against many possible discrete values, JavaScript provides the 'switch' statement as a cleaner, more readable alternative to a long chain of 'else if' statements.

Another common control flow requirement is repetition, which is handled by loops. The 'for' loop is used when you know exactly how many times you want a block of code to run. It consists of an initialization, a condition that must remain true to keep looping, and an incrementer. The 'while' loop is used when you want code to run continuously as long as a specific condition evaluates to true, which is useful when the number of iterations is unknown.''',
        codeSnippet: '''const userAge = 20;

// If / Else structure
if (userAge < 13) {
    console.log("Access denied: child.");
} else if (userAge >= 13 && userAge < 18) {
    console.log("Access restricted: teen.");
} else {
    console.log("Access granted: adult.");
}

// For Loop example (runs 5 times)
for (let i = 0; i < 5; i++) {
    console.log("Iteration number: " + i);
}''',
      ),
      AppLesson(
        title: 'Functions and Scope',
        body: '''As your programs grow larger, writing everything in a single sequential block becomes unmanageable. Functions allow you to wrap a specific block of logic into a reusable package. You declare a function using the 'function' keyword, give it a name, and define parameters—variables that act as placeholders for the data the function will receive. When you call (execute) the function, you pass in real values called arguments.

Functions typically perform a calculation or task and then send data back out using the 'return' keyword. Once a return statement executes, the function stops immediately, and the returned value can be stored in a variable. In modern JavaScript, we also frequently use Arrow Functions, which provide a more concise syntax for writing functions and behave slightly differently regarding execution context.

A critical concept tied closely to functions is Scope. Scope dictates where variables are visible and accessible in your code. Variables declared with 'let' or 'const' inside a function or a block (like an if statement) have Local Scope; they cannot be accessed from outside that block. Variables declared outside of any function have Global Scope and can be accessed from anywhere. Managing scope correctly is vital to preventing naming collisions and bugs.''',
        codeSnippet: '''// Traditional Function Declaration
function calculateArea(width, height) {
    const area = width * height;
    return area;
}

const rectArea = calculateArea(5, 10); // Returns 50

// Modern Arrow Function Syntax
const multiply = (a, b) => {
    return a * b;
};

// Implicit return arrow function (one-liner)
const greet = name => `Hello, \${name}!`;

console.log(greet("Alice")); // "Hello, Alice!"''',
      ),
      AppLesson(
        title: 'Arrays and Iteration',
        body: '''While variables hold single values, Arrays allow you to store ordered lists of multiple values in a single variable. You create an array using square brackets, separating items with commas. Arrays can hold any data type, and you can even mix different types within the same array. Every item in an array has a numeric position called an index, and importantly, JavaScript arrays are zero-indexed, meaning the first item is at index 0.

Arrays come with powerful built-in methods to manipulate their contents. You can add items to the end using '.push()', remove from the end with '.pop()', or modify the beginning with '.unshift()' and '.shift()'. Knowing how to add, remove, and access data in arrays is a foundational skill you will use daily as a software developer.

Because arrays are lists, we frequently need to perform actions on every single item in the list. While you can use a standard 'for' loop, modern JavaScript provides powerful array iteration methods. The '.forEach()' method executes a provided function once for each element. More powerfully, the '.map()' method transforms each item and returns a brand new array, while '.filter()' returns a new array containing only items that pass a specific condition.''',
        hasImage: true,
        codeSnippet: '''const fruits = ["Apple", "Banana", "Cherry"];
console.log(fruits[1]); // Outputs "Banana"

fruits.push("Date"); // Adds Date to the end

// Modern Iteration: forEach
fruits.forEach(fruit => {
    console.log("I like " + fruit);
});

// Modern Transformation: map
const numbers = [1, 2, 3, 4];
const doubled = numbers.map(num => num * 2);
// doubled is now [2, 4, 6, 8]''',
      ),
      AppLesson(
        title: 'Objects and JSON',
        body: '''Arrays are great for ordered lists, but what if you need to represent a complex entity with multiple attributes, like a User or a Car? For this, JavaScript uses Objects. Objects are collections of key-value pairs. The keys (properties) act as labels, and the values can be any data type, including strings, numbers, arrays, or even functions (which are then called methods). You define an object using curly braces.

You access the data inside an object using dot notation (e.g., 'user.name') or bracket notation (e.g., 'user["name"]'). Bracket notation is particularly useful when the key you want to access is stored dynamically inside another variable. You can easily add new properties to an existing object or modify current ones simply by assigning a new value to the key.

JavaScript Objects are closely related to JSON (JavaScript Object Notation). JSON is a lightweight text-based data format used extensively to send data between servers and web applications. While JSON looks almost exactly like a JavaScript object, it is technically a string. JavaScript provides built-in methods, 'JSON.stringify()' and 'JSON.parse()', to easily convert objects to JSON strings for transmission, and convert received JSON strings back into usable objects.''',
        codeSnippet: '''// Creating an Object
const user = {
    firstName: "John",
    lastName: "Doe",
    age: 30,
    isAdmin: false,
    hobbies: ["Reading", "Coding"],
    // Method inside an object
    getFullName: function() {
        return this.firstName + " " + this.lastName;
    }
};

console.log(user.firstName); // "John"
console.log(user.getFullName()); // "John Doe"

// Adding a new property
user.email = "john@example.com";''',
      ),
      AppLesson(
        title: 'DOM Manipulation',
        body: '''Everything we have learned so far has dealt with pure logic and data. Now we connect that logic to the visual webpage. The Document Object Model (DOM) is a programming interface created by the browser that represents the HTML document as a tree of objects. JavaScript can interact with this tree to read, change, add, or delete HTML elements dynamically without needing to reload the page.

To manipulate the DOM, you first have to select the element you want to change. The most versatile methods for this are 'document.querySelector()' which returns the first element matching a CSS selector, and 'document.querySelectorAll()' which returns a list of all matching elements. Once you have a reference to the element stored in a variable, you can modify its properties.

You can change an element\'s text content using the '.textContent' property, or modify its HTML structure using '.innerHTML'. You can also dynamically manipulate CSS classes using the '.classList' API, which allows you to 'add', 'remove', or 'toggle' classes. This is the primary way JavaScript is used to create visual interactivity, such as opening modal windows or displaying hidden menus based on application state.''',
        codeSnippet: '''// Select an element by its ID
const heading = document.querySelector("#main-title");

// Change the text content
heading.textContent = "Title Updated via JavaScript!";

// Modify styles by manipulating classes
const alertBox = document.querySelector(".alert");
alertBox.classList.add("alert-danger"); // Adds the class
alertBox.classList.remove("hidden");    // Removes the class

// Create a new element and add it to the page
const newParagraph = document.createElement("p");
newParagraph.textContent = "I was dynamically created!";
document.body.appendChild(newParagraph);''',
      ),
      AppLesson(
        title: 'Event Handling',
        body: '''DOM manipulation is powerful, but it needs to be triggered by something. That trigger is usually an Event. Events are actions or occurrences that happen in the browser, such as a user clicking a button, submitting a form, pressing a keyboard key, or scrolling the page. JavaScript allows you to "listen" for these events and execute a specific function whenever they occur.

To listen for an event, you use the 'addEventListener()' method on a selected DOM element. This method takes two arguments: the name of the event to listen for (like 'click' or 'submit') and a callback function that will run when the event fires. The browser automatically passes an 'Event Object' to this callback function, which contains valuable information about the event, such as which key was pressed or the exact mouse coordinates.

A critical concept when handling form submissions is preventing the default behavior. By default, submitting an HTML form causes the browser to refresh the page and send data to a server. In modern JavaScript applications, we usually want to handle the data processing manually. Calling 'event.preventDefault()' inside your form submit event listener stops the page reload, allowing you to validate and process the data locally.''',
        codeSnippet: '''const button = document.querySelector("#submit-btn");

// Listen for a click event
button.addEventListener("click", function(event) {
    console.log("Button was clicked!");
    // The event object holds details
    console.log("Clicked at X:", event.clientX);
});

const form = document.querySelector("#login-form");

// Handling a form submission
form.addEventListener("submit", (event) => {
    // Prevent the page from reloading
    event.preventDefault();
    console.log("Form submitted via JS logic!");
});''',
      ),
      AppLesson(
        title: 'Mini Project: Interactive To-Do List',
        body: '''It is time to put all your JavaScript logic and DOM manipulation skills together by building a classic frontend project: an interactive To-Do List. This mini project will require you to use variables to store state, arrays to manage the list of tasks, DOM selection to grab user input, and event listeners to trigger actions. It is a comprehensive test of everything covered in this course.

Start by creating the HTML structure. You need a text input field for new tasks, an "Add Task" button, and an empty unordered list (ul) to display the items. In your JavaScript file, set up an event listener on the "Add Task" button. When clicked, the function should read the text value from the input field. Ensure you include a conditional check so you do not accidentally add empty strings as tasks.

Once you have the text, dynamically create a new 'li' element using 'document.createElement()'. Set its text content to the user\'s input, and append it to the unordered list in the DOM. To make it truly interactive, add a click event listener directly to the newly created 'li' element that toggles a 'completed' CSS class (which strikes through the text) whenever the user clicks on the specific task. Clear the input field afterward, and your app is complete!''',
        codeSnippet: '''const taskInput = document.querySelector("#task-input");
const addBtn = document.querySelector("#add-btn");
const taskList = document.querySelector("#task-list");

addBtn.addEventListener("click", () => {
    const taskText = taskInput.value;
    
    // Prevent adding empty tasks
    if (taskText.trim() === "") return;
    
    // Create new list item
    const li = document.createElement("li");
    li.textContent = taskText;
    
    // Add click event to toggle completion
    li.addEventListener("click", () => {
        li.classList.toggle("completed"); // Assume CSS handles .completed
    });
    
    // Append to DOM and clear input
    taskList.appendChild(li);
    taskInput.value = "";
});''',
      ),
    ],
  ),
  AppCourse(
    id: 'web_development_react_101',
    title: 'React.js Essentials',
    description: 'Dive into modern frontend development with React. Learn component architecture, state management, hooks, and declarative UI.',
    instructor: 'Ngozi Okafor',
    category: 'Web Development',
    difficulty: 'Intermediate',
    icon: Icons.memory,
    color: Colors.lightBlue,
    duration: '8h 30m',
    lessons: [
      AppLesson(
        title: 'Introduction to React & JSX',
        body: '''React is an open-source JavaScript library developed by Facebook for building dynamic user interfaces. Unlike vanilla JavaScript where you manually query and update the DOM directly, React uses a declarative approach. You simply describe what the UI should look like based on the current data state, and React automatically and efficiently updates the DOM to match that description whenever the data changes. This dramatically simplifies building complex applications.

React introduces a syntax extension for JavaScript called JSX. At first glance, JSX looks exactly like HTML written directly inside your JavaScript files. This might feel wrong initially, but JSX is incredibly powerful. It allows you to write UI structures while seamlessly embedding JavaScript logic directly within the markup using curly braces. Under the hood, a compiler like Babel converts this JSX into standard JavaScript functions that the browser can understand.

It is important to understand that JSX is stricter than HTML. For instance, all tags must be properly closed, even self-closing tags like images and inputs. Furthermore, because 'class' is a reserved keyword in JavaScript, you must use 'className' to assign CSS classes to elements in JSX. Understanding these minor syntax differences is the first step to mastering React development.''',
        hasImage: true,
        codeSnippet: '''import React from 'react';

// A simple React functional component using JSX
function WelcomeGreeting() {
  const userName = "Developer";
  
  return (
    <div className="greeting-container">
      <h1>Hello, {userName}!</h1>
      <p>Welcome to the world of React.</p>
      {/* Note the self-closing tag below */}
      <img src="logo.png" alt="React Logo" />
    </div>
  );
}

export default WelcomeGreeting;''',
      ),
      AppLesson(
        title: 'Components and Props',
        body: '''The core philosophy of React is Component-Based Architecture. Instead of building one massive page, you break your UI down into small, isolated, and reusable pieces called Components. A component can be as small as a custom button or as large as an entire navigation bar. Conceptually, components are just JavaScript functions that accept inputs and return JSX elements describing what should appear on the screen.

To make components reusable, they need to be able to accept dynamic data. In React, this data is passed downwards from a parent component to a child component via properties, universally known as "props". You pass props to a component similarly to how you pass attributes to an HTML tag. The child component then receives these props as an object argument and can render the data dynamically.

A crucial rule in React is that props are strictly read-only. A component must never attempt to modify its own props. This ensures a unidirectional data flow—data always flows downwards from parent to child, making it much easier to debug where data is coming from and how it changes. If a child needs to communicate back to a parent, it does so by calling a function passed down to it via props.''',
        codeSnippet: '''// Child Component
function UserProfile(props) {
  return (
    <div className="card">
      <h2>{props.name}</h2>
      <p>Role: {props.role}</p>
    </div>
  );
}

// Parent Component passing Props
function App() {
  return (
    <div>
      <h1>Team Members</h1>
      {/* Reusing the component with different props */}
      <UserProfile name="Ngozi" role="Senior Engineer" />
      <UserProfile name="Chinedu" role="Designer" />
    </div>
  );
}''',
      ),
      AppLesson(
        title: 'State and the useState Hook',
        body: '''While props are used to pass static data down to child components, applications need a way to handle data that changes over time, like a counter incrementing or text entered into an input field. In React, data that changes and directly affects the UI is called State. When a component\'s state changes, React automatically triggers a re-render of that component to update the interface.

In modern functional React, state is managed using the 'useState' Hook. A Hook is simply a special function that lets you "hook into" React internal features. You import 'useState' from React and call it at the top level of your component. It takes an initial value and returns an array containing exactly two items: the current state value, and a function used to update that value. We typically use array destructuring to name these variables cleanly.

You must never modify the state variable directly (e.g., 'count = 5'). You must always use the setter function provided by the hook (e.g., 'setCount(5)'). Calling the setter function is what signals to React that the state has mutated, prompting it to calculate the differences and efficiently update the real DOM. Mastering state is the key to building truly interactive React applications.''',
        codeSnippet: '''import React, { useState } from 'react';

function Counter() {
  // Declare a state variable named 'count', initialized to 0
  const [count, setCount] = useState(0);

  return (
    <div>
      <p>You clicked the button {count} times.</p>
      {/* Update state when the button is clicked */}
      <button onClick={() => setCount(count + 1)}>
        Click me
      </button>
    </div>
  );
}''',
      ),
      AppLesson(
        title: 'Handling Events in React',
        body: '''Handling events in React is very similar to handling events in vanilla DOM elements, but with some key syntactic differences. First, React events are named using camelCase, rather than lowercase. For example, you use 'onClick' instead of 'onclick', and 'onSubmit' instead of 'onsubmit'. Second, with JSX you pass a function as the event handler directly, rather than passing a string.

When an event occurs, React passes a synthetic event object to your event handler function. This synthetic event acts as a cross-browser wrapper around the browser\'s native event, ensuring that events behave identically across all browsers. You can still access standard properties and methods, such as 'event.target.value' to get input data, or 'event.preventDefault()' to stop form submissions.

A common pattern in React is defining the event handler function inside the component before the return statement, and then passing a reference to that function to the JSX element. It is crucial to pass the function reference without executing it immediately. Writing 'onClick={handleClick}' is correct, whereas 'onClick={handleClick()}' is incorrect because it will execute the function immediately when the component renders, causing a loop.''',
        codeSnippet: '''import React from 'react';

function FormSubmitter() {
  // Define handler function
  const handleSubmit = (event) => {
    event.preventDefault(); // Stop page reload
    console.log("Form was submitted safely.");
  };

  return (
    <form onSubmit={handleSubmit}>
      <input type="text" placeholder="Enter data..." />
      {/* The button click triggers the form onSubmit */}
      <button type="submit">Submit Data</button>
    </form>
  );
}''',
      ),
      AppLesson(
        title: 'Conditional Rendering',
        body: '''In React, you often need to render different UI elements or components depending on the current state of the application. This is known as Conditional Rendering. Because React components are just JavaScript functions that return JSX, you can use standard JavaScript control flow operators like 'if' statements directly within your components to decide what JSX to return.

However, writing full 'if' statements inside the JSX return block itself is not possible. Instead, developers heavily rely on two JavaScript operators for inline conditional rendering. The first is the Logical AND operator (&&). It is perfectly suited for situations where you want to render a specific block of JSX if a condition is true, and render absolutely nothing if it is false.

The second is the Ternary Operator (condition ? true : false). This is the go-to tool when you need to render one block of JSX if a condition is true, and an entirely different block if it is false, such as swapping between a "Login" button and a "Logout" button depending on the user\'s authentication state. These inline operators make JSX templates highly expressive and concise.''',
        codeSnippet: '''function UserDashboard({ isLoggedIn, unreadMessages }) {
  return (
    <div>
      {/* Ternary Operator: Renders A or B */}
      {isLoggedIn ? (
        <h2>Welcome back to your dashboard!</h2>
      ) : (
        <h2>Please log in to continue.</h2>
      )}

      {/* Logical AND: Renders conditionally or renders nothing */}
      {unreadMessages > 0 && (
        <div className="alert">
          You have {unreadMessages} new messages!
        </div>
      )}
    </div>
  );
}''',
      ),
      AppLesson(
        title: 'Lists and Keys',
        body: '''Web applications frequently need to render lists of data, such as a feed of blog posts or a grid of products. In vanilla JavaScript, you might use a loop to manually generate HTML strings. In React, you use the standard JavaScript '.map()' array method to iterate over an array of data and return an array of JSX elements. React will automatically render this array of elements to the screen.

When you render a list of elements using map, React strictly requires that you assign a special 'key' prop to the outermost element generated in the list. This key must be a unique identifier, usually an ID from your database, and it must remain stable across re-renders. You should generally avoid using the array index as the key if the list items can be reordered, added, or deleted.

Why are keys so important? React uses a virtual representation of the DOM to optimize updates. When a list changes, React uses these keys to quickly identify which specific items have been added, changed, or removed. Without unique keys, React loses track of the elements and defaults to inefficiently tearing down and rebuilding the entire list, which severely impacts performance and can cause bugs with component state.''',
        hasImage: true,
        codeSnippet: '''function ProductList() {
  const products = [
    { id: 101, name: "Laptop", price: 999 },
    { id: 102, name: "Mouse", price: 25 },
    { id: 103, name: "Keyboard", price: 75 }
  ];

  return (
    <ul>
      {/* Iterating through data to generate UI */}
      {products.map((product) => (
        // The 'key' prop is mandatory on the top element
        <li key={product.id}>
          {product.name} - \${product.price}
        </li>
      ))}
    </ul>
  );
}''',
      ),
      AppLesson(
        title: 'The useEffect Hook',
        body: '''React components are designed to be pure functions of their state and props, primarily focused on returning UI. However, most applications need to perform "side effects"—operations that reach outside the component, such as fetching data from an API, setting up a subscription, or manually manipulating the DOM. In functional components, these side effects are handled using the 'useEffect' Hook.

The useEffect hook takes two arguments: a callback function containing your side effect logic, and an optional dependency array. By default, if you omit the dependency array, the effect will run after every single render of the component. This is rarely what you want and can easily cause infinite loops if your effect also updates state. To control when the effect runs, you provide the dependency array.

If you pass an empty array ([]), the effect runs exactly once when the component first mounts, making it the perfect place to initiate API data fetches. If you place variables inside the array (like [count, userId]), the effect will only re-run when those specific variables change between renders. Furthermore, the effect function can optionally return a cleanup function, which React will execute when the component unmounts to prevent memory leaks.''',
        codeSnippet: '''import React, { useState, useEffect } from 'react';

function UserProfile({ userId }) {
  const [userData, setUserData] = useState(null);

  useEffect(() => {
    // This effect runs whenever 'userId' changes
    console.log("Fetching data for user:", userId);
    
    // Simulated API call
    fetch(`https://api.example.com/users/\${userId}`)
      .then(response => response.json())
      .then(data => setUserData(data));
      
    // Optional Cleanup function
    return () => {
      console.log("Cleaning up previous request");
    };
  }, [userId]); // Dependency array

  if (!userData) return <p>Loading...</p>;
  return <h2>{userData.name}</h2>;
}''',
      ),
      AppLesson(
        title: 'Forms and Controlled Components',
        body: '''In standard HTML, form elements like input, textarea, and select maintain their own internal state based on user input. In React, we prefer to keep a single "source of truth" by allowing the React component to control that state. Components that handle form data this way are known as Controlled Components. Instead of asking the DOM for the input value when the form is submitted, the React state constantly syncs with the input field.

To create a controlled input, you bind the input\'s 'value' attribute directly to a piece of React state. Next, you provide an 'onChange' event handler that updates the state variable whenever the user types a keystroke. The cycle looks like this: the user types, the onChange handler fires, state updates, the component re-renders, and the input reflects the new state value.

While this means you have to write a bit more boilerplate code for every input field, the advantages are massive. Because the state is always up-to-date with the UI, you can easily implement instant inline validation, enforce input formatting (like forcing uppercase characters), or conditionally disable submit buttons if the form data is incomplete—all without querying the DOM directly.''',
        codeSnippet: '''import React, { useState } from 'react';

function ControlledForm() {
  // React state holds the form data
  const [email, setEmail] = useState('');

  const handleSubmit = (e) => {
    e.preventDefault();
    alert(`Submitting Email: \${email}`);
  };

  return (
    <form onSubmit={handleSubmit}>
      <label>
        Email Address:
        <input 
          type="email" 
          value={email} // Value controlled by state
          onChange={(e) => setEmail(e.target.value)} // State updated on keystroke
        />
      </label>
      <button type="submit" disabled={email.length === 0}>
        Subscribe
      </button>
    </form>
  );
}''',
      ),
      AppLesson(
        title: 'Context API Basics',
        body: '''As a React application grows, you will often find yourself passing props down through multiple layers of components just to get data to a deeply nested child. This painful and messy pattern is known as "prop drilling". While passing props is fine for a few layers, it becomes unmanageable for global data like user authentication status, theme preferences, or language settings. 

The React Context API solves this problem by allowing you to share values like these globally across the component tree without having to explicitly pass a prop through every level. First, you create a Context object using 'createContext()'. Next, you wrap a parent component with a Context Provider and pass it a 'value'. Any component nested inside this Provider can access that value directly.

To read the context value in a child component, you simply import the Context object and use the 'useContext' hook. React will automatically search up the component tree to find the nearest matching Provider and extract the value. While incredibly useful for global state, Context should not be overused for every piece of data, as it bypasses the standard unidirectional data flow and can make component reuse more difficult.''',
        codeSnippet: '''import React, { createContext, useContext, useState } from 'react';

// 1. Create the Context
const ThemeContext = createContext();

export function App() {
  const [theme, setTheme] = useState('dark');

  return (
    // 2. Wrap components in Provider and pass value
    <ThemeContext.Provider value={theme}>
      <div className={`app-container \${theme}`}>
        <Header />
        <button onClick={() => setTheme(theme === 'dark' ? 'light' : 'dark')}>
          Toggle Theme
        </button>
      </div>
    </ThemeContext.Provider>
  );
}

// 3. Child component consumes context directly
function Header() {
  const currentTheme = useContext(ThemeContext);
  return <h1>The current theme is {currentTheme}</h1>;
}''',
      ),
      AppLesson(
        title: 'Mini Project: Weather Dashboard',
        body: '''To solidify your understanding of React, you will build a functional Weather Dashboard. This project requires combining Component Architecture, State (useState), Side Effects (useEffect), and conditional rendering. You will create an application that allows a user to search for a city and instantly see the current weather conditions fetched from a public API.

Begin by setting up a main App component and designing a controlled form for the search input. Create state variables to hold the user\'s search query, the retrieved weather data, a loading status, and any potential error messages. Use the 'useEffect' hook to trigger the fetch request when the form is submitted. While the fetch request is pending, conditionally render a loading spinner to the user.

Once the data is successfully retrieved, pass it down as props to a separate 'WeatherDisplay' child component. This component should display the city name, temperature, and a description. Ensure you handle errors gracefully; if the user searches for a city that doesn't exist, the API will return an error, and your UI should display a polite "City not found" message rather than crashing completely. This project mimics real-world frontend development patterns perfectly.''',
        codeSnippet: '''// Core structure for the Mini Project
import React, { useState } from 'react';

export default function WeatherApp() {
  const [city, setCity] = useState('');
  const [weatherData, setWeatherData] = useState(null);

  const fetchWeather = async (e) => {
    e.preventDefault();
    // In reality, use a real API like OpenWeatherMap
    const response = await fetch(`https://api.example.com/weather?q=\${city}`);
    const data = await response.json();
    setWeatherData(data);
  };

  return (
    <div className="weather-app">
      <form onSubmit={fetchWeather}>
        <input 
          type="text" 
          value={city} 
          onChange={e => setCity(e.target.value)} 
          placeholder="Enter city..."
        />
        <button type="submit">Search</button>
      </form>
      
      {/* Conditional rendering of child component */}
      {weatherData && <WeatherDisplay data={weatherData} />}
    </div>
  );
}''',
      ),
    ],
  ),
  AppCourse(
    id: 'web_development_node_101',
    title: 'Node.js and API Development',
    description: 'Move to the backend! Learn how to use JavaScript on the server with Node.js, Express, and build robust RESTful APIs.',
    instructor: 'Ibrahim Musa',
    category: 'Web Development',
    difficulty: 'Intermediate',
    icon: Icons.dns,
    color: Colors.green,
    duration: '7h 45m',
    lessons: [
      AppLesson(
        title: 'Intro to Backend & Node.js',
        body: '''For years, JavaScript was strictly confined to running inside the web browser. If you wanted to build a backend server, interact with a database, or handle file systems, you had to learn a different language like PHP, Python, or Ruby. That changed in 2009 with the release of Node.js. Node is a runtime environment that allows you to execute JavaScript code directly on your computer or a server, completely independent of a browser.

Node is built on Google Chrome\'s incredibly fast V8 JavaScript engine. However, because it runs on the server, it has access to operating system features that the browser restricts for security reasons. With Node, your JavaScript code can read and write files on the hard drive, manage network requests, and connect directly to databases. This allows developers to use a single language (JavaScript) across the entire stack.

A defining characteristic of Node.js is its asynchronous, event-driven architecture. Traditional server languages often create a new thread for every incoming request, which consumes significant memory. Node operates on a single thread using an event loop. When a time-consuming task like a database query occurs, Node delegates the work and continues processing other requests without blocking. This makes Node exceptionally efficient for handling thousands of concurrent connections.''',
        hasImage: true,
      ),
      AppLesson(
        title: 'Modules and the File System',
        body: '''Because backend applications can grow massive, Node.js uses a modular system to keep code organized. A module is simply a JavaScript file containing related code. Node provides a set of built-in core modules, but you can also create your own custom modules. To use code from one file in another, you must explicitly export the functions or variables, and then import (require) them where needed.

One of the most important core modules is the File System (fs) module, which allows you to interact with the server\'s hard drive. Using the fs module, you can read text from files, write new files, delete files, and manage directories. The module provides both synchronous and asynchronous methods. In professional Node development, we almost exclusively use the asynchronous methods to ensure we never block the main event loop.

Modern Node development utilizes Promises and async/await syntax to handle these asynchronous operations cleanly, avoiding the infamous "callback hell". By leveraging the fs module, you can build applications that process log files, handle user uploads, or generate dynamic reports directly on the server file system.''',
        codeSnippet: '''// Importing the File System module (Promises version)
const fs = require('fs/promises');

async function manageFiles() {
  try {
    // Asynchronously writing to a file
    await fs.writeFile('message.txt', 'Hello Node.js!');
    console.log('File created successfully.');

    // Asynchronously reading the file
    const data = await fs.readFile('message.txt', 'utf8');
    console.log('File contents:', data);
  } catch (error) {
    console.error('An error occurred:', error);
  }
}

manageFiles();''',
      ),
      AppLesson(
        title: 'Creating a Basic Web Server',
        body: '''At its core, a backend web application is simply a server that listens for incoming HTTP requests and responds with data. Node provides a built-in core module called 'http' that allows you to create a raw web server from scratch. When you create a server, you define a callback function that executes every time a request is received. This function has access to the Request object (incoming data) and the Response object (outgoing data).

Within this callback function, you must inspect the Request object to determine what the client is asking for, typically by looking at the URL and the HTTP method (GET, POST, etc.). Based on that information, you construct a response. This involves setting the correct HTTP Status Code (like 200 for OK, or 404 for Not Found), setting headers to inform the client what type of data is coming, and sending the actual body payload.

While it is entirely possible to build complex applications using only the raw 'http' module, it requires a tremendous amount of manual configuration. You have to manually parse URLs, extract query parameters, stringify JSON, and manage routing with giant switch statements. Understanding the raw 'http' module is vital for foundational knowledge, but modern developers use frameworks to simplify the process.''',
        codeSnippet: '''const http = require('http');

// Create the server
const server = http.createServer((req, res) => {
  // Check the requested URL
  if (req.url === '/' && req.method === 'GET') {
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({ message: 'Welcome to the API' }));
  } else {
    res.writeHead(404, { 'Content-Type': 'text/plain' });
    res.end('Route not found');
  }
});

// Start listening on a specific port
const PORT = 3000;
server.listen(PORT, () => {
  console.log(`Server running on port \${PORT}`);
});''',
      ),
      AppLesson(
        title: 'Introduction to Express.js',
        body: '''Express.js is a fast, unopinionated, and minimalist web framework for Node.js. It sits on top of the native 'http' module, abstracting away the tedious boilerplate code and providing a robust set of features for web and mobile applications. It is the absolute industry standard for building REST APIs in Node.js, forming the "E" in popular technology stacks like MERN and MEAN.

To use Express, you first initialize an application instance. This instance provides simple methods corresponding to HTTP verbs, such as 'app.get()', 'app.post()', and 'app.delete()'. Express makes routing incredibly elegant. Instead of writing complex if-else logic to check URLs, you simply declare the path and provide a callback function to handle the request.

Express also drastically simplifies the process of sending responses. Instead of manually setting headers and stringifying objects, you can simply call 'res.json()', and Express automatically handles the formatting and headers for you. It also seamlessly parses incoming requests, easily extracting query parameters or dynamic path variables, allowing you to focus on writing business logic rather than parsing HTTP strings.''',
        codeSnippet: '''const express = require('express');
const app = express();

// A simple GET route
app.get('/api/users', (req, res) => {
  const users = [
    { id: 1, name: 'Alice' },
    { id: 2, name: 'Bob' }
  ];
  // Express handles stringifying and setting headers automatically
  res.json(users); 
});

// Dynamic routing with path variables
app.get('/api/users/:id', (req, res) => {
  const userId = req.params.id; // Extracting the dynamic ID
  res.json({ message: `Fetching user with ID \${userId}` });
});

app.listen(3000, () => console.log('Express server running!'));''',
      ),
      AppLesson(
        title: 'Routing and Organization',
        body: '''As your Express application grows from a few routes to hundreds, keeping all your route definitions inside a single 'server.js' file becomes an unmaintainable mess. Express solves this problem using the Express Router. The Router acts as a mini-application, complete with its own routing and middleware capabilities, which can be easily integrated into the main application.

Using the Router allows you to organize your code by resource or feature. For example, you can create a 'userRoutes.js' file that exclusively handles all GET, POST, and DELETE requests related to users. Inside this file, you create a Router instance, define the routes on it, and then export it. In your main server file, you import the router and mount it to a specific base path, such as '/api/users'.

This modular approach enforces a clean architecture. It makes team collaboration much easier, as different developers can work on different route files simultaneously without causing merge conflicts. Furthermore, it sets the stage for implementing controller functions—moving the actual business logic out of the route definition completely and into dedicated controller files, resulting in highly readable and testable code.''',
        codeSnippet: '''// --- routes/productRoutes.js ---
const express = require('express');
const router = express.Router();

// Note: The base path is omitted here
router.get('/', (req, res) => {
  res.send('Get all products');
});

router.post('/', (req, res) => {
  res.send('Create a new product');
});

module.exports = router;

// --- server.js ---
const express = require('express');
const productRoutes = require('./routes/productRoutes');
const app = express();

// Mount the router to a specific base path
app.use('/api/products', productRoutes);

app.listen(3000);''',
      ),
      AppLesson(
        title: 'Middleware Concepts',
        body: '''Middleware is arguably the most fundamental and powerful concept in Express.js. Middleware functions are simply functions that have access to the request object (req), the response object (res), and a special 'next' function in the application\'s request-response cycle. When a request hits your server, it passes through a pipeline of middleware functions before the final response is sent.

A middleware function can execute arbitrary code, make changes to the request and response objects, end the request-response cycle entirely, or call the 'next()' function to pass control to the next middleware in the stack. If a middleware function does not send a response, it MUST call 'next()', otherwise the request will hang indefinitely and the client will experience a timeout.

Middleware is used for practically everything in an Express app. You use it to parse incoming JSON bodies ('express.json()'), log request data to the console, authenticate users (checking if a valid token is present before allowing access to a route), and handle errors globally. By chaining small, focused middleware functions together, you can build incredibly complex request processing pipelines efficiently.''',
        hasImage: true,
        codeSnippet: '''const express = require('express');
const app = express();

// Custom Middleware function for logging
const logger = (req, res, next) => {
  console.log(`[\${new Date().toISOString()}] \${req.method} to \${req.url}`);
  // Pass control to the next function
  next(); 
};

// Apply middleware globally
app.use(logger);

// Built-in middleware to parse JSON bodies
app.use(express.json());

app.get('/', (req, res) => {
  res.send('Middleware in action!');
});''',
      ),
      AppLesson(
        title: 'Handling REST API Requests (GET/POST)',
        body: '''REST (Representational State Transfer) is an architectural style for designing networked applications. A RESTful API organizes data into resources and uses standard HTTP methods to manipulate them. The GET method is used strictly for retrieving data. When handling a GET request, your server should query a database and return the relevant data as JSON. GET requests should never alter the state of the database.

To create new resources, you handle POST requests. When a client sends a POST request, they include a payload of data (the body). Because Express does not parse JSON bodies by default, you must use the 'express.json()' middleware. Once parsed, you extract this data from 'req.body', validate it, save it to your database, and return a 201 Created status code along with the newly created resource.

For full CRUD (Create, Read, Update, Delete) capability, you also implement PUT or PATCH for updating resources, and DELETE for removing them. A well-designed REST API utilizes proper HTTP status codes, ensuring the client knows exactly what happened. For example, returning a 400 Bad Request if the client forgets to send a required field, or a 404 if they try to access an ID that doesn\'t exist.''',
        codeSnippet: '''app.post('/api/tasks', (req, res) => {
  const { title, completed } = req.body;

  // Basic Validation
  if (!title) {
    return res.status(400).json({ error: 'Task title is required' });
  }

  const newTask = {
    id: Math.floor(Math.random() * 1000), // Fake ID generation
    title: title,
    completed: completed || false
  };
  
  // Here you would save the task to a database...

  // 201 indicates a resource was successfully created
  res.status(201).json(newTask); 
});''',
      ),
      AppLesson(
        title: 'Connecting to a Database (MongoDB)',
        body: '''While saving data to memory or a file is fine for learning, real applications require a robust database. In the Node ecosystem, MongoDB—a NoSQL database—is incredibly popular because it stores data in JSON-like documents, making it a natural fit for JavaScript applications. Instead of rigid tables and rows like SQL, MongoDB uses flexible collections and documents.

To connect Node.js to MongoDB, developers almost universally use an Object Data Modeling (ODM) library called Mongoose. Mongoose provides a straightforward, schema-based solution to model your application data. It includes built-in type casting, validation, and query building. You begin by defining a Schema, which dictates the shape of your documents, including which fields are required and what data types they accept.

Once the Schema is defined, you compile it into a Model. This Model provides powerful asynchronous methods to interact with the database. You use 'Model.find()' to retrieve documents, 'Model.create()' to insert new ones, and 'Model.findByIdAndUpdate()' to modify existing records. Mongoose handles the complex database communication under the hood, allowing you to interact with your data as standard JavaScript objects.''',
        codeSnippet: '''const mongoose = require('mongoose');

// Define the Schema
const userSchema = new mongoose.Schema({
  name: { type: String, required: true },
  email: { type: String, required: true, unique: true },
  age: { type: Number, min: 18 }
});

// Create the Model
const User = mongoose.model('User', userSchema);

// Example of querying the database
async function createNewUser() {
  try {
    const newUser = await User.create({ 
      name: 'Ibrahim', 
      email: 'ibrahim@example.com', 
      age: 28 
    });
    console.log('User saved:', newUser);
  } catch (err) {
    console.error('Validation failed:', err.message);
  }
}''',
      ),
      AppLesson(
        title: 'Error Handling and Validation',
        body: '''A professional backend must be completely resilient. If a user sends malformed data or a database connection drops, the server must not crash; it should catch the error and send an appropriate response to the client. In Express, you should wrap all asynchronous route handler logic in 'try...catch' blocks. If an error occurs, you catch it and pass it to the 'next()' function.

Express has a special type of middleware for centralized error handling. An error-handling middleware is defined with exactly four arguments: (err, req, res, next). By placing this middleware at the very bottom of your application stack, you can catch any errors passed down from your routes. This allows you to format all error responses consistently and prevent the exposure of sensitive stack traces in production environments.

Equally important is data validation. You must never trust data sent by the client. Before attempting to save data to the database, you must validate it to ensure it meets your requirements (e.g., checking if an email is valid, or a password is long enough). While Mongoose handles database validation, using libraries like Joi or express-validator to validate data at the route level prevents bad requests from ever reaching the database layer.''',
        codeSnippet: '''// Async Route Handler with Try/Catch
app.get('/api/data', async (req, res, next) => {
  try {
    const data = await riskyDatabaseOperation();
    res.json(data);
  } catch (error) {
    // Pass the error to the global handler
    next(error); 
  }
});

// Global Error Handling Middleware (must be defined last)
app.use((err, req, res, next) => {
  console.error(err.stack); // Log for the developer
  
  // Send a clean response to the client
  res.status(500).json({
    status: 'error',
    message: err.message || 'Internal Server Error'
  });
});''',
      ),
      AppLesson(
        title: 'Mini Project: RESTful Book API',
        body: '''Your mini project is to build a fully functional RESTful API for a Bookstore. This project will combine Express routing, middleware, JSON body parsing, and standard HTTP methods. For this exercise, you do not need to connect a real database; you will simulate a database using an in-memory JavaScript array to store the book objects. This focuses the exercise on API design rather than database configuration.

Start by initializing an Express application and configuring it to parse JSON bodies. Create a modular router for your '/api/books' endpoints. Implement a GET route to retrieve all books, and a GET route to retrieve a single book by its ID parameter (handle the 404 case if the ID is not found). Next, build a POST route to add a new book, ensuring you validate that both 'title' and 'author' are provided in the request body.

Finally, implement a PUT route to update a book and a DELETE route to remove one. Add a custom middleware function that logs the time and HTTP method of every request to the console. When complete, test your API thoroughly using a tool like Postman or Insomnia. You have successfully engineered a backend API architecture that mirrors real-world production systems.''',
        codeSnippet: '''const express = require('express');
const app = express();
app.use(express.json()); // Parse JSON bodies

let books = [{ id: 1, title: 'Things Fall Apart', author: 'Chinua Achebe' }];

// Get all books
app.get('/api/books', (req, res) => {
  res.json(books);
});

// Create a book
app.post('/api/books', (req, res) => {
  const { title, author } = req.body;
  if (!title || !author) {
    return res.status(400).json({ error: 'Title and author required' });
  }
  const newBook = { id: books.length + 1, title, author };
  books.push(newBook);
  res.status(201).json(newBook);
});

app.listen(3000, () => console.log('Book API active on port 3000'));''',
      ),
    ],
  ),
  AppCourse(
    id: 'web_development_security_101',
    title: 'Web Security Fundamentals',
    description: 'Protect your web applications from malicious attacks. Learn about XSS, CSRF, SQL Injection, and secure authentication practices.',
    instructor: 'Folake Ojo',
    category: 'Web Development',
    difficulty: 'Advanced',
    icon: Icons.security,
    color: Colors.red,
    duration: '6h 30m',
    lessons: [
      AppLesson(
        title: 'The Web Security Landscape',
        body: '''When you deploy a web application to the internet, it becomes accessible to anyone in the world, including malicious actors. Web security is the practice of defending web applications from these threats, which aim to steal sensitive data, disrupt services, or compromise underlying server infrastructure. Understanding security is not optional for developers; a single vulnerability can destroy a company\'s reputation and result in massive financial penalties.

The Open Web Application Security Project (OWASP) regularly publishes the "OWASP Top 10", a globally recognized document outlining the most critical security risks to web applications. This list consistently includes vulnerabilities like Injection, Broken Authentication, Sensitive Data Exposure, and Cross-Site Scripting (XSS). Familiarizing yourself with the OWASP Top 10 is the foundational step in developing a security-first mindset.

The golden rule of web security is simple: Never trust user input. Every piece of data sent from the client browser to the server—whether it is a form submission, a URL parameter, or an HTTP header—must be treated as potentially dangerous. Implementing strict validation, sanitization, and encryption strategies across all layers of your application is essential for building a robust defense-in-depth architecture.''',
        hasImage: true,
      ),
      AppLesson(
        title: 'Cross-Site Scripting (XSS)',
        body: '''Cross-Site Scripting, or XSS, is one of the most common and dangerous vulnerabilities on the web. It occurs when an application includes untrusted data in a web page without proper validation or escaping. This allows an attacker to inject malicious JavaScript code into the web pages viewed by other users. When the victim\'s browser renders the page, it executes the attacker\'s script, assuming it is legitimate code from the website.

There are two main types of XSS. Stored XSS occurs when the malicious script is permanently saved on the target server, such as in a forum post or a comment section. When other users view the post, the script runs. Reflected XSS occurs when the injected script is reflected off the web server immediately, such as in an error message or search result containing an un-sanitized query parameter.

The impact of XSS is severe; attackers can steal session cookies to hijack user accounts, redirect users to phishing sites, or force users to perform actions against their will. The primary defense against XSS is strict contextual output encoding. Before rendering any user-supplied data in the browser, all HTML control characters (like <, >, and &) must be converted into their safe HTML entity equivalents (like &lt;, &gt;, and &amp;). Modern frameworks like React handle most of this escaping automatically.''',
        codeSnippet: '''// DANGEROUS: Susceptible to Reflected XSS
// If a user navigates to /search?query=<script>alert('Hacked!')</script>
app.get('/search', (req, res) => {
  const query = req.query.query;
  // The script executes directly in the browser!
  res.send(`<h1>Search results for: \${query}</h1>`); 
});

// SAFE APPROACH: Using a templating engine or library that auto-escapes
// OR sanitizing the input manually before rendering.
const sanitizeHtml = require('sanitize-html');
app.get('/search-safe', (req, res) => {
  const cleanQuery = sanitizeHtml(req.query.query);
  res.send(`<h1>Search results for: \${cleanQuery}</h1>`);
});''',
      ),
      AppLesson(
        title: 'Cross-Site Request Forgery (CSRF)',
        body: '''Cross-Site Request Forgery (CSRF) is an attack that forces an authenticated user to execute unwanted actions on a web application where they are currently logged in. Unlike XSS, which exploits the user\'s trust in a specific website, CSRF exploits a website\'s trust in a user\'s browser. Because browsers automatically send session cookies with every request to a domain, attackers can trick the browser into sending forged requests.

Imagine a user is logged into their banking app. An attacker sends them an email with a hidden image tag pointing to the bank\'s money transfer URL. When the user opens the email, their browser automatically attempts to load the image, unknowingly sending a GET request to the bank, complete with their valid authentication cookies. If the bank uses GET requests for state-changing actions, the transfer succeeds maliciously.

To mitigate CSRF, developers must ensure state-changing operations strictly require POST, PUT, or DELETE methods. More importantly, applications should implement Anti-CSRF Tokens. The server generates a unique, cryptographically strong, and unpredictable token for the user\'s session. This token must be included as a hidden field in every form submission or as a custom HTTP header. The server verifies this token before processing the request, blocking forged requests that lack it.''',
        codeSnippet: '''// Express configuration with csurf middleware to prevent CSRF
const csrf = require('csurf');
const csrfProtection = csrf({ cookie: true });

// Route to render a form, passing the token to the template
app.get('/transfer', csrfProtection, (req, res) => {
  res.render('transferForm', { 
    csrfToken: req.csrfToken() // Pass token to frontend
  });
});

// The POST route automatically requires and validates the token
app.post('/transfer', csrfProtection, (req, res) => {
  res.send('Money transferred safely.');
});

// Inside an HTML Form template, you must include the token:
// <input type="hidden" name="_csrf" value="{{csrfToken}}">''',
      ),
      AppLesson(
        title: 'SQL Injection Vulnerabilities',
        body: '''Injection flaws, particularly SQL Injection (SQLi), occur when untrusted user data is sent to an interpreter as part of a command or query. In a SQL injection attack, an attacker alters backend database queries by inputting malicious SQL code into input fields. If the application insecurely concatenates this input directly into the SQL string, the database executes the attacker\'s commands.

For example, a login query might look like: `SELECT * FROM users WHERE username = '\${user}' AND password = '\${pass}'`. If an attacker inputs `admin' OR '1'='1` as the username, the resulting query becomes `...WHERE username = 'admin' OR '1'='1'`. Since '1'='1' is always true, the database bypasses the password check entirely, instantly granting the attacker administrative access to the system.

The definitive solution to SQL Injection is the use of Parameterized Queries (also known as Prepared Statements). Parameterized queries ensure that the database treats user input strictly as data parameters, never as executable code, completely neutralizing injection attempts. Modern Object-Relational Mappers (ORMs) and query builders, such as Sequelize or Prisma, utilize parameterized queries by default, heavily protecting developers from this devastating vulnerability.''',
        codeSnippet: '''// DANGEROUS: Insecure SQL Concatenation (Vulnerable to SQLi)
const username = req.body.username;
const query = `SELECT * FROM users WHERE username = '\${username}'`;
db.query(query, (err, result) => { ... });

// SECURE: Parameterized Query
const username = req.body.username;
// The '?' acts as a placeholder. The database engine safely escapes the input.
const query = 'SELECT * FROM users WHERE username = ?';
db.query(query, [username], (err, result) => { ... });''',
      ),
      AppLesson(
        title: 'Authentication vs Authorization',
        body: '''While often used interchangeably, authentication and authorization represent two entirely distinct concepts in security architecture. Authentication is the process of verifying who a user is. When a user submits a username and password, or scans a biometric fingerprint, the system is authenticating their identity. It answers the question: "Are you who you say you are?"

Authorization, on the other hand, occurs strictly after authentication. It is the process of verifying what an authenticated user is permitted to do. Just because an employee is successfully authenticated into the company network does not mean they are authorized to access the CEO\'s financial documents. Authorization involves checking roles, permissions, and access control lists. It answers the question: "Are you allowed to perform this action?"

A robust security system requires both working flawlessly in tandem. A failure in authentication allows unauthorized users into the system entirely. A failure in authorization (known as Broken Access Control) allows low-level authenticated users to perform high-level administrative actions, such as viewing other users\' private data or deleting records they do not own. Proper access control checks must be enforced on every single secure route on the backend server.''',
        codeSnippet: '''// Middleware demonstrating Authorization
const requireAdminRole = (req, res, next) => {
  // Assume req.user was populated during the Authentication phase
  const user = req.user;
  
  if (!user) {
    return res.status(401).json({ error: "Unauthenticated" });
  }

  // Checking Authorization: Is the user an Admin?
  if (user.role !== 'admin') {
    return res.status(403).json({ error: "Forbidden: Admins only" });
  }

  // Authorized! Proceed to the route handler.
  next();
};

// Applying the authorization middleware to a sensitive route
app.delete('/api/users/:id', requireAdminRole, deleteUserHandler);''',
      ),
      AppLesson(
        title: 'Securing Passwords with Hashing',
        body: '''One of the most catastrophic security failures a company can make is storing user passwords in plain text in their database. If the database is compromised, the attacker instantly possesses the credentials of every user, which they will likely use to compromise other accounts since users routinely reuse passwords. To prevent this, passwords must always be cryptographically hashed before being stored.

Hashing is a one-way mathematical function that converts a password of any length into a fixed-length string of characters. Unlike encryption, hashing cannot be reversed; you cannot decrypt a hash to reveal the original password. When a user logs in, the system hashes their inputted password and compares the resulting hash against the hash stored in the database. If they match, the password is correct.

However, simple hashing is vulnerable to pre-computed "Rainbow Table" attacks. To thwart this, developers must use "Salting". A salt is a random string of data generated and appended to the password before hashing. This ensures that even if two users have the exact same password, their hashes will be completely different. Industry-standard algorithms like bcrypt or Argon2 handle both hashing and salting automatically, incorporating computational slowness to deter brute-force attacks.''',
        hasImage: true,
        codeSnippet: '''const bcrypt = require('bcrypt');

// Registering a new user
async function registerUser(password) {
  const saltRounds = 10;
  // bcrypt automatically generates a salt and hashes the password
  const hashedPassword = await bcrypt.hash(password, saltRounds);
  
  // Store hashedPassword in the database, NEVER the plain password
  console.log('Saved Hash:', hashedPassword);
}

// Authenticating a login attempt
async function loginUser(plainPassword, hashFromDatabase) {
  // bcrypt compares the plain text to the stored hash securely
  const match = await bcrypt.compare(plainPassword, hashFromDatabase);
  
  if (match) {
    console.log('Login successful!');
  } else {
    console.log('Invalid credentials.');
  }
}''',
      ),
      AppLesson(
        title: 'Implementing JWT for Sessions',
        body: '''Traditionally, web applications maintained user sessions by storing a session ID in a browser cookie and keeping the corresponding session data in server memory or a database. This Stateful approach struggles to scale across multiple servers. Modern distributed applications frequently rely on Stateless authentication using JSON Web Tokens (JWT). With JWT, the server does not need to store any session state.

A JWT consists of three parts: a Header (containing the algorithm), a Payload (containing user data like user ID or roles), and a Signature. When a user logs in, the server creates the payload, signs it using a secret key known only to the server, and sends the JWT back to the client. The client stores this token (usually in a secure cookie) and attaches it to every subsequent HTTP request.

When the server receives a request with a JWT, it verifies the token\'s signature using its secret key. If the signature is valid, the server trusts that the data inside the payload has not been tampered with and processes the request. While incredibly scalable, JWTs present challenges with token revocation (logging a user out globally before the token expires), which requires implementing complex token blocklists or short expiration times paired with refresh tokens.''',
        codeSnippet: '''const jwt = require('jsonwebtoken');

const SECRET_KEY = 'super_secret_server_key'; // Use environment variables in production!

// Generating a token on successful login
function generateToken(user) {
  const payload = { userId: user.id, role: user.role };
  // Token expires in 1 hour
  return jwt.sign(payload, SECRET_KEY, { expiresIn: '1h' });
}

// Verifying a token on protected routes
function verifyTokenMiddleware(req, res, next) {
  const token = req.headers.authorization?.split(' ')[1]; // Extract Bearer token
  
  if (!token) return res.status(401).json({ error: 'Token required' });

  try {
    const decoded = jwt.verify(token, SECRET_KEY);
    req.user = decoded; // Attach user payload to request
    next();
  } catch (err) {
    res.status(403).json({ error: 'Invalid or expired token' });
  }
}''',
      ),
      AppLesson(
        title: 'Content Security Policy (CSP)',
        body: '''Even with rigorous input validation and output encoding, an application might still contain a subtle XSS vulnerability. To provide a massive secondary layer of defense, modern browsers support Content Security Policy (CSP). CSP is an HTTP response header that allows site administrators to strictly declare which dynamic resources are allowed to load and execute on their web pages.

By implementing a strong CSP, you can explicitly instruct the browser to only execute JavaScript files hosted on your own domain, immediately blocking any malicious scripts injected from external domains. Furthermore, you can completely disable the execution of inline scripts (like scripts placed directly in `<script>` tags or inline `onclick` handlers). If an attacker manages to inject an inline script, CSP forces the browser to silently block its execution.

Configuring CSP correctly requires careful planning, as an overly restrictive policy will break legitimate functionality, such as legitimate analytics trackers or externally hosted fonts. Developers often begin by running CSP in "Report-Only" mode. This allows the browser to report violations to a specified server endpoint without actually blocking the resources, helping developers fine-tune the policy before enforcing it strictly in production.''',
        codeSnippet: '''const express = require('express');
const helmet = require('helmet'); // Helmet makes setting security headers easy
const app = express();

// Use helmet to automatically set a robust Content Security Policy
app.use(
  helmet.contentSecurityPolicy({
    directives: {
      defaultSrc: ["'self'"], // Only allow resources from the same origin
      scriptSrc: ["'self'", "https://trusted-analytics.com"], // Allow external JS
      styleSrc: ["'self'", "'unsafe-inline'"], // Allow inline CSS if necessary
      imgSrc: ["'self'", "data:", "https://images.example.com"],
      upgradeInsecureRequests: [], // Force HTTP connections to upgrade to HTTPS
    },
  })
);''',
      ),
      AppLesson(
        title: 'HTTPS and Secure Cookies',
        body: '''Data transmitted over standard HTTP is sent in plain text. If a user is on a public Wi-Fi network, anyone monitoring the network traffic can intercept and read the data, including passwords, credit card numbers, and session tokens. To protect data in transit, applications must use HTTPS (Hypertext Transfer Protocol Secure). HTTPS encrypts the connection between the client and the server using Transport Layer Security (TLS).

With HTTPS enabled, an attacker intercepting the traffic sees only an unreadable stream of encrypted garbage data. Today, deploying HTTPS is easier and cheaper than ever thanks to automated Certificate Authorities like Let\'s Encrypt, which provide free TLS certificates. Modern web browsers severely penalize websites that do not use HTTPS by displaying prominent "Not Secure" warnings to the user.

When transmitting sensitive data like JWTs or session IDs, configuring your cookies correctly is just as vital as HTTPS. Cookies must be flagged with the 'Secure' attribute, which guarantees the browser will only transmit the cookie over an encrypted HTTPS connection. Additionally, cookies should be flagged with the 'HttpOnly' attribute, which completely hides the cookie from client-side JavaScript, rendering it immune to theft via XSS attacks.''',
        codeSnippet: '''// Express cookie configuration for a production environment
app.post('/login', (req, res) => {
  // ... authenticate user and generate session token ...
  const sessionToken = "generated_secure_token";

  res.cookie('sessionId', sessionToken, {
    maxAge: 3600000, // Expires in 1 hour
    httpOnly: true,  // Prevents JavaScript access (XSS protection)
    secure: true,    // Only sent over HTTPS (Data in transit protection)
    sameSite: 'strict' // Prevents sending cookies in cross-site requests (CSRF protection)
  });

  res.json({ message: 'Login successful' });
});''',
      ),
      AppLesson(
        title: 'Mini Project: Securing a Vulnerable Express App',
        body: '''Your final project for this course is a practical security audit and remediation exercise. You will be provided with a small, highly vulnerable Node/Express application representing a user registration and login system. Currently, it stores passwords in plain text, lacks protection against CSRF, allows XSS through an unsanitized profile page, and operates over unencrypted HTTP. Your task is to secure it completely.

First, implement the 'bcrypt' library in the registration route to ensure all passwords are salted and hashed before reaching the database. Update the login route to securely compare hashes. Next, install and configure the 'helmet' middleware to automatically implement a robust Content Security Policy and remove identifying headers that expose backend technologies to attackers. 

Finally, restructure the session management. Replace the insecure client-accessible cookies with 'HttpOnly' and 'Secure' flagged cookies to store session tokens safely. Sanitize the user profile inputs using a library like DOMPurify or sanitize-html to prevent malicious script injection. By successfully hardening this vulnerable application, you demonstrate a comprehensive understanding of the practical steps required to defend web infrastructure in the real world.''',
        codeSnippet: '''// Implementation checklist for the Mini Project:
const express = require('express');
const helmet = require('helmet');
const bcrypt = require('bcrypt');
const sanitize = require('sanitize-html');

const app = express();

// 1. Implement Helmet for CSP and secure headers
app.use(helmet());
app.use(express.json());

app.post('/register', async (req, res) => {
  const { username, password } = req.body;
  // 2. Hash passwords
  const hash = await bcrypt.hash(password, 10);
  // ... save to DB ...
});

app.post('/profile', (req, res) => {
  // 3. Sanitize inputs to prevent XSS
  const cleanBio = sanitize(req.body.bio);
  // ... update bio in DB ...
});''',
      ),
    ],
  ),
  AppCourse(
    id: 'web_development_deployment_101',
    title: 'Full-Stack Deployment Strategies',
    description: 'Take your code from your laptop to the cloud. Learn Git, CI/CD, Docker, and modern hosting solutions to deploy apps reliably.',
    instructor: 'Kelechi Nnamdi',
    category: 'Web Development',
    difficulty: 'Advanced',
    icon: Icons.cloud_upload,
    color: Colors.purple,
    duration: '7h 15m',
    lessons: [
      AppLesson(
        title: 'Intro to Application Deployment',
        body: '''Developing a web application on your local machine is only half the battle. To make your application accessible to users worldwide, you must deploy it to production servers. Deployment is the process of moving code from a development environment to a live, internet-facing environment. Historically, this involved manually transferring files via FTP to a shared server, a slow and highly error-prone process.

Today, deployment has evolved into a sophisticated discipline known as DevOps (Development and Operations). Modern deployment strategies focus on automation, reliability, and scalability. When deploying a full-stack application, you must consider multiple moving parts: the frontend static files, the backend Node server, the database, and the secure network connections between them. If one piece is configured incorrectly, the entire application fails.

Throughout this course, we will explore the modern deployment landscape. We will start by ensuring our code is version-controlled securely. Then, we will look at managed hosting solutions that drastically simplify deploying frontends. Finally, we will delve into containerization, creating isolated, reproducible environments that guarantee your backend application runs exactly the same way in the cloud as it does on your local laptop.''',
        hasImage: true,
      ),
      AppLesson(
        title: 'Version Control with Git',
        body: '''Before you can automate deployment, your code must be managed by a Version Control System (VCS). Git is the absolute industry standard for this purpose. Git tracks every change made to your codebase over time, allowing you to revert to previous states if something breaks. It is the foundation of modern team collaboration, enabling multiple developers to work on the same project simultaneously via "branching" without overwriting each other\'s work.

To prepare for deployment, your code is typically pushed to a remote repository platform like GitHub, GitLab, or Bitbucket. These platforms act as the central source of truth for your codebase. The 'main' or 'master' branch usually represents the production-ready state of your application. When developers finish building a new feature on a separate branch, they open a Pull Request to merge their changes into the main branch.

Modern cloud hosting providers integrate directly with these Git repositories. Instead of manually uploading files, you link your hosting provider to your GitHub repository. The hosting provider constantly monitors the repository; whenever new code is merged into the main branch, the provider detects the change and automatically initiates the deployment process. Mastering Git is the mandatory first step for modern deployments.''',
        codeSnippet: '''# Common Git workflow for a new feature
# 1. Ensure you have the latest main branch
git checkout main
git pull origin main

# 2. Create and switch to a new feature branch
git checkout -b feature/user-login

# 3. Make code changes, then stage and commit them
git add .
git commit -m "Implement secure user login form"

# 4. Push the branch to the remote repository
git push origin feature/user-login
# (Then open a Pull Request on GitHub to merge into main)''',
      ),
      AppLesson(
        title: 'Preparing Apps for Production',
        body: '''Code written for a local development environment is rarely optimized for production. Before deployment, both frontend and backend applications require a "build" or preparation step. For frontend applications built with frameworks like React, the source code contains large development libraries, JSX, and un-minified CSS. The build process compiles the JSX into vanilla JavaScript, minifies the files to reduce size, and bundles everything together to optimize loading speed.

On the backend, preparation involves configuring Environment Variables. You must never hardcode sensitive information like database passwords, API keys, or secret tokens directly into your source code, as anyone with access to the repository could steal them. Instead, you use environment variables—dynamic values injected into the application by the operating system running the server.

You use a `.env` file locally to store these variables, ensuring that file is strictly ignored by Git (using a `.gitignore` file). When you deploy to a cloud provider, you manually enter these variables into their secure configuration dashboard. The application code then references `process.env.DB_PASSWORD`, which safely pulls the secure value from the server environment at runtime, keeping your secrets entirely out of version control.''',
        codeSnippet: '''// Utilizing Environment Variables in Node.js
require('dotenv').config(); // Load variables from .env file locally

const express = require('express');
const mongoose = require('mongoose');
const app = express();

// Securely access the database URI from the environment
const DB_URI = process.env.DATABASE_URI;
const PORT = process.env.PORT || 3000; // Fallback to 3000 if not provided

mongoose.connect(DB_URI)
  .then(() => console.log('Connected to Production Database'))
  .catch(err => console.error('Database connection failed', err));

app.listen(PORT, () => {
  console.log(`Server running on port \${PORT}`);
});''',
      ),
      AppLesson(
        title: 'Deploying Static Sites',
        body: '''Deploying the frontend portion of a modern web application is incredibly streamlined thanks to platforms known as Static Site Generators and specialized hosting services like Netlify, Vercel, and GitHub Pages. Because a compiled React application is ultimately just static HTML, CSS, and JavaScript files, it does not require a complex Node server to run; it merely requires a fast web server capable of delivering files to the browser.

Services like Netlify operate on a concept called Continuous Deployment. You connect your GitHub repository directly to the Netlify dashboard and specify the build command (e.g., `npm run build`) and the output directory (e.g., `build` or `dist`). Netlify provisions the servers, installs your dependencies, runs the build command, and automatically distributes the resulting static files across a global Content Delivery Network (CDN).

A CDN ensures that your frontend application loads lightning-fast for users everywhere by serving the files from a geographical server closest to their physical location. Furthermore, these platforms automatically handle HTTPS certificate generation and renewal for free. Whenever you push new code to your GitHub main branch, the platform automatically rebuilds and deploys the new version within seconds, creating a frictionless developer experience.''',
        codeSnippet: '''// Example package.json scripts for a React frontend
{
  "name": "my-frontend-app",
  "version": "1.0.0",
  "scripts": {
    "start": "react-scripts start", // Local development command
    "build": "react-scripts build"  // Production build command
  }
}

/* 
Netlify/Vercel Configuration Steps:
1. Connect GitHub Repository
2. Set Build Command to: npm run build
3. Set Publish Directory to: build/
4. Click Deploy. 
*/''',
      ),
      AppLesson(
        title: 'Introduction to Docker',
        body: '''Deploying backend applications is historically more complicated than frontends because they depend heavily on the underlying server\'s operating system, installed software versions, and specific system configurations. The infamous developer excuse, "It works on my machine!", stems from discrepancies between a local laptop environment and the production server. Docker was invented to solve this exact problem completely.

Docker is a platform for developing, shipping, and running applications inside software containers. A container is a standardized, lightweight, standalone, executable package of software. It includes everything needed to run an application: the code, the runtime (like Node.js), system tools, system libraries, and settings. Containers isolate software from its environment, guaranteeing it works uniformly regardless of where it is deployed.

Unlike traditional Virtual Machines which require booting up an entire heavy guest Operating System for every application, Docker containers share the host system\'s kernel, making them incredibly lightweight and fast to start. You can easily run a Node container, a Python container, and a MongoDB container simultaneously on a single small server without them interfering with each other\'s dependencies.''',
        hasImage: true,
        codeSnippet: '''# Analogy of Docker vs Virtual Machines

# Virtual Machine (Heavy):
# Hardware -> Host OS -> Hypervisor -> [Guest OS + Node.js + App]

# Docker Container (Lightweight):
# Hardware -> Host OS -> Docker Engine -> [Node.js + App]
# Notice the lack of a redundant Guest OS. This saves massive memory!''',
      ),
      AppLesson(
        title: 'Containerizing a Node.js App',
        body: '''To containerize an application, you must write a Dockerfile. A Dockerfile is a simple text document that contains a sequence of instructions used to assemble a Docker Image. Think of an Image as a read-only blueprint or snapshot of your application. When you tell Docker to run an Image, it creates a live, running Container based on that blueprint.

A typical Node.js Dockerfile starts with a base image, usually an official, lightweight version of Node hosted on Docker Hub. Next, you set the working directory inside the container, copy your 'package.json' files over, and run 'npm install' to install dependencies. Finally, you copy your actual application source code into the container, expose the port your app runs on, and specify the command to start the server.

Once the Dockerfile is written, you use the Docker CLI to build the Image. After the image is built, you can push it to a container registry like Docker Hub or Amazon ECR. From there, any server in the world with Docker installed can pull that exact image and run it. The server does not even need Node.js installed on it; everything required is locked safely inside the container.''',
        codeSnippet: '''# A standard Dockerfile for a Node.js application

# 1. Use the official Node 18 lightweight alpine image as a base
FROM node:18-alpine

# 2. Set the working directory inside the container
WORKDIR /usr/src/app

# 3. Copy package files and install dependencies
COPY package*.json ./
RUN npm install --production

# 4. Copy the rest of the application code
COPY . .

# 5. Document the port the app runs on
EXPOSE 3000

# 6. Define the command to start the application
CMD [ "node", "server.js" ]''',
      ),
      AppLesson(
        title: 'CI/CD Pipelines with GitHub Actions',
        body: '''Continuous Integration and Continuous Deployment (CI/CD) represent the pinnacle of automated software delivery. CI/CD relies on automated pipelines to build, test, and deploy code every time a developer pushes a commit. GitHub Actions provides a powerful engine to build these pipelines directly within your GitHub repository without relying on third-party tools like Jenkins or CircleCI.

Continuous Integration (CI) focuses on code quality. When code is pushed, the pipeline automatically spins up a temporary server, installs dependencies, and runs your suite of automated tests. If any tests fail, the pipeline halts, and the Pull Request is blocked from merging, preventing broken code from entering the main branch. This gives teams immense confidence when collaborating.

Continuous Deployment (CD) takes over after CI succeeds on the main branch. The CD pipeline automatically builds the production assets (or Docker images) and securely pushes them to your live hosting provider. By writing a simple YAML configuration file in your repository, you define the exact sequence of steps required to test and deploy. With a proper CI/CD pipeline, developers focus entirely on writing code, while the robots handle the deployment securely.''',
        codeSnippet: '''# .github/workflows/deploy.yml
name: Node.js CI/CD Pipeline

on:
  push:
    branches: [ "main" ]

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    steps:
    - name: Checkout Code
      uses: actions/checkout@v3

    - name: Setup Node.js
      uses: actions/setup-node@v3
      with:
        node-version: '18'

    - name: Install dependencies and Run Tests
      run: |
        npm ci
        npm test

    - name: Deploy to Production
      run: echo "Code tested successfully. Executing deployment script..."
      # Deployment specific commands would go here''',
      ),
      AppLesson(
        title: 'Hosting on Cloud Providers',
        body: '''When deploying containerized backend applications or complex databases, you need a robust cloud hosting provider. The three titans of cloud computing are Amazon Web Services (AWS), Google Cloud Platform (GCP), and Microsoft Azure. These platforms offer incredibly vast arrays of services, from basic Virtual Private Servers (VPS) to fully managed, auto-scaling Kubernetes clusters and serverless functions.

For beginners and smaller applications, using raw AWS services can be overwhelmingly complex. A popular alternative is Platform as a Service (PaaS) providers like Heroku, Render, or DigitalOcean App Platform. These services sit on top of infrastructure like AWS and hide the complex server management. You simply provide them with your GitHub repository or Docker Image, and they handle the server provisioning, load balancing, and network security automatically.

Choosing the right hosting strategy depends on scale. A small startup might use Render for rapid, frictionless deployment. As the application grows to millions of users, the company might migrate to AWS Elastic Container Service (ECS) to gain granular control over infrastructure costs and auto-scaling rules. Regardless of the provider, modern cloud hosting ensures your application is highly available and fault-tolerant.''',
        codeSnippet: '''/*
Comparison of Cloud Hosting Strategies:

1. Infrastructure as a Service (IaaS) - e.g., AWS EC2, DigitalOcean Droplets
   - You rent a bare Linux server.
   - You must manually install Docker, manage firewalls, and update the OS.
   - Highest control, highest maintenance burden.

2. Platform as a Service (PaaS) - e.g., Render, Heroku
   - You provide code/containers. The platform runs it.
   - Low maintenance, fast deployment.
   - Higher cost at scale, less control over underlying hardware.

3. Serverless Functions - e.g., AWS Lambda
   - You deploy individual functions, not whole servers.
   - Scales infinitely automatically, pay only for exact compute time used.
   - Requires specific architectural design.
*/''',
      ),
      AppLesson(
        title: 'Monitoring and Logging',
        body: '''Deployment is not the end of the software lifecycle; it is the beginning of operations. Once an application is live in production, you must have visibility into its health and performance. Without proper monitoring, the first time you realize your application has crashed is when angry users complain on social media. Proactive monitoring ensures you detect and fix issues before users even notice them.

Logging is the foundation of monitoring. Every significant event, error, and system state change should be logged by your application. However, storing logs on a single server\'s hard drive is useless in distributed, multi-server cloud environments. Modern architectures use centralized logging services like Datadog, Splunk, or the ELK stack (Elasticsearch, Logstash, Kibana) to stream logs from all containers into one searchable dashboard.

In addition to logs, you must monitor system metrics such as CPU usage, memory consumption, and API response times. Tools like Prometheus and Grafana can visualize these metrics in real-time graphs. Furthermore, you set up automated alerts. If the server\'s CPU usage spikes over 90% for five minutes, or if the database connection fails, the monitoring system automatically sends an alert to the engineering team via Slack or PagerDuty, enabling rapid incident response.''',
        codeSnippet: '''// Implementing structured logging with Winston in Node.js
const winston = require('winston');

// Configure a professional logger
const logger = winston.createLogger({
  level: 'info',
  format: winston.format.json(), // JSON format is easily parsed by central loggers
  transports: [
    // Write errors to error.log
    new winston.transports.File({ filename: 'error.log', level: 'error' }),
    // Write all logs to combined.log
    new winston.transports.File({ filename: 'combined.log' }),
  ],
});

// In production, you would add a transport to send logs to a service like Datadog
if (process.env.NODE_ENV !== 'production') {
  logger.add(new winston.transports.Console({
    format: winston.format.simple(),
  }));
}

logger.error('Database connection timed out');
logger.info('User successfully authenticated', { userId: 123 });''',
      ),
      AppLesson(
        title: 'Mini Project: Full Pipeline Deployment',
        body: '''Your final project is to synthesize your deployment knowledge by executing a complete, automated deployment of a full-stack application. You will be provided with a complete React frontend and a Node.js backend. Your objective is to configure the environment, write the necessary deployment files, and establish a live URL for the application without manually transferring a single file via FTP.

First, create a GitHub repository and push the provided code. Next, write a Dockerfile for the Node backend to containerize it successfully. Ensure you utilize environment variables for the database connection string and API ports. Create a free account on a PaaS provider like Render or Railway. Link your GitHub account and configure the service to build and deploy your backend Docker container automatically upon every push to the main branch.

Finally, tackle the frontend. Configure the React application to use environment variables to point to your newly deployed backend API URL. Connect the frontend repository to Vercel or Netlify, specify the build command, and deploy the static site. Test the live application to ensure the frontend successfully communicates with the containerized backend. You have successfully implemented a modern DevOps deployment pipeline!''',
        codeSnippet: '''# Final Deployment Checklist:

[ ] 1. All sensitive credentials removed from code and added to .env files.
[ ] 2. .env files added to .gitignore.
[ ] 3. Dockerfile created and tested locally using `docker build`.
[ ] 4. Code pushed to main branch on GitHub.
[ ] 5. Backend repository linked to PaaS (Render/Railway).
[ ] 6. Production Environment Variables injected into the PaaS dashboard.
[ ] 7. Frontend API base URL updated to point to the live backend URL.
[ ] 8. Frontend repository linked to Netlify/Vercel.
[ ] 9. Verify live application functionality via the public URLs.
[ ] 10. Celebrate mastering full-stack web deployment!''',
      ),
    ],
  ),
];
