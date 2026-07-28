// GENERATED FILE - DO NOT EDIT BY HAND.
// Produced by tools/generate_courses.py from the local freeCodeCamp
// curriculum assets under assets/freecodecamp/. No network access used.
import 'package:flutter/material.dart';

import '../models/app_course.dart';
final List<AppCourse> webDevelopmentCourses = [
  AppCourse(
    id: 'responsive-web-design',
    title: """Responsive Web Design""",
    description: """A freeCodeCamp curriculum covering Responsive Web Design, with 60 lessons extracted from the local curriculum assets.""",
    instructor: 'freeCodeCamp',
    category: 'Web Development',
    difficulty: 'Intermediate',
    icon: Icons.code,
    color: Colors.blue,
    duration: '4 weeks',
    lessons: [
      AppLesson(
        title: """Say Hello to HTML Elements""",
        body: """Welcome to freeCodeCamp's HTML coding challenges. These will walk you through web development step-by-step.

First, you'll start by building a simple web page using HTML. You can edit code in your code editor, which is embedded into this web page.

Do you see the code in your code editor that says `Hello`? That's an HTML element.

Most HTML elements have an opening tag and a closing tag.

Opening tags look like this:

Closing tags look like this:

The only difference between opening and closing tags is the forward slash after the opening bracket of a closing tag.

Each challenge has tests you can run at any time by clicking the "Run tests" button. When you pass all tests, you'll be prompted to submit your solution and go to the next coding challenge.

To pass the test on this challenge, change your `h1` element's text to say `Hello World`.

Hint: Your `h1` element should have the text `Hello World`.""",
        codeSnippet: """<h1>Hello World</h1>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Headline with the h2 Element""",
        body: """Over the next few lessons, we'll build an HTML5 cat photo web app piece-by-piece.

The `h2` element you will be adding in this step will add a level two heading to the web page.

This element tells the browser about the structure of your website. `h1` elements are often used for main headings, while `h2` elements are generally used for subheadings. There are also `h3`, `h4`, `h5` and `h6` elements to indicate different levels of subheadings.

Add an `h2` tag that says "CatPhotoApp" to create a second HTML element below your "Hello World" `h1` element.

Hint: You should create an `h2` element.

Your `h2` element should have a closing tag.

Your `h2` element should have the text `CatPhotoApp`.

Your `h1` element should have the text `Hello World`.

Your `h1` element should be before your `h2` element.""",
        codeSnippet: """<h1>Hello World</h1>
<h2>CatPhotoApp</h2>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Inform with the Paragraph Element""",
        body: """The `p` element is the preferred element for paragraph text on websites. `p` is short for "paragraph".

You can create a paragraph element like this:

Create a `p` element below your `h2` element, and give it the text `Hello Paragraph`.

**Note:** As a convention, all HTML tags are written in lowercase, for example `` and not ``.

Hint: Your code should have a valid `p` element.

Your `p` element should have the text `Hello Paragraph`.

Your `p` element should have a closing tag.""",
        codeSnippet: """<h1>Hello World</h1>
<h2>CatPhotoApp</h2>
<p>Hello Paragraph</p>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Fill in the Blank with Placeholder Text""",
        body: """Web developers traditionally use lorem ipsum text as placeholder text. The lorem ipsum text is randomly scraped from a famous passage by Cicero of Ancient Rome.

Lorem ipsum text has been used as placeholder text by typesetters since the 16th century, and this tradition continues on the web.

Well, 5 centuries is long enough. Since we're building a CatPhotoApp, let's use something called "kitty ipsum" text.

Replace the text inside your `p` element with the first few words of this kitty ipsum text: `Kitty ipsum dolor sit amet, shed everywhere shed everywhere stretching attack your ankles chase the red dot, hairball run catnip eat the grass sniff.`

Hint: Your `p` element should contain the first few words of the provided "kitty ipsum" text.""",
        codeSnippet: """<h1>Hello World</h1>

<h2>CatPhotoApp</h2>

<p>Kitty ipsum dolor sit amet, shed everywhere shed everywhere stretching attack your ankles chase the red dot, hairball run catnip eat the grass sniff</p>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Uncomment HTML""",
        body: """Commenting is a way that you can leave comments for other developers within your code without affecting the resulting output that is displayed to the end user.

Commenting is also a convenient way to make code inactive without having to delete it entirely.

Comments in HTML start with ``

Uncomment your `h1`, `h2` and `p` elements.

Hint: Your `h1` element should be visible on the page by uncommenting it.

Your `h2` element should be visible on the page by uncommenting it.

Your `p` element should be visible on the page by uncommenting it.

No trailing comment tags should be visible on the page (i.e. `-->`).""",
        codeSnippet: """<h1>Hello World</h1>

<h2>CatPhotoApp</h2>

<p>Kitty ipsum dolor sit amet, shed everywhere shed everywhere stretching attack your ankles chase the red dot, hairball run catnip eat the grass sniff.</p>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Comment out HTML""",
        body: """Remember that in order to start a comment, you need to use ``

Here you'll need to end the comment before your `h2` element begins.

Comment out your `h1` element and your `p` element, but not your `h2` element.

Hint: Your `h1` element should be commented out so that it is not visible on the page.

Your `h2` element should not be commented out so that it is visible on the page.

Your `p` element should be commented out so that it is not visible on the page.

Each of your comments should be closed with `-->`.

You should not change the order of the `h1`, `h2`, or `p` elements in the code.""",
        codeSnippet: """<!--<h1>Hello World</h1>-->
<h2>CatPhotoApp</h2> 
<!--<p>Kitty ipsum dolor sit amet, shed everywhere shed everywhere stretching attack your ankles chase the red dot, hairball run catnip eat the grass sniff.</p> -->""",
        hasImage: false,
      ),
      AppLesson(
        title: """Delete HTML Elements""",
        body: """Our phone doesn't have much vertical space.

Let's remove the unnecessary elements so we can start building our CatPhotoApp.

Delete your `h1` element so we can simplify our view.

Hint: Your `h1` element should be deleted.

Your `h2` element should be on the page.

Your `p` element should be on the page.""",
        codeSnippet: """<h2>CatPhotoApp</h2><p>Kitty ipsum dolor sit amet, shed everywhere shed everywhere stretching attack your ankles chase the red dot, hairball run catnip eat the grass sniff.</p>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Introduction to HTML5 Elements""",
        body: """HTML5 introduces more descriptive HTML tags. These include `main`, `header`, `footer`, `nav`, `video`, `article`, `section` and others.

These tags give a descriptive structure to your HTML, make your HTML easier to read, and help with Search Engine Optimization (SEO) and accessibility. The `main` HTML5 tag helps search engines and other developers find the main content of your page.

Example usage, a `main` element with two child elements nested inside it:

**Note:** Many of the new HTML5 tags and their benefits are covered in the Applied Accessibility section.

Create a second `p` element with the following kitty ipsum text: `Purr jump eat the grass rip the couch scratched sunbathe, shed everywhere rip the couch sleep in the sink fluffy fur catnip scratched.`

Then, create a `main` element and nest only the two `p` elements inside the `main` element.

Hint: You should have 2 `p` elements with Kitty Ipsum text.

Each of your `p` elements should have a closing tag.

Your `p` element should contain the first few words of the provided additional `kitty ipsum` text.

Your code should have one `main` element.

The `main` element should have two paragraph elements as children.

The opening `main` tag should come before the first paragraph tag.

The closing `main` tag should come after the second closing paragraph tag.""",
        codeSnippet: """<h2>CatPhotoApp</h2>
<main>
  <p>Kitty ipsum dolor sit amet, shed everywhere shed everywhere stretching attack your ankles chase the red dot, hairball run catnip eat the grass sniff.</p>
  <p>Purr jump eat the grass rip the couch scratched sunbathe, shed everywhere rip the couch sleep in the sink fluffy fur catnip scratched.</p>
</main>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Add Images to Your Website""",
        body: """You can add images to your website by using the `img` element, and point to a specific image's URL using the `src` attribute.

An example of this would be:

Note that `img` is a void element.

All `img` elements **must** have an `alt` attribute. The text inside an `alt` attribute is used for screen readers to improve accessibility and is displayed if the image fails to load.

**Note:** If the image is purely decorative, using an empty `alt` attribute is a best practice.

Ideally the `alt` attribute should not contain special characters unless needed.

Let's add an `alt` attribute to our `img` example above:

Let's try to add an image to our website:

Within the existing `main` element, insert an `img` element before the existing `p` elements.

Now set the `src` attribute so that it points to the url `https://cdn.freecodecamp.org/curriculum/cat-photo-app/relaxing-cat.jpg`

Finally, don't forget to give your `img` element an `alt` attribute with applicable text.

Hint: Your page should have an image element.

Your image should have a `src` attribute that points to the kitten image.

Your image element's `alt` attribute should not be empty.""",
        codeSnippet: """<h2>CatPhotoApp</h2>
<main>
  <a href="#"><img src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/relaxing-cat.jpg" alt="A cute orange cat lying on its back."></a>
  <p>Kitty ipsum dolor sit amet, shed everywhere shed everywhere stretching attack your ankles chase the red dot, hairball run catnip eat the grass sniff.</p>
  <p>Purr jump eat the grass rip the couch scratched sunbathe, shed everywhere rip the couch sleep in the sink fluffy fur catnip scratched.</p>
</main>""",
        hasImage: true,
      ),
      AppLesson(
        title: """Link to External Pages with Anchor Elements""",
        body: """You can use `a` (*anchor*) elements to link to content outside of your web page.

`a` elements need a destination web address called an `href` attribute. They also need anchor text. Here's an example:

Then your browser will display the text `this links to freecodecamp.org` as a link you can click. And that link will take you to the web address `https://www.freecodecamp.org`.

Create an `a` element that links to `https://www.freecatphotoapp.com` and has "cat photos" as its anchor text.

Hint: Your `a` element should have the anchor text of `cat photos`.

You need an `a` element that links to `https://www.freecatphotoapp.com`

Your `a` element should have a closing tag.""",
        codeSnippet: """<h2>CatPhotoApp</h2>
<main>
  
  <img src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/relaxing-cat.jpg" alt="A cute orange cat lying on its back.">
  
  <a href="https://www.freecatphotoapp.com">cat photos</a>
  <p>Kitty ipsum dolor sit amet, shed everywhere shed everywhere stretching attack your ankles chase the red dot, hairball run catnip eat the grass sniff.</p>
  <p>Purr jump eat the grass rip the couch scratched sunbathe, shed everywhere rip the couch sleep in the sink fluffy fur catnip scratched.</p>
</main>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Link to Internal Sections of a Page with Anchor Elements""",
        body: """`a` (*anchor*) elements can also be used to create internal links to jump to different sections within a webpage.

To create an internal link, you assign a link's `href` attribute to a hash symbol `#` plus the value of the `id` attribute for the element that you want to internally link to, usually further down the page. You then need to add the same `id` attribute to the element you are linking to. An `id` is an attribute that uniquely describes an element.

Below is an example of an internal anchor link and its target element:

When users click the `Contacts` link, they'll be taken to the section of the webpage with the **Contacts** heading element.

Change your external link to an internal link by changing the `href` attribute to `#footer` and the text from `cat photos` to `Jump to Bottom`.

Remove the `target="_blank"` attribute from the anchor tag since this causes the linked document to open in a new window tab.

Then add an `id` attribute with a value of `footer` to the `` element at the bottom of the page.

Hint: There should be only one anchor tag on your page.

There should be only one `footer` tag on your page.

The `a` tag should have an `href` attribute set to "#footer".

The `a` tag should not have a `target` attribute.

The `a` text should be "Jump to Bottom".

The `footer` tag should have an `id` attribute set to "footer".""",
        codeSnippet: """<h2>CatPhotoApp</h2>
<main>

  <a href="#footer">Jump to Bottom</a>

  <img src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/relaxing-cat.jpg" alt="A cute orange cat lying on its back.">

  <p>Kitty ipsum dolor sit amet, shed everywhere shed everywhere stretching attack your ankles chase the red dot, hairball run catnip eat the grass sniff. Purr jump eat the grass rip the couch scratched sunbathe, shed everywhere rip the couch sleep in the sink fluffy fur catnip scratched. Kitty ipsum dolor sit amet, shed everywhere shed everywhere stretching attack your ankles chase the red dot, hairball run catnip eat the grass sniff.</p>
  <p>Purr jump eat the grass rip the couch scratched sunbathe, shed everywhere rip the couch sleep in the sink fluffy fur catnip scratched. Kitty ipsum dolor sit amet, shed everywhere shed everywhere stretching attack your ankles chase the red dot, hairball run catnip eat the grass sniff. Purr jump eat the grass rip the couch scratched sunbathe, shed everywhere rip the couch sleep in the sink fluffy fur catnip scratched.</p>
  <p>Meowwww loved it, hated it, loved it, hated it yet spill litter box, scratch at owner, destroy all furniture, especially couch or lay on arms while you're using the keyboard. Missing until dinner time toy mouse squeak roll over. With tail in the air lounge in doorway. Man running from cops stops to pet cats, goes to jail.</p>
  <p>Intently stare at the same spot poop in the plant pot but kitten is playing with dead mouse. Get video posted to internet for chasing red dot leave fur on owners clothes meow to be let out and mesmerizing birds leave fur on owners clothes or favor packaging over toy so purr for no reason. Meow to be let out play time intently sniff hand run outside as soon as door open yet destroy couch.</p>

</main>

<footer id="footer">Copyright Cat Photo App</footer>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Nest an Anchor Element within a Paragraph""",
        body: """You can nest links within other text elements.

Let's break down the example. Normal text is wrapped in the `p` element:

Next is the *anchor* element `` (which requires a closing tag ``): 

`target` is an anchor tag attribute that specifies where to open the link. The value `_blank` specifies to open the link in a new tab. The `href` is an anchor tag attribute that contains the URL address of the link: 

The text, `link to www.freecodecamp.org`, within the `a` element is called anchor text, and will display the link to click:

The final output of the example will look like this: 

Here's a link to www.freecodecamp.org for you to follow.

Nest the existing `a` element within a new `p` element. Do not create a new anchor tag. The new paragraph should have text that says `View more cat photos`, where `cat photos` is a link, and the rest is plain text.

Hint: You should only have one `a` element.

The `a` element should link to "`https://www.freecatphotoapp.com`".

Your `a` element should have the anchor text of `cat photos`

You should create a new `p` element. There should be at least 3 total `p` tags in your HTML code.

Your `a` element should be nested within your new `p` element.

Your `p` element should have the text `View more ` (with a space after it).

Your `a` element should not have the text `View more`.

Each of your `p` elements should have a closing tag.

Each of your `a` elements should have a closing tag.""",
        codeSnippet: """<h2>CatPhotoApp</h2>
<main>
  <p>View more <a target="_blank" href="https://www.freecatphotoapp.com">cat photos</a></p>

  <img src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/relaxing-cat.jpg" alt="A cute orange cat lying on its back.">

  <p>Kitty ipsum dolor sit amet, shed everywhere shed everywhere stretching attack your ankles chase the red dot, hairball run catnip eat the grass sniff.</p>
  <p>Purr jump eat the grass rip the couch scratched sunbathe, shed everywhere rip the couch sleep in the sink fluffy fur catnip scratched.</p>
</main>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Make Dead Links Using the Hash Symbol""",
        body: """Sometimes you want to add `a` elements to your website before you know where they will link.

This is also handy when you're changing the behavior of a link using `JavaScript`, which we'll learn about later.

The current value of the `href` attribute is a link that points to "`https://www.freecatphotoapp.com`". Replace the `href` attribute value with a `#`, also known as a hash symbol, to create a dead link.

For example: `href="#"`

Hint: Your `a` element should be a dead link with the value of the `href` attribute set to "#".""",
        codeSnippet: """<h2>CatPhotoApp</h2>
<main>
  <p>Click here to view more <a href="#" target="_blank">cat photos</a>.</p>
  
  <img src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/relaxing-cat.jpg" alt="A cute orange cat lying on its back.">
  
  <p>Kitty ipsum dolor sit amet, shed everywhere shed everywhere stretching attack your ankles chase the red dot, hairball run catnip eat the grass sniff.</p>
  <p>Purr jump eat the grass rip the couch scratched sunbathe, shed everywhere rip the couch sleep in the sink fluffy fur catnip scratched.</p>
</main>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Turn an Image into a Link""",
        body: """You can make elements into links by nesting them within an `a` element.

Nest your image within an `a` element. Here's an example:

Remember to use `#` as your `a` element's `href` property in order to turn it into a dead link.

Place the existing image element within an `a` (*anchor*) element.

Once you've done this, hover over your image with your cursor. Your cursor's normal pointer should become the link clicking pointer. The photo is now a link.

Hint: The existing `img` element should be nested within an `a` element.

Your `a` element should be a dead link with an `href` attribute set to `#`.

Each of your `a` elements should have a closing tag.""",
        codeSnippet: """<h2>CatPhotoApp</h2>
<main>
  <p>Click here to view more <a href="#">cat photos</a>.</p>
  
  <a href="#"><img src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/relaxing-cat.jpg" alt="A cute orange cat lying on its back."></a>
  
  <p>Kitty ipsum dolor sit amet, shed everywhere shed everywhere stretching attack your ankles chase the red dot, hairball run catnip eat the grass sniff.</p>
  <p>Purr jump eat the grass rip the couch scratched sunbathe, shed everywhere rip the couch sleep in the sink fluffy fur catnip scratched.</p>
</main>""",
        hasImage: true,
      ),
      AppLesson(
        title: """Create a Bulleted Unordered List""",
        body: """HTML has a special element for creating unordered lists, or bullet point style lists.

Unordered lists start with an opening `` element, followed by any number of `` elements. Finally, unordered lists close with a ``.

For example:

would create a bullet point style list of `milk` and `cheese`.

Remove the last two `p` elements and create an unordered list of three things that cats love at the bottom of the page.

Hint: Create a `ul` element.

You should have three `li` elements within your `ul` element.

Your `ul` element should have a closing tag.

Your `li` elements should have closing tags.

Your `li` elements should not contain an empty string or only white-space.""",
        codeSnippet: """<h2>CatPhotoApp</h2>
<main>
  <p>Click here to view more <a href="#">cat photos</a>.</p>

  <a href="#"><img src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/relaxing-cat.jpg" alt="A cute orange cat lying on its back."></a>

  <ul>
    <li>milk</li>
    <li>mice</li>
    <li>catnip</li>
  </ul>
</main>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Create an Ordered List""",
        body: """HTML has another special element for creating ordered lists, or numbered lists.

Ordered lists start with an opening `` element, followed by any number of `` elements. Finally, ordered lists are closed with the `` tag.

For example:

would create a numbered list of `Garfield` and `Sylvester`.

Create an ordered list of the top 3 things cats hate the most.

Hint: You should have an ordered list for `Top 3 things cats hate:`

You should have an unordered list for `Things cats love:`

You should have only one `ul` element.

You should have only one `ol` element.

You should have three `li` elements within your `ul` element.

You should have three `li` elements within your `ol` element.

Your `ul` element should have a closing tag.

Your `ol` element should have a closing tag.

Your `li` element should have a closing tag.

The `li` elements in your unordered list should not be empty.

The `li` elements in your ordered list should not be empty.""",
        codeSnippet: """<h2>CatPhotoApp</h2>
<main>
  <p>Click here to view more <a href="#">cat photos</a>.</p>

  <a href="#"><img src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/relaxing-cat.jpg" alt="A cute orange cat lying on its back."></a>

  <p>Things cats love:</p>
  <ul>
    <li>catnip</li>
    <li>laser pointers</li>
    <li>lasagna</li>
  </ul>
  <p>Top 3 things cats hate:</p>
  <ol>
    <li>hate 1</li>
    <li>hate 2</li>
    <li>hate 3</li>
  </ol>
</main>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Create a Text Field""",
        body: """Now let's create a web form.

`input` elements are a convenient way to get input from your user.

You can create a text input like this:

Note that `input` is a void element.

Create an `input` element of type `text` below your lists.

Hint: Your app should have an `input` element of type `text`.""",
        codeSnippet: """<h2>CatPhotoApp</h2>
<main>
  <p>Click here to view more <a href="#">cat photos</a>.</p>

  <a href="#"><img src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/relaxing-cat.jpg" alt="A cute orange cat lying on its back."></a>

  <p>Things cats love:</p>
  <ul>
    <li>catnip</li>
    <li>laser pointers</li>
    <li>lasagna</li>
  </ul>
  <p>Top 3 things cats hate:</p>
  <ol>
    <li>flea treatment</li>
    <li>thunder</li>
    <li>other cats</li>
  </ol>
  <form>
    <input type="text">
  </form>
</main>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Add Placeholder Text to a Text Field""",
        body: """Placeholder text is what is displayed in your `input` element before your user has inputted anything.

You can create placeholder text like so:

**Note:** Remember that `input` is a void element.

Set the `placeholder` value of your text `input` to "cat photo URL".

Hint: You should add a `placeholder` attribute to the existing text `input` element.

You should set the value of your `placeholder` attribute to `cat photo URL`.

The finished `input` element should not have a closing tag.

The finished `input` element should have valid syntax.""",
        codeSnippet: """<h2>CatPhotoApp</h2>
<main>
  <p>Click here to view more <a href="#">cat photos</a>.</p>
  
  <a href="#"><img src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/relaxing-cat.jpg" alt="A cute orange cat lying on its back."></a>
  
  <p>Things cats love:</p>
  <ul>
    <li>catnip</li>
    <li>laser pointers</li>
    <li>lasagna</li>
  </ul>
  <p>Top 3 things cats hate:</p>
  <ol>
    <li>flea treatment</li>
    <li>thunder</li>
    <li>other cats</li>
  </ol>
  <input type="text" placeholder="cat photo URL">
</main>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Create a Form Element""",
        body: """You can build web forms that actually submit data to a server using nothing more than pure HTML. You can do this by specifying an `action` attribute on your `form` element.

For example:

Nest the existing `input` element inside a `form` element and assign `"https://www.freecatphotoapp.com/submit-cat-photo"` to the `action` attribute of the `form` element.

Hint: The existing `input` element should be nested within a `form` element.

Your `form` should have an `action` attribute which is set to `https://www.freecatphotoapp.com/submit-cat-photo`.

Your `form` element should have well-formed open and close tags.""",
        codeSnippet: """<h2>CatPhotoApp</h2>
<main>
  <p>Click here to view more <a href="#">cat photos</a>.</p>

  <a href="#"><img src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/relaxing-cat.jpg" alt="A cute orange cat lying on its back."></a>

  <p>Things cats love:</p>
  <ul>
    <li>catnip</li>
    <li>laser pointers</li>
    <li>lasagna</li>
  </ul>
  <p>Top 3 things cats hate:</p>
  <ol>
    <li>flea treatment</li>
    <li>thunder</li>
    <li>other cats</li>
  </ol>
  <form action="https://www.freecatphotoapp.com/submit-cat-photo">
    <input type="text" placeholder="cat photo URL">
  </form>
</main>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Add a Submit Button to a Form""",
        body: """Let's add a `submit` button to your form. Clicking this button will send the data from your form to the URL you specified with your form's `action` attribute.

Here's an example submit button:

Add a button as the last element of your `form` element with a type of `submit`, and `Submit` as its text.

Hint: Your `form` should have a `button` inside it.

Your submit button should have the attribute `type` set to `submit`.

Your submit button should only have the text `Submit`.

Your `button` element should have a closing tag.""",
        codeSnippet: """<h2>CatPhotoApp</h2>
<main>
  <p>Click here to view more <a href="#">cat photos</a>.</p>

  <a href="#"><img src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/relaxing-cat.jpg" alt="A cute orange cat lying on its back."></a>

  <p>Things cats love:</p>
  <ul>
    <li>catnip</li>
    <li>laser pointers</li>
    <li>lasagna</li>
  </ul>
  <p>Top 3 things cats hate:</p>
  <ol>
    <li>flea treatment</li>
    <li>thunder</li>
    <li>other cats</li>
  </ol>
  <form action="https://www.freecatphotoapp.com/submit-cat-photo">
    <input type="text" placeholder="cat photo URL">
    <button type="submit">Submit</button>
  </form>
</main>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Use HTML5 to Require a Field""",
        body: """You can require specific form fields so that your user will not be able to submit your form until he or she has filled them out.

For example, if you wanted to make a text input field required, you can just add the attribute `required` within your `input` element, like this: ``

Make your text `input` a `required` field, so that your user can't submit the form without completing this field.

Then try to submit the form without inputting any text. See how your HTML5 form notifies you that the field is required?

Hint: Your text `input` element should have the `required` attribute.""",
        codeSnippet: """<h2>CatPhotoApp</h2>
<main>
  <p>Click here to view more <a href="#">cat photos</a>.</p>
  
  <a href="#"><img src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/relaxing-cat.jpg" alt="A cute orange cat lying on its back."></a>
  
  <p>Things cats love:</p>
  <ul>
    <li>catnip</li>
    <li>laser pointers</li>
    <li>lasagna</li>
  </ul>
  <p>Top 3 things cats hate:</p>
  <ol>
    <li>flea treatment</li>
    <li>thunder</li>
    <li>other cats</li>
  </ol>
  <form action="https://www.freecatphotoapp.com/submit-cat-photo">
    <input type="text" required placeholder="cat photo URL">
    <button type="submit">Submit</button>
  </form>
</main>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Create a Set of Radio Buttons""",
        body: """You can use radio buttons for questions where you want the user to only give you one answer out of multiple options.

Radio buttons are a type of `input`.

Each of your radio buttons can be nested within its own `label` element. By wrapping an `input` element inside of a `label` element it will automatically associate the radio button input with the label element surrounding it.

All related radio buttons should have the same `name` attribute to create a radio button group. By creating a radio group, selecting any single radio button will automatically deselect the other buttons within the same group ensuring only one answer is provided by the user.

Here's an example of a radio button:

It is considered best practice to set a `for` attribute on the `label` element, with a value that matches the value of the `id` attribute of the `input` element. This allows assistive technologies to create a linked relationship between the label and the related `input` element. For example:

We can also nest the `input` element within the `label` tags:

Add a pair of radio buttons to your form, each nested in its own `label` element. One should have the option of `indoor` and the other should have the option of `outdoor`. Both should share the `name` attribute of `indoor-outdoor` to create a radio group.

Hint: Your page should have two `radio` button elements.

Your radio buttons should be given the `name` attribute of `indoor-outdoor`.

Each of your two radio button elements should be nested in its own `label` element.

Each of your `label` elements should have a closing tag.

One of your radio buttons should have the label `indoor`.

One of your radio buttons should have the label `outdoor`.

Each of your radio button elements should be added within the `form` tag.""",
        codeSnippet: """<h2>CatPhotoApp</h2>
<main>
  <p>Click here to view more <a href="#">cat photos</a>.</p>
  
  <a href="#"><img src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/relaxing-cat.jpg" alt="A cute orange cat lying on its back."></a>
  
  <p>Things cats love:</p>
  <ul>
    <li>catnip</li>
    <li>laser pointers</li>
    <li>lasagna</li>
  </ul>
  <p>Top 3 things cats hate:</p>
  <ol>
    <li>flea treatment</li>
    <li>thunder</li>
    <li>other cats</li>
  </ol>
  <form action="https://www.freecatphotoapp.com/submit-cat-photo">
   <label for="indoor"><input id="indoor" type="radio" name="indoor-outdoor"> Indoor</label>
    <label for="outdoor"><input id="outdoor" type="radio" name="indoor-outdoor"> Outdoor</label><br>
    <input type="text" placeholder="cat photo URL" required>
    <button type="submit">Submit</button>
  </form>
</main>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Create a Set of Checkboxes""",
        body: """Forms commonly use checkboxes for questions that may have more than one answer.

Checkboxes are a type of `input`.

Each of your checkboxes can be nested within its own `label` element. By wrapping an `input` element inside of a `label` element it will automatically associate the checkbox input with the label element surrounding it.

All related checkbox inputs should have the same `name` attribute.

It is considered best practice to explicitly define the relationship between a checkbox `input` and its corresponding `label` by setting the `for` attribute on the `label` element to match the `id` attribute of the associated `input` element.

Here's an example of a checkbox:

Add to your form a set of three checkboxes. Each checkbox should be nested within its own `label` element. All three should share the `name` attribute of `personality`.

Hint: Your page should have three checkbox elements.

Each of your three checkbox elements should be nested in its own `label` element.

Make sure each of your `label` elements has a closing tag.

Your checkboxes should be given the `name` attribute of `personality`.

Each of your checkboxes should be added within the `form` tag.""",
        codeSnippet: """<h2>CatPhotoApp</h2>
<main>
  <p>Click here to view more <a href="#">cat photos</a>.</p>
  
  <a href="#"><img src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/relaxing-cat.jpg" alt="A cute orange cat lying on its back."></a>
  
  <p>Things cats love:</p>
  <ul>
    <li>catnip</li>
    <li>laser pointers</li>
    <li>lasagna</li>
  </ul>
  <p>Top 3 things cats hate:</p>
  <ol>
    <li>flea treatment</li>
    <li>thunder</li>
    <li>other cats</li>
  </ol>
  <form action="https://www.freecatphotoapp.com/submit-cat-photo">
    <label for="indoor"><input id="indoor" type="radio" name="indoor-outdoor"> Indoor</label>
    <label for="outdoor"><input id="outdoor" type="radio" name="indoor-outdoor"> Outdoor</label><br>
    <label for="playful"><input id="playful" type="checkbox" name="personality">Playful</label>
    <label for="lazy"><input id="lazy" type="checkbox" 
name="personality">Lazy</label>
    <label for="evil"><input id="evil" type="checkbox" 
name="personality">Evil</label><br>
    <input type="text" placeholder="cat photo URL" required>
    <button type="submit">Submit</button>
  </form>
</main>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Use the value attribute with Radio Buttons and Checkboxes""",
        body: """When a form gets submitted, the data is sent to the server and includes entries for the options selected. Inputs of type `radio` and `checkbox` report their values from the `value` attribute.

For example:

Here, you have two `radio` inputs. When the user submits the form with the `indoor` option selected, the form data will include the line: `indoor-outdoor=indoor`. This is from the `name` and `value` attributes of the "indoor" input.

If you omit the `value` attribute, the submitted form data uses the default value, which is `on`. In this scenario, if the user clicked the "indoor" option and submitted the form, the resulting form data would be `indoor-outdoor=on`, which is not useful. So the `value` attribute needs to be set to something to identify the option.

Give each of the existing `radio` and `checkbox` inputs the `value` attribute. Do not create any new radio or checkbox elements. Use the input label text, in lowercase, as the value for the attribute.

Hint: One of your radio buttons should have the `value` attribute of `indoor`.

One of your radio buttons should have the `value` attribute of `outdoor`.

One of your checkboxes should have the `value` attribute of `loving`.

One of your checkboxes should have the `value` attribute of `lazy`.

One of your checkboxes should have the `value` attribute of `energetic`.""",
        codeSnippet: """<h2>CatPhotoApp</h2>
<main>
  <p>Click here to view more <a href="#">cat photos</a>.</p>

  <a href="#"><img src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/relaxing-cat.jpg" alt="A cute orange cat lying on its back."></a>

  <p>Things cats love:</p>
  <ul>
    <li>catnip</li>
    <li>laser pointers</li>
    <li>lasagna</li>
  </ul>
  <p>Top 3 things cats hate:</p>
  <ol>
    <li>flea treatment</li>
    <li>thunder</li>
    <li>other cats</li>
  </ol>
  <form action="https://www.freecatphotoapp.com/submit-cat-photo">
    <label for="indoor"><input id="indoor" type="radio" name="indoor-outdoor" value="indoor"> Indoor</label>
    <label for="outdoor"><input id="outdoor" type="radio" name="indoor-outdoor" value="outdoor"> Outdoor</label><br>
    <label for="loving"><input id="loving" type="checkbox" name="personality" value="loving"> Loving</label>
    <label for="lazy"><input id="lazy" type="checkbox" name="personality" value="lazy"> Lazy</label>
    <label for="energetic"><input id="energetic" type="checkbox" name="personality" value="energetic"> Energetic</label><br>
    <input type="text" placeholder="cat photo URL" required>
    <button type="submit">Submit</button>
  </form>
</main>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Check Radio Buttons and Checkboxes by Default""",
        body: """You can set a checkbox or radio button to be checked by default using the `checked` attribute.

To do this, just add the word `checked` to the inside of an `input` element. For example:

Set the first of your radio buttons and the first of your checkboxes to both be checked by default.

Hint: Your first radio button on your form should be checked by default.

Your first checkbox on your form should be checked by default.

You should not change the inner text of the `Indoor` label.

You should not change the inner text of the `Loving` label.""",
        codeSnippet: """<h2>CatPhotoApp</h2>
<main>
  <p>Click here to view more <a href="#">cat photos</a>.</p>

  <a href="#"><img src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/relaxing-cat.jpg" alt="A cute orange cat lying on its back."></a>

  <p>Things cats love:</p>
  <ul>
    <li>catnip</li>
    <li>laser pointers</li>
    <li>lasagna</li>
  </ul>
  <p>Top 3 things cats hate:</p>
  <ol>
    <li>flea treatment</li>
    <li>thunder</li>
    <li>other cats</li>
  </ol>
  <form action="https://www.freecatphotoapp.com/submit-cat-photo">
    <label for="indoor"><input id="indoor" type="radio" name="indoor-outdoor" value="indoor" checked> Indoor</label>
    <label for="outdoor"><input id="outdoor" type="radio" name="indoor-outdoor" value="outdoor"> Outdoor</label><br>
    <label for="loving"><input id="loving" type="checkbox" name="personality" value="loving" checked> Loving</label>
    <label for="lazy"><input id="lazy" type="checkbox" name="personality" value="lazy"> Lazy</label>
    <label for="energetic"><input id="energetic" type="checkbox" name="personality" value="energetic"> Energetic</label><br>
    <input type="text" placeholder="cat photo URL" required>
    <button type="submit">Submit</button>
  </form>
</main>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Nest Many Elements within a Single div Element""",
        body: """The `div` element, also known as a division element, is a general purpose container for other elements.

The `div` element is probably the most commonly used HTML element of all.

Just like any other non-self-closing element, you can open a `div` element with `` and close it on another line with ``.

Nest your "Things cats love" and "Top 3 things cats hate" lists all within a single `div` element.

Hint: Try putting your opening `div` tag above your "Things cats love" `p` element and your closing `div` tag after your closing `ol` tag so that both of your lists are within one `div`.

Hint: Your `p` elements should be nested inside your `div` element.

Your `ul` element should be nested inside your `div` element.

Your `ol` element should be nested inside your `div` element.

Your `div` element should have a closing tag.""",
        codeSnippet: """<h2>CatPhotoApp</h2>
<main>
  <p>Click here to view more <a href="#">cat photos</a>.</p>
  
  <a href="#"><img src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/relaxing-cat.jpg" alt="A cute orange cat lying on its back."></a>
  <div>
    <p>Things cats love:</p>
    <ul>
      <li>catnip</li>
      <li>laser pointers</li>
      <li>lasagna</li>
    </ul>
    <p>Top 3 things cats hate:</p>
    <ol>
      <li>flea treatment</li>
      <li>thunder</li>
      <li>other cats</li>
    </ol>
  </div>
  <form action="https://www.freecatphotoapp.com/submit-cat-photo">
    <label for="indoor"><input id="indoor" type="radio" name="indoor-outdoor" value="indoor" checked> Indoor</label>
    <label for="outdoor"><input id="outdoor" type="radio" name="indoor-outdoor" value="outdoor"> Outdoor</label><br>
    <label for="loving"><input id="loving" type="checkbox" name="personality" value="loving" checked> Loving</label>
    <label for="lazy"><input id="lazy" type="checkbox" name="personality" value="lazy"> Lazy</label>
    <label for="energetic"><input id="energetic" type="checkbox" name="personality" value="energetic"> Energetic</label><br>
    <input type="text" placeholder="cat photo URL" required>
    <button type="submit">Submit</button>
  </form>
</main>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Declare the Doctype of an HTML Document""",
        body: """The challenges so far have covered specific HTML elements and their uses. However, there are a few elements that give overall structure to your page, and should be included in every HTML document.

At the top of your document, you need to tell the browser which version of HTML your page is using. HTML is an evolving language, and is updated regularly. Most major browsers support the latest specification, which is HTML5. However, older web pages may use previous versions of the language.

You tell the browser this information by adding the `` tag on the first line, where the `...` part is the version of HTML. For HTML5, you use ``.

The `!` and uppercase `DOCTYPE` is important, especially for older browsers. The `html` is not case sensitive.

Next, the rest of your HTML code needs to be wrapped in `html` tags. The opening `` goes directly below the `` line, and the closing `` goes at the end of the page.

Here's an example of the page structure. Your HTML code would go in the space between the two `html` tags.

Add a `DOCTYPE` tag for HTML5 to the top of the blank HTML document in the code editor. Under it, add opening and closing `html` tags, which wrap around an `h1` element. The heading can include any text.

Hint: Your code should include a `` tag.

There should be one `html` element.

The `html` tags should wrap around one `h1` element.""",
        codeSnippet: """<!DOCTYPE html>
<html>
  <h1> Hello world </h1>
</html>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Define the Head and Body of an HTML Document""",
        body: """You can add another level of organization in your HTML document within the `html` tags with the `head` and `body` elements. Any markup with information about your page would go into the `head` tag. Then any markup with the content of the page (what displays for a user) would go into the `body` tag.

Metadata elements, such as `link`, `meta`, `title`, and `style`, typically go inside the `head` element.

Here's an example of a page's layout:

Edit the markup so there's a `head` and a `body`. The `head` element should only include the `title`, and the `body` element should only include the `h1` and `p`.

Hint: There should be only one `head` element on the page.

There should be only one `body` element on the page.

The `head` element should be a child of the `html` element.

The `body` element should be a child of the `html` element.

The `head` element should wrap around the `title` element.

The `body` element should wrap around both the `h1` and `p` elements.""",
        codeSnippet: """<!DOCTYPE html>
<html>
 <head>
  <title>The best page ever</title>
 </head>
 <body>
  <h1>The best page ever</h1>
  <p>Cat ipsum dolor sit amet, jump launch to pounce upon little yarn mouse, bare fangs at toy run hide in litter box until treats are fed. Go into a room to decide you didn't want to be in there anyway. I like big cats and i can not lie kitty ipsum dolor sit amet, shed everywhere shed everywhere stretching attack your ankles chase the red dot, hairball run catnip eat the grass sniff. Meow i could pee on this if i had the energy for slap owner's face at 5am until human fills food dish yet scamper. Knock dish off table head butt cant eat out of my own dish scratch the furniture. Make meme, make cute face. Sleep in the bathroom sink chase laser but pee in the shoe. Paw at your fat belly licks your face and eat grass, throw it back up kitty ipsum dolor sit amet, shed everywhere shed everywhere stretching attack your ankles chase the red dot, hairball run catnip eat the grass sniff.</p>
 </body>
</html>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Change the Color of Text""",
        body: """Now let's change the color of some of our text.

We can do this by changing the `style` of your `h2` element.

The property that is responsible for the color of an element's text is the `color` style property.

Here's how you would set your `h2` element's text color to blue:

Note that it is a good practice to end inline `style` declarations with a `;` .

Change your `h2` element's style so that its text color is red.

Hint: Your `h2` element should have a `style` declaration.

Your `h2` element should have color set to `red`.

Your `style` declaration should end with a `;` .""",
        codeSnippet: """<h2 style="color: red;">CatPhotoApp</h2>
<main>
  <p>Click here to view more <a href="#">cat photos</a>.</p>

  <a href="#"><img src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/relaxing-cat.jpg" alt="A cute orange cat lying on its back."></a>

  <div>
    <p>Things cats love:</p>
    <ul>
      <li>catnip</li>
      <li>laser pointers</li>
      <li>lasagna</li>
    </ul>
    <p>Top 3 things cats hate:</p>
    <ol>
      <li>flea treatment</li>
      <li>thunder</li>
      <li>other cats</li>
    </ol>
  </div>

  <form action="https://freecatphotoapp.com/submit-cat-photo">
    <label><input type="radio" name="indoor-outdoor" checked> Indoor</label>
    <label><input type="radio" name="indoor-outdoor"> Outdoor</label><br>
    <label><input type="checkbox" name="personality" checked> Loving</label>
    <label><input type="checkbox" name="personality"> Lazy</label>
    <label><input type="checkbox" name="personality"> Energetic</label><br>
    <input type="text" placeholder="cat photo URL" required>
    <button type="submit">Submit</button>
  </form>
</main>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Use CSS Selectors to Style Elements""",
        body: """With CSS, there are hundreds of CSS properties that you can use to change the way an element looks on your page.

When you entered `CatPhotoApp`, you were styling that individual `h2` element with inline CSS, which stands for Cascading Style Sheets.

That's one way to specify the style of an element, but there's a better way to apply CSS.

At the top of your code, create a `style` block like this:

Inside that style block, you can create a CSS selector for all `h2` elements. For example, if you wanted all `h2` elements to be red, you would add a style rule that looks like this:

Note that it's important to have both opening and closing curly braces (`{` and `}`) around each element's style rule(s). You also need to make sure that your element's style definition is between the opening and closing style tags. Finally, be sure to add a semicolon to the end of each of your element's style rules.

Delete your `h2` element's style attribute, and instead create a CSS `style` block. Add the necessary CSS to turn all `h2` elements blue.

Hint: The `style` attribute should be removed from your `h2` element.

You should create a `style` element.

Your `h2` element should be blue.

Your stylesheet `h2` declaration should be valid with a semicolon and closing brace.

All your `style` elements should be valid and have closing tags.""",
        codeSnippet: """<style>
  h2 {
    color: blue;
  }
</style>
<h2>CatPhotoApp</h2>
<main>
  <p>Click here to view more <a href="#">cat photos</a>.</p>

  <a href="#"><img src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/relaxing-cat.jpg" alt="A cute orange cat lying on its back."></a>

  <div>
    <p>Things cats love:</p>
    <ul>
      <li>catnip</li>
      <li>laser pointers</li>
      <li>lasagna</li>
    </ul>
    <p>Top 3 things cats hate:</p>
    <ol>
      <li>flea treatment</li>
      <li>thunder</li>
      <li>other cats</li>
    </ol>
  </div>

  <form action="https://freecatphotoapp.com/submit-cat-photo">
    <label><input type="radio" name="indoor-outdoor" checked> Indoor</label>
    <label><input type="radio" name="indoor-outdoor"> Outdoor</label><br>
    <label><input type="checkbox" name="personality" checked> Loving</label>
    <label><input type="checkbox" name="personality"> Lazy</label>
    <label><input type="checkbox" name="personality"> Energetic</label><br>
    <input type="text" placeholder="cat photo URL" required>
    <button type="submit">Submit</button>
  </form>
</main>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Use a CSS Class to Style an Element""",
        body: """Classes are reusable styles that can be added to HTML elements.

Here's an example CSS class declaration:

You can see that we've created a CSS class called `blue-text` within the `` tag. You can apply a class to an HTML element like this: `CatPhotoApp`. Note that in your CSS `style` element, class names start with a period. In your HTML elements' class attribute, the class name does not include the period.

Inside your `style` element, change the `h2` selector to `.red-text` and update the color's value from `blue` to `red`.

Give your `h2` element the `class` attribute with a value of `red-text`.

Hint: Your `h2` element should be red.

Your `h2` element should have the class `red-text`.

Your stylesheet should declare a `red-text` class and have its color set to `red`.

You should not use inline style declarations like `style="color: red"` in your `h2` element.""",
        codeSnippet: """<style>
  .red-text {
    color: red;
  }
</style>

<h2 class="red-text">CatPhotoApp</h2>
<main>
  <p>Click here to view more <a href="#">cat photos</a>.</p>
  
  <a href="#"><img src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/relaxing-cat.jpg" alt="A cute orange cat lying on its back."></a>
  
  <div>
    <p>Things cats love:</p>
    <ul>
      <li>catnip</li>
      <li>laser pointers</li>
      <li>lasagna</li>
    </ul>
    <p>Top 3 things cats hate:</p>
    <ol>
      <li>flea treatment</li>
      <li>thunder</li>
      <li>other cats</li>
    </ol>
  </div>
  
  <form action="https://freecatphotoapp.com/submit-cat-photo">
    <label><input type="radio" name="indoor-outdoor" checked> Indoor</label>
    <label><input type="radio" name="indoor-outdoor"> Outdoor</label><br>
    <label><input type="checkbox" name="personality" checked> Loving</label>
    <label><input type="checkbox" name="personality"> Lazy</label>
    <label><input type="checkbox" name="personality"> Energetic</label><br>
    <input type="text" placeholder="cat photo URL" required>
    <button type="submit">Submit</button>
  </form>
</main>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Style Multiple Elements with a CSS Class""",
        body: """Classes allow you to use the same CSS styles on multiple HTML elements. You can see this by applying your `red-text` class to the first `p` element.

Hint: Your `h2` element should be red.

Your `h2` element should have the class `red-text`.

Your first `p` element should be red.

Your second and third `p` elements should not be red.

Your first `p` element should have the class `red-text`.""",
        codeSnippet: """<style>
  .red-text {
    color: red;
  }
</style>

<h2 class="red-text">CatPhotoApp</h2>
<main>
  <p class="red-text">Click here to view more <a href="#">cat photos</a>.</p>
  
  <a href="#"><img src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/relaxing-cat.jpg" alt="A cute orange cat lying on its back."></a>
  
  <div>
    <p>Things cats love:</p>
    <ul>
      <li>catnip</li>
      <li>laser pointers</li>
      <li>lasagna</li>
    </ul>
    <p>Top 3 things cats hate:</p>
    <ol>
      <li>flea treatment</li>
      <li>thunder</li>
      <li>other cats</li>
    </ol>
  </div>
  
  <form action="https://freecatphotoapp.com/submit-cat-photo">
    <label><input type="radio" name="indoor-outdoor" checked> Indoor</label>
    <label><input type="radio" name="indoor-outdoor"> Outdoor</label><br>
    <label><input type="checkbox" name="personality" checked> Loving</label>
    <label><input type="checkbox" name="personality"> Lazy</label>
    <label><input type="checkbox" name="personality"> Energetic</label><br>
    <input type="text" placeholder="cat photo URL" required>
    <button type="submit">Submit</button>
  </form>
</main>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Change the Font Size of an Element""",
        body: """Font size is controlled by the `font-size` CSS property, like this:

Inside the same `` tag that contains your `red-text` class, create an entry for `p` elements and set the `font-size` to 16 pixels (`16px`).

Hint: Between the `style` tags, give the `p` elements `font-size` of `16px`. Browser and Text zoom should be at 100%.""",
        codeSnippet: """<style>
  .red-text {
    color: red;
  }
  p {
    font-size: 16px;
  }
</style>

<h2 class="red-text">CatPhotoApp</h2>
<main>
  <p class="red-text">Click here to view more <a href="#">cat photos</a>.</p>

  <a href="#"><img src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/relaxing-cat.jpg" alt="A cute orange cat lying on its back."></a>

  <div>
    <p>Things cats love:</p>
    <ul>
      <li>catnip</li>
      <li>laser pointers</li>
      <li>lasagna</li>
    </ul>
    <p>Top 3 things cats hate:</p>
    <ol>
      <li>flea treatment</li>
      <li>thunder</li>
      <li>other cats</li>
    </ol>
  </div>

  <form action="https://freecatphotoapp.com/submit-cat-photo">
    <label><input type="radio" name="indoor-outdoor" checked> Indoor</label>
    <label><input type="radio" name="indoor-outdoor"> Outdoor</label><br>
    <label><input type="checkbox" name="personality" checked> Loving</label>
    <label><input type="checkbox" name="personality"> Lazy</label>
    <label><input type="checkbox" name="personality"> Energetic</label><br>
    <input type="text" placeholder="cat photo URL" required>
    <button type="submit">Submit</button>
  </form>
</main>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Set the Font Family of an Element""",
        body: """You can set which font an element should use, by using the `font-family` property.

For example, if you wanted to set your `h2` element's font to `sans-serif`, you would use the following CSS:

Make all of your `p` elements use the `monospace` font.

Hint: Your `p` elements should use the font `monospace`.""",
        codeSnippet: """<style>
  .red-text {
    color: red;
  }

  p {
    font-size: 16px;
    font-family: monospace;
  }
</style>

<h2 class="red-text">CatPhotoApp</h2>
<main>
  <p class="red-text">Click here to view more <a href="#">cat photos</a>.</p>
  
  <a href="#"><img src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/relaxing-cat.jpg" alt="A cute orange cat lying on its back."></a>
  
  <div>
    <p>Things cats love:</p>
    <ul>
      <li>catnip</li>
      <li>laser pointers</li>
      <li>lasagna</li>
    </ul>
    <p>Top 3 things cats hate:</p>
    <ol>
      <li>flea treatment</li>
      <li>thunder</li>
      <li>other cats</li>
    </ol>
  </div>
  
  <form action="https://freecatphotoapp.com/submit-cat-photo">
    <label><input type="radio" name="indoor-outdoor" checked> Indoor</label>
    <label><input type="radio" name="indoor-outdoor"> Outdoor</label><br>
    <label><input type="checkbox" name="personality" checked> Loving</label>
    <label><input type="checkbox" name="personality"> Lazy</label>
    <label><input type="checkbox" name="personality"> Energetic</label><br>
    <input type="text" placeholder="cat photo URL" required>
    <button type="submit">Submit</button>
  </form>
</main>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Import a Google Font""",
        body: """In addition to specifying common fonts that are found on most operating systems, we can also specify non-standard, custom web fonts for use on our website. There are many sources for web fonts on the Internet. For this example we will focus on the Google Fonts library.

Google Fonts is a free library of web fonts that you can use in your CSS by referencing the font's URL.

So, let's go ahead and import and apply a Google font (note that if Google is blocked in your country, you will need to skip this challenge).

To import a Google Font, you can copy the font's URL from the Google Fonts library and then paste it in your HTML. For this challenge, we'll import the `Lobster` font. To do this, copy the following code snippet and paste it into the top of your code editor (before the opening `style` element):

Now you can use the `Lobster` font in your CSS by using `Lobster` as the FAMILY_NAME as in the following example:

The GENERIC_NAME is optional, and is a fallback font in case the other specified font is not available. This is covered in the next challenge.

Family names are case-sensitive and need to be wrapped in quotes if there is a space in the name. For example, you need quotes to use the `"Open Sans"` font, but not to use the `Lobster` font.

Import the `Lobster` font to your web page. Then, use an element selector to set `Lobster` as the `font-family` for your `h2` element.

Hint: You should import the `Lobster` font.

Your `h2` element should use the font `Lobster`.

You should only use an `h2` element selector to change the font.

Your `p` element should still use the font `monospace`.""",
        codeSnippet: """<link href="https://fonts.googleapis.com/css?family=Lobster" rel="stylesheet" type="text/css">
<style>
  .red-text {
    color: red;
  }

  p {
    font-size: 16px;
    font-family: monospace;
  }

  h2 {
    font-family: Lobster;
  }
</style>

<h2 class="red-text">CatPhotoApp</h2>
<main>
  <p class="red-text">Click here to view more <a href="#">cat photos</a>.</p>

  <a href="#"><img src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/relaxing-cat.jpg" alt="A cute orange cat lying on its back."></a>

  <div>
    <p>Things cats love:</p>
    <ul>
      <li>catnip</li>
      <li>laser pointers</li>
      <li>lasagna</li>
    </ul>
    <p>Top 3 things cats hate:</p>
    <ol>
      <li>flea treatment</li>
      <li>thunder</li>
      <li>other cats</li>
    </ol>
  </div>

  <form action="https://freecatphotoapp.com/submit-cat-photo">
    <label><input type="radio" name="indoor-outdoor" checked> Indoor</label>
    <label><input type="radio" name="indoor-outdoor"> Outdoor</label><br>
    <label><input type="checkbox" name="personality" checked> Loving</label>
    <label><input type="checkbox" name="personality"> Lazy</label>
    <label><input type="checkbox" name="personality"> Energetic</label><br>
    <input type="text" placeholder="cat photo URL" required>
    <button type="submit">Submit</button>
  </form>
</main>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Specify How Fonts Should Degrade""",
        body: """There are several default fonts that are available in all browsers. These generic font families include `monospace`, `serif` and `sans-serif`.

When one font isn't available, you can tell the browser to "degrade" to another font.

For example, if you wanted an element to use the `Helvetica` font, but degrade to the `sans-serif` font when `Helvetica` isn't available, you will specify it as follows:

Generic font family names are not case-sensitive. Also, they do not need quotes because they are CSS keywords.

To begin, apply the `monospace` font to the `h2` element, so that it now has two fonts - `Lobster` and `monospace`.

In the last challenge, you imported the `Lobster` font using the `link` tag. Now comment out that import of the `Lobster` font (using the HTML comments you learned before) from Google Fonts so that it isn't available anymore. Notice how your `h2` element degrades to the `monospace` font.

**Note:** If you have the `Lobster` font installed on your computer, you won't see the degradation because your browser is able to find the font.

Hint: Your h2 element should use the font `Lobster`.

Your h2 element should degrade to the font `monospace` when `Lobster` is not available.

You should comment out your call to Google for the `Lobster` font by putting ``.""",
        codeSnippet: """<!--<link href="https://fonts.googleapis.com/css?family=Lobster" rel="stylesheet" type="text/css">-->
<style>
  .red-text {
    color: red;
  }

  h2 {
    font-family: Lobster, monospace;
  }

  p {
    font-size: 16px;
    font-family: monospace;
  }
</style>

<h2 class="red-text">CatPhotoApp</h2>
<main>
  <p class="red-text">Click here to view more <a href="#">cat photos</a>.</p>
  
  <a href="#"><img src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/relaxing-cat.jpg" alt="A cute orange cat lying on its back."></a>
  
  <div>
    <p>Things cats love:</p>
    <ul>
      <li>catnip</li>
      <li>laser pointers</li>
      <li>lasagna</li>
    </ul>
    <p>Top 3 things cats hate:</p>
    <ol>
      <li>flea treatment</li>
      <li>thunder</li>
      <li>other cats</li>
    </ol>
  </div>
  
  <form action="https://freecatphotoapp.com/submit-cat-photo">
    <label><input type="radio" name="indoor-outdoor" checked> Indoor</label>
    <label><input type="radio" name="indoor-outdoor"> Outdoor</label><br>
    <label><input type="checkbox" name="personality" checked> Loving</label>
    <label><input type="checkbox" name="personality"> Lazy</label>
    <label><input type="checkbox" name="personality"> Energetic</label><br>
    <input type="text" placeholder="cat photo URL" required>
    <button type="submit">Submit</button>
  </form>
</main>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Size Your Images""",
        body: """CSS has a property called `width` that controls an element's width. Just like with fonts, we'll use `px` (pixels) to specify the image's width.

For example, if we wanted to create a CSS class called `larger-image` that gave HTML elements a width of 500 pixels, we'd use:

Create a class called `smaller-image` and use it to resize the image so that it's only 100 pixels wide.

Hint: Your `img` element should have the class `smaller-image`.

Your image should be 100 pixels wide.""",
        codeSnippet: """<link href="https://fonts.googleapis.com/css?family=Lobster" rel="stylesheet" type="text/css">
<style>
  .red-text {
    color: red;
  }

  h2 {
    font-family: Lobster, monospace;
  }

  p {
    font-size: 16px;
    font-family: monospace;
  }

  .smaller-image {
    width: 100px;
  }
</style>

<h2 class="red-text">CatPhotoApp</h2>
<main>
  <p class="red-text">Click here to view more <a href="#">cat photos</a>.</p>
  
  <a href="#"><img class="smaller-image" src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/relaxing-cat.jpg" alt="A cute orange cat lying on its back."></a>
  
  <div>
    <p>Things cats love:</p>
    <ul>
      <li>catnip</li>
      <li>laser pointers</li>
      <li>lasagna</li>
    </ul>
    <p>Top 3 things cats hate:</p>
    <ol>
      <li>flea treatment</li>
      <li>thunder</li>
      <li>other cats</li>
    </ol>
  </div>
  
  <form action="https://freecatphotoapp.com/submit-cat-photo">
    <label><input type="radio" name="indoor-outdoor" checked> Indoor</label>
    <label><input type="radio" name="indoor-outdoor"> Outdoor</label><br>
    <label><input type="checkbox" name="personality" checked> Loving</label>
    <label><input type="checkbox" name="personality"> Lazy</label>
    <label><input type="checkbox" name="personality"> Energetic</label><br>
    <input type="text" placeholder="cat photo URL" required>
    <button type="submit">Submit</button>
  </form>
</main>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Add Borders Around Your Elements""",
        body: """CSS borders have properties like `style`, `color` and `width`.

For example, if we wanted to create a red, 5 pixel border around an HTML element, we could use this class:

Create a class called `thick-green-border`. This class should add a 10px, solid, green border around an HTML element. Apply the class to your cat photo.

Remember that you can apply multiple classes to an element using its `class` attribute, by separating each class name with a space. For example:

Hint: Your `img` element should have the class `smaller-image`.

Your `img` element should have the class `thick-green-border`.

Your image should have a border width of `10px`.

Your image should have a border style of `solid`.

The border around your `img` element should be green.""",
        codeSnippet: """<link href="https://fonts.googleapis.com/css?family=Lobster" rel="stylesheet" type="text/css">
<style>
  .red-text {
    color: red;
  }

  h2 {
    font-family: Lobster, monospace;
  }

  p {
    font-size: 16px;
    font-family: monospace;
  }

  .smaller-image {
    width: 100px;
  }

  .thick-green-border {
    border-width: 10px;
    border-color: green;
    border-style: solid;
  }
</style>

<h2 class="red-text">CatPhotoApp</h2>
<main>
  <p class="red-text">Click here to view more <a href="#">cat photos</a>.</p>

  <a href="#"><img class="smaller-image thick-green-border" src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/relaxing-cat.jpg" alt="A cute orange cat lying on its back."></a>

  <div>
    <p>Things cats love:</p>
    <ul>
      <li>catnip</li>
      <li>laser pointers</li>
      <li>lasagna</li>
    </ul>
    <p>Top 3 things cats hate:</p>
    <ol>
      <li>flea treatment</li>
      <li>thunder</li>
      <li>other cats</li>
    </ol>
  </div>

  <form action="https://freecatphotoapp.com/submit-cat-photo">
    <label><input type="radio" name="indoor-outdoor" checked> Indoor</label>
    <label><input type="radio" name="indoor-outdoor"> Outdoor</label><br>
    <label><input type="checkbox" name="personality" checked> Loving</label>
    <label><input type="checkbox" name="personality"> Lazy</label>
    <label><input type="checkbox" name="personality"> Energetic</label><br>
    <input type="text" placeholder="cat photo URL" required>
    <button type="submit">Submit</button>
  </form>
</main>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Add Rounded Corners with border-radius""",
        body: """Your cat photo currently has sharp corners. We can round out those corners with a CSS property called `border-radius`.

You can specify a `border-radius` with pixels. Give your cat photo a `border-radius` of `10px`.

**Note:** This challenge allows for multiple possible solutions. For example, you may add `border-radius` to either the `.thick-green-border` class or the `.smaller-image` class.

Hint: Your image element should have the class `thick-green-border`.

Your image should have a border radius of `10px`.""",
        codeSnippet: """<link href="https://fonts.googleapis.com/css?family=Lobster" rel="stylesheet" type="text/css">
<style>
  .red-text {
    color: red;
  }

  h2 {
    font-family: Lobster, monospace;
  }

  p {
    font-size: 16px;
    font-family: monospace;
  }

  .thick-green-border {
    border-color: green;
    border-width: 10px;
    border-style: solid;
  }

  .smaller-image {
    width: 100px;
    border-radius: 10px;
  }
</style>

<h2 class="red-text">CatPhotoApp</h2>
<main>
  <p class="red-text">Click here to view more <a href="#">cat photos</a>.</p>

  <a href="#"><img class="smaller-image thick-green-border" src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/relaxing-cat.jpg" alt="A cute orange cat lying on its back."></a>

  <div>
    <p>Things cats love:</p>
    <ul>
      <li>catnip</li>
      <li>laser pointers</li>
      <li>lasagna</li>
    </ul>
    <p>Top 3 things cats hate:</p>
    <ol>
      <li>flea treatment</li>
      <li>thunder</li>
      <li>other cats</li>
    </ol>
  </div>

  <form action="https://freecatphotoapp.com/submit-cat-photo">
    <label><input type="radio" name="indoor-outdoor" checked> Indoor</label>
    <label><input type="radio" name="indoor-outdoor"> Outdoor</label><br>
    <label><input type="checkbox" name="personality" checked> Loving</label>
    <label><input type="checkbox" name="personality"> Lazy</label>
    <label><input type="checkbox" name="personality"> Energetic</label><br>
    <input type="text" placeholder="cat photo URL" required>
    <button type="submit">Submit</button>
  </form>
</main>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Make Circular Images with a border-radius""",
        body: """In addition to pixels, you can also specify the `border-radius` using a percentage.

Give your cat photo a `border-radius` of `50%`.

Hint: Your image should have a border radius of `50%`, making it perfectly circular.

The `border-radius` value should use a percentage value of `50%`.""",
        codeSnippet: """<link href="https://fonts.googleapis.com/css?family=Lobster" rel="stylesheet" type="text/css">
<style>
  .red-text {
    color: red;
  }

  h2 {
    font-family: Lobster, monospace;
  }

  p {
    font-size: 16px;
    font-family: monospace;
  }

  .thick-green-border {
    border-color: green;
    border-width: 10px;
    border-style: solid;
    border-radius: 10px;
  }

  .smaller-image {
    width: 100px;
    border-radius: 50%;
  }
</style>

<h2 class="red-text">CatPhotoApp</h2>
<main>
  <p class="red-text">Click here to view more <a href="#">cat photos</a>.</p>

  <a href="#"><img class="smaller-image thick-green-border" src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/relaxing-cat.jpg" alt="A cute orange cat lying on its back."></a>

  <div>
    <p>Things cats love:</p>
    <ul>
      <li>catnip</li>
      <li>laser pointers</li>
      <li>lasagna</li>
    </ul>
    <p>Top 3 things cats hate:</p>
    <ol>
      <li>flea treatment</li>
      <li>thunder</li>
      <li>other cats</li>
    </ol>
  </div>

  <form action="https://freecatphotoapp.com/submit-cat-photo">
    <label><input type="radio" name="indoor-outdoor" checked> Indoor</label>
    <label><input type="radio" name="indoor-outdoor"> Outdoor</label><br>
    <label><input type="checkbox" name="personality" checked> Loving</label>
    <label><input type="checkbox" name="personality"> Lazy</label>
    <label><input type="checkbox" name="personality"> Energetic</label><br>
    <input type="text" placeholder="cat photo URL" required>
    <button type="submit">Submit</button>
  </form>
</main>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Give a Background Color to a div Element""",
        body: """You can set an element's background color with the `background-color` property.

For example, if you wanted an element's background color to be `green`, you'd put this within your `style` element:

Create a class called `silver-background` with the `background-color` of `silver`. Assign this class to your `div` element.

Hint: Your `div` element should have the class `silver-background`.

Your `div` element should have a silver background.

A class named `silver-background` should be defined within the `style` element and the value of `silver` should be assigned to the `background-color` property.""",
        codeSnippet: """<link href="https://fonts.googleapis.com/css?family=Lobster" rel="stylesheet" type="text/css">
<style>
  .red-text {
    color: red;
  }

  h2 {
    font-family: Lobster, monospace;
  }

  p {
    font-size: 16px;
    font-family: monospace;
  }

  .thick-green-border {
    border-color: green;
    border-width: 10px;
    border-style: solid;
    border-radius: 50%;
  }

  .smaller-image {
    width: 100px;
  }

  .silver-background {
    background-color: silver;
  }
</style>

<h2 class="red-text">CatPhotoApp</h2>
<main>
  <p class="red-text">Click here to view more <a href="#">cat photos</a>.</p>

  <a href="#"><img class="smaller-image thick-green-border" src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/relaxing-cat.jpg" alt="A cute orange cat lying on its back."></a>

  <div class="silver-background">
    <p>Things cats love:</p>
    <ul>
      <li>catnip</li>
      <li>laser pointers</li>
      <li>lasagna</li>
    </ul>
    <p>Top 3 things cats hate:</p>
    <ol>
      <li>flea treatment</li>
      <li>thunder</li>
      <li>other cats</li>
    </ol>
  </div>

  <form action="https://freecatphotoapp.com/submit-cat-photo">
    <label><input type="radio" name="indoor-outdoor" checked> Indoor</label>
    <label><input type="radio" name="indoor-outdoor"> Outdoor</label><br>
    <label><input type="checkbox" name="personality" checked> Loving</label>
    <label><input type="checkbox" name="personality"> Lazy</label>
    <label><input type="checkbox" name="personality"> Energetic</label><br>
    <input type="text" placeholder="cat photo URL" required>
    <button type="submit">Submit</button>
  </form>
</main>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Set the id of an Element""",
        body: """In addition to classes, each HTML element can also have an `id` attribute.

There are several benefits to using `id` attributes: You can use an `id` to style a single element and later you'll learn that you can use them to select and modify specific elements with JavaScript.

`id` attributes should be unique. Browsers won't enforce this, but it is a widely agreed upon best practice. So please don't give more than one element the same `id` attribute.

Here's an example of how you give your `h2` element the id of `cat-photo-app`:

Give your `form` element the id `cat-photo-form`.

Hint: Your `form` element should have the id of `cat-photo-form`.""",
        codeSnippet: """<link href="https://fonts.googleapis.com/css?family=Lobster" rel="stylesheet" type="text/css">
<style>
  .red-text {
    color: red;
  }

  h2 {
    font-family: Lobster, monospace;
  }

  p {
    font-size: 16px;
    font-family: monospace;
  }

  .thick-green-border {
    border-color: green;
    border-width: 10px;
    border-style: solid;
    border-radius: 50%;
  }

  .smaller-image {
    width: 100px;
  }

  .silver-background {
    background-color: silver;
  }
</style>

<h2 class="red-text">CatPhotoApp</h2>
<main>
  <p class="red-text">Click here to view more <a href="#">cat photos</a>.</p>
  
  <a href="#"><img class="smaller-image thick-green-border" src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/relaxing-cat.jpg" alt="A cute orange cat lying on its back."></a>
  
  <div class="silver-background">
    <p>Things cats love:</p>
    <ul>
      <li>catnip</li>
      <li>laser pointers</li>
      <li>lasagna</li>
    </ul>
    <p>Top 3 things cats hate:</p>
    <ol>
      <li>flea treatment</li>
      <li>thunder</li>
      <li>other cats</li>
    </ol>
  </div>
  
  <form action="https://freecatphotoapp.com/submit-cat-photo" id="cat-photo-form">
    <label><input type="radio" name="indoor-outdoor" checked> Indoor</label>
    <label><input type="radio" name="indoor-outdoor"> Outdoor</label><br>
    <label><input type="checkbox" name="personality" checked> Loving</label>
    <label><input type="checkbox" name="personality"> Lazy</label>
    <label><input type="checkbox" name="personality"> Energetic</label><br>
    <input type="text" placeholder="cat photo URL" required>
    <button type="submit">Submit</button>
  </form>
</main>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Use an id Attribute to Style an Element""",
        body: """One cool thing about `id` attributes is that, like classes, you can style them using CSS.

However, an `id` is not reusable and should only be applied to one element. An `id` also has a higher specificity (importance) than a class so if both are applied to the same element and have conflicting styles, the styles of the `id` will be applied.

Here's an example of how you can take your element with the `id` attribute of `cat-photo-element` and give it the background color of green. In your `style` element:

Note that inside your `style` element, you always reference classes by putting a `.` in front of their names. You always reference ids by putting a `#` in front of their names.

Try giving your form, which now has the `id` attribute of `cat-photo-form`, a green background.

Hint: Your `form` element should have the id of `cat-photo-form`.

Your `form` element should have the `background-color` of green.

Your `form` element should have an `id` attribute.

You should not give your `form` any `class` or `style` attributes.""",
        codeSnippet: """<link href="https://fonts.googleapis.com/css?family=Lobster" rel="stylesheet" type="text/css">
<style>
  .red-text {
    color: red;
  }

  h2 {
    font-family: Lobster, monospace;
  }

  p {
    font-size: 16px;
    font-family: monospace;
  }

  .thick-green-border {
    border-color: green;
    border-width: 10px;
    border-style: solid;
    border-radius: 50%;
  }

  .smaller-image {
    width: 100px;
  }

  .silver-background {
    background-color: silver;
  }

  #cat-photo-form {
    background-color: green;
  }
</style>

<h2 class="red-text">CatPhotoApp</h2>
<main>
  <p class="red-text">Click here to view more <a href="#">cat photos</a>.</p>
  
  <a href="#"><img class="smaller-image thick-green-border" src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/relaxing-cat.jpg" alt="A cute orange cat lying on its back."></a>
  
  <div class="silver-background">
    <p>Things cats love:</p>
    <ul>
      <li>catnip</li>
      <li>laser pointers</li>
      <li>lasagna</li>
    </ul>
    <p>Top 3 things cats hate:</p>
    <ol>
      <li>flea treatment</li>
      <li>thunder</li>
      <li>other cats</li>
    </ol>
  </div>
  
  <form action="https://freecatphotoapp.com/submit-cat-photo" id="cat-photo-form">
    <label><input type="radio" name="indoor-outdoor" checked> Indoor</label>
    <label><input type="radio" name="indoor-outdoor"> Outdoor</label><br>
    <label><input type="checkbox" name="personality" checked> Loving</label>
    <label><input type="checkbox" name="personality"> Lazy</label>
    <label><input type="checkbox" name="personality"> Energetic</label><br>
    <input type="text" placeholder="cat photo URL" required>
    <button type="submit">Submit</button>
  </form>
</main>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Adjust the Padding of an Element""",
        body: """Now let's put our Cat Photo App away for a little while and learn more about styling HTML.

You may have already noticed this, but all HTML elements are essentially little rectangles.

Three important properties control the space that surrounds each HTML element: `padding`, `border`, and `margin`.

An element's `padding` controls the amount of space between the element's content and its `border`.

Here, we can see that the blue box and the red box are nested within the yellow box. Note that the red box has more `padding` than the blue box.

When you increase the blue box's `padding`, it will increase the distance (`padding`) between the text and the border around it.

Change the `padding` of your blue box to match that of your red box.

Hint: Your `blue-box` class should give elements `20px` of `padding`.""",
        codeSnippet: """<style>
  .injected-text {
    margin-bottom: -25px;
    text-align: center;
  }

  .box {
    border-style: solid;
    border-color: black;
    border-width: 5px;
    text-align: center;
  }

  .yellow-box {
    background-color: yellow;
    padding: 10px;
  }

  .red-box {
    background-color: crimson;
    color: #fff;
    padding: 20px;
  }

  .blue-box {
    background-color: blue;
    color: #fff;
    padding: 20px;
  }
</style>
<h5 class="injected-text">margin</h5>

<div class="box yellow-box">
  <h5 class="box red-box">padding</h5>
  <h5 class="box blue-box">padding</h5>
</div>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Adjust the Margin of an Element""",
        body: """An element's `margin` controls the amount of space between an element's `border` and surrounding elements.

Here, we can see that the blue box and the red box are nested within the yellow box. Note that the red box has a bigger `margin` than the blue box, making it appear smaller.

When you increase the blue box's `margin`, it will increase the distance between its border and surrounding elements.

Change the `margin` of the blue box to match that of the red box.

Hint: Your `blue-box` class should give elements `20px` of `margin`.""",
        codeSnippet: """<style>
  .injected-text {
    margin-bottom: -25px;
    text-align: center;
  }

  .box {
    border-style: solid;
    border-color: black;
    border-width: 5px;
    text-align: center;
  }

  .yellow-box {
    background-color: yellow;
    padding: 10px;
  }

  .red-box {
    background-color: crimson;
    color: #fff;
    padding: 20px;
    margin: 20px;
  }

  .blue-box {
    background-color: blue;
    color: #fff;
    padding: 20px;
    margin: 20px;
  }
</style>
<h5 class="injected-text">margin</h5>

<div class="box yellow-box">
  <h5 class="box red-box">padding</h5>
  <h5 class="box blue-box">padding</h5>
</div>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Add a Negative Margin to an Element""",
        body: """An element's `margin` controls the amount of space between an element's `border` and surrounding elements.

If you set an element's `margin` to a negative value, the element will grow larger.

Try to set the `margin` to a negative value like the one for the red box.

Change the `margin` of the blue box to `-15px`, so it fills the entire horizontal width of the yellow box around it.

Hint: Your `blue-box` class should give elements `-15px` of `margin`.""",
        codeSnippet: """<style>
  .injected-text {
    margin-bottom: -25px;
    text-align: center;
  }

  .box {
    border-style: solid;
    border-color: black;
    border-width: 5px;
    text-align: center;
  }

  .yellow-box {
    background-color: yellow;
    padding: 10px;
  }

  .red-box {
    background-color: crimson;
    color: #fff;
    padding: 20px;
    margin: -15px;
  }

  .blue-box {
    background-color: blue;
    color: #fff;
    padding: 20px;
    margin: 20px;
    margin-top: -15px;
  }
</style>

<div class="box yellow-box">
  <h5 class="box red-box">padding</h5>
  <h5 class="box blue-box">padding</h5>
</div>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Add Different Padding to Each Side of an Element""",
        body: """Sometimes you will want to customize an element so that it has different amounts of `padding` on each of its sides.

CSS allows you to control the `padding` of all four individual sides of an element with the `padding-top`, `padding-right`, `padding-bottom`, and `padding-left` properties.

Give the blue box a `padding` of `40px` on its top and left side, but only `20px` on its bottom and right side.

Hint: Your `blue-box` class should give the top of the elements `40px` of `padding`.

Your `blue-box` class should give the right of the elements `20px` of `padding`.

Your `blue-box` class should give the bottom of the elements `20px` of `padding`.

Your `blue-box` class should give the left of the elements `40px` of `padding`.""",
        codeSnippet: """<style>
  .injected-text {
    margin-bottom: -25px;
    text-align: center;
  }

  .box {
    border-style: solid;
    border-color: black;
    border-width: 5px;
    text-align: center;
  }

  .yellow-box {
    background-color: yellow;
    padding: 10px;
  }

  .red-box {
    background-color: crimson;
    color: #fff;
    padding-top: 40px;
    padding-right: 20px;
    padding-bottom: 20px;
    padding-left: 40px;
  }

  .blue-box {
    background-color: blue;
    color: #fff;
    padding-top: 40px;
    padding-right: 20px;
    padding-bottom: 20px;
    padding-left: 40px;
  }
</style>
<h5 class="injected-text">margin</h5>

<div class="box yellow-box">
  <h5 class="box red-box">padding</h5>
  <h5 class="box blue-box">padding</h5>
</div>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Add Different Margins to Each Side of an Element""",
        body: """Sometimes you will want to customize an element so that it has a different `margin` on each of its sides.

CSS allows you to control the `margin` of all four individual sides of an element with the `margin-top`, `margin-right`, `margin-bottom`, and `margin-left` properties.

Give the blue box a `margin` of `40px` on its top and left side, but only `20px` on its bottom and right side.

Hint: Your `blue-box` class should give the top of elements `40px` of `margin`.

Your `blue-box` class should give the right of elements `20px` of `margin`.

Your `blue-box` class should give the bottom of elements `20px` of `margin`.

Your `blue-box` class should give the left of elements `40px` of `margin`.""",
        codeSnippet: """<style>
  .injected-text {
    margin-bottom: -25px;
    text-align: center;
  }

  .box {
    border-style: solid;
    border-color: black;
    border-width: 5px;
    text-align: center;
  }

  .yellow-box {
    background-color: yellow;
    padding: 10px;
  }

  .red-box {
    background-color: crimson;
    color: #fff;
    margin-top: 40px;
    margin-right: 20px;
    margin-bottom: 20px;
    margin-left: 40px;
  }

  .blue-box {
    background-color: blue;
    color: #fff;
    margin-top: 40px;
    margin-right: 20px;
    margin-bottom: 20px;
    margin-left: 40px;
  }
</style>
<h5 class="injected-text">margin</h5>

<div class="box yellow-box">
  <h5 class="box red-box">padding</h5>
  <h5 class="box blue-box">padding</h5>
</div>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Use Clockwise Notation to Specify the Padding of an Element""",
        body: """Instead of specifying an element's `padding-top`, `padding-right`, `padding-bottom`, and `padding-left` properties individually, you can specify them all in one line, like this:

These four values work like a clock: top, right, bottom, left, and will produce the exact same result as using the side-specific padding instructions.

Use Clockwise Notation to give the `.blue-box` class a `padding` of `40px` on its top and left side, but only `20px` on its bottom and right side.

Hint: Your `blue-box` class should give the top of elements `40px` of `padding`.

Your `blue-box` class should give the right of elements `20px` of `padding`.

Your `blue-box` class should give the bottom of elements `20px` of `padding`.

Your `blue-box` class should give the left of elements `40px` of `padding`.

You should use the clockwise notation to set the padding of `blue-box` class.""",
        codeSnippet: """<style>
  .injected-text {
    margin-bottom: -25px;
    text-align: center;
  }

  .box {
    border-style: solid;
    border-color: black;
    border-width: 5px;
    text-align: center;
  }

  .yellow-box {
    background-color: yellow;
    padding: 20px 40px 20px 40px;
  }

  .red-box {
    background-color: crimson;
    color: #fff;
    padding: 20px 40px 20px 40px;
  }

  .blue-box {
    background-color: blue;
    color: #fff;
    padding: 40px 20px 20px 40px;
  }
</style>
<h5 class="injected-text">margin</h5>

<div class="box yellow-box">
  <h5 class="box red-box">padding</h5>
  <h5 class="box blue-box">padding</h5>
</div>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Use Clockwise Notation to Specify the Margin of an Element""",
        body: """Let's try this again, but with `margin` this time.

Instead of specifying an element's `margin-top`, `margin-right`, `margin-bottom`, and `margin-left` properties individually, you can specify them all in one line, like this:

These four values work like a clock: top, right, bottom, left, and will produce the exact same result as using the side-specific margin instructions.

Use Clockwise Notation to give the element with the `blue-box` class a margin of `40px` on its top and left side, but only `20px` on its bottom and right side.

Hint: Your `blue-box` class should give the top of elements `40px` of `margin`.

Your `blue-box` class should give the right of elements `20px` of `margin`.

Your `blue-box` class should give the bottom of elements `20px` of `margin`.

Your `blue-box` class should give the left of elements `40px` of `margin`.

You should use the clockwise notation to set the margin of `blue-box` class.""",
        codeSnippet: """<style>
  .injected-text {
    margin-bottom: -25px;
    text-align: center;
  }

  .box {
    border-style: solid;
    border-color: black;
    border-width: 5px;
    text-align: center;
  }

  .yellow-box {
    background-color: yellow;
    padding: 20px 40px 20px 40px;
  }

  .red-box {
    background-color: crimson;
    color: #fff;
    margin: 20px 40px 20px 40px;
  }

  .blue-box {
    background-color: blue;
    color: #fff;
    margin: 40px 20px 20px 40px;
  }
</style>
<h5 class="injected-text">margin</h5>

<div class="box yellow-box">
  <h5 class="box red-box">padding</h5>
  <h5 class="box blue-box">padding</h5>
</div>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Use Attribute Selectors to Style Elements""",
        body: """You have been adding `id` or `class` attributes to elements that you wish to specifically style. These are known as ID and class selectors. There are other CSS Selectors you can use to select custom groups of elements to style.

Let's bring out CatPhotoApp again to practice using CSS Selectors.

For this challenge, you will use the `[attr=value]` attribute selector to style the checkboxes in CatPhotoApp. This selector matches and styles elements with a specific attribute value. For example, the below code changes the margins of all elements with the attribute `type` and a corresponding value of `radio`:

Using the `type` attribute selector, try to give the checkboxes in CatPhotoApp a top margin of 10px and a bottom margin of 15px.

Hint: The `type` attribute selector should be used to select the checkboxes.

The top margins of the checkboxes should be 10px.

The bottom margins of the checkboxes should be 15px.""",
        codeSnippet: """<link href="https://fonts.googleapis.com/css?family=Lobster" rel="stylesheet" type="text/css">
<style>
  .red-text {
    color: red;
  }

  h2 {
    font-family: Lobster, monospace;
  }

  p {
    font-size: 16px;
    font-family: monospace;
  }

  .thick-green-border {
    border-color: green;
    border-width: 10px;
    border-style: solid;
    border-radius: 50%;
  }

  .smaller-image {
    width: 100px;
  }

  .silver-background {
    background-color: silver;
  }
  [type='checkbox'] {
    margin-top: 10px;
    margin-bottom: 15px;
  }
</style>

<h2 class="red-text">CatPhotoApp</h2>
<main>
  <p class="red-text">Click here to view more <a href="#">cat photos</a>.</p>
  
  <a href="#"><img class="smaller-image thick-green-border" src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/relaxing-cat.jpg" alt="A cute orange cat lying on its back."></a>
  
  <div class="silver-background">
    <p>Things cats love:</p>
    <ul>
      <li>catnip</li>
      <li>laser pointers</li>
      <li>lasagna</li>
    </ul>
    <p>Top 3 things cats hate:</p>
    <ol>
      <li>flea treatment</li>
      <li>thunder</li>
      <li>other cats</li>
    </ol>
  </div>
  
  <form action="https://freecatphotoapp.com/submit-cat-photo" id="cat-photo-form">
    <label><input type="radio" name="indoor-outdoor" checked> Indoor</label>
    <label><input type="radio" name="indoor-outdoor"> Outdoor</label><br>
    <label><input type="checkbox" name="personality" checked> Loving</label>
    <label><input type="checkbox" name="personality"> Lazy</label>
    <label><input type="checkbox" name="personality"> Energetic</label><br>
    <input type="text" placeholder="cat photo URL" required>
    <button type="submit">Submit</button>
  </form>
</main>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Understand Absolute versus Relative Units""",
        body: """The last several challenges all set an element's margin or padding with pixels (`px`). Pixels are a type of length unit, which is what tells the browser how to size or space an item. In addition to `px`, CSS has a number of different length unit options that you can use.

The two main types of length units are absolute and relative. Absolute units tie to physical units of length. For example, `in` and `mm` refer to inches and millimeters, respectively. Absolute length units approximate the actual measurement on a screen, but there are some differences depending on a screen's resolution.

Relative units, such as `em` or `rem`, are relative to another length value. For example, `em` is based on the size of an element's font. If you use it to set the `font-size` property itself, it's relative to the parent's `font-size`.

**Note:** There are several relative unit options that are tied to the size of the viewport. They are covered in the Responsive Web Design Principles section.

Add a `padding` property to the element with class `red-box` and set it to `1.5em`.

Hint: Your `red-box` class should have a `padding` property.

Your `red-box` class should give elements 1.5em of `padding`.""",
        codeSnippet: """<style>
  .injected-text {
    margin-bottom: -25px;
    text-align: center;
  }

  .box {
    border-style: solid;
    border-color: black;
    border-width: 5px;
    text-align: center;
  }

  .yellow-box {
    background-color: yellow;
    padding: 20px 40px 20px 40px;
  }

  .red-box {
    background-color: red;
    margin: 20px 40px 20px 40px;
    padding: 1.5em;
  }

  .green-box {
    background-color: green;
    margin: 20px 40px 20px 40px;
  }
</style>
<h5 class="injected-text">margin</h5>

<div class="box yellow-box">
  <h5 class="box red-box">padding</h5>
  <h5 class="box green-box">padding</h5>
</div>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Style the HTML Body Element""",
        body: """Now let's start fresh and talk about CSS inheritance.

Every HTML page has a `body` element.

We can prove that the `body` element exists here by giving it a `background-color` of black.

We can do this by adding the following to our `style` element:

Hint: Your `body` element should have the `background-color` of black.

Your CSS rule should be properly formatted with both opening and closing curly brackets.

Your CSS rule should end with a semicolon.""",
        codeSnippet: """<style>
body {
  background-color: black;
}
</style>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Inherit Styles from the Body Element""",
        body: """Now we've proven that every HTML page has a `body` element, and that its `body` element can also be styled with CSS.

Remember, you can style your `body` element just like any other HTML element, and all your other elements will inherit your `body` element's styles.

First, create an `h1` element with the text `Hello World`.

Then, let's give all elements on your page the color of `green` by adding `color: green;` to your `body` element's style declaration.

Finally, give your `body` element the font-family of `monospace` by adding `font-family: monospace;` to your `body` element's style declaration.

Hint: You should create an `h1` element.

Your `h1` element should have the text `Hello World`.

Your `h1` element should have a closing tag.

Your `body` element should have the `color` property of `green`.

Your `body` element should have the `font-family` property of `monospace`.

Your `h1` element should inherit the font `monospace` from your `body` element.

Your `h1` element should inherit the color `green` from your `body` element.""",
        codeSnippet: """<style>
  body {
    background-color: black;
    font-family: monospace;
    color: green;
  }

</style>
<h1>Hello World!</h1>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Prioritize One Style Over Another""",
        body: """Sometimes your HTML elements will receive multiple styles that conflict with one another.

For example, your `h1` element can't be both green and pink at the same time.

Let's see what happens when we create a class that makes text pink, then apply it to an element. Will our class *override* the `body` element's `color: green;` CSS property?

Create a CSS class called `pink-text` that gives an element the color pink.

Give your `h1` element the class of `pink-text`.

Hint: Your `h1` element should have the class `pink-text`.

Your `` should have a `pink-text` CSS class that changes the `color`.

Your `h1` element should be pink.""",
        codeSnippet: """<style>
  body {
    background-color: black;
    font-family: monospace;
    color: green;
  }
  .pink-text {
    color: pink;
  }
</style>
<h1 class="pink-text">Hello World!</h1>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Override Styles in Subsequent CSS""",
        body: """Our `pink-text` class overrode our `body` element's CSS declaration!

We just proved that our classes will override the `body` element's CSS. So the next logical question is, what can we do to override our `pink-text` class?

Create an additional CSS class called `blue-text` that gives an element the color blue. Make sure it's below your `pink-text` class declaration.

Apply the `blue-text` class to your `h1` element in addition to your `pink-text` class, and let's see which one wins.

Applying multiple class attributes to an HTML element is done with a space between them like this:

**Note:** It doesn't matter which order the classes are listed in the HTML element.

However, the order of the `class` declarations in the `` section is what is important. The second declaration will always take precedence over the first. Because `.blue-text` is declared second, it overrides the attributes of `.pink-text`.

Hint: Your `h1` element should have the class `pink-text`.

Your `h1` element should have the class `blue-text`.

Both `blue-text` and `pink-text` should belong to the same `h1` element.

Your `h1` element should be blue.""",
        codeSnippet: """<style>
  body {
    background-color: black;
    font-family: monospace;
    color: green;
  }
  .pink-text {
    color: pink;
  }

  .blue-text {
    color: blue;
  }  
</style>
<h1 class="pink-text blue-text">Hello World!</h1>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Override Class Declarations by Styling ID Attributes""",
        body: """We just proved that browsers read CSS from top to bottom in order of their declaration. That means that, in the event of a conflict, the browser will use whichever CSS declaration came last. Notice that if we even had put `blue-text` before `pink-text` in our `h1` element's classes, it would still look at the declaration order and not the order of their use!

But we're not done yet. There are other ways that you can override CSS. Do you remember id attributes?

Let's override your `pink-text` and `blue-text` classes, and make your `h1` element orange, by giving the `h1` element an id and then styling that id.

Give your `h1` element the `id` attribute of `orange-text`. Remember, id styles look like this:

Leave the `blue-text` and `pink-text` classes on your `h1` element.

Create a CSS declaration for your `orange-text` id in your `style` element. Here's an example of what this looks like:

**Note:** It doesn't matter whether you declare this CSS above or below `pink-text` class, since the `id` attribute will always take precedence.

Hint: Your `h1` element should have the class `pink-text`.

Your `h1` element should have the class `blue-text`.

Your `h1` element should have the id of `orange-text`.

There should be only one `h1` element.

Your `orange-text` id should have a CSS declaration.

Your `h1` should not have any `style` attributes.

Your `h1` element should be orange.""",
        codeSnippet: """<style>
  body {
    background-color: black;
    font-family: monospace;
    color: green;
  }
  .pink-text {
    color: pink;
  }
  .blue-text {
    color: blue;
  }
  #orange-text {
    color: orange;
  }  
</style>
<h1 id="orange-text"  class="pink-text blue-text">Hello World!</h1>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Override Class Declarations with Inline Styles""",
        body: """So we've proven that id declarations override class declarations, regardless of where they are declared in your `style` element CSS.

There are other ways that you can override CSS. Do you remember inline styles?

Use an inline style to try to make our `h1` element white. Remember, inline styles look like this:

Leave the `blue-text` and `pink-text` classes on your `h1` element.

Hint: Your `h1` element should have the class `pink-text`.

Your `h1` element should have the class `blue-text`.

Your `h1` element should have the id of `orange-text`.

Your `h1` element should have an inline style.

Your `h1` element should be white.""",
        codeSnippet: """<style>
  body {
    background-color: black;
    font-family: monospace;
    color: green;
  }
  #orange-text {
    color: orange;
  }
  .pink-text {
    color: pink;
  }
  .blue-text {
    color: blue;
  }
</style>
<h1 id="orange-text" class="pink-text blue-text" style="color: white">Hello World!</h1>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Override All Other Styles by using Important""",
        body: """Yay! We just proved that inline styles will override all the CSS declarations in your `style` element.

But wait. There's one last way to override CSS. This is the most powerful method of all. But before we do it, let's talk about why you would ever want to override CSS.

In many situations, you will use CSS libraries. These may accidentally override your own CSS. So when you absolutely need to be sure that an element has specific CSS, you can use `!important`.

Let's go all the way back to our `pink-text` class declaration. Remember that our `pink-text` class was overridden by subsequent class declarations, id declarations, and inline styles.

Let's add the keyword `!important` to your pink-text element's color declaration to make 100% sure that your `h1` element will be pink.

An example of how to do this is:

Hint: Your `h1` element should have the class `pink-text`.

Your `h1` element should have the class `blue-text`.

Your `h1` element should have the `id` of `orange-text`.

Your `h1` element should have the inline style of `color: white`.

Your `pink-text` class declaration should have the `!important` keyword to override all other declarations.

Your `h1` element should be pink.""",
        codeSnippet: """<style>
  body {
    background-color: black;
    font-family: monospace;
    color: green;
  }
  #orange-text {
    color: orange;
  }
  .pink-text {
    color: pink !important;
  }
  .blue-text {
    color: blue;
  }
</style>
<h1 id="orange-text" class="pink-text blue-text" style="color: white">Hello World!</h1>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Use Hex Code for Specific Colors""",
        body: """Did you know there are other ways to represent colors in CSS? One of these ways is called hexadecimal code, or hex code for short.

We usually use decimals, or base 10 numbers, which use the symbols 0 to 9 for each digit. Hexadecimals (or hex) are base 16 numbers. This means it uses sixteen distinct symbols. Like decimals, the symbols 0-9 represent the values zero to nine. Then A,B,C,D,E,F represent the values ten to fifteen. Altogether, 0 to F can represent a digit in hexadecimal, giving us 16 total possible values. You can find more information about hexadecimal numbers here.

In CSS, we can use 6 hexadecimal digits to represent colors, two each for the red (R), green (G), and blue (B) components. For example, `#000000` is black and is also the lowest possible value. You can find more information about the RGB color system here.

Replace the word `black` in our `body` element's background-color with its hex code representation, `#000000`.

Hint: Your `body` element should have the `background-color` of black.

The hex code for the color black should be used instead of the word `black`.""",
        codeSnippet: """<style>
  body {
    background-color: #000000;
  }
</style>""",
        hasImage: false,
      )
    ],
  ),
  AppCourse(
    id: 'javascript-algorithms-and-data-structures',
    title: """JavaScript Algorithms and Data Structures""",
    description: """A freeCodeCamp curriculum covering JavaScript Algorithms and Data Structures, with 60 lessons extracted from the local curriculum assets.""",
    instructor: 'freeCodeCamp',
    category: 'Web Development',
    difficulty: 'Intermediate',
    icon: Icons.code,
    color: Colors.blue,
    duration: '4 weeks',
    lessons: [
      AppLesson(
        title: """Comment Your JavaScript Code""",
        body: """Comments are lines of code that JavaScript will intentionally ignore. Comments are a great way to leave notes to yourself and to other people who will later need to figure out what that code does.

There are two ways to write comments in JavaScript:

Using `//` will tell JavaScript to ignore the remainder of the text on the current line. This is an in-line comment:

You can make a multi-line comment beginning with `/*` and ending with `*/`. This is a multi-line comment:

**NOTE:** As you write code, you should regularly add comments to clarify the function of parts of your code. Good commenting can help communicate the intent of your code—both for others *and* for your future self.

Try creating one of each type of comment.

Hint: You should create a `//` style comment that contains at least five letters.

You should create a `/* */` style comment that contains at least five letters.""",
        codeSnippet: """// Fake Comment
/* Another Comment */""",
        hasImage: false,
      ),
      AppLesson(
        title: """Declare JavaScript Variables""",
        body: """In computer science, data is anything that is meaningful to the computer. JavaScript provides eight different data types which are `undefined`, `null`, `boolean`, `string`, `symbol`, `bigint`, `number`, and `object`.

For example, computers distinguish between numbers, such as the number `12`, and `strings`, such as `"12"`, `"dog"`, or `"123 cats"`, which are collections of characters. Computers can perform mathematical operations on a number, but not on a string.

Variables allow computers to store and manipulate data in a dynamic fashion. They do this by using a "label" to point to the data rather than using the data itself. Any of the eight data types may be stored in a variable.

Variables are similar to the x and y variables you use in mathematics, which means they're a simple name to represent the data we want to refer to. Computer variables differ from mathematical variables in that they can store different values at different times.

We tell JavaScript to create or declare a variable by putting the keyword `var` in front of it, like so:

creates a variable called `ourName`. In JavaScript we end statements with semicolons. Variable names can be made up of numbers, letters, and `\$` or `_`, but may not contain spaces or start with a number.

Use the `var` keyword to create a variable called `myName`.

**Hint** 
Look at the `ourName` example above if you get stuck.

Hint: You should declare `myName` with the `var` keyword, ending with a semicolon""",
        codeSnippet: """var myName;""",
        hasImage: false,
      ),
      AppLesson(
        title: """Storing Values with the Assignment Operator""",
        body: """In JavaScript, you can store a value in a variable with the assignment operator (`=`).

This assigns the `Number` value `5` to `myVariable`.

If there are any calculations to the right of the `=` operator, those are performed before the value is assigned to the variable on the left of the operator.

First, this code creates a variable named `myVar`. Then, the code assigns `5` to `myVar`. Now, if `myVar` appears again in the code, the program will treat it as if it is `5`.

Assign the value `7` to variable `a`.

Hint: You should not change code above the specified comment.

`a` should have a value of 7.""",
        codeSnippet: """var a;
a = 7;""",
        hasImage: false,
      ),
      AppLesson(
        title: """Assigning the Value of One Variable to Another""",
        body: """After a value is assigned to a variable using the assignment operator, you can assign the value of that variable to another variable using the assignment operator.

The above declares a `myVar` variable with no value, then assigns it the value `5`. Next, a variable named `myNum` is declared with no value. Then, the contents of `myVar` (which is `5`) is assigned to the variable `myNum`. Now, `myNum` also has the value of `5`.

Assign the contents of `a` to variable `b`.

Hint: You should not change code above the specified comment.

`b` should have a value of `7`.

`a` should be assigned to `b` with `=`.""",
        codeSnippet: """var a;
a = 7;
var b;
b = a;""",
        hasImage: false,
      ),
      AppLesson(
        title: """Initializing Variables with the Assignment Operator""",
        body: """It is common to initialize a variable to an initial value in the same line as it is declared.

Creates a new variable called `myVar` and assigns it an initial value of `0`.

Define a variable `a` with `var` and initialize it to a value of `9`.

Hint: You should initialize `a` to a value of `9`.""",
        codeSnippet: """var a = 9;""",
        hasImage: false,
      ),
      AppLesson(
        title: """Declare String Variables""",
        body: """Previously you used the following code to declare a variable:

But you can also declare a string variable like this:

`"your name"` is called a string literal. A string literal, or string, is a series of zero or more characters enclosed in single or double quotes.

Create two new string variables: `myFirstName` and `myLastName` and assign them the values of your first and last name, respectively.

Hint: `myFirstName` should be a string with at least one character in it.

`myLastName` should be a string with at least one character in it.""",
        codeSnippet: """var myFirstName = "Alan";
var myLastName = "Turing";""",
        hasImage: false,
      ),
      AppLesson(
        title: """Understanding Uninitialized Variables""",
        body: """When JavaScript variables are declared, they have an initial value of `undefined`. If you do a mathematical operation on an `undefined` variable your result will be `NaN` which means "Not a Number". If you concatenate a string with an `undefined` variable, you will get a string of `undefined`.

Initialize the three variables `a`, `b`, and `c` with `5`, `10`, and `"I am a"` respectively so that they will not be `undefined`.

Hint: `a` should be defined and have a final value of `6`.

`b` should be defined and have a final value of `15`.

`c` should not contain `undefined` and should have a final value of the string `I am a String!`

You should not change code below the specified comment.""",
        codeSnippet: """var a = 5;
var b = 10;
var c = "I am a";
a = a + 1;
b = b + 5;
c = c + " String!";""",
        hasImage: false,
      ),
      AppLesson(
        title: """Understanding Case Sensitivity in Variables""",
        body: """In JavaScript all variables and function names are case sensitive. This means that capitalization matters.

`MYVAR` is not the same as `MyVar` nor `myvar`. It is possible to have multiple distinct variables with the same name but different casing. It is strongly recommended that for the sake of clarity, you *do not* use this language feature.

**Best Practice**

Write variable names in JavaScript in camelCase. In camelCase, multi-word variable names have the first word in lowercase and the first letter of each subsequent word is capitalized.

**Examples:**

Modify the existing declarations and assignments so their names use camelCase.

Do not create any new variables.

Hint: `studlyCapVar` should be defined and have a value of `10`.

`properCamelCase` should be defined and have a value of the string `A String`.

`titleCaseOver` should be defined and have a value of `9000`.

`studlyCapVar` should use camelCase in both declaration and assignment sections.

`properCamelCase` should use camelCase in both declaration and assignment sections.

`titleCaseOver` should use camelCase in both declaration and assignment sections.""",
        codeSnippet: """var studlyCapVar;
var properCamelCase;
var titleCaseOver;

studlyCapVar = 10;
properCamelCase = "A String";
titleCaseOver = 9000;""",
        hasImage: false,
      ),
      AppLesson(
        title: """Explore Differences Between the var and let Keywords""",
        body: """One of the biggest problems with declaring variables with the `var` keyword is that you can easily overwrite variable declarations:

In the code above, the `camper` variable is originally declared as `James`, and is then overridden to be `David`. The console then displays the string `David`.

In a small application, you might not run into this type of problem. But as your codebase becomes larger, you might accidentally overwrite a variable that you did not intend to. Because this behavior does not throw an error, searching for and fixing bugs becomes more difficult.

A keyword called `let` was introduced in ES6, a major update to JavaScript, to solve this potential issue with the `var` keyword. You'll learn about other ES6 features in later challenges.

If you replace `var` with `let` in the code above, it results in an error:

The error can be seen in your browser console.

So unlike `var`, when you use `let`, a variable with the same name can only be declared once.

Update the code so it only uses the `let` keyword.

Hint: `var` should not exist in the code.

`catName` should be the string `Oliver`.

`catSound` should be the string `Meow!`""",
        codeSnippet: """let catName = "Oliver";
let catSound = "Meow!";""",
        hasImage: false,
      ),
      AppLesson(
        title: """Declare a Read-Only Variable with the const Keyword""",
        body: """The keyword `let` is not the only new way to declare variables. In ES6, you can also declare variables using the `const` keyword.

`const` has all the awesome features that `let` has, with the added bonus that variables declared using `const` are read-only. They are a constant value, which means that once a variable is assigned with `const`, it cannot be reassigned:

The console will display an error due to reassigning the value of `FAV_PET`.

You should always name variables you don't want to reassign using the `const` keyword. This helps when you accidentally attempt to reassign a variable that is meant to stay constant.

**Note:** It is common for developers to use uppercase variable identifiers for immutable values and lowercase or camelCase for mutable values (objects and arrays). You will learn more about objects, arrays, and immutable and mutable values in later challenges. Also in later challenges, you will see examples of uppercase, lowercase, or camelCase variable identifiers.

Change the code so that all variables are declared using `let` or `const`. Use `let` when you want the variable to change, and `const` when you want the variable to remain constant. Also, rename variables declared with `const` to conform to common practices. Do not change the strings assigned to the variables.

Hint: `var` should not exist in your code.

You should change `fCC` to all uppercase.

`FCC` should be a constant variable declared with `const`.

The string assigned to `FCC` should not be changed.

`fact` should be declared with `let`.

`console.log` should be changed to print the `FCC` and `fact` variables.""",
        codeSnippet: """const FCC = "freeCodeCamp";
let fact = "is cool!";

fact = "is awesome!";
console.log(FCC, fact);""",
        hasImage: false,
      ),
      AppLesson(
        title: """Add Two Numbers with JavaScript""",
        body: """`Number` is a data type in JavaScript which represents numeric data.

Now let's try to add two numbers using JavaScript.

JavaScript uses the `+` symbol as an addition operator when placed between two numbers.

**Example:**

`myVar` now has the value `15`.

Change the `0` so that sum will equal `20`.

Hint: `sum` should equal `20`.

You should use the `+` operator.""",
        codeSnippet: """const sum = 10 + 10;""",
        hasImage: false,
      ),
      AppLesson(
        title: """Subtract One Number from Another with JavaScript""",
        body: """We can also subtract one number from another.

JavaScript uses the `-` symbol for subtraction.

**Example**

`myVar` would have the value `6`.

Change the `0` so the difference is `12`.

Hint: The variable `difference` should be equal to `12`.

You should only subtract one number from `45`.""",
        codeSnippet: """const difference = 45 - 33;""",
        hasImage: false,
      ),
      AppLesson(
        title: """Multiply Two Numbers with JavaScript""",
        body: """We can also multiply one number by another.

JavaScript uses the `*` symbol for multiplication of two numbers.

**Example**

`myVar` would have the value `169`.

Change the `0` so that product will equal `80`.

Hint: The variable `product` should be equal to 80.

You should use the `*` operator.""",
        codeSnippet: """const product = 8 * 10;""",
        hasImage: false,
      ),
      AppLesson(
        title: """Divide One Number by Another with JavaScript""",
        body: """We can also divide one number by another.

JavaScript uses the `/` symbol for division.

**Example**

`myVar` now has the value `8`.

Change the `0` so that the `quotient` is equal to `2`.

Hint: The variable `quotient` should be equal to 2.

You should use the `/` operator.""",
        codeSnippet: """const quotient = 66 / 33;""",
        hasImage: false,
      ),
      AppLesson(
        title: """Increment a Number with JavaScript""",
        body: """You can easily increment or add one to a variable with the `++` operator.

is the equivalent of

**Note:** The entire line becomes `i++;`, eliminating the need for the equal sign.

Change the code to use the `++` operator on `myVar`.

Hint: `myVar` should equal `88`.

You should not use the assignment operator.

You should use the `++` operator.

You should not change code above the specified comment.""",
        codeSnippet: """let myVar = 87;
myVar++;""",
        hasImage: false,
      ),
      AppLesson(
        title: """Decrement a Number with JavaScript""",
        body: """You can easily decrement or decrease a variable by one with the `--` operator.

is the equivalent of

**Note:** The entire line becomes `i--;`, eliminating the need for the equal sign.

Change the code to use the `--` operator on `myVar`.

Hint: `myVar` should equal `10`.

`myVar = myVar - 1;` should be changed.

You should not assign `myVar` with `10`.

You should use the `--` operator on `myVar`.

You should not change code above the specified comment.""",
        codeSnippet: """let myVar = 11;
myVar--;""",
        hasImage: false,
      ),
      AppLesson(
        title: """Create Decimal Numbers with JavaScript""",
        body: """We can store decimal numbers in variables too. Decimal numbers are sometimes referred to as floating point numbers or floats.

**Note:** when you compute numbers, they are computed with finite precision. Operations using floating points may lead to different results than the desired outcome. If you are getting one of these results, open a topic on the freeCodeCamp forum.

Create a variable `myDecimal` and give it a decimal value with a fractional part (e.g. `5.7`).

Hint: `myDecimal` should be a number.

`myDecimal` should have a decimal point""",
        codeSnippet: """const myDecimal = 9.9;""",
        hasImage: false,
      ),
      AppLesson(
        title: """Multiply Two Decimals with JavaScript""",
        body: """In JavaScript, you can also perform calculations with decimal numbers, just like whole numbers.

Let's multiply two decimals together to get their product.

Change the `0.0` so that product will equal `5.0`.

Hint: The variable `product` should equal `5.0`.

You should use the `*` operator""",
        codeSnippet: """const product = 2.0 * 2.5;""",
        hasImage: false,
      ),
      AppLesson(
        title: """Divide One Decimal by Another with JavaScript""",
        body: """Now let's divide one decimal by another.

Change the `0.0` so that `quotient` will equal to `2.2`.

Hint: The variable `quotient` should equal `2.2`

You should use the `/` operator to divide 4.4 by 2

The quotient variable should only be assigned once""",
        codeSnippet: """const quotient = 4.4 / 2.0;""",
        hasImage: false,
      ),
      AppLesson(
        title: """Finding a Remainder in JavaScript""",
        body: """The remainder operator `%` gives the remainder of the division of two numbers.

**Example**

5 % 2 = 1
5 / 2 = 2 remainder 1
2 * 2 = 4
5 - 4 = 1

**Usage** 
In mathematics, a number can be checked to be even or odd by checking the remainder of the division of the number by `2`. Even numbers have a remainder of `0`, while odd numbers a remainder of `1`.

17 % 2 = 1
48 % 2 = 0

**Note:** The remainder operator is sometimes incorrectly referred to as the modulus operator. It is very similar to modulus, but does not work properly with negative numbers.

Set `remainder` equal to the remainder of `11` divided by `3` using the remainder (`%`) operator.

Hint: The variable `remainder` should be initialized

The value of `remainder` should be `2`

You should use the `%` operator""",
        codeSnippet: """const remainder = 11 % 3;""",
        hasImage: false,
      ),
      AppLesson(
        title: """Compound Assignment With Augmented Addition""",
        body: """In programming, it is common to use assignments to modify the contents of a variable. Remember that everything to the right of the equals sign is evaluated first, so we can say:

to add `5` to `myVar`. Since this is such a common pattern, there are operators which do both a mathematical operation and assignment in one step.

One such operator is the `+=` operator.

`6` would be displayed in the console.

Convert the assignments for `a`, `b`, and `c` to use the `+=` operator.

Hint: `a` should equal `15`.

`b` should equal `26`.

`c` should equal `19`.

You should use the `+=` operator for each variable.

You should not modify the code above the specified comment.""",
        codeSnippet: """let a = 3;
let b = 17;
let c = 12;

a += 12;
b += 9;
c += 7;""",
        hasImage: false,
      ),
      AppLesson(
        title: """Compound Assignment With Augmented Subtraction""",
        body: """Like the `+=` operator, `-=` subtracts a number from a variable.

will subtract `5` from `myVar`. This can be rewritten as:

Convert the assignments for `a`, `b`, and `c` to use the `-=` operator.

Hint: `a` should equal `5`.

`b` should equal `-6`.

`c` should equal `2`.

You should use the `-=` operator for each variable.

You should not modify the code above the specified comment.""",
        codeSnippet: """let a = 11;
let b = 9;
let c = 3;

a -= 6;
b -= 15;
c -= 1;""",
        hasImage: false,
      ),
      AppLesson(
        title: """Compound Assignment With Augmented Multiplication""",
        body: """The `*=` operator multiplies a variable by a number.

will multiply `myVar` by `5`. This can be rewritten as:

Convert the assignments for `a`, `b`, and `c` to use the `*=` operator.

Hint: `a` should equal `25`.

`b` should equal `36`.

`c` should equal `46`.

You should use the `*=` operator for each variable.

You should not modify the code above the specified comment.""",
        codeSnippet: """let a = 5;
let b = 12;
let c = 4.6;

a *= 5;
b *= 3;
c *= 10;""",
        hasImage: false,
      ),
      AppLesson(
        title: """Compound Assignment With Augmented Division""",
        body: """The `/=` operator divides a variable by another number.

Will divide `myVar` by `5`. This can be rewritten as:

Convert the assignments for `a`, `b`, and `c` to use the `/=` operator.

Hint: `a` should equal `4`.

`b` should equal `27`.

`c` should equal `3`.

You should use the `/=` operator for each variable.

You should not modify the code above the specified comment.""",
        codeSnippet: """let a = 48;
let b = 108;
let c = 33;

a /= 12;
b /= 4;
c /= 11;""",
        hasImage: false,
      ),
      AppLesson(
        title: """Escaping Literal Quotes in Strings""",
        body: """When you are defining a string you must start and end with a single or double quote. What happens when you need a literal quote: `"` or `'` inside of your string?

In JavaScript, you can escape a quote from considering it as an end of string quote by placing a backslash (`\\`) in front of the quote.

This signals to JavaScript that the following quote is not the end of the string, but should instead appear inside the string. So if you were to print this to the console, you would get:

Use backslashes to assign a string to the `myStr` variable so that if you were to print it to the console, you would see:

Hint: You should use two double quotes (`"`) and four escaped double quotes (`\\"`).

Variable `myStr` should contain the string: `I am a "double quoted" string inside "double quotes".`""",
        codeSnippet: """const myStr = "I am a \\"double quoted\\" string inside \\"double quotes\\".";""",
        hasImage: false,
      ),
      AppLesson(
        title: """Quoting Strings with Single Quotes""",
        body: """String values in JavaScript may be written with single or double quotes, as long as you start and end with the same type of quote. Unlike some other programming languages, single and double quotes work the same in JavaScript.

The reason why you might want to use one type of quote over the other is if you want to use both in a string. This might happen if you want to save a conversation in a string and have the conversation in quotes. Another use for it would be saving an `` tag with various attributes in quotes, all within a string.

However, this becomes a problem if you need to use the outermost quotes within it. Remember, a string has the same kind of quote at the beginning and end. But if you have that same quote somewhere in the middle, the string will stop early and throw an error.

Here `badStr` will throw an error.

In the goodStr above, you can use both quotes safely by using the backslash `\\` as an escape character.

**Note:** The backslash `\\` should not be confused with the forward slash `/`. They do not do the same thing.

Change the provided string to a string with single quotes at the beginning and end and no escape characters.

Right now, the `` tag in the string uses double quotes everywhere. You will need to change the outer quotes to single quotes so you can remove the escape characters.

Hint: You should remove all the backslashes (`\\`).

You should have two single quotes `'` and four double quotes `"`.""",
        codeSnippet: """const myStr = '<a href="http://www.example.com" target="_blank">Link</a>';""",
        hasImage: false,
      ),
      AppLesson(
        title: """Escape Sequences in Strings""",
        body: """Quotes are not the only characters that can be escaped inside a string. Escape sequences allow you to use characters you may not otherwise be able to use in a string.

CodeOutput\\'single quote\\"double quote\\\\backslash\\nnewline\\ttab\\rcarriage return\\bbackspace\\fform feed

*Note that the backslash itself must be escaped in order to display as a backslash.*

Assign the following three lines of text into the single variable `myStr` using escape sequences.

FirstLine
    \\SecondLine
ThirdLine

You will need to use escape sequences to insert special characters correctly. You will also need to follow the spacing as it looks above, with no spaces between escape sequences or words.

**Note:** The indentation for `SecondLine` is achieved with the tab escape character, not spaces.

Hint: `myStr` should not contain any spaces

`myStr` should contain the strings `FirstLine`, `SecondLine` and `ThirdLine` (remember case sensitivity)

`FirstLine` should be followed by the newline character `\\n`

`myStr` should contain a tab character `\\t` which follows a newline character

`SecondLine` should be preceded by the backslash character `\\`

There should be a newline character between `SecondLine` and `ThirdLine`

`myStr` should only contain characters shown in the instructions""",
        codeSnippet: """const myStr = "FirstLine\\n\\t\\\\SecondLine\\nThirdLine";""",
        hasImage: false,
      ),
      AppLesson(
        title: """Concatenating Strings with Plus Operator""",
        body: """In JavaScript, when the `+` operator is used with a `String` value, it is called the concatenation operator. You can build a new string out of other strings by concatenating them together.

**Example**

**Note:** Watch out for spaces. Concatenation does not add spaces between concatenated strings, so you'll need to add them yourself.

Example:

The string `I come first. I come second.` would be displayed in the console.

Build `myStr` from the strings `This is the start.` and `This is the end.` using the `+` operator. Be sure to include a space between the two strings.

Hint: `myStr` should have a single space character between the two strings.

`myStr` should have a value of the string `This is the start. This is the end.`

You should use the `+` operator to build `myStr`.

`myStr` should be created using the `const` keyword.

You should assign the result to the `myStr` variable.""",
        codeSnippet: """const myStr = "This is the start. " + "This is the end.";""",
        hasImage: false,
      ),
      AppLesson(
        title: """Concatenating Strings with the Plus Equals Operator""",
        body: """We can also use the `+=` operator to concatenate a string onto the end of an existing string variable. This can be very helpful to break a long string over several lines.

**Note:** Watch out for spaces. Concatenation does not add spaces between concatenated strings, so you'll need to add them yourself.

Example:

`ourStr` now has a value of the string `I come first. I come second.`.

Build `myStr` over several lines by concatenating these two strings: `This is the first sentence.` and `This is the second sentence.` using the `+=` operator. Use the `+=` operator similar to how it is shown in the example and be sure to include a space between the two strings. Start by assigning the first string to `myStr`, then add on the second string.

Hint: `myStr` should have a single space character between the two strings.

`myStr` should have a value of the string `This is the first sentence. This is the second sentence.`

You should use the `+=` operator to build `myStr`.""",
        codeSnippet: """let myStr = "This is the first sentence. ";
myStr += "This is the second sentence.";""",
        hasImage: false,
      ),
      AppLesson(
        title: """Constructing Strings with Variables""",
        body: """Sometimes you will need to build a string. By using the concatenation operator (`+`), you can insert one or more variables into a string you're building.

Example:

`ourStr` would have a value of the string `Hello, our name is freeCodeCamp, how are you?`.

Set `myName` to a string equal to your name and build `myStr` with `myName` between the strings `My name is ` and ` and I am well!`

Hint: `myName` should be set to a string at least 3 characters long.

You should use two `+` operators to build `myStr` with `myName` inside it.""",
        codeSnippet: """const myName = "Bob";
const myStr = "My name is " + myName + " and I am well!";""",
        hasImage: false,
      ),
      AppLesson(
        title: """Appending Variables to Strings""",
        body: """Just as we can build a string over multiple lines out of string literals, we can also append variables to a string using the plus equals (`+=`) operator.

Example:

`ourStr` would have the value `freeCodeCamp is awesome!`.

Set `someAdjective` to a string of at least 3 characters and append it to `myStr` using the `+=` operator.

Hint: `someAdjective` should be set to a string at least 3 characters long.

You should append `someAdjective` to `myStr` using the `+=` operator.""",
        codeSnippet: """const someAdjective = "neat";
let myStr = "Learning to code is ";
myStr += someAdjective;""",
        hasImage: false,
      ),
      AppLesson(
        title: """Find the Length of a String""",
        body: """You can find the length of a `String` value by writing `.length` after the string variable or string literal.

The value `10` would be displayed in the console. Note that the space character between "Alan" and "Peter" is also counted.

For example, if we created a variable `const firstName = "Ada"`, we could find out how long the string `Ada` is by using the `firstName.length` property.

Use the `.length` property to set `lastNameLength` to the number of characters in `lastName`.

Hint: You should not change the variable declarations in the `// Setup` section.

`lastNameLength` should be equal to eight.

You should be getting the length of `lastName` by using `.length` like this: `lastName.length`.""",
        codeSnippet: """let lastNameLength = 0;
const lastName = "Lovelace";
lastNameLength = lastName.length;""",
        hasImage: false,
      ),
      AppLesson(
        title: """Use Bracket Notation to Find the First Character in a String""",
        body: """Bracket notation is a way to get a character at a specific index within a string.

Most modern programming languages, like JavaScript, don't start counting at 1 like humans do. They start at 0. This is referred to as Zero-based indexing.

For example, the character at index 0 in the word `Charles` is `C`. So if `const firstName = "Charles"`, you can get the value of the first letter of the string by using `firstName[0]`.

Example:

`firstLetter` would have a value of the string `C`.

Use bracket notation to find the first character in the `lastName` variable and assign it to `firstLetterOfLastName`.

**Hint:** Try looking at the example above if you get stuck.

Hint: The `firstLetterOfLastName` variable should have the value of `L`.

You should use bracket notation.""",
        codeSnippet: """let firstLetterOfLastName = "";
const lastName = "Lovelace";

// Only change code below this line
firstLetterOfLastName = lastName[0];""",
        hasImage: false,
      ),
      AppLesson(
        title: """Understand String Immutability""",
        body: """In JavaScript, `String` values are immutable, which means that they cannot be altered once created.

For example, the following code will produce an error because the letter `B` in the string `Bob` cannot be changed to the letter `J`:

Note that this does *not* mean that `myStr` could not be re-assigned. The only way to change `myStr` would be to assign it with a new value, like this:

Correct the assignment to `myStr` so it contains the string value of `Hello World` using the approach shown in the example above.

Hint: `myStr` should have a value of the string `Hello World`.

You should not change the code above the specified comment.""",
        codeSnippet: """let myStr = "Jello World";
myStr = "Hello World";""",
        hasImage: false,
      ),
      AppLesson(
        title: """Use Bracket Notation to Find the Nth Character in a String""",
        body: """You can also use bracket notation to get the character at other positions within a string.

Remember that computers start counting at `0`, so the first character is actually the zeroth character.

Example:

`secondLetterOfFirstName` would have a value of the string `d`.

Let's try to set `thirdLetterOfLastName` to equal the third letter of the `lastName` variable using bracket notation.

**Hint:** Try looking at the example above if you get stuck.

Hint: The `thirdLetterOfLastName` variable should have the value of `v`.

You should use bracket notation.""",
        codeSnippet: """const lastName = "Lovelace";
const thirdLetterOfLastName = lastName[2];""",
        hasImage: false,
      ),
      AppLesson(
        title: """Use Bracket Notation to Find the Last Character in a String""",
        body: """In order to get the last letter of a string, you can subtract one from the string's length.

For example, if `const firstName = "Ada"`, you can get the value of the last letter of the string by using `firstName[firstName.length - 1]`.

Example:

`lastLetter` would have a value of the string `a`.

Use bracket notation to find the last character in the `lastName` variable.

**Hint:** Try looking at the example above if you get stuck.

Hint: `lastLetterOfLastName` should be the letter `e`.

You should use `.length` to get the last letter.""",
        codeSnippet: """const lastName = "Lovelace";
const lastLetterOfLastName = lastName[lastName.length - 1];""",
        hasImage: false,
      ),
      AppLesson(
        title: """Use Bracket Notation to Find the Nth-to-Last Character in a String""",
        body: """You can use the same principle we just used to retrieve the last character in a string to retrieve the Nth-to-last character.

For example, you can get the value of the third-to-last letter of the `const firstName = "Augusta"` string by using `firstName[firstName.length - 3]`

Example:

`thirdToLastLetter` would have a value of the string `s`.

Use bracket notation to find the second-to-last character in the `lastName` string.

**Hint:** Try looking at the example above if you get stuck.

Hint: `secondToLastLetterOfLastName` should be the letter `c`.

You should use `.length` to get the second last letter.""",
        codeSnippet: """const lastName = "Lovelace";
const secondToLastLetterOfLastName = lastName[lastName.length - 2];""",
        hasImage: false,
      ),
      AppLesson(
        title: """Word Blanks""",
        body: """You are provided sentences with some missing words, like nouns, verbs, adjectives and adverbs. You then fill in the missing pieces with words of your choice in a way that the completed sentence makes sense.

Consider this sentence:

This sentence has three missing pieces- an adjective, a verb and an adverb, and we can add words of our choice to complete it. We can then assign the completed sentence to a variable as follows:

In this challenge, we provide you with a noun, a verb, an adjective and an adverb. You need to form a complete sentence using words of your choice, along with the words we provide.

You will need to use the string concatenation operator `+` to build a new string, using the provided variables: `myNoun`, `myAdjective`, `myVerb`, and `myAdverb`. You will then assign the formed string to the `wordBlanks` variable. You should not change the words assigned to the variables.

You will also need to account for spaces in your string, so that the final sentence has spaces between all the words. The result should be a complete sentence.

Hint: `wordBlanks` should be a string.

You should not change the values assigned to `myNoun`, `myVerb`, `myAdjective` or `myAdverb`.

You should not directly use the values `dog`, `ran`, `big`, or `quickly` to create `wordBlanks`.

`wordBlanks` should contain all of the words assigned to the variables `myNoun`, `myVerb`, `myAdjective` and `myAdverb` separated by non-word characters (and any additional words of your choice).""",
        codeSnippet: """const myNoun = "dog";
const myAdjective = "big";
const myVerb = "ran";
const myAdverb = "quickly";

let wordBlanks = "Once there was a " + myNoun + " which was very " + myAdjective + ". ";
wordBlanks += "It " + myVerb + " " + myAdverb + " around the yard.";""",
        hasImage: false,
      ),
      AppLesson(
        title: """Store Multiple Values in one Variable using JavaScript Arrays""",
        body: """With JavaScript `array` variables, we can store several pieces of data in one place.

You start an array declaration with an opening square bracket, end it with a closing square bracket, and put a comma between each entry, like this:

Modify the new array `myArray` so that it contains both a string and a number (in that order).

Hint: `myArray` should be an array.

The first item in `myArray` should be a string.

The second item in `myArray` should be a number.""",
        codeSnippet: """const myArray = ["The Answer", 42];""",
        hasImage: false,
      ),
      AppLesson(
        title: """Nest one Array within Another Array""",
        body: """You can also nest arrays within other arrays, like below:

This is also called a multi-dimensional array.

Create a nested array called `myArray`.

Hint: `myArray` should have at least one array nested within another array.""",
        codeSnippet: """const myArray = [[1, 2, 3]];""",
        hasImage: false,
      ),
      AppLesson(
        title: """Access Array Data with Indexes""",
        body: """We can access the data inside arrays using indexes.

Array indexes are written in the same bracket notation that strings use, except that instead of specifying a character, they are specifying an entry in the array. Like strings, arrays use zero-based indexing, so the first element in an array has an index of `0`.

**Example**

The `console.log(array[0])` prints `50`, and `data` has the value `60`.

Create a variable called `myData` and set it to equal the first value of `myArray` using bracket notation.

Hint: The variable `myData` should equal the first value of `myArray`.

The data in variable `myArray` should be accessed using bracket notation.""",
        codeSnippet: """const myArray = [50, 60, 70];
const myData = myArray[0];""",
        hasImage: false,
      ),
      AppLesson(
        title: """Modify Array Data With Indexes""",
        body: """Unlike strings, the entries of arrays are mutable and can be changed freely, even if the array was declared with `const`.

**Example**

`ourArray` now has the value `[15, 40, 30]`.

**Note:** There shouldn't be any spaces between the array name and the square brackets, like `array [0]`. Although JavaScript is able to process this correctly, this may confuse other programmers reading your code.

Modify the data stored at index `0` of `myArray` to a value of `45`.

Hint: `myArray` should now be `[45, 64, 99]`.

You should be using correct index to modify the value in `myArray`.""",
        codeSnippet: """const myArray = [18, 64, 99];
myArray[0] = 45;""",
        hasImage: false,
      ),
      AppLesson(
        title: """Access Multi-Dimensional Arrays With Indexes""",
        body: """One way to think of a multi-dimensional array, is as an *array of arrays*. When you use brackets to access your array, the first set of brackets refers to the entries in the outermost (the first level) array, and each additional pair of brackets refers to the next level of entries inside.

**Example**

In this example, `subarray` has the value `[[10, 11, 12], 13, 14]`,
`nestedSubarray` has the value `[10, 11, 12]`, and `element` has the value `11` .

**Note:** There shouldn't be any spaces between the array name and the square brackets, like `array [0][0]` and even this `array [0] [0]` is not allowed. Although JavaScript is able to process this correctly, this may confuse other programmers reading your code.

Using bracket notation select an element from `myArray` such that `myData` is equal to `8`.

Hint: `myData` should be equal to `8`.

You should be using bracket notation to read the correct value from `myArray`.""",
        codeSnippet: """const myArray = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [[10, 11, 12], 13, 14]];
const myData = myArray[2][1];""",
        hasImage: false,
      ),
      AppLesson(
        title: """Manipulate Arrays With push Method""",
        body: """An easy way to append data to the end of an array is via the `push()` method.

The `push()` method takes one or more arguments and appends them to the end of the array, in the order in which they appear. It returns the new length of the array.

Examples:

`arr1` now has the value `[1, 2, 3, 4, 5]` and `arr2` has the value `["Stimpson", "J", "cat", ["happy", "joy"]]`.

Push `["dog", 3]` onto the end of the `myArray` variable.

Hint: `myArray` should now equal `[["John", 23], ["cat", 2], ["dog", 3]]`.""",
        codeSnippet: """const myArray = [["John", 23], ["cat", 2]];
myArray.push(["dog",3]);""",
        hasImage: false,
      ),
      AppLesson(
        title: """Manipulate Arrays With pop Method""",
        body: """Another way to change the data in an array is with the `.pop()` function.

`.pop()` is used to pop a value off of the end of an array. We can store this popped off value by assigning it to a variable. In other words, `.pop()` removes the last element from an array and returns that element.

Any type of entry can be popped off of an array - numbers, strings, even nested arrays.

The first `console.log` will display the value `6`, and the second will display the value `[1, 4]`.

Use the `.pop()` function to remove the last item from `myArray` and assign the popped off value to a new variable, `removedFromMyArray`.

Hint: `myArray` should only contain `[["John", 23]]`.

You should use `pop()` on `myArray`.

`removedFromMyArray` should only contain `["cat", 2]`.""",
        codeSnippet: """const myArray = [["John", 23], ["cat", 2]];
const removedFromMyArray = myArray.pop();""",
        hasImage: false,
      ),
      AppLesson(
        title: """Manipulate Arrays With shift Method""",
        body: """`pop()` always removes the last element of an array. What if you want to remove the first?

That's where `.shift()` comes in. It works just like `.pop()`, except it removes the first element instead of the last.

Example:

`removedFromOurArray` would have a value of the string `Stimpson`, and `ourArray` would have `["J", ["cat"]]`.

Use the `.shift()` function to remove the first item from `myArray` and assign the "shifted off" value to a new variable, `removedFromMyArray`.

Hint: `myArray` should now equal `[["dog", 3]]`.

`removedFromMyArray` should contain `["John", 23]`.""",
        codeSnippet: """const myArray = [["John", 23], ["dog", 3]];

// Only change code below this line
const removedFromMyArray = myArray.shift();""",
        hasImage: false,
      ),
      AppLesson(
        title: """Manipulate Arrays With unshift Method""",
        body: """Not only can you `shift` elements off of the beginning of an array, you can also `unshift` elements to the beginning of an array i.e. add elements in front of the array.

`.unshift()` works exactly like `.push()`, but instead of adding the element at the end of the array, `unshift()` adds the element at the beginning of the array.

Example:

After the `shift`, `ourArray` would have the value `["J", "cat"]`. After the `unshift`, `ourArray` would have the value `["Happy", "J", "cat"]`.

Add `["Paul", 35]` to the beginning of the `myArray` variable using `unshift()`.

Hint: `myArray` should now have `[["Paul", 35], ["dog", 3]]`.""",
        codeSnippet: """const myArray = [["John", 23], ["dog", 3]];
myArray.shift();
myArray.unshift(["Paul", 35]);""",
        hasImage: false,
      ),
      AppLesson(
        title: """Shopping List""",
        body: """Create a shopping list in the variable `myList`. The list should be a multi-dimensional array containing several sub-arrays.

The first element in each sub-array should contain a string with the name of the item. The second element should be a number representing the quantity i.e.

There should be at least 5 sub-arrays in the list.

Hint: `myList` should be an array.

The first elements in each of your sub-arrays should all be strings.

The second elements in each of your sub-arrays should all be numbers.

You should have at least 5 items in your list.""",
        codeSnippet: """const myList = [
  ["Candy", 10],
  ["Potatoes", 12],
  ["Eggs", 12],
  ["Catfood", 1],
  ["Toads", 9]
];""",
        hasImage: false,
      ),
      AppLesson(
        title: """Write Reusable JavaScript with Functions""",
        body: """In JavaScript, we can divide up our code into reusable parts called functions.

Here's an example of a function:

You can call or invoke this function by using its name followed by parentheses, like this: `functionName();` Each time the function is called it will print out the message `Hello World` on the dev console. All of the code between the curly braces will be executed every time the function is called.

Create a function called reusableFunction which prints the string Hi World to the dev console.
 
 
 Call the function.

Hint: `reusableFunction` should be a function.

If `reusableFunction` is called, it should output the string `Hi World` to the console.

You should call `reusableFunction` once it is defined.""",
        codeSnippet: """function reusableFunction() {
  console.log("Hi World");
}
reusableFunction();""",
        hasImage: false,
      ),
      AppLesson(
        title: """Passing Values to Functions with Arguments""",
        body: """Parameters are variables that act as placeholders for the values that are to be input to a function when it is called. When a function is defined, it is typically defined along with one or more parameters. The actual values that are input (or "passed") into a function when it is called are known as arguments.

Here is a function with two parameters, `param1` and `param2`:

Then we can call `testFun` like this: `testFun("Hello", "World");`. We have passed two string arguments, `Hello` and `World`. Inside the function, `param1` will equal the string `Hello` and `param2` will equal the string `World`. Note that you could call `testFun` again with different arguments and the parameters would take on the value of the new arguments.

Create a function called functionWithArgs that accepts two arguments and outputs their sum to the dev console.Call the function with two numbers as arguments.

Hint: `functionWithArgs` should be a function.

`functionWithArgs(1,2)` should output `3`.

`functionWithArgs(7,9)` should output `16`.

You should call `functionWithArgs` with two numbers after you define it.""",
        codeSnippet: """function functionWithArgs(a, b) {
  console.log(a + b);
}
functionWithArgs(10, 5);""",
        hasImage: false,
      ),
      AppLesson(
        title: """Return a Value from a Function with Return""",
        body: """We can pass values into a function with arguments. You can use a `return` statement to send a value back out of a function.

**Example**

`answer` has the value `8`.

`plusThree` takes an argument for `num` and returns a value equal to `num + 3`.

Create a function `timesFive` that accepts one argument, multiplies it by `5`, and returns the new value.

Hint: `timesFive` should be a function

`timesFive(5)` should return `25`

`timesFive(2)` should return `10`

`timesFive(0)` should return `0`""",
        codeSnippet: """function timesFive(num) {
  return num * 5;
}
timesFive(10);""",
        hasImage: false,
      ),
      AppLesson(
        title: """Global Scope and Functions""",
        body: """In JavaScript, scope refers to the visibility of variables. Variables which are defined outside of a function block have Global scope. This means, they can be seen everywhere in your JavaScript code.

Variables which are declared without the `let` or `const` keywords are automatically created in the `global` scope. This can create unintended consequences elsewhere in your code or when running a function again. You should always declare your variables with `let` or `const`.

Using `let` or `const`, declare a global variable named `myGlobal` outside of any function. Initialize it with a value of `10`.

Inside function `fun1`, assign `5` to `oopsGlobal` ***without*** using the `var`, `let` or `const` keywords.

Hint: `myGlobal` should be defined

`myGlobal` should have a value of `10`

`myGlobal` should be declared using the `let` or `const` keywords

`oopsGlobal` should be a global variable and have a value of `5`""",
        codeSnippet: """const myGlobal = 10;

function fun1() {
  oopsGlobal = 5;
}

function fun2() {
  let output = "";
  if(typeof myGlobal != "undefined") {
    output += "myGlobal: " + myGlobal;
  }
  if(typeof oopsGlobal != "undefined") {
    output += " oopsGlobal: " + oopsGlobal;
  }
  console.log(output);
}""",
        hasImage: false,
      ),
      AppLesson(
        title: """Local Scope and Functions""",
        body: """Variables which are declared within a function, as well as the function parameters, have local scope. That means they are only visible within that function.

Here is a function `myTest` with a local variable called `loc`.

The `myTest()` function call will display the string `foo` in the console. The `console.log(loc)` line (outside of the `myTest` function) will throw an error, as `loc` is not defined outside of the function.

The editor has two `console.log`s to help you see what is happening. Check the console as you code to see how it changes. Declare a local variable `myVar` inside `myLocalScope` and run the tests.

**Note:** The console will still display `ReferenceError: myVar is not defined`, but this will not cause the tests to fail.

Hint: The code should not contain a global `myVar` variable.

You should add a local `myVar` variable.""",
        codeSnippet: """function myLocalScope() {
  // Only change code below this line
  let myVar;
  console.log('inside myLocalScope', myVar);
}
myLocalScope();

// Run and check the console
// myVar is not defined outside of myLocalScope
console.log('outside myLocalScope', myVar);""",
        hasImage: false,
      ),
      AppLesson(
        title: """Global vs. Local Scope in Functions""",
        body: """It is possible to have both local and global variables with the same name. When you do this, the local variable takes precedence over the global variable.

In this example:

The function `myFun` will return the string `Head` because the local version of the variable is present.

Add a local variable to `myOutfit` function to override the value of `outerWear` with the string `sweater`.

Hint: You should not change the value of the global `outerWear`.

`myOutfit` should return the string `sweater`.

You should not change the return statement.""",
        codeSnippet: """const outerWear = "T-Shirt";
function myOutfit() {
  const outerWear = "sweater";
  return outerWear;
}""",
        hasImage: false,
      ),
      AppLesson(
        title: """Understanding Undefined Value returned from a Function""",
        body: """A function can include the `return` statement but it does not have to. In the case that the function doesn't have a `return` statement, when you call it, the function processes the inner code but the returned value is `undefined`.

**Example**

`addSum` is a function without a `return` statement. The function will change the global `sum` variable but the returned value of the function is `undefined`.

Create a function `addFive` without any arguments. This function adds 5 to the `sum` variable, but its returned value is `undefined`.

Hint: `addFive` should be a function.

Once both functions have run, the `sum` should be equal to `8`.

Returned value from `addFive` should be `undefined`.

Inside the `addFive` function, you should add `5` to the `sum` variable.""",
        codeSnippet: """let sum = 0;

function addThree() {
  sum = sum + 3;
}

function addFive() {
  sum = sum + 5;
}

addThree();
addFive();""",
        hasImage: false,
      ),
      AppLesson(
        title: """Assignment with a Returned Value""",
        body: """If you'll recall from our discussion about Storing Values with the Assignment Operator, everything to the right of the equal sign is resolved before the value is assigned. This means we can take the return value of a function and assign it to a variable.

Assume we have defined a function `sum` which adds two numbers together.

Calling the `sum` function with the arguments of `5` and `12` produces a return value of `17`. This return value is assigned to the `ourSum` variable.

Call the `processArg` function with an argument of `7` and assign its return value to the variable `processed`.

Hint: `processed` should have a value of `2`

You should assign `processArg` to `processed`""",
        codeSnippet: """var processed = 0;

function processArg(num) {
  return (num + 3) / 5;
}

processed = processArg(7);""",
        hasImage: false,
      ),
      AppLesson(
        title: """Stand in Line""",
        body: """In Computer Science a queue is an abstract Data Structure where items are kept in order. New items can be added at the back of the queue and old items are taken off from the front of the queue.

Write a function `nextInLine` which takes an array (`arr`) and a number (`item`) as arguments.

Add the number to the end of the array, then remove the first element of the array.

The `nextInLine` function should then return the element that was removed.

Hint: `nextInLine([], 5)` should return a number.

`nextInLine([], 1)` should return `1`

`nextInLine([2], 1)` should return `2`

`nextInLine([5,6,7,8,9], 1)` should return `5`""",
        codeSnippet: """let testArr = [1, 2, 3, 4, 5];

function nextInLine(arr, item) {
    arr.push(item);
    return arr.shift();
}""",
        hasImage: false,
      ),
      AppLesson(
        title: """Understanding Boolean Values""",
        body: """Another data type is the Boolean. Booleans may only be one of two values: `true` or `false`. They are basically little on-off switches, where `true` is on and `false` is off. These two states are mutually exclusive.

**Note:** Boolean values are never written with quotes. The strings `"true"` and `"false"` are not Boolean and have no special meaning in JavaScript.

Modify the `welcomeToBooleans` function so that it returns `true` instead of `false`.

Hint: The `welcomeToBooleans()` function should return a Boolean (`true` or `false`) value.

`welcomeToBooleans()` should return `true`.""",
        codeSnippet: """function welcomeToBooleans() {
  return true; // Change this line
}""",
        hasImage: false,
      ),
      AppLesson(
        title: """Use Conditional Logic with If Statements""",
        body: """`if` statements are used to make decisions in code. The keyword `if` tells JavaScript to execute the code in the curly braces under certain conditions, defined in the parentheses. These conditions are known as `Boolean` conditions and they may only be `true` or `false`.

When the condition evaluates to `true`, the program executes the statement inside the curly braces. When the Boolean condition evaluates to `false`, the statement inside the curly braces will not execute.

**Pseudocode**

if (condition is true) {  statement is executed}

**Example**

`test(true)` returns the string `It was true`, and `test(false)` returns the string `It was false`.

When `test` is called with a value of `true`, the `if` statement evaluates `myCondition` to see if it is `true` or not. Since it is `true`, the function returns `It was true`. When we call `test` with a value of `false`, `myCondition` is *not* `true` and the statement in the curly braces is not executed and the function returns `It was false`.

Create an `if` statement inside the function to return `Yes, that was true` if the parameter `wasThatTrue` is `true` and return `No, that was false` otherwise.

Hint: `trueOrFalse` should be a function

`trueOrFalse(true)` should return a string

`trueOrFalse(false)` should return a string

`trueOrFalse(true)` should return the string `Yes, that was true`

`trueOrFalse(false)` should return the string `No, that was false`""",
        codeSnippet: """function trueOrFalse(wasThatTrue) {
  if (wasThatTrue) {
    return "Yes, that was true";
  }
  return "No, that was false";
}""",
        hasImage: false,
      ),
      AppLesson(
        title: """Comparison with the Equality Operator""",
        body: """There are many comparison operators in JavaScript. All of these operators return a boolean `true` or `false` value.

The most basic operator is the equality operator `==`. The equality operator compares two values and returns `true` if they're equivalent or `false` if they are not. Note that equality is different from assignment (`=`), which assigns the value on the right of the operator to a variable on the left.

If `myVal` is equal to `10`, the equality operator returns `true`, so the code in the curly braces will execute, and the function will return `Equal`. Otherwise, the function will return `Not Equal`. In order for JavaScript to compare two different data types (for example, `numbers` and `strings`), it must convert one type to another. This is known as Type Coercion. Once it does, however, it can compare terms as follows:

Add the equality operator to the indicated line so that the function will return the string `Equal` when `val` is equivalent to `12`.

Hint: `testEqual(10)` should return the string `Not Equal`

`testEqual(12)` should return the string `Equal`

`testEqual("12")` should return the string `Equal`

You should use the `==` operator""",
        codeSnippet: """function testEqual(val) {
  if (val == 12) {
    return "Equal";
  }
  return "Not Equal";
}""",
        hasImage: false,
      )
    ],
  ),
  AppCourse(
    id: 'front-end-development-libraries',
    title: """Front End Development Libraries""",
    description: """A freeCodeCamp curriculum covering Front End Development Libraries, with 60 lessons extracted from the local curriculum assets.""",
    instructor: 'freeCodeCamp',
    category: 'Web Development',
    difficulty: 'Intermediate',
    icon: Icons.code,
    color: Colors.blue,
    duration: '4 weeks',
    lessons: [
      AppLesson(
        title: """Use Responsive Design with Bootstrap Fluid Containers""",
        body: """In the HTML5 and CSS section of freeCodeCamp we built a Cat Photo App. Now let's go back to it. This time, we'll style it using the popular Bootstrap responsive CSS framework.

Bootstrap will figure out how wide your screen is and respond by resizing your HTML elements - hence the name responsive design.

With responsive design, there is no need to design a mobile version of your website. It will look good on devices with screens of any width.

You can add Bootstrap to any app by adding the following code to the top of your HTML:

In this case, we've already added it for you to this page behind the scenes. Note that using either `>` or `/>` to close the `link` tag is acceptable.

To get started, we should nest all of our HTML (except the `link` tag and the `style` element) in a `div` element with the class `container-fluid`.

Hint: Your `div` element should have the class `container-fluid`.

Your `div` element should have a closing tag.

All HTML elements after the closing `style` tag should be nested in `.container-fluid`.""",
        codeSnippet: """<link href="https://fonts.googleapis.com/css?family=Lobster" rel="stylesheet" type="text/css">
<style>
  .red-text {
    color: red;
  }

  h2 {
    font-family: Lobster, Monospace;
  }

  p {
    font-size: 16px;
    font-family: Monospace;
  }

  .thick-green-border {
    border-color: green;
    border-width: 10px;
    border-style: solid;
    border-radius: 50%;
  }

  .smaller-image {
    width: 100px;
  }
</style>
<div class="container-fluid">
  <h2 class="red-text">CatPhotoApp</h2>

<p>Click here for <a href="#">cat photos</a>.</p>

<a href="#"><img class="smaller-image thick-green-border" src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/relaxing-cat.jpg" alt="A cute orange cat lying on its back."></a>

<p>Things cats love:</p>
<ul>
  <li>catnip</li>
  <li>laser pointers</li>
  <li>lasagna</li>
</ul>
<p>Top 3 things cats hate:</p>
<ol>
  <li>flea treatment</li>
  <li>thunder</li>
  <li>other cats</li>
</ol>
<form action="https://freecatphotoapp.com/submit-cat-photo">
  <label><input type="radio" name="indoor-outdoor"> Indoor</label>
  <label><input type="radio" name="indoor-outdoor"> Outdoor</label>
  <label><input type="checkbox" name="personality"> Loving</label>
  <label><input type="checkbox" name="personality"> Lazy</label>
  <label><input type="checkbox" name="personality"> Crazy</label>
  <input type="text" placeholder="cat photo URL" required>
  <button type="submit">Submit</button>
</form>
</div>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Make Images Mobile Responsive""",
        body: """First, add a new image below the existing one. Set its `src` attribute to `https://cdn.freecodecamp.org/curriculum/cat-photo-app/running-cats.jpg`.

It would be great if this image could be exactly the width of our phone's screen.

Fortunately, with Bootstrap, all we need to do is add the `img-responsive` class to your image. Do this, and the image should perfectly fit the width of your page.

Hint: You should have a total of two images.

Your new image should be below your old one and have the class `img-responsive`.

Your new image should not have the class `smaller-image`.

Your new image should have a `src` of `https://cdn.freecodecamp.org/curriculum/cat-photo-app/running-cats.jpg`.

Your new `img` element should have a closing angle bracket.""",
        codeSnippet: """<link href="https://fonts.googleapis.com/css?family=Lobster" rel="stylesheet" type="text/css">
<style>
  .red-text {
    color: red;
  }

  h2 {
    font-family: Lobster, Monospace;
  }

  p {
    font-size: 16px;
    font-family: Monospace;
  }

  .thick-green-border {
    border-color: green;
    border-width: 10px;
    border-style: solid;
    border-radius: 50%;
  }

  .smaller-image {
    width: 100px;
  }
</style>

<div class="container-fluid">
  <h2 class="red-text">CatPhotoApp</h2>

  <p>Click here for <a href="#">cat photos</a>.</p>

  <a href="#"><img class="smaller-image thick-green-border" src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/relaxing-cat.jpg" alt="A cute orange cat lying on its back."></a>
  <img src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/running-cats.jpg" class="img-responsive">

  <p>Things cats love:</p>
  <ul>
    <li>catnip</li>
    <li>laser pointers</li>
    <li>lasagna</li>
  </ul>
  <p>Top 3 things cats hate:</p>
  <ol>
    <li>flea treatment</li>
    <li>thunder</li>
    <li>other cats</li>
  </ol>
  <form action="https://freecatphotoapp.com/submit-cat-photo">
    <label><input type="radio" name="indoor-outdoor"> Indoor</label>
    <label><input type="radio" name="indoor-outdoor"> Outdoor</label>
    <label><input type="checkbox" name="personality"> Loving</label>
    <label><input type="checkbox" name="personality"> Lazy</label>
    <label><input type="checkbox" name="personality"> Crazy</label>
    <input type="text" placeholder="cat photo URL" required>
    <button type="submit">Submit</button>
  </form>
</div>""",
        hasImage: true,
      ),
      AppLesson(
        title: """Center Text with Bootstrap""",
        body: """Now that we're using Bootstrap, we can center our heading element to make it look better. All we need to do is add the class `text-center` to our `h2` element.

Remember that you can add several classes to the same element by separating each of them with a space, like this:

Hint: Your `h2` element should be centered by applying the class `text-center`

Your `h2` element should still have the class `red-text`""",
        codeSnippet: """<link href="https://fonts.googleapis.com/css?family=Lobster" rel="stylesheet" type="text/css">
<style>
  .red-text {
    color: red;
  }

  h2 {
    font-family: Lobster, Monospace;
  }

  p {
    font-size: 16px;
    font-family: Monospace;
  }

  .thick-green-border {
    border-color: green;
    border-width: 10px;
    border-style: solid;
    border-radius: 50%;
  }

  .smaller-image {
    width: 100px;
  }
</style>

<div class="container-fluid">
  <h2 class="red-text text-center">CatPhotoApp</h2>

  <p>Click here for <a href="#">cat photos</a>.</p>

  <a href="#"><img class="smaller-image thick-green-border" src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/relaxing-cat.jpg" alt="A cute orange cat lying on its back."></a>

  <img src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/running-cats.jpg" class="img-responsive" alt="Tuxedo cats running on dirt ground.">
  <p>Things cats love:</p>
  <ul>
    <li>catnip</li>
    <li>laser pointers</li>
    <li>lasagna</li>
  </ul>
  <p>Top 3 things cats hate:</p>
  <ol>
    <li>flea treatment</li>
    <li>thunder</li>
    <li>other cats</li>
  </ol>
  <form action="https://freecatphotoapp.com/submit-cat-photo">
    <label><input type="radio" name="indoor-outdoor"> Indoor</label>
    <label><input type="radio" name="indoor-outdoor"> Outdoor</label>
    <label><input type="checkbox" name="personality"> Loving</label>
    <label><input type="checkbox" name="personality"> Lazy</label>
    <label><input type="checkbox" name="personality"> Crazy</label>
    <input type="text" placeholder="cat photo URL" required>
    <button type="submit">Submit</button>
  </form>
</div>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Create a Bootstrap Button""",
        body: """Bootstrap has its own styles for `button` elements, which look much better than the plain HTML ones.

Create a new `button` element below your large kitten photo. Give it the `btn` and `btn-default` classes, as well as the text of `Like`.

Hint: You should create a new `button` element with the text `Like`.

Your new button should have two classes: `btn` and `btn-default`.

All of your `button` elements should have closing tags.""",
        codeSnippet: """<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css?family=Lobster" rel="stylesheet" type="text/css">
<style>
  .red-text {
    color: red;
  }

  h2 {
    font-family: Lobster, Monospace;
  }

  p {
    font-size: 16px;
    font-family: Monospace;
  }

  .thick-green-border {
    border-color: green;
    border-width: 10px;
    border-style: solid;
    border-radius: 50%;
  }

  .smaller-image {
    width: 100px;
  }
</style>
</head>
<body>
<div class="container-fluid">
  <h2 class="red-text text-center">CatPhotoApp</h2>

  <p>Click here for <a href="#">cat photos</a>.</p>

  <a href="#"><img class="smaller-image thick-green-border" src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/relaxing-cat.jpg" alt="A cute orange cat lying on its back."></a>

  <img src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/running-cats.jpg" class="img-responsive" alt="Tuxedo cats running on dirt ground.">

   <!-- ADD Bootstrap Styled Button -->
  <button class="btn btn-default">Like</button> 

  <p>Things cats love:</p>
  <ul>
    <li>catnip</li>
    <li>laser pointers</li>
    <li>lasagna</li>
  </ul>
  <p>Top 3 things cats hate:</p>
  <ol>
    <li>flea treatment</li>
    <li>thunder</li>
    <li>other cats</li>
  </ol>
  <form action="https://freecatphotoapp.com/submit-cat-photo">
    <label><input type="radio" name="indoor-outdoor"> Indoor</label>
    <label><input type="radio" name="indoor-outdoor"> Outdoor</label>
    <label><input type="checkbox" name="personality"> Loving</label>
    <label><input type="checkbox" name="personality"> Lazy</label>
    <label><input type="checkbox" name="personality"> Crazy</label>
    <input type="text" placeholder="cat photo URL" required>
    <button type="submit">Submit</button>
  </form>
</div>
</html>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Create a Block Element Bootstrap Button""",
        body: """Normally, your `button` elements with the `btn` and `btn-default` classes are only as wide as the text that they contain. For example:

This button would only be as wide as the word `Submit`.

Submit

By making them block elements with the additional class of `btn-block`, your button will stretch to fill your page's entire horizontal space and any elements following it will flow onto a "new line" below the block.

This button would take up 100% of the available width.

Submit

Note that these buttons still need the `btn` class.

Add Bootstrap's `btn-block` class to your Bootstrap button.

Hint: Your button should still have the `btn` and `btn-default` classes.

Your button should have the class `btn-block`.

All of your `button` elements should have closing tags.""",
        codeSnippet: """<link href="https://fonts.googleapis.com/css?family=Lobster" rel="stylesheet" type="text/css">
<style>
  .red-text {
    color: red;
  }

  h2 {
    font-family: Lobster, Monospace;
  }

  p {
    font-size: 16px;
    font-family: Monospace;
  }

  .thick-green-border {
    border-color: green;
    border-width: 10px;
    border-style: solid;
    border-radius: 50%;
  }

  .smaller-image {
    width: 100px;
  }
</style>

<div class="container-fluid">
  <h2 class="red-text text-center">CatPhotoApp</h2>

  <p>Click here for <a href="#">cat photos</a>.</p>

  <a href="#"><img class="smaller-image thick-green-border" src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/relaxing-cat.jpg" alt="A cute orange cat lying on its back."></a>

  <img src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/running-cats.jpg" class="img-responsive" alt="Tuxedo cats running on dirt ground.">
  <button class="btn btn-block btn-default">Like</button>
  <p>Things cats love:</p>
  <ul>
    <li>catnip</li>
    <li>laser pointers</li>
    <li>lasagna</li>
  </ul>
  <p>Top 3 things cats hate:</p>
  <ol>
    <li>flea treatment</li>
    <li>thunder</li>
    <li>other cats</li>
  </ol>
  <form action="https://freecatphotoapp.com/submit-cat-photo">
    <label><input type="radio" name="indoor-outdoor"> Indoor</label>
    <label><input type="radio" name="indoor-outdoor"> Outdoor</label>
    <label><input type="checkbox" name="personality"> Loving</label>
    <label><input type="checkbox" name="personality"> Lazy</label>
    <label><input type="checkbox" name="personality"> Crazy</label>
    <input type="text" placeholder="cat photo URL" required>
    <button type="submit">Submit</button>
  </form>
</div>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Taste the Bootstrap Button Color Rainbow""",
        body: """The `btn-primary` class is the main color you'll use in your app. It is useful for highlighting actions you want your user to take.

Replace Bootstrap's `btn-default` class with `btn-primary` in your button.

Note that this button will still need the `btn` and `btn-block` classes.

Hint: Your button should have the class `btn-primary`.

Your button should still have the `btn` and `btn-block` classes.

All your `button` elements should have closing tags.""",
        codeSnippet: """<link href="https://fonts.googleapis.com/css?family=Lobster" rel="stylesheet" type="text/css">
<style>
  .red-text {
    color: red;
  }

  h2 {
    font-family: Lobster, Monospace;
  }

  p {
    font-size: 16px;
    font-family: Monospace;
  }

  .thick-green-border {
    border-color: green;
    border-width: 10px;
    border-style: solid;
    border-radius: 50%;
  }

  .smaller-image {
    width: 100px;
  }
</style>

<div class="container-fluid">
  <h2 class="red-text text-center">CatPhotoApp</h2>

  <p>Click here for <a href="#">cat photos</a>.</p>

  <a href="#"><img class="smaller-image thick-green-border" src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/relaxing-cat.jpg" alt="A cute orange cat lying on its back."></a>

  <img src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/running-cats.jpg" class="img-responsive" alt="Tuxedo cats running on dirt ground.">
  <button class="btn btn-primary btn-block">Like</button>
  <p>Things cats love:</p>
  <ul>
    <li>catnip</li>
    <li>laser pointers</li>
    <li>lasagna</li>
  </ul>
  <p>Top 3 things cats hate:</p>
  <ol>
    <li>flea treatment</li>
    <li>thunder</li>
    <li>other cats</li>
  </ol>
  <form action="https://freecatphotoapp.com/submit-cat-photo">
    <label><input type="radio" name="indoor-outdoor"> Indoor</label>
    <label><input type="radio" name="indoor-outdoor"> Outdoor</label>
    <label><input type="checkbox" name="personality"> Loving</label>
    <label><input type="checkbox" name="personality"> Lazy</label>
    <label><input type="checkbox" name="personality"> Crazy</label>
    <input type="text" placeholder="cat photo URL" required>
    <button type="submit">Submit</button>
  </form>
</div>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Call out Optional Actions with btn-info""",
        body: """Bootstrap comes with several pre-defined colors for buttons. The `btn-info` class is used to call attention to optional actions that the user can take.

Create a new block-level Bootstrap button below your `Like` button with the text `Info`, and add Bootstrap's `btn-info` class to it.

Note that these buttons still need the `btn` and `btn-block` classes.

Hint: You should create a new `button` element with the text `Info`.

Both of your Bootstrap buttons should have the `btn` and `btn-block` classes.

Your new button should have the class `btn-info`.

All of your `button` elements should have closing tags.""",
        codeSnippet: """<link href="https://fonts.googleapis.com/css?family=Lobster" rel="stylesheet" type="text/css">
<style>
  .red-text {
    color: red;
  }

  h2 {
    font-family: Lobster, Monospace;
  }

  p {
    font-size: 16px;
    font-family: Monospace;
  }

  .thick-green-border {
    border-color: green;
    border-width: 10px;
    border-style: solid;
    border-radius: 50%;
  }

  .smaller-image {
    width: 100px;
  }
</style>

<div class="container-fluid">
  <h2 class="red-text text-center">CatPhotoApp</h2>

  <p>Click here for <a href="#">cat photos</a>.</p>

  <a href="#"><img class="smaller-image thick-green-border" src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/relaxing-cat.jpg" alt="A cute orange cat lying on its back."></a>

  <img src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/running-cats.jpg" class="img-responsive" alt="Tuxedo cats running on dirt ground.">
  <button class="btn btn-block btn-primary">Like</button>
  <button class="btn btn-block btn-info">Info</button>

  <p>Things cats love:</p>
  <ul>
    <li>catnip</li>
    <li>laser pointers</li>
    <li>lasagna</li>
  </ul>
  <p>Top 3 things cats hate:</p>
  <ol>
    <li>flea treatment</li>
    <li>thunder</li>
    <li>other cats</li>
  </ol>
  <form action="https://freecatphotoapp.com/submit-cat-photo">
    <label><input type="radio" name="indoor-outdoor"> Indoor</label>
    <label><input type="radio" name="indoor-outdoor"> Outdoor</label>
    <label><input type="checkbox" name="personality"> Loving</label>
    <label><input type="checkbox" name="personality"> Lazy</label>
    <label><input type="checkbox" name="personality"> Crazy</label>
    <input type="text" placeholder="cat photo URL" required>
    <button type="submit">Submit</button>
  </form>
</div>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Warn Your Users of a Dangerous Action with btn-danger""",
        body: """Bootstrap comes with several pre-defined colors for buttons. The `btn-danger` class is the button color you'll use to notify users that the button performs a destructive action, such as deleting a cat photo.

Create a button with the text `Delete` and give it the class `btn-danger`.

Note that these buttons still need the `btn` and `btn-block` classes.

Hint: You should create a new `button` element with the text `Delete`.

All of your Bootstrap buttons should have the `btn` and `btn-block` classes.

Your new button should have the class `btn-danger`.

All of your `button` elements should have closing tags.""",
        codeSnippet: """<link href="https://fonts.googleapis.com/css?family=Lobster" rel="stylesheet" type="text/css">
<style>
  .red-text {
    color: red;
  }

  h2 {
    font-family: Lobster, Monospace;
  }

  p {
    font-size: 16px;
    font-family: Monospace;
  }

  .thick-green-border {
    border-color: green;
    border-width: 10px;
    border-style: solid;
    border-radius: 50%;
  }

  .smaller-image {
    width: 100px;
  }
</style>

<div class="container-fluid">
  <h2 class="red-text text-center">CatPhotoApp</h2>

  <p>Click here for <a href="#">cat photos</a>.</p>

  <a href="#"><img class="smaller-image thick-green-border" src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/relaxing-cat.jpg" alt="A cute orange cat lying on its back."></a>

  <img src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/running-cats.jpg" class="img-responsive" alt="Tuxedo cats running on dirt ground.">
  <button class="btn btn-block btn-primary">Like</button>
  <button class="btn btn-block btn-info">Info</button>
  <button class="btn btn-block btn-danger">Delete</button>
  <p>Things cats love:</p>
  <ul>
    <li>catnip</li>
    <li>laser pointers</li>
    <li>lasagna</li>
  </ul>
  <p>Top 3 things cats hate:</p>
  <ol>
    <li>flea treatment</li>
    <li>thunder</li>
    <li>other cats</li>
  </ol>
  <form action="https://freecatphotoapp.com/submit-cat-photo">
    <label><input type="radio" name="indoor-outdoor"> Indoor</label>
    <label><input type="radio" name="indoor-outdoor"> Outdoor</label>
    <label><input type="checkbox" name="personality"> Loving</label>
    <label><input type="checkbox" name="personality"> Lazy</label>
    <label><input type="checkbox" name="personality"> Crazy</label>
    <input type="text" placeholder="cat photo URL" required>
    <button type="submit">Submit</button>
  </form>
</div>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Use the Bootstrap Grid to Put Elements Side By Side""",
        body: """Bootstrap uses a responsive 12-column grid system, which makes it easy to put elements into rows and specify each element's relative width. Most of Bootstrap's classes can be applied to a `div` element.

Bootstrap has different column width attributes that it uses depending on how wide the user's screen is. For example, phones have narrow screens, and laptops have wider screens.

Take for example Bootstrap's `col-md-*` class. Here, `md` means medium, and `*` is a number specifying how many columns wide the element should be. In this case, the column width of an element on a medium-sized screen, such as a laptop, is being specified.

In the Cat Photo App that we're building, we'll use `col-xs-*`, where `xs` means extra small (like an extra-small mobile phone screen), and `*` is the number of columns specifying how many columns wide the element should be.

Put the `Like`, `Info` and `Delete` buttons side-by-side by nesting all three of them within one `` element, then each of them within a `` element.

The `row` class is applied to a `div`, and the buttons themselves can be nested within it.

Hint: Your buttons should all be nested within the same `div` element with the class `row`.

Each of your Bootstrap buttons should be nested within its own `div` element with the class `col-xs-4`.

Each of your `button` elements should have a closing tag.

Each of your `div` elements should have a closing tag.""",
        codeSnippet: """<link href="https://fonts.googleapis.com/css?family=Lobster" rel="stylesheet" type="text/css">
<style>
  .red-text {
    color: red;
  }

  h2 {
    font-family: Lobster, Monospace;
  }

  p {
    font-size: 16px;
    font-family: Monospace;
  }

  .thick-green-border {
    border-color: green;
    border-width: 10px;
    border-style: solid;
    border-radius: 50%;
  }

  .smaller-image {
    width: 100px;
  }
</style>

<div class="container-fluid">
  <h2 class="red-text text-center">CatPhotoApp</h2>

  <p>Click here for <a href="#">cat photos</a>.</p>

  <a href="#"><img class="smaller-image thick-green-border" src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/relaxing-cat.jpg" alt="A cute orange cat lying on its back."></a>

  <img src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/running-cats.jpg" class="img-responsive" alt="Tuxedo cats running on dirt ground.">
  <div class="row">
    <div class="col-xs-4">
      <button class="btn btn-block btn-primary">Like</button>
    </div>
    <div class="col-xs-4">
      <button class="btn btn-block btn-info">Info</button>
    </div>
    <div class="col-xs-4">
      <button class="btn btn-block btn-danger">Delete</button>
    </div>
  </div>
  
  <p>Things cats love:</p>
  <ul>
    <li>catnip</li>
    <li>laser pointers</li>
    <li>lasagna</li>
  </ul>
  <p>Top 3 things cats hate:</p>
  <ol>
    <li>flea treatment</li>
    <li>thunder</li>
    <li>other cats</li>
  </ol>
  <form action="https://freecatphotoapp.com/submit-cat-photo">
    <label><input type="radio" name="indoor-outdoor"> Indoor</label>
    <label><input type="radio" name="indoor-outdoor"> Outdoor</label>
    <label><input type="checkbox" name="personality"> Loving</label>
    <label><input type="checkbox" name="personality"> Lazy</label>
    <label><input type="checkbox" name="personality"> Crazy</label>
    <input type="text" placeholder="cat photo URL" required>
    <button type="submit">Submit</button>
  </form>
</div>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Ditch Custom CSS for Bootstrap""",
        body: """We can clean up our code and make our Cat Photo App look more conventional by using Bootstrap's built-in styles instead of the custom styles we created earlier.

Don't worry - there will be plenty of time to customize our CSS later.

Delete the `.red-text`, `p`, and `.smaller-image` CSS declarations from your `style` element so that the only declarations left in your `style` element are `h2` and `thick-green-border`.

Then delete the `p` element that contains a dead link. Then remove the `red-text` class from your `h2` element and replace it with the `text-primary` Bootstrap class.

Finally, remove the `smaller-image` class from your first `img` element and replace it with the `img-responsive` class.

Hint: Your `h2` element should no longer have the class `red-text`.

Your `h2` element should now have the class `text-primary`.

Your paragraph elements should no longer use the font `Monospace`.

The `smaller-image` class should be removed from your top image.

You should add the `img-responsive` class to your top image.""",
        codeSnippet: """<link href="https://fonts.googleapis.com/css?family=Lobster" rel="stylesheet" type="text/css">
<style>
  h2 {
    font-family: Lobster, Monospace;
  }

  .thick-green-border {
    border-color: green;
    border-width: 10px;
    border-style: solid;
    border-radius: 50%;
  }
</style>

<div class="container-fluid">
  <h2 class="text-primary text-center">CatPhotoApp</h2>

  <a href="#"><img class="img-responsive thick-green-border" src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/relaxing-cat.jpg" alt="A cute orange cat lying on its back."></a>

  <img src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/running-cats.jpg" class="img-responsive" alt="Tuxedo cats running on dirt ground.">
  <div class="row">
    <div class="col-xs-4">
      <button class="btn btn-block btn-primary">Like</button>
    </div>
    <div class="col-xs-4">
      <button class="btn btn-block btn-info">Info</button>
    </div>
    <div class="col-xs-4">
      <button class="btn btn-block btn-danger">Delete</button>
    </div>
  </div>
  <p>Things cats love:</p>
  <ul>
    <li>catnip</li>
    <li>laser pointers</li>
    <li>lasagna</li>
  </ul>
  <p>Top 3 things cats hate:</p>
  <ol>
    <li>flea treatment</li>
    <li>thunder</li>
    <li>other cats</li>
  </ol>
  <form action="https://freecatphotoapp.com/submit-cat-photo">
    <label><input type="radio" name="indoor-outdoor"> Indoor</label>
    <label><input type="radio" name="indoor-outdoor"> Outdoor</label>
    <label><input type="checkbox" name="personality"> Loving</label>
    <label><input type="checkbox" name="personality"> Lazy</label>
    <label><input type="checkbox" name="personality"> Crazy</label>
    <input type="text" placeholder="cat photo URL" required>
    <button type="submit">Submit</button>
  </form>
</div>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Use a span to Target Inline Elements""",
        body: """You can use spans to create inline elements. Remember when we used the `btn-block` class to make the button fill the entire row?

normal button

btn-block button

That illustrates the difference between an "inline" element and a "block" element.

By using the inline `span` element, you can put several elements on the same line, and even style different parts of the same line differently.

Using a `span` element, nest the word `love` inside the `p` element that currently has the text `Things cats love`. Then give the `span` the class `text-danger` to make the text red.

Here's how you would do this for the `p` element that has the text `Top 3 things cats hate`:

Hint: Your `span` element should be inside your `p` element.

Your `span` element should have just the text `love`.

Your `span` element should have class `text-danger`.

Your `span` element should have a closing tag.""",
        codeSnippet: """<link href="https://fonts.googleapis.com/css?family=Lobster" rel="stylesheet" type="text/css">
<style>

  h2 {
    font-family: Lobster, Monospace;
  }

  .thick-green-border {
    border-color: green;
    border-width: 10px;
    border-style: solid;
    border-radius: 50%;
  }

</style>

<div class="container-fluid">
  <h2 class="text-primary text-center">CatPhotoApp</h2>

  <a href="#"><img class="img-responsive thick-green-border" src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/relaxing-cat.jpg" alt="A cute orange cat lying on its back."></a>

  <img src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/running-cats.jpg" class="img-responsive" alt="Tuxedo cats running on dirt ground.">
  <div class="row">
    <div class="col-xs-4">
      <button class="btn btn-block btn-primary">Like</button>
    </div>
    <div class="col-xs-4">
      <button class="btn btn-block btn-info">Info</button>
    </div>
    <div class="col-xs-4">
      <button class="btn btn-block btn-danger">Delete</button>
    </div>
  </div>
  <p>Things cats <span class="text-danger">love</span>:</p>
  <ul>
    <li>catnip</li>
    <li>laser pointers</li>
    <li>lasagna</li>
  </ul>
  <p>Top 3 things cats hate:</p>
  <ol>
    <li>flea treatment</li>
    <li>thunder</li>
    <li>other cats</li>
  </ol>
  <form action="https://freecatphotoapp.com/submit-cat-photo">
    <label><input type="radio" name="indoor-outdoor"> Indoor</label>
    <label><input type="radio" name="indoor-outdoor"> Outdoor</label>
    <label><input type="checkbox" name="personality"> Loving</label>
    <label><input type="checkbox" name="personality"> Lazy</label>
    <label><input type="checkbox" name="personality"> Crazy</label>
    <input type="text" placeholder="cat photo URL" required>
    <button type="submit">Submit</button>
  </form>
</div>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Create a Custom Heading""",
        body: """We will make a simple heading for our Cat Photo App by putting the title and relaxing cat image in the same row.

Remember, Bootstrap uses a responsive grid system, which makes it easy to put elements into rows and specify each element's relative width. Most of Bootstrap's classes can be applied to a `div` element.

Nest your first image and your `h2` element within a single `` element. Nest your `h2` element within a `` and your image in a `` so that they are on the same line.

Notice how the image is now just the right size to fit along the text?

Hint: Your `h2` element and topmost `img` element should both be nested together within a `div` element with the class `row`.

Your topmost `img` element should be nested within a `div` with the class `col-xs-4`.

Your `h2` element should be nested within a `div` with the class `col-xs-8`.

All of your `div` elements should have closing tags.""",
        codeSnippet: """<link href="https://fonts.googleapis.com/css?family=Lobster" rel="stylesheet" type="text/css">

<style>
  h2 {
    font-family: Lobster, Monospace;
  }

  .thick-green-border {
    border-color: green;
    border-width: 10px;
    border-style: solid;
    border-radius: 50%;
  }
</style>

<div class="container-fluid">
  <div class="row">
    <div class="col-xs-8">
      <h2 class="text-primary  text-center">CatPhotoApp</h2>
    </div>
    <div class="col-xs-4">
        <a href="#"><img class="img-responsive thick-green-border" src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/relaxing-cat.jpg" alt="A cute orange cat lying on its back."></a>
    </div>
  </div>
  <img src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/running-cats.jpg" class="img-responsive" alt="Tuxedo cats running on dirt ground.">
  <div class="row">
    <div class="col-xs-4">
      <button class="btn btn-block btn-primary">Like</button>
    </div>
    <div class="col-xs-4">
      <button class="btn btn-block btn-info">Info</button>
    </div>
    <div class="col-xs-4">
      <button class="btn btn-block btn-danger">Delete</button>
    </div>
  </div>
  <p>Things cats <span class="text-danger">love:</span></p>
  <ul>
    <li>catnip</li>
    <li>laser pointers</li>
    <li>lasagna</li>
  </ul>
  <p>Top 3 things cats hate:</p>
  <ol>
    <li>flea treatment</li>
    <li>thunder</li>
    <li>other cats</li>
  </ol>
  <form action="https://freecatphotoapp.com/submit-cat-photo">
    <label><input type="radio" name="indoor-outdoor"> Indoor</label>
    <label><input type="radio" name="indoor-outdoor"> Outdoor</label>
    <label><input type="checkbox" name="personality"> Loving</label>
    <label><input type="checkbox" name="personality"> Lazy</label>
    <label><input type="checkbox" name="personality"> Crazy</label>
    <input type="text" placeholder="cat photo URL" required>
    <button type="submit">Submit</button>
  </form>
</div>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Add Font Awesome Icons to our Buttons""",
        body: """Font Awesome is a convenient library of icons. These icons can be webfonts or vector graphics. These icons are treated just like fonts. You can specify their size using pixels, and they will assume the font size of their parent HTML elements.

You can include Font Awesome in any app by adding the following code to the top of your HTML:

In this case, we've already added it for you to this page behind the scenes.

The `i` element was originally used to make other elements italic, but is now commonly used for icons. You can add the Font Awesome classes to the `i` element to turn it into an icon, for example:

Note that the `span` element is also acceptable for use with icons.

Use Font Awesome to add a `thumbs-up` icon to your like button by giving it an `i` element with the classes `fas` and `fa-thumbs-up`. Make sure to keep the text `Like` next to the icon.

Hint: You should add an `i` element with the classes `fas` and `fa-thumbs-up`.

Your `fa-thumbs-up` icon should be located within the Like button.

Your `i` element should be nested within your `button` element.

Your icon element should have a closing tag.""",
        codeSnippet: """<link href="https://fonts.googleapis.com/css?family=Lobster" rel="stylesheet" type="text/css">
<style>
  h2 {
    font-family: Lobster, Monospace;
  }

  .thick-green-border {
    border-color: green;
    border-width: 10px;
    border-style: solid;
    border-radius: 50%;
  }
</style>

<div class="container-fluid">
  <div class="row">
    <div class="col-xs-8">
      <h2 class="text-primary text-center">CatPhotoApp</h2>
    </div>
    <div class="col-xs-4">
      <a href="#"><img class="img-responsive thick-green-border" src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/relaxing-cat.jpg" alt="A cute orange cat lying on its back."></a>
    </div>
  </div>
  <img src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/running-cats.jpg" class="img-responsive" alt="Tuxedo cats running on dirt ground.">
  <div class="row">
    <div class="col-xs-4">
      <button class="btn btn-block btn-primary"><i class="fas fa-thumbs-up"></i> Like</button>
    </div>
    <div class="col-xs-4">
      <button class="btn btn-block btn-info">Info</button>
    </div>
    <div class="col-xs-4">
      <button class="btn btn-block btn-danger">Delete</button>
    </div>
  </div>
  <p>Things cats <span class="text-danger">love:</span></p>
  <ul>
    <li>catnip</li>
    <li>laser pointers</li>
    <li>lasagna</li>
  </ul>
  <p>Top 3 things cats hate:</p>
  <ol>
    <li>flea treatment</li>
    <li>thunder</li>
    <li>other cats</li>
  </ol>
  <form action="https://freecatphotoapp.com/submit-cat-photo">
    <label><input type="radio" name="indoor-outdoor"> Indoor</label>
    <label><input type="radio" name="indoor-outdoor"> Outdoor</label>
    <label><input type="checkbox" name="personality"> Loving</label>
    <label><input type="checkbox" name="personality"> Lazy</label>
    <label><input type="checkbox" name="personality"> Crazy</label>
    <input type="text" placeholder="cat photo URL" required>
    <button type="submit">Submit</button>
  </form>
</div>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Add Font Awesome Icons to all of our Buttons""",
        body: """Font Awesome is a convenient library of icons. These icons can be web fonts or vector graphics. These icons are treated just like fonts. You can specify their size using pixels, and they will assume the font size of their parent HTML elements.

Use Font Awesome to add an `info-circle` icon to your info button and a `trash` icon to your delete button.

**Note:** You can use either `i` or `span` elements to complete this challenge.

Hint: You should add a `` within your `info` button element.

You should add a `` within your `delete` button element.

Each of your `i` elements should have a closing tag and `` is in your `like` button element.""",
        codeSnippet: """<link href="https://fonts.googleapis.com/css?family=Lobster" rel="stylesheet" type="text/css">
<style>
  h2 {
    font-family: Lobster, Monospace;
  }

  .thick-green-border {
    border-color: green;
    border-width: 10px;
    border-style: solid;
    border-radius: 50%;
  }
</style>

<div class="container-fluid">
  <div class="row">
    <div class="col-xs-8">
      <h2 class="text-primary text-center">CatPhotoApp</h2>
    </div>
    <div class="col-xs-4">
      <a href="#"><img class="img-responsive thick-green-border" src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/relaxing-cat.jpg" alt="A cute orange cat lying on its back."></a>
    </div>
  </div>
  <img src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/running-cats.jpg" class="img-responsive" alt="Tuxedo cats running on dirt ground.">
  <div class="row">
    <div class="col-xs-4">
      <button class="btn btn-block btn-primary"><i class="fas fa-thumbs-up"></i> Like</button>
    </div>
    <div class="col-xs-4">
      <button class="btn btn-block btn-info"><i class="fas fa-info-circle"></i> Info</button>
    </div>
    <div class="col-xs-4">
      <button class="btn btn-block btn-danger"><i class="fas fa-trash"></i> Delete</button>
    </div>
  </div>
  <p>Things cats <span class="text-danger">love:</span></p>
  <ul>
    <li>catnip</li>
    <li>laser pointers</li>
    <li>lasagna</li>
  </ul>
  <p>Top 3 things cats hate:</p>
  <ol>
    <li>flea treatment</li>
    <li>thunder</li>
    <li>other cats</li>
  </ol>
  <form action="https://freecatphotoapp.com/submit-cat-photo">
    <label><input type="radio" name="indoor-outdoor"> Indoor</label>
    <label><input type="radio" name="indoor-outdoor"> Outdoor</label>
    <label><input type="checkbox" name="personality"> Loving</label>
    <label><input type="checkbox" name="personality"> Lazy</label>
    <label><input type="checkbox" name="personality"> Crazy</label>
    <input type="text" placeholder="cat photo URL" required>
    <button type="submit">Submit</button>
  </form>
</div>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Responsively Style Radio Buttons""",
        body: """You can use Bootstrap's `col-xs-*` classes on `form` elements, too! This way, our radio buttons will be evenly spread out across the page, regardless of how wide the screen resolution is.

Nest both your radio buttons within a `` element. Then nest each of them within a `` element.

**Note:** As a reminder, radio buttons are `input` elements of type `radio`.

Hint: All of your radio buttons should be nested inside one `div` with the class `row`.

Each of your radio buttons should be nested inside its own `div` with the class `col-xs-6`.

All of your `div` elements should have closing tags.""",
        codeSnippet: """<link href="https://fonts.googleapis.com/css?family=Lobster" rel="stylesheet" type="text/css">
<style>
  h2 {
    font-family: Lobster, Monospace;
  }

  .thick-green-border {
    border-color: green;
    border-width: 10px;
    border-style: solid;
    border-radius: 50%;
  }
</style>

<div class="container-fluid">
  <div class="row">
    <div class="col-xs-8">
      <h2 class="text-primary text-center">CatPhotoApp</h2>
    </div>
    <div class="col-xs-4">
      <a href="#"><img class="img-responsive thick-green-border" src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/relaxing-cat.jpg" alt="A cute orange cat lying on its back."></a>
    </div>
  </div>
  <img src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/running-cats.jpg" class="img-responsive" alt="Tuxedo cats running on dirt ground.">
  <div class="row">
    <div class="col-xs-4">
      <button class="btn btn-block btn-primary"><i class="fa fa-thumbs-up"></i> Like</button>
    </div>
    <div class="col-xs-4">
      <button class="btn btn-block btn-info"><i class="fa fa-info-circle"></i> Info</button>
    </div>
    <div class="col-xs-4">
      <button class="btn btn-block btn-danger"><i class="fa fa-trash"></i> Delete</button>
    </div>
  </div>
  <p>Things cats <span class="text-danger">love:</span></p>
  <ul>
    <li>catnip</li>
    <li>laser pointers</li>
    <li>lasagna</li>
  </ul>
  <p>Top 3 things cats hate:</p>
  <ol>
    <li>flea treatment</li>
    <li>thunder</li>
    <li>other cats</li>
  </ol>
  <form action="https://freecatphotoapp.com/submit-cat-photo">
  <div class="row">
      <div class="col-xs-6">
        <label><input type="radio" name="indoor-outdoor"> Indoor</label>
      </div>
      <div class="col-xs-6">
        <label><input type="radio" name="indoor-outdoor"> Outdoor</label>
      </div>
    </div>
    <label><input type="checkbox" name="personality"> Loving</label>
    <label><input type="checkbox" name="personality"> Lazy</label>
    <label><input type="checkbox" name="personality"> Crazy</label>
    <input type="text" placeholder="cat photo URL" required>
    <button type="submit">Submit</button>
  </form>
</div>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Responsively Style Checkboxes""",
        body: """Since Bootstrap's `col-xs-*` classes are applicable to all `form` elements, you can use them on your checkboxes too! This way, the checkboxes will be evenly spread out across the page, regardless of how wide the screen resolution is.

Nest all three of your checkboxes in a `` element. Then nest each of them in a `` element.

Hint: All of your checkboxes should be nested inside one `div` with the class `row`.

Each of your checkboxes should be nested inside its own `div` with the class `col-xs-4`.

All of your `div` elements should have closing tags.""",
        codeSnippet: """<link href="https://fonts.googleapis.com/css?family=Lobster" rel="stylesheet" type="text/css">
<style>
  h2 {
    font-family: Lobster, Monospace;
  }

  .thick-green-border {
    border-color: green;
    border-width: 10px;
    border-style: solid;
    border-radius: 50%;
  }

</style>

<div class="container-fluid">
  <div class="row">
    <div class="col-xs-8">
      <h2 class="text-primary text-center">CatPhotoApp</h2>
    </div>
    <div class="col-xs-4">
      <a href="#"><img class="img-responsive thick-green-border" src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/relaxing-cat.jpg" alt="A cute orange cat lying on its back."></a>
    </div>
  </div>
  <img src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/running-cats.jpg" class="img-responsive" alt="Tuxedo cats running on dirt ground.">
  <div class="row">
    <div class="col-xs-4">
      <button class="btn btn-block btn-primary"><i class="fa fa-thumbs-up"></i> Like</button>
    </div>
    <div class="col-xs-4">
      <button class="btn btn-block btn-info"><i class="fa fa-info-circle"></i> Info</button>
    </div>
    <div class="col-xs-4">
      <button class="btn btn-block btn-danger"><i class="fa fa-trash"></i> Delete</button>
    </div>
  </div>
  <p>Things cats <span class="text-danger">love:</span></p>
  <ul>
    <li>catnip</li>
    <li>laser pointers</li>
    <li>lasagna</li>
  </ul>
  <p>Top 3 things cats hate:</p>
  <ol>
    <li>flea treatment</li>
    <li>thunder</li>
    <li>other cats</li>
  </ol>
  <form action="https://freecatphotoapp.com/submit-cat-photo">
    <div class="row">
      <div class="col-xs-6">
        <label><input type="radio" name="indoor-outdoor"> Indoor</label>
      </div>
      <div class="col-xs-6">
        <label><input type="radio" name="indoor-outdoor"> Outdoor</label>
      </div>
    </div>
    <div class="row">
      <div class="col-xs-4">
        <label><input type="checkbox" name="personality"> Loving</label>   
      </div>
      <div class="col-xs-4">
         <label><input type="checkbox" name="personality"> Lazy</label>
      </div>
      <div class="col-xs-4">
         <label><input type="checkbox" name="personality"> Crazy</label>
      </div>
    </div>
    <input type="text" placeholder="cat photo URL" required>
    <button type="submit">Submit</button>
  </form>
</div>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Style Text Inputs as Form Controls""",
        body: """You can add the `fa-paper-plane` Font Awesome icon by adding `` within your submit `button` element.

Give your form's text input field a class of `form-control`. Give your form's submit button the classes `btn btn-primary`. Also give this button the Font Awesome icon of `fa-paper-plane`.

All textual ``, ``, and `` elements with the class `.form-control` have a width of 100%.

Hint: The submit button in your form should have the classes `btn btn-primary`.

You should add a `` within your submit `button` element.

The text `input` in your form should have the class `form-control`.

Each of your `i` elements should have a closing tag.""",
        codeSnippet: """<link href="https://fonts.googleapis.com/css?family=Lobster" rel="stylesheet" type="text/css">
<style>
  h2 {
    font-family: Lobster, Monospace;
  }

  .thick-green-border {
    border-color: green;
    border-width: 10px;
    border-style: solid;
    border-radius: 50%;
  }

</style>

<div class="container-fluid">
  <div class="row">
    <div class="col-xs-8">
      <h2 class="text-primary text-center">CatPhotoApp</h2>
    </div>
    <div class="col-xs-4">
      <a href="#"><img class="img-responsive thick-green-border" src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/relaxing-cat.jpg" alt="A cute orange cat lying on its back."></a>
    </div>
  </div>
  <img src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/running-cats.jpg" class="img-responsive" alt="Tuxedo cats running on dirt ground.">
  <div class="row">
    <div class="col-xs-4">
      <button class="btn btn-block btn-primary"><i class="fa fa-thumbs-up"></i> Like</button>
    </div>
    <div class="col-xs-4">
      <button class="btn btn-block btn-info"><i class="fa fa-info-circle"></i> Info</button>
    </div>
    <div class="col-xs-4">
      <button class="btn btn-block btn-danger"><i class="fa fa-trash"></i> Delete</button>
    </div>
  </div>
  <p>Things cats <span class="text-danger">love:</span></p>
  <ul>
    <li>catnip</li>
    <li>laser pointers</li>
    <li>lasagna</li>
  </ul>
  <p>Top 3 things cats hate:</p>
  <ol>
    <li>flea treatment</li>
    <li>thunder</li>
    <li>other cats</li>
  </ol>
  <form action="https://freecatphotoapp.com/submit-cat-photo">
    <div class="row">
      <div class="col-xs-6">
        <label><input type="radio" name="indoor-outdoor"> Indoor</label>
      </div>
      <div class="col-xs-6">
        <label><input type="radio" name="indoor-outdoor"> Outdoor</label>
      </div>
    </div>
    <div class="row">
      <div class="col-xs-4">
        <label><input type="checkbox" name="personality"> Loving</label>
      </div>
      <div class="col-xs-4">
        <label><input type="checkbox" name="personality"> Lazy</label>
      </div>
      <div class="col-xs-4">
        <label><input type="checkbox" name="personality"> Crazy</label>
      </div>
    </div>
    <input type="text" class="form-control" placeholder="cat photo URL" required>
    <button type="submit" class="btn btn-primary"><i class="fa fa-paper-plane"></i>Submit</button>
  </form>
</div>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Line up Form Elements Responsively with Bootstrap""",
        body: """Now let's get your form `input` and your submission `button` on the same line. We'll do this the same way we have previously: by using a `div` element with the class `row`, and other `div` elements within it using the `col-xs-*` class.

Nest both your form's text `input` and submit `button` within a `div` with the class `row`. Nest your form's text `input` within a div with the class of `col-xs-7`. Nest your form's submit `button` in a `div` with the class `col-xs-5`.

This is the last challenge we'll do for our Cat Photo App for now. We hope you've enjoyed learning Font Awesome, Bootstrap, and responsive design!

Hint: Your form submission button and text input should be nested in a div with class `row`.

Your form text input should be nested in a div with the class `col-xs-7`.

Your form submission button should be nested in a div with the class `col-xs-5`.

All of your `div` elements should have closing tags.""",
        codeSnippet: """<link href="https://fonts.googleapis.com/css?family=Lobster" rel="stylesheet" type="text/css">
<style>
  h2 {
    font-family: Lobster, Monospace;
  }

  .thick-green-border {
    border-color: green;
    border-width: 10px;
    border-style: solid;
    border-radius: 50%;
  }

</style>

<div class="container-fluid">
  <div class="row">
    <div class="col-xs-8">
      <h2 class="text-primary text-center">CatPhotoApp</h2>
    </div>
    <div class="col-xs-4">
      <a href="#"><img class="img-responsive thick-green-border" src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/relaxing-cat.jpg" alt="A cute orange cat lying on its back."></a>
    </div>
  </div>
  <img src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/running-cats.jpg" class="img-responsive" alt="Tuxedo cats running on dirt ground.">
  <div class="row">
    <div class="col-xs-4">
      <button class="btn btn-block btn-primary"><i class="fa fa-thumbs-up"></i> Like</button>
    </div>
    <div class="col-xs-4">
      <button class="btn btn-block btn-info"><i class="fa fa-info-circle"></i> Info</button>
    </div>
    <div class="col-xs-4">
      <button class="btn btn-block btn-danger"><i class="fa fa-trash"></i> Delete</button>
    </div>
  </div>
  <p>Things cats <span class="text-danger">love:</span></p>
  <ul>
    <li>catnip</li>
    <li>laser pointers</li>
    <li>lasagna</li>
  </ul>
  <p>Top 3 things cats hate:</p>
  <ol>
    <li>flea treatment</li>
    <li>thunder</li>
    <li>other cats</li>
  </ol>
  <form action="https://freecatphotoapp.com/submit-cat-photo">
    <div class="row">
      <div class="col-xs-6">
        <label><input type="radio" name="indoor-outdoor"> Indoor</label>
      </div>
      <div class="col-xs-6">
        <label><input type="radio" name="indoor-outdoor"> Outdoor</label>
      </div>
    </div>
    <div class="row">
      <div class="col-xs-4">
        <label><input type="checkbox" name="personality"> Loving</label>
      </div>
      <div class="col-xs-4">
        <label><input type="checkbox" name="personality"> Lazy</label>
      </div>
      <div class="col-xs-4">
        <label><input type="checkbox" name="personality"> Crazy</label>
      </div>
    </div>
    <div class="row">
      <div class="col-xs-7">
        <input type="text" class="form-control" placeholder="cat photo URL" required>
      </div>
      <div class="col-xs-5">
        <button type="submit" class="btn btn-primary"><i class="fa fa-paper-plane"></i> Submit</button>
      </div>
    </div>
  </form>
</div>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Create a Bootstrap Headline""",
        body: """Now let's build something from scratch to practice our HTML, CSS and Bootstrap skills.

We'll build a jQuery playground, which we'll soon put to use in our jQuery challenges.

To start with, create an `h3` element, with the text `jQuery Playground`.

Color your `h3` element with the `text-primary` Bootstrap class, and center it with the `text-center` Bootstrap class.

Hint: You should add an `h3` element to your page.

Your `h3` element should have a closing tag.

Your `h3` element should be colored by applying the class `text-primary`

Your `h3` element should be centered by applying the class `text-center`

Your `h3` element should have the text `jQuery Playground`.""",
        codeSnippet: """<h3 class="text-primary text-center">jQuery Playground</h3>""",
        hasImage: false,
      ),
      AppLesson(
        title: """House our page within a Bootstrap container-fluid div""",
        body: """Now let's make sure all the content on your page is mobile-responsive.

Let's nest your `h3` element within a `div` element with the class `container-fluid`.

Hint: Your `div` element should have the class `container-fluid`.

Each of your `div` elements should have closing tags.

Your `h3` element should be nested inside a `div` element.""",
        codeSnippet: """<div class="container-fluid">
    <h3 class="text-primary text-center">jQuery Playground</h3>
</div>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Create a Bootstrap Row""",
        body: """Now we'll create a Bootstrap row for our inline elements.

Create a `div` element below the `h3` tag, with a class of `row`.

Hint: You should add a `div` element below your `h3` element.

Your `div` element should have the class `row`

Your `row div` should be nested inside the `container-fluid div`

Your `div` element should have a closing tag.""",
        codeSnippet: """<div class="container-fluid">
  <h3 class="text-primary text-center">jQuery Playground</h3>
  <div class="row"></div>
</div>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Split Your Bootstrap Row""",
        body: """Now that we have a Bootstrap Row, let's split it into two columns to house our elements.

Create two `div` elements within your row, both with the class `col-xs-6`.

Hint: Two `div class="col-xs-6"` elements should be nested within your `div class="row"` element.

All your `div` elements should have closing tags.""",
        codeSnippet: """<div class="container-fluid">
  <h3 class="text-primary text-center">jQuery Playground</h3>
  <div class="row">
    <div class="col-xs-6"></div>
    <div class="col-xs-6"></div>
  </div>
</div>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Create Bootstrap Wells""",
        body: """Bootstrap has a class called `well` that can create a visual sense of depth for your columns.

Nest one `div` element with the class `well` within each of your `col-xs-6` `div` elements.

Hint: You should add a `div` element with the class `well` inside each of your `div` elements with the class `col-xs-6`

Both of your `div` elements with the class `col-xs-6` should be nested within your `div` element with the class `row`.

All your `div` elements should have closing tags.""",
        codeSnippet: """<div class="container-fluid">
  <h3 class="text-primary text-center">jQuery Playground</h3>
  <div class="row">
    <div class="col-xs-6">
      <div class="well"></div>
    </div>
    <div class="col-xs-6">
      <div class="well"></div>
    </div>
  </div>
</div>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Add Elements within Your Bootstrap Wells""",
        body: """Now we're several `div` elements deep on each column of our row. This is as deep as we'll need to go. Now we can add our `button` elements.

Nest three `button` elements within each of your `div` elements having the class name `well`.

Hint: Three `button` elements should be nested within each of your `div` elements with class `well`.

You should have a total of 6 `button` elements.

All of your `button` elements should have closing tags.""",
        codeSnippet: """<div class="container-fluid">
  <h3 class="text-primary text-center">jQuery Playground</h3>
  <div class="row">
    <div class="col-xs-6">
      <div class="well">
        <button></button>
        <button></button>
        <button></button>
      </div>
    </div>
    <div class="col-xs-6">
      <div class="well">
        <button></button>
        <button></button>
        <button></button>
      </div>
    </div>
  </div>
</div>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Apply the Default Bootstrap Button Style""",
        body: """Bootstrap has another button class called `btn-default`.

Apply both the `btn` and `btn-default` classes to each of your `button` elements.

Hint: You should apply the `btn` class to each of your `button` elements.

You should apply the `btn-default` class to each of your `button` elements.""",
        codeSnippet: """<div class="container-fluid">
  <h3 class="text-primary text-center">jQuery Playground</h3>
  <div class="row">
    <div class="col-xs-6">
      <div class="well">
        <button class="btn btn-default"></button>
        <button class="btn btn-default"></button>
        <button class="btn btn-default"></button>
      </div>
    </div>
    <div class="col-xs-6">
      <div class="well">
        <button class="btn btn-default"></button>
        <button class="btn btn-default"></button>
        <button class="btn btn-default"></button>
      </div>
    </div>
  </div>
</div>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Create a Class to Target with jQuery Selectors""",
        body: """Not every class needs to have corresponding CSS. Sometimes we create classes just for the purpose of selecting these elements more easily using jQuery.

Give each of your `button` elements the class `target`.

Hint: You should apply the `target` class to each of your `button` elements.""",
        codeSnippet: """<div class="container-fluid">
  <h3 class="text-primary text-center">jQuery Playground</h3>
  <div class="row">
    <div class="col-xs-6">
      <div class="well">
        <button class="target btn btn-default"></button>
        <button class="target btn btn-default"></button>
        <button class="target btn btn-default"></button>
      </div>
    </div>
    <div class="col-xs-6">
      <div class="well">
        <button class="target btn btn-default"></button>
        <button class="target btn btn-default"></button>
        <button class="target btn btn-default"></button>
      </div>
    </div>
  </div>
</div>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Add id Attributes to Bootstrap Elements""",
        body: """Recall that in addition to class attributes, you can give each of your elements an `id` attribute.

Each id must be unique to a specific element and used only once per page.

Let's give a unique id to each of our `div` elements of class `well`.

Remember that you can give an element an id like this:

Give the well on the left the id of `left-well`. Give the well on the right the id of `right-well`.

Hint: Your left `well` should have the id of `left-well`.

Your right `well` should have the id of `right-well`.""",
        codeSnippet: """<div class="container-fluid">
  <h3 class="text-primary text-center">jQuery Playground</h3>
  <div class="row">
    <div class="col-xs-6">
      <div class="well" id="left-well">
        <button class="btn btn-default target"></button>
        <button class="btn btn-default target"></button>
        <button class="btn btn-default target"></button>
      </div>
    </div>
    <div class="col-xs-6">
      <div class="well" id="right-well">
        <button class="btn btn-default target"></button>
        <button class="btn btn-default target"></button>
        <button class="btn btn-default target"></button>
      </div>
    </div>
  </div>
</div>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Label Bootstrap Wells""",
        body: """For the sake of clarity, let's label both of our wells with their ids.

Above your left-well, inside its `col-xs-6` `div` element, add an `h4` element with the text `#left-well`.

Above your right-well, inside its `col-xs-6` `div` element, add an `h4` element with the text `#right-well`.

Hint: You should add an `h4` element to each of your `` elements.

One `h4` element should have the text `#left-well`.

One `h4` element should have the text `#right-well`.

All of your `h4` elements should have closing tags.""",
        codeSnippet: """<div class="container-fluid">
  <h3 class="text-primary text-center">jQuery Playground</h3>
  <div class="row">
    <div class="col-xs-6">
      <h4>#left-well</h4>
      <div class="well" id="left-well">
        <button class="btn btn-default target"></button>
        <button class="btn btn-default target"></button>
        <button class="btn btn-default target"></button>
      </div>
    </div>
    <div class="col-xs-6">
      <h4>#right-well</h4>
      <div class="well" id="right-well">
        <button class="btn btn-default target"></button>
        <button class="btn btn-default target"></button>
        <button class="btn btn-default target"></button>
      </div>
    </div>
  </div>
</div>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Give Each Element a Unique id""",
        body: """We will also want to be able to use jQuery to target each button by its unique id.

Give each of your buttons a unique id, starting with `target1` and ending with `target6`.

Make sure that `target1` to `target3` are in `#left-well`, and `target4` to `target6` are in `#right-well`.

Hint: One `button` element should have the id `target1`.

One `button` element should have the id `target2`.

One `button` element should have the id `target3`.

One `button` element should have the id `target4`.

One `button` element should have the id `target5`.

One `button` element should have the id `target6`.""",
        codeSnippet: """<div class="container-fluid">
  <h3 class="text-primary text-center">jQuery Playground</h3>
  <div class="row">
    <div class="col-xs-6">
      <h4>#left-well</h4>
      <div class="well" id="left-well">
        <button class="btn btn-default target" id="target1"></button>
        <button class="btn btn-default target" id="target2"></button>
        <button class="btn btn-default target" id="target3"></button>
      </div>
    </div>
    <div class="col-xs-6">
      <h4>#right-well</h4>
      <div class="well" id="right-well">
        <button class="btn btn-default target" id="target4"></button>
        <button class="btn btn-default target" id="target5"></button>
        <button class="btn btn-default target" id="target6"></button>
      </div>
    </div>
  </div>
</div>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Label Bootstrap Buttons""",
        body: """Just like we labeled our wells, we want to label our buttons.

Give each of your `button` elements text that corresponds to its id selector.

Hint: Your `button` element with the id `target1` should have the text `#target1`.

Your `button` element with the id `target2` should have the text `#target2`.

Your `button` element with the id `target3` should have the text `#target3`.

Your `button` element with the id `target4` should have the text `#target4`.

Your `button` element with the id `target5` should have the text `#target5`.

Your `button` element with the id `target6` should have the text `#target6`.""",
        codeSnippet: """<div class="container-fluid">
  <h3 class="text-primary text-center">jQuery Playground</h3>
  <div class="row">
    <div class="col-xs-6">
      <h4>#left-well</h4>
      <div class="well" id="left-well">
        <button class="btn btn-default target" id="target1">#target1</button>
        <button class="btn btn-default target" id="target2">#target2</button>
        <button class="btn btn-default target" id="target3">#target3</button>
      </div>
    </div>
    <div class="col-xs-6">
      <h4>#right-well</h4>
      <div class="well" id="right-well">
        <button class="btn btn-default target" id="target4">#target4</button>
        <button class="btn btn-default target" id="target5">#target5</button>
        <button class="btn btn-default target" id="target6">#target6</button>
      </div>
    </div>
  </div>
</div>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Use Comments to Clarify Code""",
        body: """When we start using jQuery, we will modify HTML elements without needing to actually change them in HTML.

Let's make sure that everyone knows they shouldn't actually modify any of this code directly.

Remember that you can start a comment with ``

Add a comment at the top of your HTML that says `Code below this line should not be changed`

Hint: You should start a comment with ``.

You should have the same number of comment openers and closers.""",
        codeSnippet: """<!-- Code below this line should not be changed -->
<div class="container-fluid">
  <h3 class="text-primary text-center">jQuery Playground</h3>
  <div class="row">
    <div class="col-xs-6">
      <h4>#left-well</h4>
      <div class="well" id="left-well">
        <button class="btn btn-default target" id="target1">#target1</button>
        <button class="btn btn-default target" id="target2">#target2</button>
        <button class="btn btn-default target" id="target3">#target3</button>
      </div>
    </div>
    <div class="col-xs-6">
      <h4>#right-well</h4>
      <div class="well" id="right-well">
        <button class="btn btn-default target" id="target4">#target4</button>
        <button class="btn btn-default target" id="target5">#target5</button>
        <button class="btn btn-default target" id="target6">#target6</button>
      </div>
    </div>
  </div>
</div>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Learn How Script Tags and Document Ready Work""",
        body: """Now we're ready to learn jQuery, the most popular JavaScript tool of all time.

Before we can start using jQuery, we need to add some things to our HTML.

First, add a `script` element at the top of your page. Be sure to close it on the following line.

Your browser will run any JavaScript inside a `script` element, including jQuery.

Inside your `script` element, add this code: `\$(document).ready(function() {` to your `script`. Then close it on the following line (still inside your `script` element) with: `});`

We'll learn more about `functions` later. The important thing to know is that code you put inside this `function` will run as soon as your browser has loaded your page.

This is important because without your `document ready function`, your code may run before your HTML is rendered, which would cause bugs.

Hint: You should create a `script` element making sure it is valid and has a closing tag.

You should add `\$(document).ready(function() {` to the beginning of your `script` element.

You should close your `\$(document).ready(function() {` function with `});`""",
        codeSnippet: """<script>
  \$(document).ready(function() {
  });
</script>
<!-- Only change code above this line -->

<div class="container-fluid">
  <h3 class="text-primary text-center">jQuery Playground</h3>
  <div class="row">
    <div class="col-xs-6">
      <h4>#left-well</h4>
      <div class="well" id="left-well">
        <button class="btn btn-default target" id="target1">#target1</button>
        <button class="btn btn-default target" id="target2">#target2</button>
        <button class="btn btn-default target" id="target3">#target3</button>
      </div>
    </div>
    <div class="col-xs-6">
      <h4>#right-well</h4>
      <div class="well" id="right-well">
        <button class="btn btn-default target" id="target4">#target4</button>
        <button class="btn btn-default target" id="target5">#target5</button>
        <button class="btn btn-default target" id="target6">#target6</button>
      </div>
    </div>
  </div>
</div>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Target HTML Elements with Selectors Using jQuery""",
        body: """Now we have a `document ready` function.

Now let's write our first jQuery statement. All jQuery functions start with a `\$`, usually referred to as a dollar sign operator, or as bling.

jQuery often selects an HTML element with a selector, then does something to that element.

For example, let's make all of your `button` elements bounce. Just add this code inside your document ready function:

Note that we've already included both the jQuery library and the Animate.css library in the background so that you can use them in the editor. So you are using jQuery to apply the Animate.css `bounce` class to your `button` elements.

Hint: You should use the jQuery `addClass()` function to give the classes `animated` and `bounce` to your `button` elements.

You should only use jQuery to add these classes to the element.

Your jQuery code should be within the `\$(document).ready();` function.""",
        codeSnippet: """<script>
  \$(document).ready(function() {
    \$("button").addClass("animated bounce");
  });
</script>

<!-- Only change code above this line -->

<div class="container-fluid">
  <h3 class="text-primary text-center">jQuery Playground</h3>
  <div class="row">
    <div class="col-xs-6">
      <h4>#left-well</h4>
      <div class="well" id="left-well">
        <button class="btn btn-default target" id="target1">#target1</button>
        <button class="btn btn-default target" id="target2">#target2</button>
        <button class="btn btn-default target" id="target3">#target3</button>
      </div>
    </div>
    <div class="col-xs-6">
      <h4>#right-well</h4>
      <div class="well" id="right-well">
        <button class="btn btn-default target" id="target4">#target4</button>
        <button class="btn btn-default target" id="target5">#target5</button>
        <button class="btn btn-default target" id="target6">#target6</button>
      </div>
    </div>
  </div>
</div>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Target Elements by Class Using jQuery""",
        body: """You see how we made all of your `button` elements bounce? We selected them with `\$("button")`, then we added some CSS classes to them with `.addClass("animated bounce");`.

You just used jQuery's `.addClass()` function, which allows you to add classes to elements.

First, let's target your `div` elements with the class `well` by using the `\$(".well")` selector.

Note that, just like with CSS declarations, you type a `.` before the class's name.

Then use jQuery's `.addClass()` function to add the classes `animated` and `shake`.

For example, you could make all the elements with the class `text-primary` shake by adding the following to your `document ready function`:

Hint: You should use the jQuery `addClass()` function to give the classes `animated` and `shake` to all your elements with the class `well`.

You should only use jQuery to add these classes to the element.""",
        codeSnippet: """<script>
  \$(document).ready(function() {
    \$("button").addClass("animated bounce");
    \$(".well").addClass("animated shake");
  });
</script>

<!-- Only change code above this line -->

<div class="container-fluid">
  <h3 class="text-primary text-center">jQuery Playground</h3>
  <div class="row">
    <div class="col-xs-6">
      <h4>#left-well</h4>
      <div class="well" id="left-well">
        <button class="btn btn-default target" id="target1">#target1</button>
        <button class="btn btn-default target" id="target2">#target2</button>
        <button class="btn btn-default target" id="target3">#target3</button>
      </div>
    </div>
    <div class="col-xs-6">
      <h4>#right-well</h4>
      <div class="well" id="right-well">
        <button class="btn btn-default target" id="target4">#target4</button>
        <button class="btn btn-default target" id="target5">#target5</button>
        <button class="btn btn-default target" id="target6">#target6</button>
      </div>
    </div>
  </div>
</div>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Target Elements by id Using jQuery""",
        body: """You can also target elements by their id attributes.

First target your `button` element with the id `target3` by using the `\$("#target3")` selector.

Note that, just like with CSS declarations, you type a `#` before the id's name.

Then use jQuery's `.addClass()` function to add the classes `animated` and `fadeOut`.

Here's how you'd make the `button` element with the id `target6` fade out:

Hint: You should select the `button` element with the `id` of `target3` and use the jQuery `addClass()` function to give it the class of `animated`.

You should target the element with the id `target3` and use the jQuery `addClass()` function to give it the class `fadeOut`.

You should only use jQuery to add these classes to the element.""",
        codeSnippet: """<script>
  \$(document).ready(function() {
    \$("button").addClass("animated bounce");
    \$(".well").addClass("animated shake");
    \$("#target3").addClass("animated fadeOut");
  });
</script>

<!-- Only change code above this line -->

<div class="container-fluid">
  <h3 class="text-primary text-center">jQuery Playground</h3>
  <div class="row">
    <div class="col-xs-6">
      <h4>#left-well</h4>
      <div class="well" id="left-well">
        <button class="btn btn-default target" id="target1">#target1</button>
        <button class="btn btn-default target" id="target2">#target2</button>
        <button class="btn btn-default target" id="target3">#target3</button>
      </div>
    </div>
    <div class="col-xs-6">
      <h4>#right-well</h4>
      <div class="well" id="right-well">
        <button class="btn btn-default target" id="target4">#target4</button>
        <button class="btn btn-default target" id="target5">#target5</button>
        <button class="btn btn-default target" id="target6">#target6</button>
      </div>
    </div>
  </div>
</div>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Delete Your jQuery Functions""",
        body: """These animations were cool at first, but now they're getting kind of distracting.

Delete all three of these jQuery functions from your `document ready function`, but leave your `document ready function` itself intact.

Hint: All three of your jQuery functions should be deleted from your `document ready function`.

You should leave your `script` element intact.

You should leave your `\$(document).ready(function() {` at the beginning of your `script` element.

You should leave the `document.ready` function's closing `})` intact.

You should leave your `script` element closing tag intact.""",
        codeSnippet: """<script>
  \$(document).ready(function() {

  });
</script>

<!-- Only change code above this line -->

<div class="container-fluid">
  <h3 class="text-primary text-center">jQuery Playground</h3>
  <div class="row">
    <div class="col-xs-6">
      <h4>#left-well</h4>
      <div class="well" id="left-well">
        <button class="btn btn-default target" id="target1">#target1</button>
        <button class="btn btn-default target" id="target2">#target2</button>
        <button class="btn btn-default target" id="target3">#target3</button>
      </div>
    </div>
    <div class="col-xs-6">
      <h4>#right-well</h4>
      <div class="well" id="right-well">
        <button class="btn btn-default target" id="target4">#target4</button>
        <button class="btn btn-default target" id="target5">#target5</button>
        <button class="btn btn-default target" id="target6">#target6</button>
      </div>
    </div>
  </div>
</div>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Target the Same Element with Multiple jQuery Selectors""",
        body: """Now you know three ways of targeting elements: by type: `\$("button")`, by class: `\$(".btn")`, and by id `\$("#target1")`.

Although it is possible to add multiple classes in a single `.addClass()` call, let's add them to the same element in *three separate ways*.

Using `.addClass()`, add only one class at a time to the same element, three different ways:

Add the `animated` class to all elements with type `button`.

Add the `shake` class to all the buttons with class `.btn`.

Add the `btn-primary` class to the button with id `#target1`.

**Note:** You should only be targeting one element and adding only one class at a time. Altogether, your three individual selectors will end up adding the three classes `shake`, `animated`, and `btn-primary` to `#target1`.

Hint: Your code should use the `\$("button")` selector.

Your code should use the `\$(".btn")` selector.

Your code should use the `\$("#target1")` selector.

You should only add one class with each of your three selectors.

Your `#target1` element should have the classes `animated`‚ `shake` and `btn-primary`.

You should only use jQuery to add these classes to the element.""",
        codeSnippet: """<script>
  \$(document).ready(function() {
    \$("button").addClass("animated");
    \$(".btn").addClass("shake");
    \$("#target1").addClass("btn-primary");
  });
</script>

<!-- Only change code above this line -->

<div class="container-fluid">
  <h3 class="text-primary text-center">jQuery Playground</h3>
  <div class="row">
    <div class="col-xs-6">
      <h4>#left-well</h4>
      <div class="well" id="left-well">
        <button class="btn btn-default target" id="target1">#target1</button>
        <button class="btn btn-default target" id="target2">#target2</button>
        <button class="btn btn-default target" id="target3">#target3</button>
      </div>
    </div>
    <div class="col-xs-6">
      <h4>#right-well</h4>
      <div class="well" id="right-well">
        <button class="btn btn-default target" id="target4">#target4</button>
        <button class="btn btn-default target" id="target5">#target5</button>
        <button class="btn btn-default target" id="target6">#target6</button>
      </div>
    </div>
  </div>
</div>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Remove Classes from an Element with jQuery""",
        body: """In the same way you can add classes to an element with jQuery's `addClass()` function, you can remove them with jQuery's `removeClass()` function.

Here's how you would do this for a specific button:

Let's remove the `btn-default` class from all of our `button` elements.

Hint: The `btn-default` class should be removed from all of your `button` elements.

You should only use jQuery to remove this class from the element.

You should only remove the `btn-default` class.""",
        codeSnippet: """<script>
  \$(document).ready(function() {
    \$("button").addClass("animated bounce");
    \$(".well").addClass("animated shake");
    \$("#target3").addClass("animated fadeOut");
    \$("button").removeClass("btn-default");
  });
</script>

<!-- Only change code above this line -->

<div class="container-fluid">
  <h3 class="text-primary text-center">jQuery Playground</h3>
  <div class="row">
    <div class="col-xs-6">
      <h4>#left-well</h4>
      <div class="well" id="left-well">
        <button class="btn btn-default target" id="target1">#target1</button>
        <button class="btn btn-default target" id="target2">#target2</button>
        <button class="btn btn-default target" id="target3">#target3</button>
      </div>
    </div>
    <div class="col-xs-6">
      <h4>#right-well</h4>
      <div class="well" id="right-well">
        <button class="btn btn-default target" id="target4">#target4</button>
        <button class="btn btn-default target" id="target5">#target5</button>
        <button class="btn btn-default target" id="target6">#target6</button>
      </div>
    </div>
  </div>
</div>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Change the CSS of an Element Using jQuery""",
        body: """We can also change the CSS of an HTML element directly with jQuery.

jQuery has a function called `.css()` that allows you to change the CSS of an element.

Here's how we would change its color to blue:

This is slightly different from a normal CSS declaration, because the CSS property and its value are in quotes, and separated with a comma instead of a colon.

Delete your jQuery selectors, leaving an empty `document ready function`.

Select `target1` and change its color to red.

Hint: Your `target1` element should have red text.

You should only use jQuery to add these classes to the element.""",
        codeSnippet: """<script>
  \$(document).ready(function() {
    \$("button").addClass("animated bounce");
    \$(".well").addClass("animated shake");
    \$("#target3").addClass("animated fadeOut");
    \$("button").removeClass("btn-default");
    \$("#target1").css("color", "red");
  });
</script>

<!-- Only change code above this line -->
<div class="container-fluid">
  <h3 class="text-primary text-center">jQuery Playground</h3>
  <div class="row">
    <div class="col-xs-6">
      <h4>#left-well</h4>
      <div class="well" id="left-well">
        <button class="btn btn-default target" id="target1">#target1</button>
        <button class="btn btn-default target" id="target2">#target2</button>
        <button class="btn btn-default target" id="target3">#target3</button>
      </div>
    </div>
    <div class="col-xs-6">
      <h4>#right-well</h4>
      <div class="well" id="right-well">
        <button class="btn btn-default target" id="target4">#target4</button>
        <button class="btn btn-default target" id="target5">#target5</button>
        <button class="btn btn-default target" id="target6">#target6</button>
      </div>
    </div>
  </div>
</div>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Disable an Element Using jQuery""",
        body: """You can also change the non-CSS properties of HTML elements with jQuery. For example, you can disable buttons.

When you disable a button, it will become grayed-out and can no longer be clicked.

jQuery has a function called `.prop()` that allows you to adjust the properties of elements.

Here's how you would disable all buttons:

Disable only the `target1` button.

Hint: Your `target1` button should be disabled.

No other buttons should be disabled.

You should only use jQuery to add these classes to the element.""",
        codeSnippet: """<script>
  \$(document).ready(function() {
    \$("#target1").css("color", "red");
    \$("#target1").prop("disabled", true);

  });
</script>

<!-- Only change code above this line -->

<div class="container-fluid">
  <h3 class="text-primary text-center">jQuery Playground</h3>
  <div class="row">
    <div class="col-xs-6">
      <h4>#left-well</h4>
      <div class="well" id="left-well">
        <button class="btn btn-default target" id="target1">#target1</button>
        <button class="btn btn-default target" id="target2">#target2</button>
        <button class="btn btn-default target" id="target3">#target3</button>
      </div>
    </div>
    <div class="col-xs-6">
      <h4>#right-well</h4>
      <div class="well" id="right-well">
        <button class="btn btn-default target" id="target4">#target4</button>
        <button class="btn btn-default target" id="target5">#target5</button>
        <button class="btn btn-default target" id="target6">#target6</button>
      </div>
    </div>
  </div>
</div>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Change Text Inside an Element Using jQuery""",
        body: """Using jQuery, you can change the text between the start and end tags of an element. You can even change HTML markup.

jQuery has a function called `.html()` that lets you add HTML tags and text within an element. Any content previously within the element will be completely replaced with the content you provide using this function.

Here's how you would rewrite and emphasize the text of our heading:

jQuery also has a similar function called `.text()` that only alters text without adding tags. In other words, this function will not evaluate any HTML tags passed to it, but will instead treat it as the text you want to replace the existing content with.

Change the button with id `target4` by emphasizing its text.

View our news article for &lt;em&gt; to learn the difference between `` and `` and their uses.

Note that while the `` tag has traditionally been used to emphasize text, it has since been adopted for use as a tag for icons. The `` tag is now widely accepted as the tag for emphasis. Either will work for this challenge.

Hint: You should emphasize the text in your `target4` button by adding HTML tags.

The text should otherwise remain unchanged.

You should not alter any other text.

You should be using `.html()` and not `.text()`.

You should select `button id="target4"` with jQuery.""",
        codeSnippet: """<script>
  \$(document).ready(function() {
    \$("#target1").css("color", "red");
    \$("#target4").html('<em>#target4</em>');
  });
</script>

<div class="container-fluid">
  <h3 class="text-primary text-center">jQuery Playground</h3>
  <div class="row">
    <div class="col-xs-6">
      <h4>#left-well</h4>
      <div class="well" id="left-well">
        <button class="btn btn-default target" id="target1">#target1</button>
        <button class="btn btn-default target" id="target2">#target2</button>
        <button class="btn btn-default target" id="target3">#target3</button>
      </div>
    </div>
    <div class="col-xs-6">
      <h4>#right-well</h4>
      <div class="well" id="right-well">
        <button class="btn btn-default target" id="target4">#target4</button>
        <button class="btn btn-default target" id="target5">#target5</button>
        <button class="btn btn-default target" id="target6">#target6</button>
      </div>
    </div>
  </div>
</div>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Remove an Element Using jQuery""",
        body: """Now let's remove an HTML element from your page using jQuery.

jQuery has a function called `.remove()` that will remove an HTML element entirely.

Remove the `#target4` element from the page by using the `.remove()` function.

Hint: You should use jQuery to remove your `target4` element from your page.

You should only use jQuery to remove this element.""",
        codeSnippet: """<script>
  \$(document).ready(function() {
    \$("#target1").css("color", "red");
    \$("#target1").prop("disabled", true);
    \$("#target4").remove();
  });
</script>

<!-- Only change code above this line -->

<div class="container-fluid">
  <h3 class="text-primary text-center">jQuery Playground</h3>
  <div class="row">
    <div class="col-xs-6">
      <h4>#left-well</h4>
      <div class="well" id="left-well">
        <button class="btn btn-default target" id="target1">#target1</button>
        <button class="btn btn-default target" id="target2">#target2</button>
        <button class="btn btn-default target" id="target3">#target3</button>
      </div>
    </div>
    <div class="col-xs-6">
      <h4>#right-well</h4>
      <div class="well" id="right-well">
        <button class="btn btn-default target" id="target4">#target4</button>
        <button class="btn btn-default target" id="target5">#target5</button>
        <button class="btn btn-default target" id="target6">#target6</button>
      </div>
    </div>
  </div>
</div>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Use appendTo to Move Elements with jQuery""",
        body: """Now let's try moving elements from one `div` to another.

jQuery has a function called `appendTo()` that allows you to select HTML elements and append them to another element.

For example, if we wanted to move `target4` from our right well to our left well, we would use:

Move your `target2` element from your `left-well` to your `right-well`.

Hint: Your `target2` element should not be inside your `left-well`.

Your `target2` element should be inside your `right-well`.

You should only use jQuery to move these elements.""",
        codeSnippet: """<script>
  \$(document).ready(function() {
    \$("#target1").css("color", "red");
    \$("#target1").prop("disabled", true);
    \$("#target4").remove();
    \$("#target2").appendTo("#right-well");
  });
</script>

<!-- Only change code above this line -->

<div class="container-fluid">
  <h3 class="text-primary text-center">jQuery Playground</h3>
  <div class="row">
    <div class="col-xs-6">
      <h4>#left-well</h4>
      <div class="well" id="left-well">
        <button class="btn btn-default target" id="target1">#target1</button>
        <button class="btn btn-default target" id="target2">#target2</button>
        <button class="btn btn-default target" id="target3">#target3</button>
      </div>
    </div>
    <div class="col-xs-6">
      <h4>#right-well</h4>
      <div class="well" id="right-well">
        <button class="btn btn-default target" id="target4">#target4</button>
        <button class="btn btn-default target" id="target5">#target5</button>
        <button class="btn btn-default target" id="target6">#target6</button>
      </div>
    </div>
  </div>
</div>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Clone an Element Using jQuery""",
        body: """In addition to moving elements, you can also copy them from one place to another.

jQuery has a function called `clone()` that makes a copy of an element.

For example, if we wanted to copy `target2` from our `left-well` to our `right-well`, we would use:

Did you notice this involves sticking two jQuery functions together? This is called function chaining and it's a convenient way to get things done with jQuery.

Clone your `target5` element and append it to your `left-well`.

Hint: Your `target5` element should be inside your `right-well`.

A copy of your `target5` element should also be inside your `left-well`.

You should only use jQuery to move these elements.""",
        codeSnippet: """<script>
  \$(document).ready(function() {
    \$("#target1").css("color", "red");
    \$("#target1").prop("disabled", true);
    \$("#target4").remove();
    \$("#target2").appendTo("#right-well");
    \$("#target5").clone().appendTo("#left-well");
  });
</script>

<!-- Only change code above this line -->

<div class="container-fluid">
  <h3 class="text-primary text-center">jQuery Playground</h3>
  <div class="row">
    <div class="col-xs-6">
      <h4>#left-well</h4>
      <div class="well" id="left-well">
        <button class="btn btn-default target" id="target1">#target1</button>
        <button class="btn btn-default target" id="target2">#target2</button>
        <button class="btn btn-default target" id="target3">#target3</button>
      </div>
    </div>
    <div class="col-xs-6">
      <h4>#right-well</h4>
      <div class="well" id="right-well">
        <button class="btn btn-default target" id="target4">#target4</button>
        <button class="btn btn-default target" id="target5">#target5</button>
        <button class="btn btn-default target" id="target6">#target6</button>
      </div>
    </div>
  </div>
</div>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Target the Parent of an Element Using jQuery""",
        body: """Every HTML element has a `parent` element from which it `inherits` properties.

For example, the `h3` element in your `jQuery Playground` has the parent element of ``, which itself has the parent element of `body`.

jQuery has a function called `parent()` that allows you to access the parent of whichever element you've selected.

Here's an example of how you would use the `parent()` function if you wanted to give the parent element of the `left-well` element a background color of blue:

Give the parent of the `#target1` element a background-color of red.

Hint: Your `left-well` element should have a red background.

You should use the `.parent()` function to modify this element.

The `.parent()` method should be called on the `#target1` element.

You should only use jQuery to add these classes to the element.""",
        codeSnippet: """<script>
  \$(document).ready(function() {
    \$("#target1").css("color", "red");
    \$("#target1").prop("disabled", true);
    \$("#target4").remove();
    \$("#target2").appendTo("#right-well");
    \$("#target5").clone().appendTo("#left-well");
    \$("#target1").parent().css("background-color", "red");
  });
</script>

<!-- Only change code above this line -->

<body>
  <div class="container-fluid">
    <h3 class="text-primary text-center">jQuery Playground</h3>
    <div class="row">
      <div class="col-xs-6">
        <h4>#left-well</h4>
        <div class="well" id="left-well">
          <button class="btn btn-default target" id="target1">#target1</button>
          <button class="btn btn-default target" id="target2">#target2</button>
          <button class="btn btn-default target" id="target3">#target3</button>
        </div>
      </div>
      <div class="col-xs-6">
        <h4>#right-well</h4>
        <div class="well" id="right-well">
          <button class="btn btn-default target" id="target4">#target4</button>
          <button class="btn btn-default target" id="target5">#target5</button>
          <button class="btn btn-default target" id="target6">#target6</button>
        </div>
      </div>
    </div>
  </div>
</body>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Target the Children of an Element Using jQuery""",
        body: """When HTML elements are placed one level below another they are called children of that element. For example, the button elements in this challenge with the text `#target1`, `#target2`, and `#target3` are all children of the `` element.

jQuery has a function called `children()` that allows you to access the children of whichever element you've selected.

Here's an example of how you would use the `children()` function to give the children of your `left-well` element the color `blue`:

Give all the children of your `right-well` element the color orange.

Hint: All children of `#right-well` should have orange text.

You should use the `children()` function to modify these elements.

You should only use jQuery to add these classes to the element.""",
        codeSnippet: """<script>
  \$(document).ready(function() {
    \$("#target1").css("color", "red");
    \$("#target1").prop("disabled", true);
    \$("#target4").remove();
    \$("#target2").appendTo("#right-well");
    \$("#target5").clone().appendTo("#left-well");
    \$("#target1").parent().css("background-color", "red");
    \$("#right-well").children().css("color", "orange");
  });
</script>

<!-- Only change code above this line -->

<div class="container-fluid">
  <h3 class="text-primary text-center">jQuery Playground</h3>
  <div class="row">
    <div class="col-xs-6">
      <h4>#left-well</h4>
      <div class="well" id="left-well">
        <button class="btn btn-default target" id="target1">#target1</button>
        <button class="btn btn-default target" id="target2">#target2</button>
        <button class="btn btn-default target" id="target3">#target3</button>
      </div>
    </div>
    <div class="col-xs-6">
      <h4>#right-well</h4>
      <div class="well" id="right-well">
        <button class="btn btn-default target" id="target4">#target4</button>
        <button class="btn btn-default target" id="target5">#target5</button>
        <button class="btn btn-default target" id="target6">#target6</button>
      </div>
    </div>
  </div>
</div>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Target a Specific Child of an Element Using jQuery""",
        body: """You've seen why id attributes are so convenient for targeting with jQuery selectors. But you won't always have such neat ids to work with.

Fortunately, jQuery has some other tricks for targeting the right elements.

jQuery uses CSS Selectors to target elements. The `target:nth-child(n)` CSS selector allows you to select all the nth elements with the target class or element type.

Here's how you would give the third element in each well the bounce class:

Make the second child in each of your well elements bounce. You must select the elements' children with the `target` class.

Hint: The second element in your `target` elements should bounce.

Only two elements should bounce.

You should use the `:nth-child()` selector to modify these elements.

You should only use jQuery to add these classes to the element.""",
        codeSnippet: """<script>
  \$(document).ready(function() {
    \$("#target1").css("color", "red");
    \$("#target1").prop("disabled", true);
    \$("#target4").remove();
    \$("#target2").appendTo("#right-well");
    \$("#target5").clone().appendTo("#left-well");
    \$("#target1").parent().css("background-color", "red");
    \$("#right-well").children().css("color", "orange");
    \$(".target:nth-child(2)").addClass("animated bounce");
  });
</script>

<!-- Only change code above this line -->

<div class="container-fluid">
  <h3 class="text-primary text-center">jQuery Playground</h3>
  <div class="row">
    <div class="col-xs-6">
      <h4>#left-well</h4>
      <div class="well" id="left-well">
        <button class="btn btn-default target" id="target1">#target1</button>
        <button class="btn btn-default target" id="target2">#target2</button>
        <button class="btn btn-default target" id="target3">#target3</button>
      </div>
    </div>
    <div class="col-xs-6">
      <h4>#right-well</h4>
      <div class="well" id="right-well">
        <button class="btn btn-default target" id="target4">#target4</button>
        <button class="btn btn-default target" id="target5">#target5</button>
        <button class="btn btn-default target" id="target6">#target6</button>
      </div>
    </div>
  </div>
</div>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Target Even Elements Using jQuery""",
        body: """You can also target elements based on their positions using `:odd` or `:even` selectors.

Note that jQuery is zero-indexed which means the first element in a selection has a position of 0. This can be a little confusing as, counter-intuitively, `:odd` selects the second element (position 1), fourth element (position 3), and so on.

Here's how you would target all the odd elements with class `target` and give them classes:

Try selecting all the even `target` elements and giving them the classes of `animated` and `shake`. Remember that **even** refers to the position of elements with a zero-based system in mind.

Hint: All of the `target` elements that jQuery considers to be even should shake.

You should use the `:even` selector to modify these elements.

You should only use jQuery to add these classes to the element.""",
        codeSnippet: """<script>
  \$(document).ready(function() {
    \$("#target1").css("color", "red");
    \$("#target1").prop("disabled", true);
    \$("#target4").remove();
    \$("#target2").appendTo("#right-well");
    \$("#target5").clone().appendTo("#left-well");
    \$("#target1").parent().css("background-color", "red");
    \$("#right-well").children().css("color", "orange");
    \$("#left-well").children().css("color", "green");
    \$(".target:nth-child(2)").addClass("animated bounce");
    \$(".target:even").addClass("animated shake");
  });
</script>

<!-- Only change code above this line -->

<div class="container-fluid">
  <h3 class="text-primary text-center">jQuery Playground</h3>
  <div class="row">
    <div class="col-xs-6">
      <h4>#left-well</h4>
      <div class="well" id="left-well">
        <button class="btn btn-default target" id="target1">#target1</button>
        <button class="btn btn-default target" id="target2">#target2</button>
        <button class="btn btn-default target" id="target3">#target3</button>
      </div>
    </div>
    <div class="col-xs-6">
      <h4>#right-well</h4>
      <div class="well" id="right-well">
        <button class="btn btn-default target" id="target4">#target4</button>
        <button class="btn btn-default target" id="target5">#target5</button>
        <button class="btn btn-default target" id="target6">#target6</button>
      </div>
    </div>
  </div>
</div>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Use jQuery to Modify the Entire Page""",
        body: """We're done playing with our jQuery playground. Let's tear it down!

jQuery can target the `body` element as well.

Here's how we would make the entire body fade out: `\$("body").addClass("animated fadeOut");`

But let's do something more dramatic. Add the classes `animated` and `hinge` to your `body` element.

Hint: You should add the classes `animated` and `hinge` to your `body` element.""",
        codeSnippet: """<script>
  \$(document).ready(function() {
    \$("#target1").css("color", "red");
    \$("#target1").prop("disabled", true);
    \$("#target4").remove();
    \$("#target2").appendTo("#right-well");
    \$("#target5").clone().appendTo("#left-well");
    \$("#target1").parent().css("background-color", "red");
    \$("#right-well").children().css("color", "orange");
    \$("#left-well").children().css("color", "green");
    \$(".target:nth-child(2)").addClass("animated bounce");
    \$(".target:even").addClass("animated shake");
    \$("body").addClass("animated hinge");
  });
</script>

<!-- Only change code above this line -->

<div class="container-fluid">
  <h3 class="text-primary text-center">jQuery Playground</h3>
  <div class="row">
    <div class="col-xs-6">
      <h4>#left-well</h4>
      <div class="well" id="left-well">
        <button class="btn btn-default target" id="target1">#target1</button>
        <button class="btn btn-default target" id="target2">#target2</button>
        <button class="btn btn-default target" id="target3">#target3</button>
      </div>
    </div>
    <div class="col-xs-6">
      <h4>#right-well</h4>
      <div class="well" id="right-well">
        <button class="btn btn-default target" id="target4">#target4</button>
        <button class="btn btn-default target" id="target5">#target5</button>
        <button class="btn btn-default target" id="target6">#target6</button>
      </div>
    </div>
  </div>
</div>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Store Data with Sass Variables""",
        body: """One feature of Sass that's different than CSS is it uses variables. They are declared and set to store data, similar to JavaScript.

In JavaScript, variables are defined using the `let` and `const` keywords. In Sass, variables start with a `\$` followed by the variable name.

Here are a couple examples:

And to use the variables:

One example where variables are useful is when a number of elements need to be the same color. If that color is changed, the only place to edit the code is the variable value.

Create a variable `\$text-color` and set it to `red`. Then change the value of the `color` property for the `.blog-post` and `h2` to the `\$text-color` variable.

Hint: Your code should have a Sass variable declared for `\$text-color` with a value of `red`.

Your code should use the `\$text-color` variable to change the `color` for the `.blog-post` and `h2` items.

Your `.blog-post` element should have a `color` of red.

Your `h2` elements should have a `color` of red.""",
        codeSnippet: """<style type='text/scss'>
  \$text-color: red;

  .header{
    text-align: center;
  }
  .blog-post, h2 {
    color: \$text-color;
  }
</style>

<h1 class="header">Learn Sass</h1>
<div class="blog-post">
  <h2>Some random title</h2>
  <p>This is a paragraph with some random text in it</p>
</div>
<div class="blog-post">
  <h2>Header #2</h2>
  <p>Here is some more random text.</p>
</div>
<div class="blog-post">
  <h2>Here is another header</h2>
  <p>Even more random text within a paragraph</p>
</div>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Nest CSS with Sass""",
        body: """Sass allows nesting of CSS rules, which is a useful way of organizing a style sheet.

Normally, each element is targeted on a different line to style it, like so:

For a large project, the CSS file will have many lines and rules. This is where nesting can help organize your code by placing child style rules within the respective parent elements:

Use the nesting technique shown above to re-organize the CSS rules for both children of `.blog-post` element. For testing purposes, the `h1` should come before the `p` element.

Hint: Your code should re-organize the CSS rules so the `h1` and `p` are nested in the `.blog-post` parent element.""",
        codeSnippet: """<style type='text/scss'>
  .blog-post {
    h1 {
      text-align: center;
      color: blue;
    }
    p {
      font-size: 20px;
    }
  }
</style>

<div class="blog-post">
  <h1>Blog Title</h1>
  <p>This is a paragraph</p>
</div>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Create Reusable CSS with Mixins""",
        body: """In Sass, a mixin is a group of CSS declarations that can be reused throughout the style sheet. The definition starts with the `@mixin` at-rule, followed by a custom name. You apply the mixin using the `@include` at-rule.

Compiles to:

Your mixins can also take arguments, which allows their behavior to be customized. The arguments are required when using the mixin.

You can make arguments optional by giving the parameters default values.

Write a mixin named `shape` and give it 3 parameters: `\$w`, `\$h`, and `\$bg-color`.

Use the `shape` mixin to give the `#square` element a width and height of `50px`, and the background color `red`. For the `#rect-a` element add a width of `100px`, a height of `50px`, and the background color `blue`. Finally, for the `#rect-b` element add a width of `50px`, a height of `100px`, and the background color `orange`.

Hint: You should declare a mixin named `shape` with 3 parameters: `\$w`, `\$h`, and `\$bg-color`.

Your mixin should include a `width` property that uses the `\$w` parameter.

Your mixin should include a `height` property that uses the `\$h` parameter.

Your mixin should include a `background-color` property that uses the `\$bg-color` parameter.

You should replace the styles inside the `#square` selector with a call to the `shape` mixin using the `@include` keyword. Setting a width and height of `50px`, and the background color `red`.

You should replace the styles inside the `#rect-a` selector with a call to the `shape` mixin using the `@include` keyword. Setting a width of `100px`, a height of `50px`, and the background color `blue`.

You should replace the styles inside the `#rect-b` selector with a call to the `shape` mixin using the `@include` keyword. Setting a width of `50px`, a height of `100px`, and the background color `orange`.""",
        codeSnippet: """<style type='text/scss'>
@mixin shape(\$w, \$h, \$bg-color) {
  width: \$w;
  height: \$h;
  background-color: \$bg-color;
}

#square {
  @include shape(50px, 50px, red);
}

#rect-a {
  @include shape(100px, 50px, blue);
}

#rect-b {
  @include shape(50px, 100px, orange);
}
</style>

<div id="square"></div>
<div id="rect-a"></div>
<div id="rect-b"></div>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Use @if and @else to Add Logic To Your Styles""",
        body: """The `@if` directive in Sass is useful to test for a specific case - it works just like the `if` statement in JavaScript.

And just like in JavaScript, the `@else if` and `@else` directives test for more conditions:

Create a mixin called `border-stroke` that takes a parameter `\$val`. The mixin should check for the following conditions using `@if`, `@else if`, and `@else` directives:

If the `\$val` parameter value is not `light`, `medium`, or `heavy`, then the `border` property should be set to `none`.

Hint: Your code should declare a mixin named `border-stroke` which has a parameter named `\$val`.

Your mixin should have an `@if` statement to check if `\$val` is `light`, and to set the `border` to `1px solid black`.

Your mixin should have an `@else if` statement to check if `\$val` is `medium`, and to set the `border` to `3px solid black`.

Your mixin should have an `@else if` statement to check if `\$val` is `heavy`, and to set the `border` to `6px solid black`.

Your mixin should have an `@else` statement to set the `border` to `none`.""",
        codeSnippet: """<style type='text/scss'>
  @mixin border-stroke(\$val) {
    @if \$val == light {
      border: 1px solid black;
    }
    @else if \$val == medium {
      border: 3px solid black;
    }
    @else if \$val == heavy {
      border: 6px solid black;
    }
    @else {
      border: none;
    }
  }


  #box {
    width: 150px;
    height: 150px;
    background-color: red;
    @include border-stroke(medium);
  }
</style>

<div id="box"></div>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Use @for to Create a Sass Loop""",
        body: """The `@for` directive adds styles in a loop, very similar to a `for` loop in JavaScript.

`@for` is used in two ways: "start through end" or "start to end". The main difference is that the "start **to** end" *excludes* the end number as part of the count, and "start **through** end" *includes* the end number as part of the count.

Here's a start **through** end example:

The `#{\$i}` part is the syntax to combine a variable (`i`) with text to make a string. When the Sass file is converted to CSS, it looks like this:

This is a powerful way to create a grid layout. Now you have twelve options for column widths available as CSS classes.

Write a `@for` directive that takes a variable `\$j` that goes from 1 **to** 6.

It should create 5 classes called `.text-1` to `.text-5` where each has a `font-size` set to 15px multiplied by the index.

Hint: Your code should use the `@for` directive.

Your `.text-1` class should have a `font-size` of 15px.

Your `.text-2` class should have a `font-size` of 30px.

Your `.text-3` class should have a `font-size` of 45px.

Your `.text-4` class should have a `font-size` of 60px.

Your `.text-5` class should have a `font-size` of 75px.""",
        codeSnippet: """<style type='text/scss'>

@for \$i from 1 through 5 {
  .text-#{\$i} { font-size: 15px * \$i; }
}

</style>

<p class="text-1">Hello</p>
<p class="text-2">Hello</p>
<p class="text-3">Hello</p>
<p class="text-4">Hello</p>
<p class="text-5">Hello</p>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Use @each to Map Over Items in a List""",
        body: """The last challenge showed how the `@for` directive uses a starting and ending value to loop a certain number of times. Sass also offers the `@each` directive which loops over each item in a list or map. On each iteration, the variable gets assigned to the current value from the list or map.

A map has slightly different syntax. Here's an example:

Note that the `\$key` variable is needed to reference the keys in the map. Otherwise, the compiled CSS would have `color1`, `color2`... in it. Both of the above code examples are converted into the following CSS:

Write an `@each` directive that goes through a list: `blue, black, red` and assigns each variable to a `.color-bg` class, where the `color` part changes for each item to the respective color. Each class should set the `background-color` to the respective color as well.

Hint: Your code should use the `@each` directive.

Your `.blue-bg` class should have a `background-color` of blue.

Your `.black-bg` class should have a `background-color` of black.

Your `.red-bg` class should have a `background-color` of red.""",
        codeSnippet: """<style type='text/scss'>

  @each \$color in blue, black, red {
    .#{\$color}-bg {background-color: \$color;}
  }

  div {
    height: 200px;
    width: 200px;
  }
</style>

<div class="blue-bg"></div>
<div class="black-bg"></div>
<div class="red-bg"></div>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Apply a Style Until a Condition is Met with @while""",
        body: """The `@while` directive is an option with similar functionality to the JavaScript `while` loop. It creates CSS rules until a condition is met.

The `@for` challenge gave an example to create a simple grid system. This can also work with `@while`.

First, define a variable `\$x` and set it to 1. Next, use the `@while` directive to create the grid system *while* `\$x` is less than 13. After setting the CSS rule for `width`, `\$x` is incremented by 1 to avoid an infinite loop.

Use `@while` to create a series of classes with different `font-sizes`.

There should be 5 different classes from `text-1` to `text-5`. Then set `font-size` to `15px` multiplied by the current index number. Make sure to avoid an infinite loop!

Hint: Your code should use the `@while` directive.

Your code should use an index variable which starts at an index of 1.

Your code should increment the counter variable.

Your `.text-1` class should have a `font-size` of `15px`.

Your `.text-2` class should have a `font-size` of `30px`.

Your `.text-3` class should have a `font-size` of `45px`.

Your `.text-4` class should have a `font-size` of `60px`.

Your `.text-5` class should have a `font-size` of `75px`.""",
        codeSnippet: """<style type='text/scss'>
  \$x: 1;
  @while \$x < 6 {
    .text-#{\$x}{
      font-size: 15px * \$x;
    }
    \$x: \$x + 1;
  }
</style>

<p class="text-1">Hello</p>
<p class="text-2">Hello</p>
<p class="text-3">Hello</p>
<p class="text-4">Hello</p>
<p class="text-5">Hello</p>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Split Your Styles into Smaller Chunks with Partials""",
        body: """Partials in Sass are separate files that hold segments of CSS code. These are imported and used in other Sass files. This is a great way to group similar code into a module to keep it organized.

Names for partials start with the underscore (`_`) character, which tells Sass it is a small segment of CSS and not to convert it into a CSS file. Also, Sass files end with the `.scss` file extension. To bring the code in the partial into another Sass file, use the `@import` directive.

For example, if all your mixins are saved in a partial named "\\_mixins.scss", and they are needed in the "main.scss" file, this is how to use them in the main file:

Note that the underscore and file extension are not needed in the `import` statement - Sass understands it is a partial. Once a partial is imported into a file, all variables, mixins, and other code are available to use.

Write an `@import` statement to import a partial named `_variables.scss` into the main.scss file.

Hint: Your code should use the `@import` directive, and should not include the underscore in the file name.""",
        codeSnippet: """@import 'variables'""",
        hasImage: false,
      ),
      AppLesson(
        title: """Extend One Set of CSS Styles to Another Element""",
        body: """Sass has a feature called `extend` that makes it easy to borrow the CSS rules from one element and build upon them in another.

For example, the below block of CSS rules style a `.panel` class. It has a `background-color`, `height` and `border`.

Now you want another panel called `.big-panel`. It has the same base properties as `.panel`, but also needs a `width` and `font-size`. It's possible to copy and paste the initial CSS rules from `.panel`, but the code becomes repetitive as you add more types of panels. The `extend` directive is a simple way to reuse the rules written for one element, then add more for another:

The `.big-panel` will have the same properties as `.panel` in addition to the new styles.

Make a class `.info-important` that extends `.info` and also has a `background-color` set to magenta.

Hint: Your `info-important` class should have a `background-color` set to `magenta`.

Your `info-important` class should use `@extend` to inherit the styling from the `info` class.""",
        codeSnippet: """<style type='text/scss'>
  h3{
    text-align: center;
  }
  .info{
    width: 200px;
    border: 1px solid black;
    margin: 0 auto;
  }
  .info-important{
    @extend .info;
    background-color: magenta;
  }



</style>
<h3>Posts</h3>
<div class="info-important">
  <p>This is an important post. It should extend the class ".info" and have its own CSS styles.</p>
</div>

<div class="info">
  <p>This is a simple post. It has basic styling and can be extended for other uses.</p>
</div>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Create a Simple JSX Element""",
        body: """React is an Open Source view library created and maintained by Facebook. It's a great tool to render the User Interface (UI) of modern web applications.

React uses a syntax extension of JavaScript called JSX that allows you to write HTML directly within JavaScript. This has several benefits. It lets you use the full programmatic power of JavaScript within HTML, and helps to keep your code readable. For the most part, JSX is similar to the HTML that you have already learned, however there are a few key differences that will be covered throughout these challenges.

For instance, because JSX is a syntactic extension of JavaScript, you can actually write JavaScript directly within JSX. To do this, you simply include the code you want to be treated as JavaScript within curly braces: `{ 'this is treated as JavaScript code' }`. Keep this in mind, since it's used in several future challenges.

However, because JSX is not valid JavaScript, JSX code must be compiled into JavaScript. The transpiler Babel is a popular tool for this process. For your convenience, it's already added behind the scenes for these challenges. If you happen to write syntactically invalid JSX, you will see the first test in these challenges fail.

It's worth noting that under the hood the challenges are calling `ReactDOM.render(JSX, document.getElementById('root'))`. This function call is what places your JSX into React's own lightweight representation of the DOM. React then uses snapshots of its own DOM to optimize updating only specific parts of the actual DOM.

The current code uses JSX to assign a `div` element to the constant `JSX`. Replace the `div` with an `h1` element and add the text `Hello JSX!` inside it.

Hint: The constant `JSX` should return an `h1` element.

The `h1` tag should include the text `Hello JSX!`""",
        codeSnippet: """const JSX = <h1>Hello JSX!</h1>;""",
        hasImage: false,
      ),
      AppLesson(
        title: """Create a Complex JSX Element""",
        body: """The last challenge was a simple example of JSX, but JSX can represent more complex HTML as well.

One important thing to know about nested JSX is that it must return a single element.

This one parent element would wrap all of the other levels of nested elements.

For instance, several JSX elements written as siblings with no parent wrapper element will not transpile.

Here's an example:

**Valid JSX:**

**Invalid JSX:**

Define a new constant `JSX` that renders a `div` which contains the following elements in order:

An `h1`, a `p`, and an unordered list that contains three `li` items. You can include any text you want within each element.

**Note:** When rendering multiple elements like this, you can wrap them all in parentheses, but it's not strictly required. Also notice this challenge uses a `div` tag to wrap all the child elements within a single parent element. If you remove the `div`, the JSX will no longer transpile. Keep this in mind, since it will also apply when you return JSX elements in React components.

Hint: The constant `JSX` should return a `div` element.

The `div` should contain an `h1` tag as the first element.

The `div` should contain a `p` tag as the second element.

The `div` should contain a `ul` tag as the third element.

The `ul` should contain three `li` elements.""",
        codeSnippet: """const JSX = (
<div>
  <h1>Hello JSX!</h1>
  <p>Some info</p>
  <ul>
    <li>An item</li>
    <li>Another item</li>
    <li>A third item</li>
  </ul>
</div>);""",
        hasImage: false,
      )
    ],
  ),
  AppCourse(
    id: 'data-visualization',
    title: """Data Visualization""",
    description: """A freeCodeCamp curriculum covering Data Visualization, with 44 lessons extracted from the local curriculum assets.""",
    instructor: 'freeCodeCamp',
    category: 'Web Development',
    difficulty: 'Intermediate',
    icon: Icons.code,
    color: Colors.blue,
    duration: '4 weeks',
    lessons: [
      AppLesson(
        title: """Add Document Elements with D3""",
        body: """D3 has several methods that let you add and change elements in your document.

The `select()` method selects one element from the document. It takes an argument for the name of the element you want and returns an HTML node for the first element in the document that matches the name. Here's an example:

The above example finds the first anchor tag on the page and saves an HTML node for it in the variable `anchor`. You can use the selection with other methods. The `d3` part of the example is a reference to the D3 object, which is how you access D3 methods.

Two other useful methods are `append()` and `text()`.

The `append()` method takes an argument for the element you want to add to the document. It appends an HTML node to a selected item, and returns a handle to that node.

The `text()` method either sets the text of the selected node, or gets the current text. To set the value, you pass a string as an argument inside the parentheses of the method.

Here's an example that selects an unordered list, appends a list item, and adds text:

D3 allows you to chain several methods together with periods to perform a number of actions in a row.

Use the `select` method to select the `body` tag in the document. Then `append` an `h1` tag to it, and add the text `Learning D3` into the `h1` element.

Hint: The `body` should have one `h1` element.

The `h1` element should have the text `Learning D3` in it.

Your code should access the `d3` object.

Your code should use the `select` method.

Your code should use the `append` method.

Your code should use the `text` method.""",
        codeSnippet: """<body>
  <script>
    d3.select('body').append('h1').text('Learning D3');
  </script>
</body>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Select a Group of Elements with D3""",
        body: """D3 also has the `selectAll()` method to select a group of elements. It returns an array of HTML nodes for all the items in the document that match the input string. Here's an example to select all the anchor tags in a document:

Like the `select()` method, `selectAll()` supports method chaining, and you can use it with other methods.

Select all of the `li` tags in the document, and change their text to the string `list item` by chaining the `.text()` method.

Hint: There should be 3 `li` elements on the page, and the text in each one should say `list item`. Capitalization and spacing should match exactly.

Your code should access the `d3` object.

Your code should use the `selectAll` method.""",
        codeSnippet: """<body>
  <ul>
    <li>Example</li>
    <li>Example</li>
    <li>Example</li>
  </ul>
  <script>
    d3.selectAll('li').text('list item');
  </script>
</body>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Work with Data in D3""",
        body: """The D3 library focuses on a data-driven approach. When you have a set of data, you can apply D3 methods to display it on the page. Data comes in many formats, but this challenge uses a simple array of numbers.

The first step is to make D3 aware of the data. The `data()` method is used on a selection of DOM elements to attach the data to those elements. The data set is passed as an argument to the method.

A common workflow pattern is to create a new element in the document for each piece of data in the set. D3 has the `enter()` method for this purpose.

When `enter()` is combined with the `data()` method, it looks at the selected elements from the page and compares them to the number of data items in the set. If there are fewer elements than data items, it creates the missing elements.

Here is an example that selects a `ul` element and creates a new list item based on the number of entries in the array:

It may seem confusing to select elements that don't exist yet. This code is telling D3 to first select the `ul` on the page. Next, select all list items, which returns an empty selection. Then the `data()` method reviews the dataset and runs the following code three times, once for each item in the array. The `enter()` method sees there are no `li` elements on the page, but it needs 3 (one for each piece of data in `dataset`). New `li` elements are appended to the `ul` and have the text `New item`.

Select the `body` node, then select all `h2` elements. Have D3 create and append an `h2` tag for each item in the `dataset` array. The text in the `h2` should say `New Title`. Your code should use the `data()` and `enter()` methods.

Hint: Your document should have 9 `h2` elements.

The text in the `h2` elements should say `New Title`. The capitalization and spacing should match exactly.

Your code should use the `data()` method.

Your code should use the `enter()` method.""",
        codeSnippet: """<body>
  <script>
    const dataset = [12, 31, 22, 17, 25, 18, 29, 14, 9];

    d3.select('body')
      .selectAll('h2')
      .data(dataset)
      .enter()
      .append('h2')
      .text('New Title');
  </script>
</body>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Work with Dynamic Data in D3""",
        body: """The last two challenges cover the basics of displaying data dynamically with D3 using the `data()` and `enter()` methods. These methods take a data set and, together with the `append()` method, create a new DOM element for each entry in the data set.

In the previous challenge, you created a new `h2` element for each item in the `dataset` array, but they all contained the same text, `New Title`. This is because you have not made use of the data that is bound to each of the `h2` elements.

The D3 `text()` method can take a string or a callback function as an argument:

In the example above, the parameter `d` refers to a single entry in the dataset that a selection is bound to.

Using the current example as context, the first `h2` element is bound to 12, the second `h2` element is bound to 31, the third `h2` element is bound to 22, and so on.

Change the `text()` method so that each `h2` element displays the corresponding value from the `dataset` array with a single space and the string `USD`. For example, the first heading should be `12 USD`.

Hint: The first `h2` should have the text `12 USD`.

The second `h2` should have the text `31 USD`.

The third `h2` should have the text `22 USD`.

The fourth `h2` should have the text `17 USD`.

The fifth `h2` should have the text `25 USD`.

The sixth `h2` should have the text `18 USD`.

The seventh `h2` should have the text `29 USD`.

The eighth `h2` should have the text `14 USD`.

The ninth `h2` should have the text `9 USD`.""",
        codeSnippet: """<body>
  <script>
    const dataset = [12, 31, 22, 17, 25, 18, 29, 14, 9];

    d3.select('body')
      .selectAll('h2')
      .data(dataset)
      .enter()
      .append('h2')
      .text(d => `\${d} USD`);
  </script>
</body>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Add Inline Styling to Elements""",
        body: """D3 lets you add inline CSS styles on dynamic elements with the `style()` method.

The `style()` method takes a comma-separated key-value pair as an argument. Here's an example to set the selection's text color to blue:

Add the `style()` method to the code in the editor to make all the displayed text have a `font-family` of `verdana`.

Hint: Your `h2` elements should have a `font-family` of `verdana`.

Your code should use the `style()` method.""",
        codeSnippet: """<body>
  <script>
    const dataset = [12, 31, 22, 17, 25, 18, 29, 14, 9];

    d3.select('body')
      .selectAll('h2')
      .data(dataset)
      .enter()
      .append('h2')
      .text(d => d + ' USD')
      .style('font-family', 'verdana');
  </script>
</body>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Change Styles Based on Data""",
        body: """D3 is about visualization and presentation of data. It's likely you'll want to change the styling of elements based on the data.
For example, you may want to color a data point blue if it has a value less than 20, and red otherwise. You can use a callback function in the `style()` method and include the conditional logic. The callback function uses the `d` parameter to represent the data point:

The `style()` method is not limited to setting the `color` - it can be used with other CSS properties as well.

Add the `style()` method to the code in the editor to set the `color` of the `h2` elements conditionally. Write the callback function so if the data value is less than 20, it returns red, otherwise it returns green.

**Note:** You can use if-else logic, or the ternary operator.

Hint: The first `h2` should have a `color` of red.

The second `h2` should have a `color` of green.

The third `h2` should have a `color` of green.

The fourth `h2` should have a `color` of red.

The fifth `h2` should have a `color` of green.

The sixth `h2` should have a `color` of red.

The seventh `h2` should have a `color` of green.

The eighth `h2` should have a `color` of red.

The ninth `h2` should have a `color` of red.""",
        codeSnippet: """<body>
  <script>
    const dataset = [12, 31, 22, 17, 25, 18, 29, 14, 9];

    d3.select('body')
      .selectAll('h2')
      .data(dataset)
      .enter()
      .append('h2')
      .text(d => d + ' USD')
      .style('color', d => (d < 20 ? 'red' : 'green'));
  </script>
</body>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Add Classes with D3""",
        body: """Using a lot of inline styles on HTML elements gets hard to manage, even for smaller apps. It's easier to add a class to elements and style that class one time using CSS rules. D3 has the `attr()` method to add any HTML attribute to an element, including a class name.

The `attr()` method works the same way that `style()` does. It takes comma-separated values, and can use a callback function. Here's an example to add a class of `container` to a selection:

Note that the `class` parameter will remain the same whenever you need to add a class and only the `container` parameter will change.

Add the `attr()` method to the code in the editor and put a class of `bar` on the `div` elements.

Hint: Your `div` elements should have a class of `bar`.

Your code should use the `attr()` method.""",
        codeSnippet: """<style>
  .bar {
    width: 25px;
    height: 100px;
    display: inline-block;
    background-color: blue;
  }
</style>
<body>
  <script>
    const dataset = [12, 31, 22, 17, 25, 18, 29, 14, 9];

    d3.select('body')
      .selectAll('div')
      .data(dataset)
      .enter()
      .append('div')
      // Add your code below this line
      .attr('class', 'bar');
    // Add your code above this line
  </script>
</body>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Update the Height of an Element Dynamically""",
        body: """The previous challenges covered how to display data from an array and how to add CSS classes. You can combine these lessons to create a simple bar chart. There are two steps to this:

1. Create a `div` for each data point in the array

2. Give each `div` a dynamic height, using a callback function in the `style()` method that sets height equal to the data value

Recall the format to set a style using a callback function:

Add the `style()` method to the code in the editor to set the `height` property for each element. Use a callback function to return the value of the data point with the string `px` added to it.

Hint: The first `div` should have a `height` of `12` pixels.

The second `div` should have a `height` of `31` pixels.

The third `div` should have a `height` of `22` pixels.

The fourth `div` should have a `height` of `17` pixels.

The fifth `div` should have a `height` of `25` pixels.

The sixth `div` should have a `height` of `18` pixels.

The seventh `div` should have a `height` of `29` pixels.

The eighth `div` should have a `height` of `14` pixels.

The ninth `div` should have a `height` of `9` pixels.""",
        codeSnippet: """<style>
  .bar {
    width: 25px;
    height: 100px;
    display: inline-block;
    background-color: blue;
  }
</style>
<body>
  <script>
    const dataset = [12, 31, 22, 17, 25, 18, 29, 14, 9];

    d3.select('body')
      .selectAll('div')
      .data(dataset)
      .enter()
      .append('div')
      .attr('class', 'bar')
      .style('height', d => `\${d}px`);
  </script>
</body>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Change the Presentation of a Bar Chart""",
        body: """The last challenge created a bar chart, but there are a couple of formatting changes that could improve it:

1. Add space between each bar to visually separate them, which is done by adding a margin to the CSS for the `bar` class

2. Increase the height of the bars to better show the difference in values, which is done by multiplying the value by a number to scale the height

First, add a `margin` of `2px` to the `bar` class in the `style` tag. Next, change the callback function in the `style()` method so it returns a value `10` times the original data value (plus the `px`).

**Note:** Multiplying each data point by the _same_ constant only alters the scale. It's like zooming in, and it doesn't change the meaning of the underlying data.

Hint: The first `div` should have a `height` of `120` pixels and a `margin` of `2` pixels.

The second `div` should have a `height` of `310` pixels and a `margin` of `2` pixels.

The third `div` should have a `height` of `220` pixels and a `margin` of `2` pixels.

The fourth `div` should have a `height` of `170` pixels and a `margin` of `2` pixels.

The fifth `div` should have a `height` of `250` pixels and a `margin` of `2` pixels.

The sixth `div` should have a `height` of `180` pixels and a `margin` of `2` pixels.

The seventh `div` should have a `height` of `290` pixels and a `margin` of `2` pixels.

The eighth `div` should have a `height` of `140` pixels and a `margin` of `2` pixels.

The ninth `div` should have a `height` of `90` pixels and a `margin` of `2` pixels.""",
        codeSnippet: """<style>
  .bar {
    width: 25px;
    height: 100px;
    margin: 2px;
    display: inline-block;
    background-color: blue;
  }
</style>
<body>
  <script>
    const dataset = [12, 31, 22, 17, 25, 18, 29, 14, 9];

    d3.select('body')
      .selectAll('div')
      .data(dataset)
      .enter()
      .append('div')
      .attr('class', 'bar')
      .style('height', d => d * 10 + 'px');
  </script>
</body>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Learn About SVG in D3""",
        body: """SVG stands for Scalable Vector Graphics.

Here "scalable" means that, if you zoom in or out on an object, it would not appear pixelated. It scales with the display system, whether it's on a small mobile screen or a large TV monitor.

SVG is used to make common geometric shapes. Since D3 maps data into a visual representation, it uses SVG to create the shapes for the visualization. SVG shapes for a web page must go within an HTML `svg` tag.

CSS can be scalable when styles use relative units (such as `vh`, `vw`, or percentages), but using SVG is more flexible to build data visualizations.

Add an `svg` node to the `body` using `append()`. Give it a `width` attribute set to the provided `w` constant and a `height` attribute set to the provided `h` constant using the `attr()` or `style()` methods for each. You'll see it in the output because there's a `background-color` of pink applied to it in the `style` tag.

**Note:** When using `attr()` width and height attributes do not have units. This is the building block of scaling - the element will always have a 5:1 width to height ratio, no matter what the zoom level is.

Hint: Your document should have 1 `svg` element.

The `svg` element should have a `width` attribute set to `500` or styled to have a width of `500px`.

The `svg` element should have a `height` attribute set to `100` or styled to have a height of `100px`.""",
        codeSnippet: """<style>
  svg {
    background-color: pink;
  }
</style>
<body>
  <script>
    const dataset = [12, 31, 22, 17, 25, 18, 29, 14, 9];

    const w = 500;
    const h = 100;

    const svg = d3
      .select('body')
      .append('svg')
      .attr('width', w)
      .attr('height', h);
  </script>
</body>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Display Shapes with SVG""",
        body: """The last challenge created an `svg` element with a given width and height, which was visible because it had a `background-color` applied to it in the `style` tag. The code made space for the given width and height.

The next step is to create a shape to put in the `svg` area. There are a number of supported shapes in SVG, such as rectangles and circles. They are used to display data. For example, a rectangle (``) SVG shape could create a bar in a bar chart.

When you place a shape into the `svg` area, you can specify where it goes with `x` and `y` coordinates. The origin point of (0, 0) is in the upper-left corner. Positive values for `x` push the shape to the right, and positive values for `y` push the shape down from the origin point.

To place a shape in the middle of the 500 (width) x 100 (height) `svg` from last challenge, the `x` coordinate would be 250 and the `y` coordinate would be 50.

An SVG `rect` has four attributes. There are the `x` and `y` coordinates for where it is placed in the `svg` area. It also has a `height` and `width` to specify the size.

Add a `rect` shape to the `svg` using `append()`, and give it a `width` attribute of `25` and `height` attribute of `100`. Also, give the `rect` `x` and `y` attributes each set to `0`.

Hint: Your document should have 1 `rect` element.

The `rect` element should have a `width` attribute set to `25`.

The `rect` element should have a `height` attribute set to `100`.

The `rect` element should have an `x` attribute set to `0`.

The `rect` element should have a `y` attribute set to `0`.""",
        codeSnippet: """<body>
  <script>
    const dataset = [12, 31, 22, 17, 25, 18, 29, 14, 9];

    const w = 500;
    const h = 100;

    const svg = d3
      .select('body')
      .append('svg')
      .attr('width', w)
      .attr('height', h)
      .append('rect')
      .attr('width', 25)
      .attr('height', 100)
      .attr('x', 0)
      .attr('y', 0);
  </script>
</body>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Create a Bar for Each Data Point in the Set""",
        body: """The last challenge added only one rectangle to the `svg` element to represent a bar. Here, you'll combine what you've learned so far about `data()`, `enter()`, and SVG shapes to create and append a rectangle for each data point in `dataset`.

A previous challenge showed the format for how to create and append a `div` for each item in `dataset`:

There are a few differences working with `rect` elements instead of `div` elements. The `rect` elements must be appended to an `svg` element, not directly to the `body`. Also, you need to tell D3 where to place each `rect` within the `svg` area. The bar placement will be covered in the next challenge.

Use the `data()`, `enter()`, and `append()` methods to create and append a `rect` for each item in `dataset`. The bars should display all on top of each other; this will be fixed in the next challenge.

Hint: Your document should have 9 `rect` elements.

Your code should use the `data()` method.

Your code should use the `enter()` method.

Your code should use the `append()` method.""",
        codeSnippet: """<body>
  <script>
    const dataset = [12, 31, 22, 17, 25, 18, 29, 14, 9];

    const w = 500;
    const h = 100;

    const svg = d3
      .select('body')
      .append('svg')
      .attr('width', w)
      .attr('height', h);

    svg
      .selectAll('rect')
      .data(dataset)
      .enter()
      .append('rect')
      .attr('x', 0)
      .attr('y', 0)
      .attr('width', 25)
      .attr('height', 100);
  </script>
</body>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Dynamically Set the Coordinates for Each Bar""",
        body: """The last challenge created and appended a rectangle to the `svg` element for each point in `dataset` to represent a bar. Unfortunately, they were all stacked on top of each other.

The placement of a rectangle is handled by the `x` and `y` attributes. They tell D3 where to start drawing the shape in the `svg` area. The last challenge set them each to 0, so every bar was placed in the upper-left corner.

For a bar chart, all of the bars should sit on the same vertical level, which means the `y` value stays the same (at 0) for all bars. The `x` value, however, needs to change as you add new bars. Remember that larger `x` values push items farther to the right. As you go through the array elements in `dataset`, the `x` value should increase.

The `attr()` method in D3 accepts a callback function to dynamically set that attribute. The callback function takes two arguments, one for the data point itself (usually `d`) and one for the index of the data point in the array. The second argument for the index is optional. Here's the format:

It's important to note that you do NOT need to write a `for` loop or use `forEach()` to iterate over the items in the data set. Recall that the `data()` method parses the data set, and any method that's chained after `data()` is run once for each item in the data set.

Change the `x` attribute callback function so it returns the index times 30.

**Note:** Each bar has a width of 25, so increasing each `x` value by 30 adds some space between the bars. Any value greater than 25 would work in this example.

Hint: The first `rect` should have an `x` value of `0`.

The second `rect` should have an `x` value of `30`.

The third `rect` should have an `x` value of `60`.

The fourth `rect` should have an `x` value of `90`.

The fifth `rect` should have an `x` value of `120`.

The sixth `rect` should have an `x` value of `150`.

The seventh `rect` should have an `x` value of `180`.

The eighth `rect` should have an `x` value of `210`.

The ninth `rect` should have an `x` value of `240`.""",
        codeSnippet: """<body>
  <script>
    const dataset = [12, 31, 22, 17, 25, 18, 29, 14, 9];

    const w = 500;
    const h = 100;

    const svg = d3
      .select('body')
      .append('svg')
      .attr('width', w)
      .attr('height', h);

    svg
      .selectAll('rect')
      .data(dataset)
      .enter()
      .append('rect')
      .attr('x', (d, i) => {
        return i * 30;
      })
      .attr('y', 0)
      .attr('width', 25)
      .attr('height', 100);
  </script>
</body>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Dynamically Change the Height of Each Bar""",
        body: """The height of each bar can be set to the value of the data point in the array, similar to how the `x` value was set dynamically.

Here `d` would be the data point value, and `i` would be the index of the data point in the array.

Change the callback function for the `height` attribute to return the data value times 3.

**Note:** Remember that multiplying all data points by the same constant scales the data (like zooming in). It helps to see the differences between bar values in this example.

Hint: The first `rect` should have a `height` of `36`.

The second `rect` should have a `height` of `93`.

The third `rect` should have a `height` of `66`.

The fourth `rect` should have a `height` of `51`.

The fifth `rect` should have a `height` of `75`.

The sixth `rect` should have a `height` of `54`.

The seventh `rect` should have a `height` of `87`.

The eighth `rect` should have a `height` of `42`.

The ninth `rect` should have a `height` of `27`.""",
        codeSnippet: """<body>
  <script>
    const dataset = [12, 31, 22, 17, 25, 18, 29, 14, 9];

    const w = 500;
    const h = 100;

    const svg = d3
      .select('body')
      .append('svg')
      .attr('width', w)
      .attr('height', h);

    svg
      .selectAll('rect')
      .data(dataset)
      .enter()
      .append('rect')
      .attr('x', (d, i) => i * 30)
      .attr('y', 0)
      .attr('width', 25)
      .attr('height', (d, i) => {
        return d * 3;
      });
  </script>
</body>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Invert SVG Elements""",
        body: """You may have noticed the bar chart looked like it's upside-down, or inverted. This is because of how SVG uses (x, y) coordinates.

In SVG, the origin point for the coordinates is in the upper-left corner. An `x` coordinate of 0 places a shape on the left edge of the SVG area. A `y` coordinate of 0 places a shape on the top edge of the SVG area. Higher `x` values push the rectangle to the right. Higher `y` values push the rectangle down.

To make the bars right-side-up, you need to change the way the `y` coordinate is calculated. It needs to account for both the height of the bar and the total height of the SVG area.

The height of the SVG area is 100. If you have a data point of 0 in the set, you would want the bar to start at the bottom of the SVG area (not the top). To do this, the `y` coordinate needs a value of 100. If the data point value were 1, you would start with a `y` coordinate of 100 to set the bar at the bottom. Then you need to account for the height of the bar of 1, so the final `y` coordinate would be 99.

The `y` coordinate that is `y = heightOfSVG - heightOfBar` would place the bars right-side-up.

Change the callback function for the `y` attribute to set the bars right-side-up. Remember that the `height` of the bar is 3 times the data value `d`.

**Note:** In general, the relationship is `y = h - m * d`, where `m` is the constant that scales the data points.

Hint: The first `rect` should have a `y` value of `64`.

The second `rect` should have a `y` value of `7`.

The third `rect` should have a `y` value of `34`.

The fourth `rect` should have a `y` value of `49`.

The fifth `rect` should have a `y` value of `25`.

The sixth `rect` should have a `y` value of `46`.

The seventh `rect` should have a `y` value of `13`.

The eighth `rect` should have a `y` value of `58`.

The ninth `rect` should have a `y` value of `73`.""",
        codeSnippet: """<body>
  <script>
    const dataset = [12, 31, 22, 17, 25, 18, 29, 14, 9];

    const w = 500;
    const h = 100;

    const svg = d3
      .select('body')
      .append('svg')
      .attr('width', w)
      .attr('height', h);

    svg
      .selectAll('rect')
      .data(dataset)
      .enter()
      .append('rect')
      .attr('x', (d, i) => i * 30)
      .attr('y', (d, i) => h - 3 * d)
      .attr('width', 25)
      .attr('height', (d, i) => 3 * d);
  </script>
</body>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Change the Color of an SVG Element""",
        body: """The bars are in the right position, but they are all the same black color. SVG has a way to change the color of the bars.

In SVG, a `rect` shape is colored with the `fill` attribute. It supports hex codes, color names, and rgb values, as well as more complex options like gradients and transparency.

Add an `attr()` method to set the `fill` of all the bars to the color navy.

Hint: The bars should all have a `fill` color of navy.""",
        codeSnippet: """<body>
  <script>
    const dataset = [12, 31, 22, 17, 25, 18, 29, 14, 9];

    const w = 500;
    const h = 100;

    const svg = d3
      .select('body')
      .append('svg')
      .attr('width', w)
      .attr('height', h);

    svg
      .selectAll('rect')
      .data(dataset)
      .enter()
      .append('rect')
      .attr('x', (d, i) => i * 30)
      .attr('y', (d, i) => h - 3 * d)
      .attr('width', 25)
      .attr('height', (d, i) => 3 * d)
      .attr('fill', 'navy');
  </script>
</body>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Add Labels to D3 Elements""",
        body: """D3 lets you label a graph element, such as a bar, using the SVG `text` element.

Like the `rect` element, a `text` element needs to have `x` and `y` attributes, to place it on the SVG. It also needs to access the data to display those values.

D3 gives you a high level of control over how you label your bars.

The code in the editor already binds the data to each new `text` element. First, append `text` nodes to the `svg`. Next, add attributes for the `x` and `y` coordinates. They should be calculated the same way as the `rect` ones, except the `y` value for the `text` should make the label sit 3 units higher than the bar. Finally, use the D3 `text()` method to set the label equal to the data point value.

**Note:** For the label to sit higher than the bar, decide if the `y` value for the `text` should be 3 greater or 3 less than the `y` value for the bar.

Hint: The first `text` element should have a label of `12` and a `y` value of `61`.

The second `text` element should have a label of `31` and a `y` value of `4`.

The third `text` element should have a label of `22` and a `y` value of `31`.

The fourth `text` element should have a label of `17` and a `y` value of `46`.

The fifth `text` element should have a label of `25` and a `y` value of `22`.

The sixth `text` element should have a label of `18` and a `y` value of `43`.

The seventh `text` element should have a label of `29` and a `y` value of `10`.

The eighth `text` element should have a label of `14` and a `y` value of `55`.

The ninth `text` element should have a label of `9` and a `y` value of `70`.""",
        codeSnippet: """<body>
  <script>
    const dataset = [12, 31, 22, 17, 25, 18, 29, 14, 9];

    const w = 500;
    const h = 100;

    const svg = d3
      .select('body')
      .append('svg')
      .attr('width', w)
      .attr('height', h);

    svg
      .selectAll('rect')
      .data(dataset)
      .enter()
      .append('rect')
      .attr('x', (d, i) => i * 30)
      .attr('y', (d, i) => h - 3 * d)
      .attr('width', 25)
      .attr('height', (d, i) => 3 * d)
      .attr('fill', 'navy');

    svg
      .selectAll('text')
      .data(dataset)
      .enter()
      .append('text')
      .attr('x', (d, i) => i * 30)
      .attr('y', (d, i) => h - 3 * d - 3)
      .text(d => d);
  </script>
  <body></body>
</body>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Style D3 Labels""",
        body: """D3 methods can add styles to the bar labels. The `fill` attribute sets the color of the text for a `text` node. The `style()` method sets CSS rules for other styles, such as `font-family` or `font-size`.

Set the `font-size` of the `text` elements to `25px`, and the color of the text to red.

Hint: The labels should all have a `fill` color of red.

The labels should all have a `font-size` of `25` pixels.""",
        codeSnippet: """<body>
  <script>
    const dataset = [12, 31, 22, 17, 25, 18, 29, 14, 9];

    const w = 500;
    const h = 100;

    const svg = d3
      .select('body')
      .append('svg')
      .attr('width', w)
      .attr('height', h);

    svg
      .selectAll('rect')
      .data(dataset)
      .enter()
      .append('rect')
      .attr('x', (d, i) => i * 30)
      .attr('y', (d, i) => h - 3 * d)
      .attr('width', 25)
      .attr('height', (d, i) => d * 3)
      .attr('fill', 'navy');

    svg
      .selectAll('text')
      .data(dataset)
      .enter()
      .append('text')
      .text(d => d)
      .attr('x', (d, i) => i * 30)
      .attr('y', (d, i) => h - 3 * d - 3)
      .style('font-size', 25)
      .attr('fill', 'red');
  </script>
</body>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Add a Hover Effect to a D3 Element""",
        body: """It's possible to add effects that highlight a bar when the user hovers over it with the mouse. So far, the styling for the rectangles is applied with the built-in D3 and SVG methods, but you can use CSS as well.

You set the CSS class on the SVG elements with the `attr()` method. Then the `:hover` pseudo-class for your new class holds the style rules for any hover effects.

Use the `attr()` method to add a class of `bar` to all the `rect` elements. This changes the `fill` color of the bar to brown when you mouse over it.

Hint: Your `rect` elements should have a class of `bar`.""",
        codeSnippet: """<style>
  .bar:hover {
    fill: brown;
  }
</style>
<body>
  <script>
    const dataset = [12, 31, 22, 17, 25, 18, 29, 14, 9];

    const w = 500;
    const h = 100;

    const svg = d3
      .select('body')
      .append('svg')
      .attr('width', w)
      .attr('height', h);

    svg
      .selectAll('rect')
      .data(dataset)
      .enter()
      .append('rect')
      .attr('x', (d, i) => i * 30)
      .attr('y', (d, i) => h - 3 * d)
      .attr('width', 25)
      .attr('height', (d, i) => 3 * d)
      .attr('fill', 'navy')
    // Add your code below this line
      .attr('class', 'bar');
    // Add your code above this line

    svg
      .selectAll('text')
      .data(dataset)
      .enter()
      .append('text')
      .text(d => d)
      .attr('x', (d, i) => i * 30)
      .attr('y', (d, i) => h - 3 * d - 3);
  </script>
</body>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Add a Tooltip to a D3 Element""",
        body: """A tooltip shows more information about an item on a page when the user hovers over that item. There are several ways to add a tooltip to a visualization. This challenge uses the SVG `title` element.

`title` pairs with the `text()` method to dynamically add data to the bars.

Append a `title` element under each `rect` node. Then call the `text()` method with a callback function so the text displays the data value.

Hint: Your code should have 9 `title` elements.

The first `title` element should have tooltip text of `12`.

The second `title` element should have tooltip text of `31`.

The third `title` element should have tooltip text of `22`.

The fourth `title` element should have tooltip text of `17`.

The fifth `title` element should have tooltip text of `25`.

The sixth `title` element should have tooltip text of `18`.

The seventh `title` element should have tooltip text of `29`.

The eighth `title` element should have tooltip text of `14`.

The ninth `title` element should have tooltip text of `9`.""",
        codeSnippet: """<style>
  .bar:hover {
    fill: brown;
  }
</style>
<body>
  <script>
    const dataset = [12, 31, 22, 17, 25, 18, 29, 14, 9];

    const w = 500;
    const h = 100;

    const svg = d3
      .select('body')
      .append('svg')
      .attr('width', w)
      .attr('height', h);

    svg
      .selectAll('rect')
      .data(dataset)
      .enter()
      .append('rect')
      .attr('x', (d, i) => i * 30)
      .attr('y', (d, i) => h - 3 * d)
      .attr('width', 25)
      .attr('height', (d, i) => d * 3)
      .attr('fill', 'navy')
      .attr('class', 'bar')
      .append('title')
      .text(d => d);

    svg
      .selectAll('text')
      .data(dataset)
      .enter()
      .append('text')
      .text(d => d)
      .attr('x', (d, i) => i * 30)
      .attr('y', (d, i) => h - (d * 3 + 3));
  </script>
</body>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Create a Scatterplot with SVG Circles""",
        body: """A scatter plot is another type of visualization. It usually uses circles to map data points, which have two values each. These values tie to the `x` and `y` axes, and are used to position the circle in the visualization.

SVG has a `circle` tag to create the circle shape. It works a lot like the `rect` elements you used for the bar chart.

Use the `data()`, `enter()`, and `append()` methods to bind `dataset` to new `circle` elements that are appended to the SVG.

**Note:** The circles won't be visible because we haven't set their attributes yet. We'll do that in the next challenge.

Hint: Your code should have 10 `circle` elements.""",
        codeSnippet: """<body>
  <script>
    const dataset = [
      [34, 78],
      [109, 280],
      [310, 120],
      [79, 411],
      [420, 220],
      [233, 145],
      [333, 96],
      [222, 333],
      [78, 320],
      [21, 123]
    ];

    const w = 500;
    const h = 500;

    const svg = d3
      .select('body')
      .append('svg')
      .attr('width', w)
      .attr('height', h);

    svg.selectAll('circle').data(dataset).enter().append('circle');
  </script>
</body>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Add Attributes to the Circle Elements""",
        body: """The last challenge created the `circle` elements for each point in the `dataset`, and appended them to the SVG. But D3 needs more information about the position and size of each `circle` to display them correctly.

A `circle` in SVG has three main attributes. The `cx` and `cy` attributes are the coordinates. They tell D3 where to position the _center_ of the shape on the SVG. The radius (`r` attribute) gives the size of the `circle`.

Just like the `rect` `y` coordinate, the `cy` attribute for a `circle` is measured from the top of the SVG, not from the bottom.

All three attributes can use a callback function to set their values dynamically. Remember that all methods chained after `data(dataset)` run once per item in `dataset`. The `d` parameter in the callback function refers to the current item in `dataset`, which is an array for each point. You use bracket notation, like `d[0]`, to access the values in that array.

Add `cx`, `cy`, and `r` attributes to the `circle` elements. The `cx` value should be the first number in the array for each item in `dataset`. The `cy` value should be based off the second number in the array, but make sure to show the chart right-side-up and not inverted. The `r` value should be `5` for all circles.

Hint: Your code should have 10 `circle` elements.

The first `circle` element should have a `cx` value of `34`, a `cy` value of `422`, and an `r` value of `5`.

The second `circle` element should have a `cx` value of `109`, a `cy` value of `220`, and an `r` value of `5`.

The third `circle` element should have a `cx` value of `310`, a `cy` value of `380`, and an `r` value of `5`.

The fourth `circle` element should have a `cx` value of `79`, a `cy` value of `89`, and an `r` value of `5`.

The fifth `circle` element should have a `cx` value of `420`, a `cy` value of `280`, and an `r` value of `5`.

The sixth `circle` element should have a `cx` value of `233`, a `cy` value of `355`, and an `r` value of `5`.

The seventh `circle` element should have a `cx` value of `333`, a `cy` value of `404`, and an `r` value of `5`.

The eighth `circle` element should have a `cx` value of `222`, a `cy` value of `167`, and an `r` value of `5`.

The ninth `circle` element should have a `cx` value of `78`, a `cy` value of `180`, and an `r` value of `5`.

The tenth `circle` element should have a `cx` value of `21`, a `cy` value of `377`, and an `r` value of `5`.""",
        codeSnippet: """<body>
  <script>
    const dataset = [
      [34, 78],
      [109, 280],
      [310, 120],
      [79, 411],
      [420, 220],
      [233, 145],
      [333, 96],
      [222, 333],
      [78, 320],
      [21, 123]
    ];

    const w = 500;
    const h = 500;

    const svg = d3
      .select('body')
      .append('svg')
      .attr('width', w)
      .attr('height', h);

    svg
      .selectAll('circle')
      .data(dataset)
      .enter()
      .append('circle')
      .attr('cx', d => d[0])
      .attr('cy', d => h - d[1])
      .attr('r', 5);
  </script>
</body>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Add Labels to Scatter Plot Circles""",
        body: """You can add text to create labels for the points in a scatter plot.

The goal is to display the comma-separated values for the first (`x`) and second (`y`) fields of each item in `dataset`.

The `text` nodes need `x` and `y` attributes to position it on the SVG. In this challenge, the `y` value (which determines height) can use the same value that the `circle` uses for its `cy` attribute. The `x` value can be slightly larger than the `cx` value of the `circle`, so the label is visible. This will push the label to the right of the plotted point.

Label each point on the scatter plot using the `text` elements. The text of the label should be the two values separated by a comma and a space. For example, the label for the first point is `34, 78`. Set the `x` attribute so it's `5` units more than the value you used for the `cx` attribute on the `circle`. Set the `y` attribute the same way that's used for the `cy` value on the `circle`.

Hint: Your code should have 10 `text` elements.

The first label should have text of `34, 78`, an `x` value of `39`, and a `y` value of `422`.

The second label should have text of `109, 280`, an `x` value of `114`, and a `y` value of `220`.

The third label should have text of `310, 120`, an `x` value of `315`, and a `y` value of `380`.

The fourth label should have text of `79, 411`, an `x` value of `84`, and a `y` value of `89`.

The fifth label should have text of `420, 220`, an `x` value of `425`, and a `y` value of `280`.

The sixth label should have text of `233, 145`, an `x` value of `238`, and a `y` value of `355`.

The seventh label should have text of `333, 96`, an `x` value of `338`, and a `y` value of `404`.

The eighth label should have text of `222, 333`, an `x` value of `227`, and a `y` value of `167`.

The ninth label should have text of `78, 320`, an `x` value of `83`, and a `y` value of `180`.

The tenth label should have text of `21, 123`, an `x` value of `26`, and a `y` value of `377`.""",
        codeSnippet: """<body>
  <script>
    const dataset = [
      [34, 78],
      [109, 280],
      [310, 120],
      [79, 411],
      [420, 220],
      [233, 145],
      [333, 96],
      [222, 333],
      [78, 320],
      [21, 123]
    ];

    const w = 500;
    const h = 500;

    const svg = d3
      .select('body')
      .append('svg')
      .attr('width', w)
      .attr('height', h);

    svg
      .selectAll('circle')
      .data(dataset)
      .enter()
      .append('circle')
      .attr('cx', (d, i) => d[0])
      .attr('cy', (d, i) => h - d[1])
      .attr('r', 5);

    svg
      .selectAll('text')
      .data(dataset)
      .enter()
      .append('text')
      .attr('x', d => d[0] + 5)
      .attr('y', d => h - d[1])
      .text(d => d[0] + ', ' + d[1]);
  </script>
</body>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Create a Linear Scale with D3""",
        body: """The bar and scatter plot charts both plotted data directly onto the SVG. However, if the height of a bar or one of the data points were larger than the SVG height or width values, it would go outside the SVG area.

In D3, there are scales to help plot data. `scales` are functions that tell the program how to map a set of raw data points onto the pixels of the SVG.

For example, say you have a 100x500-sized SVG and you want to plot Gross Domestic Product (GDP) for a number of countries. The set of numbers would be in the billion or trillion-dollar range. You provide D3 a type of scale to tell it how to place the large GDP values into that 100x500-sized area.

It's unlikely you would plot raw data as-is. Before plotting it, you set the scale for your entire data set, so that the `x` and `y` values fit your SVG width and height.

D3 has several scale types. For a linear scale (usually used with quantitative data), there is the D3 method `scaleLinear()`:

By default, a scale uses the identity relationship. The value of the input is the same as the value of the output. A separate challenge covers how to change this.

Change the `scale` variable to create a linear scale. Then set the `output` variable to the scale called with an input argument of `50`.

Hint: The text in the `h2` should be `50`.

Your code should use the `scaleLinear()` method.

The `output` variable should call `scale` with an argument of `50`.""",
        codeSnippet: """<body>
  <script>
    const scale = d3.scaleLinear();
    const output = scale(50);

    d3.select('body').append('h2').text(output);
  </script>
</body>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Set a Domain and a Range on a Scale""",
        body: """By default, scales use the identity relationship. This means the input value maps to the output value. However, scales can be much more flexible and interesting.

Say a dataset has values ranging from 50 to 480. This is the input information for a scale, also known as the domain.

You want to map those points along the `x` axis on the SVG, between 10 units and 500 units. This is the output information, also known as the range.

The `domain()` and `range()` methods set these values for the scale. Both methods take an array of at least two elements as an argument. Here's an example:

In order, the following values would be displayed in the console: `10`, `500`, `323.37`, and `807.67`.

Notice that the scale uses the linear relationship between the domain and range values to figure out what the output should be for a given number. The minimum value in the domain (50) maps to the minimum value (10) in the range.

Create a scale and set its domain to `[250, 500]` and range to `[10, 150]`.

**Note:** You can chain the `domain()` and `range()` methods onto the `scale` variable.

Hint: Your code should use the `domain()` method.

The `domain()` of the `scale` should be set to `[250, 500]`.

Your code should use the `range()` method.

The `range()` of the `scale` should be set to `[10, 150]`.

The text in the `h2` should be `-102`.""",
        codeSnippet: """<body>
  <script>
    const scale = d3.scaleLinear();
    scale.domain([250, 500]);
    scale.range([10, 150]);
    const output = scale(50);
    d3.select('body').append('h2').text(output);
  </script>
</body>""",
        hasImage: false,
      ),
      AppLesson(
        title: """>-""",
        body: """The D3 methods `domain()` and `range()` set that information for your scale based on the data. There are a couple methods to make that easier.

Often when you set the domain, you'll want to use the minimum and maximum values within the data set. Trying to find these values manually, especially in a large data set, may cause errors.

D3 has two methods - `min()` and `max()` to return this information. Here's an example:

A dataset may have nested arrays, like the `[x, y]` coordinate pairs that were in the scatter plot example. In that case, you need to tell D3 how to calculate the maximum and minimum. Fortunately, both the `min()` and `max()` methods take a callback function. In this example, the callback function's argument `d` is for the current inner array. The callback needs to return the element from the inner array (the `x` or `y` value) over which you want to compute the maximum or minimum. Here's an example for how to find the min and max values with an array of arrays:

`minX` would have the value `1`.

The `positionData` array holds sub arrays of x, y, and z coordinates. Use a D3 method to find the maximum value of the z coordinate (the third value) from the arrays and save it in the `output` variable.

Hint: The text in the `h2` should be `8`.

Your code should use the `max()` method.""",
        codeSnippet: """<body>
  <script>
    const positionData = [
      [1, 7, -4],
      [6, 3, 8],
      [2, 9, 3]
    ];

    const output = d3.max(positionData, d => d[2]);

    d3.select('body').append('h2').text(output);
  </script>
</body>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Use Dynamic Scales""",
        body: """The D3 `min()` and `max()` methods are useful to help set the scale.

Given a complex data set, one priority is to set the scale so the visualization fits the SVG container's width and height. You want all the data plotted inside the SVG so it's visible on the web page.

The example below sets the x-axis scale for scatter plot data. The `domain()` method passes information to the scale about the raw data values for the plot. The `range()` method gives it information about the actual space on the web page for the visualization.

In the example, the domain goes from 0 to the maximum in the set. It uses the `max()` method with a callback function based on the x values in the arrays. The range uses the SVG's width (`w`), but it includes some padding, too. This puts space between the scatter plot dots and the edge of the SVG.

The padding may be confusing at first. Picture the x-axis as a horizontal line from 0 to 500 (the width value for the SVG). Including the padding in the `range()` method forces the plot to start at 30 along that line (instead of 0), and end at 470 (instead of 500).

Use the `yScale` variable to create a linear y-axis scale. The domain should start at zero and go to the maximum `y` value in the set. The range should use the SVG height (`h`) and include padding.

**Note:** Remember to keep the plot right-side-up. When you set the range for the y coordinates, the higher value (height minus padding) is the first argument, and the lower value is the second argument.

Hint: The text in the `h2` should be `30`.

The `domain()` of yScale should be equivalent to `[0, 411]`.

The `range()` of yScale should be equivalent to `[470, 30]`.""",
        codeSnippet: """<body>
  <script>
    const dataset = [
      [34, 78],
      [109, 280],
      [310, 120],
      [79, 411],
      [420, 220],
      [233, 145],
      [333, 96],
      [222, 333],
      [78, 320],
      [21, 123]
    ];

    const w = 500;
    const h = 500;

    const padding = 30;

    const xScale = d3
      .scaleLinear()
      .domain([0, d3.max(dataset, d => d[0])])
      .range([padding, w - padding]);

    const yScale = d3
      .scaleLinear()
      .domain([0, d3.max(dataset, d => d[1])])
      .range([h - padding, padding]);

    const output = yScale(411);
    d3.select('body').append('h2').text(output);
  </script>
</body>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Use a Pre-Defined Scale to Place Elements""",
        body: """With the scales set up, it's time to map the scatter plot again. The scales are like processing functions that turn the `x` and `y` raw data into values that fit and render correctly on the SVG. They keep the data within the screen's plotting area.

You set the coordinate attribute values for an SVG shape with the scaling function. This includes `x` and `y` attributes for `rect` or `text` elements, or `cx` and `cy` for `circles`. Here's an example:

Scales set shape coordinate attributes to place the data points onto the SVG. You don't need to apply scales when you display the actual data value, for example, in the `text()` method for a tooltip or label.

Use `xScale` and `yScale` to position both the `circle` and `text` shapes onto the SVG. For the `circles`, apply the scales to set the `cx` and `cy` attributes. Give them a radius of `5` units, too.

For the `text` elements, apply the scales to set the `x` and `y` attributes. The labels should be offset to the right of the dots. To do this, add `10` units to the `x` data value before passing it to the `xScale`.

Hint: Your code should have 10 `circle` elements.

The first `circle` element should have a `cx` value of approximately `91` and a `cy` value of approximately `368` after applying the scales. It should also have an `r` value of `5`.

The second `circle` element should have a `cx` value of approximately `159` and a `cy` value of approximately `181` after applying the scales. It should also have an `r` value of `5`.

The third `circle` element should have a `cx` value of approximately `340` and a `cy` value of approximately `329` after applying the scales. It should also have an `r` value of `5`.

The fourth `circle` element should have a `cx` value of approximately `131` and a `cy` value of approximately `60` after applying the scales. It should also have an `r` value of `5`.

The fifth `circle` element should have a `cx` value of approximately `440` and a `cy` value of approximately `237` after applying the scales. It should also have an `r` value of `5`.

The sixth `circle` element should have a `cx` value of approximately `271` and a `cy` value of approximately `306` after applying the scales. It should also have an `r` value of `5`.

The seventh `circle` element should have a `cx` value of approximately `361` and a `cy` value of approximately `351` after applying the scales. It should also have an `r` value of `5`.

The eighth `circle` element should have a `cx` value of approximately `261` and a `cy` value of approximately `132` after applying the scales. It should also have an `r` value of `5`.

The ninth `circle` element should have a `cx` value of approximately `131` and a `cy` value of approximately `144` after applying the scales. It should also have an `r` value of `5`.

The tenth `circle` element should have a `cx` value of approximately `79` and a `cy` value of approximately `326` after applying the scales. It should also have an `r` value of `5`.

Your code should have 10 `text` elements.

The first label should have an `x` value of approximately `100` and a `y` value of approximately `368` after applying the scales.

The second label should have an `x` value of approximately `168` and a `y` value of approximately `181` after applying the scales.

The third label should have an `x` value of approximately `350` and a `y` value of approximately `329` after applying the scales.

The fourth label should have an `x` value of approximately `141` and a `y` value of approximately `60` after applying the scales.

The fifth label should have an `x` value of approximately `449` and a `y` value of approximately `237` after applying the scales.

The sixth label should have an `x` value of approximately `280` and a `y` value of approximately `306` after applying the scales.

The seventh label should have an `x` value of approximately `370` and a `y` value of approximately `351` after applying the scales.

The eighth label should have an `x` value of approximately `270` and a `y` value of approximately `132` after applying the scales.

The ninth label should have an `x` value of approximately `140` and a `y` value of approximately `144` after applying the scales.

The tenth label should have an `x` value of approximately `88` and a `y` value of approximately `326` after applying the scales.""",
        codeSnippet: """<body>
  <script>
    const dataset = [
      [34, 78],
      [109, 280],
      [310, 120],
      [79, 411],
      [420, 220],
      [233, 145],
      [333, 96],
      [222, 333],
      [78, 320],
      [21, 123]
    ];

    const w = 500;
    const h = 500;
    const padding = 60;

    const xScale = d3
      .scaleLinear()
      .domain([0, d3.max(dataset, d => d[0])])
      .range([padding, w - padding]);

    const yScale = d3
      .scaleLinear()
      .domain([0, d3.max(dataset, d => d[1])])
      .range([h - padding, padding]);

    const svg = d3
      .select('body')
      .append('svg')
      .attr('width', w)
      .attr('height', h);

    svg
      .selectAll('circle')
      .data(dataset)
      .enter()
      .append('circle')
      .attr('cx', d => xScale(d[0]))
      .attr('cy', d => yScale(d[1]))
      .attr('r', 5);

    svg
      .selectAll('text')
      .data(dataset)
      .enter()
      .append('text')
      .text(d => d[0] + ', ' + d[1])
      .attr('x', d => xScale(d[0] + 10))
      .attr('y', d => yScale(d[1]));
  </script>
</body>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Add Axes to a Visualization""",
        body: """Another way to improve the scatter plot is to add an x-axis and a y-axis.

D3 has two methods, `axisLeft()` and `axisBottom()`, to render the y-axis and x-axis, respectively. Here's an example to create the x-axis based on the `xScale` in the previous challenges:

The next step is to render the axis on the SVG. To do so, you can use a general SVG component, the `g` element. The `g` stands for group. Unlike `rect`, `circle`, and `text`, an axis is just a straight line when it's rendered. Because it is a simple shape, using `g` works. The last step is to apply a `transform` attribute to position the axis on the SVG in the right place. Otherwise, the line would render along the border of the SVG and wouldn't be visible. SVG supports different types of `transforms`, but positioning an axis needs `translate`. When it's applied to the `g` element, it moves the whole group over and down by the given amounts. Here's an example:

The above code places the x-axis at the bottom of the SVG. Then it's passed as an argument to the `call()` method. The y-axis works in the same way, except the `translate` argument is in the form `(x, 0)`. Because `translate` is a string in the `attr()` method above, you can use concatenation to include variable values for its arguments.

The scatter plot now has an x-axis. Create a y-axis in a variable named `yAxis` using the `axisLeft()` method. Then render the axis using a `g` element. Make sure to use a `transform` attribute to translate the axis by the amount of padding units right, and `0` units down. Remember to `call()` the axis.

Hint: Your code should use the `axisLeft()` method with `yScale` passed as the argument.

The y-axis `g` element should have a `transform` attribute to translate the axis by `(60, 0)`.

Your code should call the `yAxis`.""",
        codeSnippet: """<body>
  <script>
    const dataset = [
      [34, 78],
      [109, 280],
      [310, 120],
      [79, 411],
      [420, 220],
      [233, 145],
      [333, 96],
      [222, 333],
      [78, 320],
      [21, 123]
    ];

    const w = 500;
    const h = 500;
    const padding = 60;

    const xScale = d3
      .scaleLinear()
      .domain([0, d3.max(dataset, d => d[0])])
      .range([padding, w - padding]);

    const yScale = d3
      .scaleLinear()
      .domain([0, d3.max(dataset, d => d[1])])
      .range([h - padding, padding]);

    const svg = d3
      .select('body')
      .append('svg')
      .attr('width', w)
      .attr('height', h);

    svg
      .selectAll('circle')
      .data(dataset)
      .enter()
      .append('circle')
      .attr('cx', d => xScale(d[0]))
      .attr('cy', d => yScale(d[1]))
      .attr('r', d => 5);

    svg
      .selectAll('text')
      .data(dataset)
      .enter()
      .append('text')
      .text(d => d[0] + ',' + d[1])
      .attr('x', d => xScale(d[0] + 10))
      .attr('y', d => yScale(d[1]));

    const xAxis = d3.axisBottom(xScale);

    const yAxis = d3.axisLeft(yScale);

    svg
      .append('g')
      .attr('transform', 'translate(0,' + (h - padding) + ')')
      .call(xAxis);

    svg
      .append('g')
      .attr('transform', 'translate(' + padding + ',0)')
      .call(yAxis);
  </script>
</body>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Handle Click Events with JavaScript using the onclick property""",
        body: """You want your code to execute only once your page has finished loading. For that purpose, you can attach a JavaScript event to the document called `DOMContentLoaded`. Here's the code that does this:

You can implement event handlers that go inside of the `DOMContentLoaded` function. You can implement an `onclick` event handler which triggers when the user clicks on the `#getMessage` element, by adding the following code:

Add a click event handler inside of the `DOMContentLoaded` function for the element with id of `getMessage`.

Hint: Your code should use the `document.getElementById` method to select the element whose id is `getMessage`.

Your code should add an `onclick` event handler.""",
        codeSnippet: """<script>
  document.addEventListener('DOMContentLoaded', function () {
    // Add your code below this line
    document.getElementById('getMessage').onclick = function () {};
    // Add your code above this line
  });
</script>

<style>
  body {
    text-align: center;
    font-family: 'Helvetica', sans-serif;
  }
  h1 {
    font-size: 2em;
    font-weight: bold;
  }
  .box {
    border-radius: 5px;
    background-color: #eee;
    padding: 20px 5px;
  }
  button {
    color: white;
    background-color: #4791d0;
    border-radius: 5px;
    border: 1px solid #4791d0;
    padding: 5px 10px 8px 10px;
  }
  button:hover {
    background-color: #0f5897;
    border: 1px solid #0f5897;
  }
</style>
<h1>Cat Photo Finder</h1>
<p class="message box">The message will go here</p>
<p>
  <button id="getMessage">Get Message</button>
</p>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Change Text with click Events""",
        body: """When the click event happens, you can use JavaScript to update an HTML element.

For example, when a user clicks the `Get Message` button, it changes the text of the element with the class `message` to say `Here is the message`.

This works by adding the following code within the click event:

Add code inside the `onclick` event handler to change the text inside the `message` element to say `Here is the message`.

Hint: Your code should use the `document.getElementsByClassName` method to select the element with class `message` and set its `textContent` to the given string.""",
        codeSnippet: """<script>
  document.addEventListener('DOMContentLoaded', function () {
    document.getElementById('getMessage').onclick = function () {
      // Add your code below this line
      document.getElementsByClassName('message')[0].textContent =
        'Here is the message';
      // Add your code above this line
    };
  });
</script>

<style>
  body {
    text-align: center;
    font-family: 'Helvetica', sans-serif;
  }
  h1 {
    font-size: 2em;
    font-weight: bold;
  }
  .box {
    border-radius: 5px;
    background-color: #eee;
    padding: 20px 5px;
  }
  button {
    color: white;
    background-color: #4791d0;
    border-radius: 5px;
    border: 1px solid #4791d0;
    padding: 5px 10px 8px 10px;
  }
  button:hover {
    background-color: #0f5897;
    border: 1px solid #0f5897;
  }
</style>

<h1>Cat Photo Finder</h1>
<p class="message">The message will go here</p>
<p>
  <button id="getMessage">Get Message</button>
</p>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Get JSON with the JavaScript XMLHttpRequest Method""",
        body: """You can also request data from an external source. This is where APIs come into play.

Remember that APIs - or Application Programming Interfaces - are tools that computers use to communicate with one another. You'll learn how to update HTML with the data we get from APIs using a technology called AJAX.

Most web APIs transfer data in a format called JSON. JSON stands for JavaScript Object Notation.

JSON syntax looks very similar to JavaScript object literal notation. JSON has object properties and their current values, sandwiched between a `{` and a `}`.

These properties and their values are often referred to as "key-value pairs".

However, JSON transmitted by APIs are sent as `bytes`, and your application receives it as a `string`. These can be converted into JavaScript objects, but they are not JavaScript objects by default. The `JSON.parse` method parses the string and constructs the JavaScript object described by it.

You can request the JSON from freeCodeCamp's Cat Photo API. Here's the code you can put in your click event to do this:

Here's a review of what each piece is doing. The JavaScript `XMLHttpRequest` object has a number of properties and methods that are used to transfer data. First, an instance of the `XMLHttpRequest` object is created and saved in the `req` variable. Next, the `open` method initializes a request - this example is requesting data from an API, therefore is a `GET` request. The second argument for `open` is the URL of the API you are requesting data from. The third argument is a Boolean value where `true` makes it an asynchronous request. The `send` method sends the request. Finally, the `onload` event handler parses the returned data and applies the `JSON.stringify` method to convert the JavaScript object into a string. This string is then inserted as the message text.

Update the code to create and send a `GET` request to the freeCodeCamp Cat Photo API. Then click the `Get Message` button. Your AJAX function will replace the `The message will go here` text with the raw JSON output from the API.

Hint: Your code should create a new `XMLHttpRequest`.

Your code should use the `open` method to initialize a `GET` request to the freeCodeCamp Cat Photo API.

Your code should use the `send` method to send the request.

Your code should have an `onload` event handler set to a function.

Your code should use the `JSON.parse` method to parse the `responseText`.

Your code should get the element with class `message` and change its inner HTML to the string of JSON data.""",
        codeSnippet: """<script>
  document.addEventListener('DOMContentLoaded', function () {
    document.getElementById('getMessage').onclick = function () {
      const req = new XMLHttpRequest();
      req.open('GET', '/json/cats.json', true);
      req.send();
      req.onload = () => {
        const json = JSON.parse(req.responseText);
        document.getElementsByClassName('message')[0].innerHTML =
          JSON.stringify(json);
      };
    };
  });
</script>

<style>
  body {
    text-align: center;
    font-family: 'Helvetica', sans-serif;
  }
  h1 {
    font-size: 2em;
    font-weight: bold;
  }
  .box {
    border-radius: 5px;
    background-color: #eee;
    padding: 20px 5px;
  }
  button {
    color: white;
    background-color: #4791d0;
    border-radius: 5px;
    border: 1px solid #4791d0;
    padding: 5px 10px 8px 10px;
  }
  button:hover {
    background-color: #0f5897;
    border: 1px solid #0f5897;
  }
</style>

<h1>Cat Photo Finder</h1>
<p class="message box">The message will go here</p>
<p>
  <button id="getMessage">Get Message</button>
</p>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Get JSON with the JavaScript fetch method""",
        body: """Another way to request external data is to use the JavaScript `fetch()` method. It is equivalent to `XMLHttpRequest`, but the syntax is considered easier to understand.

Here is the code for making a GET request to `/json/cats.json`

Note: The `fetch()` method uses `GET` as the default `HTTP` method. This means you don’t need to specify it explicitly for basic data retrieval.

Take a look at each piece of this code.

The first line is the one that makes the request. So, `fetch(URL)` makes a `GET` request to the URL specified. The method returns a Promise.

After a Promise is returned, if the request was successful, the `then` method is executed, which takes the response and converts it to JSON format.

The `then` method also returns a Promise, which is handled by the next `then` method. The argument in the second `then` is the JSON object you are looking for!

Now, it selects the element that will receive the data by using `document.getElementById()`. Then it modifies the HTML code of the element by inserting a string created from the JSON object returned from the request.

Update the code to create and send a `GET` request to the freeCodeCamp Cat Photo API. But this time, using the `fetch` method instead of `XMLHttpRequest`.

Hint: Your code should use the fetched data to replace the inner HTML

Your code should make a `GET` request with `fetch`.

Your code should use `then` to convert the response to JSON.

Your code should use `then` to handle the data converted to JSON by the other `then`.

Your code should get the element with id `message` and change its inner HTML to the string of JSON data.""",
        codeSnippet: """<script>
  document.addEventListener('DOMContentLoaded', function () {
    document.getElementById('getMessage').onclick = () => {
      fetch('/json/cats.json')
        .then(response => response.json())
        .then(data => {
          document.getElementById('message').innerHTML = JSON.stringify(data);
        });
    };
  });
</script>
<style>
  body {
    text-align: center;
    font-family: 'Helvetica', sans-serif;
  }
  h1 {
    font-size: 2em;
    font-weight: bold;
  }
  .box {
    border-radius: 5px;
    background-color: #eee;
    padding: 20px 5px;
  }
  button {
    color: white;
    background-color: #4791d0;
    border-radius: 5px;
    border: 1px solid #4791d0;
    padding: 5px 10px 8px 10px;
  }
  button:hover {
    background-color: #0f5897;
    border: 1px solid #0f5897;
  }
</style>
<h1>Cat Photo Finder</h1>
<p id="message" class="box">The message will go here</p>
<p>
  <button id="getMessage">Get Message</button>
</p>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Access the JSON Data from an API""",
        body: """In the previous challenge, you saw how to get JSON data from the freeCodeCamp Cat Photo API.

Now you'll take a closer look at the returned data to better understand the JSON format. Recall some notation in JavaScript:

[ ] -> Square brackets represent an array.{ } -> Curly brackets represent an object." " -> Double quotes represent a string. They are also used for key names in JSON.

Understanding the structure of the data that an API returns is important because it influences how you retrieve the values you need.

On the right, click the `Get Message` button to load the freeCodeCamp Cat Photo API JSON into the HTML.

The first and last character you see in the JSON data are square brackets `[ ]`. This means that the returned data is an array. The second character in the JSON data is a curly `{` bracket, which starts an object. Looking closely, you can see that there are three separate objects. The JSON data is an array of three objects, where each object contains information about a cat photo.

You learned earlier that objects contain "key-value pairs" that are separated by commas. In the Cat Photo example, the first object has `"id":0` where `id` is a key and `0` is its corresponding value. Similarly, there are keys for `imageLink`, `altText`, and `codeNames`. Each cat photo object has these same keys, but with different values.

Another interesting "key-value pair" in the first object is `"codeNames":["Juggernaut","Mrs. Wallace","ButterCup"]`. Here `codeNames` is the key and its value is an array of three strings. It's possible to have arrays of objects as well as a key with an array as a value.

Remember how to access data in arrays and objects. Arrays use bracket notation to access a specific index of an item. Objects use either bracket or dot notation to access the value of a given property. Here's an example that prints the `altText` property of the first cat photo - note that the parsed JSON data in the editor is saved in a variable called `json`:

The console would display the string `A white cat wearing a green helmet shaped melon on its head.`.

For the cat with the `id` of 2, print to the console the second value in the `codeNames` array. You should use bracket and dot notation on the object (which is saved in the variable `json`) to access the value.

Hint: Your code should use bracket and dot notation to access the proper code name, and print `Loki` to the console.""",
        codeSnippet: """<script>
  document.addEventListener('DOMContentLoaded', function () {
    document.getElementById('getMessage').onclick = function () {
      const req = new XMLHttpRequest();
      req.open('GET', '/json/cats.json', true);
      req.send();
      req.onload = function () {
        const json = JSON.parse(req.responseText);
        document.getElementsByClassName('message')[0].innerHTML =
          JSON.stringify(json);
        // Add your code below this line
        console.log(json[2].codeNames[1]);
        // Add your code above this line
      };
    };
  });
</script>

<style>
  body {
    text-align: center;
    font-family: 'Helvetica', sans-serif;
  }
  h1 {
    font-size: 2em;
    font-weight: bold;
  }
  .box {
    border-radius: 5px;
    background-color: #eee;
    padding: 20px 5px;
  }
  button {
    color: white;
    background-color: #4791d0;
    border-radius: 5px;
    border: 1px solid #4791d0;
    padding: 5px 10px 8px 10px;
  }
  button:hover {
    background-color: #0f5897;
    border: 1px solid #0f5897;
  }
</style>

<h1>Cat Photo Finder</h1>
<p class="message">The message will go here</p>
<p>
  <button id="getMessage">Get Message</button>
</p>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Convert JSON Data to HTML""",
        body: """Now that you're getting data from a JSON API, you can display it in the HTML.

You can use a `forEach` method to loop through the data since the cat photo objects are held in an array. As you get to each item, you can modify the HTML elements.

First, declare an html variable with `let html = "";`.

Then, loop through the JSON, adding HTML to the variable that wraps the key names in `strong` tags, followed by the value. When the loop is finished, you render it.

Here's the code that does this:

**Note:** For this challenge, you need to add new HTML elements to the page, so you cannot rely on `textContent`. Instead, you need to use `innerHTML`, which can make a site vulnerable to cross-site scripting attacks.

Add a `forEach` method to loop over the JSON data and create the HTML elements to display it.

Here is some example JSON:

Hint: Your code should store the data in the `html` variable

Your code should use a `forEach` method to loop over the JSON data from the API.

Your code should wrap the key names in `strong` tags.""",
        codeSnippet: """<script>
  document.addEventListener('DOMContentLoaded', function () {
    document.getElementById('getMessage').onclick = function () {
      const req = new XMLHttpRequest();
      req.open('GET', '/json/cats.json', true);
      req.send();
      req.onload = function () {
        const json = JSON.parse(req.responseText);
        let html = '';
        // Add your code below this line
        json.forEach(function (val) {
          var keys = Object.keys(val);
          html += "<div class = 'cat'>";
          keys.forEach(function (key) {
            html += '<strong>' + key + '</strong>: ' + val[key] + '<br>';
          });
          html += '</div><br>';
        });
        // Add your code above this line
        document.getElementsByClassName('message')[0].innerHTML = html;
      };
    };
  });
</script>

<style>
  body {
    text-align: center;
    font-family: 'Helvetica', sans-serif;
  }
  h1 {
    font-size: 2em;
    font-weight: bold;
  }
  .box {
    border-radius: 5px;
    background-color: #eee;
    padding: 20px 5px;
  }
  button {
    color: white;
    background-color: #4791d0;
    border-radius: 5px;
    border: 1px solid #4791d0;
    padding: 5px 10px 8px 10px;
  }
  button:hover {
    background-color: #0f5897;
    border: 1px solid #0f5897;
  }
</style>

<h1>Cat Photo Finder</h1>
<p class="message">The message will go here</p>
<p>
  <button id="getMessage">Get Message</button>
</p>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Render Images from Data Sources""",
        body: """The last few challenges showed that each object in the JSON array contains an `imageLink` key with a value that is the URL of a cat's image.

When you're looping through these objects, you can use this `imageLink` property to display this image in an `img` element.

Here's the code that does this:

Add code to use the `imageLink` and `altText` properties in an `img` tag.

Hint: You should use the `imageLink` property to display the images.

You should use the `altText` for the `alt` attribute values of the images.""",
        codeSnippet: """<script>
  document.addEventListener('DOMContentLoaded', function () {
    document.getElementById('getMessage').onclick = function () {
      const req = new XMLHttpRequest();
      req.open('GET', '/json/cats.json', true);
      req.send();
      req.onload = function () {
        const json = JSON.parse(req.responseText);
        let html = '';
        json.forEach(function (val) {
          html += "<div class = 'cat'>";
          // Add your code below this line
          html +=
            "<img src = '" +
            val.imageLink +
            "' " +
            "alt='" +
            val.altText +
            "'>";
          // Add your code above this line
          html += '</div><br>';
        });
        document.getElementsByClassName('message')[0].innerHTML = html;
      };
    };
  });
</script>
<style>
  body {
    text-align: center;
    font-family: 'Helvetica', sans-serif;
  }
  h1 {
    font-size: 2em;
    font-weight: bold;
  }
  .box {
    border-radius: 5px;
    background-color: #eee;
    padding: 20px 5px;
  }
  button {
    color: white;
    background-color: #4791d0;
    border-radius: 5px;
    border: 1px solid #4791d0;
    padding: 5px 10px 8px 10px;
  }
  button:hover {
    background-color: #0f5897;
    border: 1px solid #0f5897;
  }
</style>
<h1>Cat Photo Finder</h1>
<p class="message">The message will go here</p>
<p>
  <button id="getMessage">Get Message</button>
</p>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Pre-filter JSON to Get the Data You Need""",
        body: """If you don't want to render every cat photo you get from the freeCodeCamp Cat Photo API, you can pre-filter the JSON before looping through it.

Given that the JSON data is stored in an array, you can use the `filter` method to filter out the cat whose `id` key has a value of `1`.

Here's the code to do this:

Add code to `filter` the json data to remove the cat with the `id` value of `1`.

Hint: Your code should use the `filter` method.""",
        codeSnippet: """<script>
  document.addEventListener('DOMContentLoaded', function () {
    document.getElementById('getMessage').onclick = function () {
      const req = new XMLHttpRequest();
      req.open('GET', '/json/cats.json', true);
      req.send();
      req.onload = function () {
        let json = JSON.parse(req.responseText);
        let html = '';
        // Add your code below this line
        json = json.filter(function (val) {
          return val.id !== 1;
        });

        // Add your code above this line
        json.forEach(function (val) {
          html += "<div class = 'cat'>";

          html +=
            "<img src = '" +
            val.imageLink +
            "' " +
            "alt='" +
            val.altText +
            "'>";

          html += '</div>';
        });
        document.getElementsByClassName('message')[0].innerHTML = html;
      };
    };
  });
</script>

<style>
  body {
    text-align: center;
    font-family: 'Helvetica', sans-serif;
  }
  h1 {
    font-size: 2em;
    font-weight: bold;
  }
  .box {
    border-radius: 5px;
    background-color: #eee;
    padding: 20px 5px;
  }
  button {
    color: white;
    background-color: #4791d0;
    border-radius: 5px;
    border: 1px solid #4791d0;
    padding: 5px 10px 8px 10px;
  }
  button:hover {
    background-color: #0f5897;
    border: 1px solid #0f5897;
  }
</style>

<h1>Cat Photo Finder</h1>
<p class="message">The message will go here</p>
<p>
  <button id="getMessage">Get Message</button>
</p>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Get Geolocation Data to Find A User's GPS Coordinates""",
        body: """Another cool thing you can do is access your user's current location. Every browser has a built in navigator that can give you this information.

The navigator will get the user's current longitude and latitude.

You will see a prompt to allow or block this site from knowing your current location. The challenge can be completed either way, as long as the code is correct.

By selecting allow, you will see the text on the output phone change to your latitude and longitude.

Here's code that does this:

First, it checks if the `navigator.geolocation` object exists. If it does, the `getCurrentPosition` method on that object is called, which initiates an asynchronous request for the user's position. If the request is successful, the callback function in the method runs. This function accesses the `position` object's values for latitude and longitude using dot notation and updates the HTML.

Add the example code inside the `script` tags to check a user's current location and insert it into the HTML.

Hint: Your code should use `navigator.geolocation` to access the user's current location.

Your code should use `position.coords.latitude` to display the user's latitudinal location.

Your code should use `position.coords.longitude` to display the user's longitudinal location.

You should display the user's position within the `div` element with `id="data"`.""",
        codeSnippet: """<script>
  // Add your code below this line
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      document.getElementById('data').innerHTML = "latitude: " + position.coords.latitude + "<br>longitude: " + position.coords.longitude;
    });
  }
  // Add your code above this line
</script>
<h4>You are here:</h4>
<div id="data">

</div>

</section>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Post Data with the JavaScript XMLHttpRequest Method""",
        body: """In the previous examples, you received data from an external resource. You can also send data to an external resource, as long as that resource supports AJAX requests and you know the URL.

JavaScript's `XMLHttpRequest` method is also used to post data to a server. Here's an example:

You've seen several of these methods before. Here the `open` method initializes the request as a `POST` to the given URL of the external resource, and passes `true` as the third parameter - indicating to perform the operation asynchronously.

The `setRequestHeader` method sets the value of an HTTP request header, which contains information about the sender and the request. It must be called after the `open` method, but before the `send` method. The two parameters are the name of the header and the value to set as the body of that header.

Next, the `onreadystatechange` event listener handles a change in the state of the request. A `readyState` of `4` means the operation is complete, and a `status` of `201` means it was a successful request. Therefore, the document's HTML can be updated.

Finally, the `send` method sends the request with the `body` value. The `body` consists of a `userName` and a `suffix` key.

Update the code so it makes a `POST` request to the API endpoint. Then type your name in the input field and click `Send Message`. Your AJAX function should replace `Reply from Server will be here.` with data from the server. Format the response to display your name appended with the text ` loves cats`.

Hint: Your code should create a new `XMLHttpRequest`.

Your code should use the `open` method to initialize a `POST` request to the server.

Your code should use the `setRequestHeader` method.

Your code should have an `onreadystatechange` event handler set to a function.

Your code should get the element with class `message` and change its `textContent` to `userName loves cats`

Your code should use the `send` method.""",
        codeSnippet: """<script>
  document.addEventListener('DOMContentLoaded', function () {
    document.getElementById('sendMessage').onclick = function () {
      const userName = document.getElementById('name').value;
      const url = 'https://jsonplaceholder.typicode.com/posts';
      // Add your code below this line
      const xhr = new XMLHttpRequest();
      xhr.open('POST', url, true);
      xhr.setRequestHeader('Content-Type', 'application/json; charset=UTF-8');
      xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 201) {
          const serverResponse = JSON.parse(xhr.response);
          document.getElementsByClassName('message')[0].textContent =
            serverResponse.userName + serverResponse.suffix;
        }
      };
      const body = JSON.stringify({
        userName: userName,
        suffix: ' loves cats!'
      });
      xhr.send(body);
      // Add your code above this line
    };
  });
</script>

<style>
  body {
    text-align: center;
    font-family: 'Helvetica', sans-serif;
  }
  h1 {
    font-size: 2em;
    font-weight: bold;
  }
  .box {
    border-radius: 5px;
    background-color: #eee;
    padding: 20px 5px;
  }
  button {
    color: white;
    background-color: #4791d0;
    border-radius: 5px;
    border: 1px solid #4791d0;
    padding: 5px 10px 8px 10px;
  }
  button:hover {
    background-color: #0f5897;
    border: 1px solid #0f5897;
  }
</style>

<h1>Cat Friends</h1>
<p class="message">Reply from Server will be here</p>
<p>
  <label for="name"
    >Your name:
    <input type="text" id="name" />
  </label>
  <button id="sendMessage">Send Message</button>
</p>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Visualize Data with a Bar Chart""",
        body: """**Objective:** Build an app that is functionally similar to this: https://bar-chart.freecodecamp.rocks.

Fulfill the below user stories and get all of the tests to pass. Use whichever libraries or APIs you need. Give it your own personal style.

You can use HTML, JavaScript, CSS, and the D3 svg-based visualization library. The tests require axes to be generated using the D3 axis property, which automatically generates ticks along the axis. These ticks are required for passing the D3 tests because their positions are used to determine alignment of graphed elements. You will find information about generating axes at . Required DOM elements are queried on the moment of each test. If you use a front-end framework (like Vue for example), the test results may be inaccurate for dynamic content. We hope to accommodate them eventually, but these frameworks are not currently supported for D3 projects.

**User Story #1:** My chart should have a title with a corresponding `id="title"`.

**User Story #2:** My chart should have a `g` element x-axis with a corresponding `id="x-axis"`.

**User Story #3:** My chart should have a `g` element y-axis with a corresponding `id="y-axis"`.

**User Story #4:** Both axes should contain multiple tick labels, each with a corresponding `class="tick"`.

**User Story #5:** My chart should have a `rect` element for each data point with a corresponding `class="bar"` displaying the data.

**User Story #6:** Each `.bar` should have the properties `data-date` and `data-gdp` containing `date` and `GDP` values.

**User Story #7:** The `.bar` elements' `data-date` properties should match the order of the provided data.

**User Story #8:** The `.bar` elements' `data-gdp` properties should match the order of the provided data.

**User Story #9:** Each `.bar` element's height should accurately represent the data's corresponding `GDP`.

**User Story #10:** The `data-date` attribute and its corresponding `.bar` element should align with the corresponding value on the x-axis.

**User Story #11:** The `data-gdp` attribute and its corresponding `.bar` element should align with the corresponding value on the y-axis.

**User Story #12:** I can mouse over an area and see a tooltip with a corresponding `id="tooltip"` which displays more information about the area.

**User Story #13:** My tooltip should have a `data-date` property that corresponds to the `data-date` of the active area.

Here is the dataset you will need to complete this project: `https://raw.githubusercontent.com/freeCodeCamp/ProjectReferenceData/master/GDP-data.json`

You can build your project by using this CodePen template and clicking `Save` to create your own pen. Or you can use this CDN link to run the tests in any environment you like: `https://cdn.freecodecamp.org/testable-projects-fcc/v1/bundle.js`.

Once you're done, submit the URL to your working project with all its tests passing.""",
        codeSnippet: """// solution required""",
        hasImage: false,
      ),
      AppLesson(
        title: """Visualize Data with a Scatterplot Graph""",
        body: """**Objective:** Build an app that is functionally similar to this: https://scatterplot-graph.freecodecamp.rocks.

Fulfill the below user stories and get all of the tests to pass. Use whichever libraries or APIs you need. Give it your own personal style.

You can use HTML, JavaScript, CSS, and the D3 svg-based visualization library. The tests require axes to be generated using the D3 axis property, which automatically generates ticks along the axis. These ticks are required for passing the D3 tests because their positions are used to determine alignment of graphed elements. You will find information about generating axes at . Required DOM elements are queried on the moment of each test. If you use a front-end framework (like Vue for example), the test results may be inaccurate for dynamic content. We hope to accommodate them eventually, but these frameworks are not currently supported for D3 projects.

**User Story #1:** I can see a title element that has a corresponding `id="title"`.

**User Story #2:** I can see an x-axis that has a corresponding `id="x-axis"`.

**User Story #3:** I can see a y-axis that has a corresponding `id="y-axis"`.

**User Story #4:** I can see dots, that each have a class of `dot`, which represent the data being plotted.

**User Story #5:** Each dot should have the properties `data-xvalue` and `data-yvalue` containing their corresponding `x` and `y` values.

**User Story #6:** The `data-xvalue` and `data-yvalue` of each dot should be within the range of the actual data and in the correct data format. For `data-xvalue`, integers (full years) or `Date` objects are acceptable for test evaluation. For `data-yvalue` (minutes), use `Date` objects.

**User Story #7:** The `data-xvalue` and its corresponding dot should align with the corresponding point/value on the x-axis.

**User Story #8:** The `data-yvalue` and its corresponding dot should align with the corresponding point/value on the y-axis.

**User Story #9:** I can see multiple tick labels on the y-axis with `%M:%S` time format.

**User Story #10:** I can see multiple tick labels on the x-axis that show the year.

**User Story #11:** I can see that the range of the x-axis labels are within the range of the actual x-axis data.

**User Story #12:** I can see that the range of the y-axis labels are within the range of the actual y-axis data.

**User Story #13:** I can see a legend containing descriptive text that has `id="legend"`.

**User Story #14:** I can mouse over an area and see a tooltip with a corresponding `id="tooltip"` which displays more information about the area.

**User Story #15:** My tooltip should have a `data-year` property that corresponds to the `data-xvalue` of the active area.

Here is the dataset you will need to complete this project: `https://raw.githubusercontent.com/freeCodeCamp/ProjectReferenceData/master/cyclist-data.json`

You can build your project by using this CodePen template and clicking `Save` to create your own pen. Or you can use this CDN link to run the tests in any environment you like: `https://cdn.freecodecamp.org/testable-projects-fcc/v1/bundle.js`

Once you're done, submit the URL to your working project with all its tests passing.""",
        codeSnippet: """// solution required""",
        hasImage: false,
      ),
      AppLesson(
        title: """Visualize Data with a Heat Map""",
        body: """**Objective:** Build an app that is functionally similar to this: https://heat-map.freecodecamp.rocks.

Fulfill the below user stories and get all of the tests to pass. Use whichever libraries or APIs you need. Give it your own personal style.

You can use HTML, JavaScript, CSS, and the D3 svg-based visualization library. Required DOM elements are queried on the moment of each test. If you use a front-end framework (like Vue for example), the test results may be inaccurate for dynamic content. We hope to accommodate them eventually, but these frameworks are not currently supported for D3 projects.

**User Story #1:** My heat map should have a title with a corresponding `id="title"`.

**User Story #2:** My heat map should have a description with a corresponding `id="description"`.

**User Story #3:** My heat map should have an x-axis with a corresponding `id="x-axis"`.

**User Story #4:** My heat map should have a y-axis with a corresponding `id="y-axis"`.

**User Story #5:** My heat map should have `rect` elements with a `class="cell"` that represent the data.

**User Story #6:** There should be at least 4 different fill colors used for the cells.

**User Story #7:** Each cell will have the properties `data-month`, `data-year`, `data-temp` containing their corresponding `month`, `year`, and `temperature` values.

**User Story #8:** The `data-month`, `data-year` of each cell should be within the range of the data.

**User Story #9:** My heat map should have cells that align with the corresponding month on the y-axis.

**User Story #10:** My heat map should have cells that align with the corresponding year on the x-axis.

**User Story #11:** My heat map should have multiple tick labels on the y-axis with the full month name.

**User Story #12:** My heat map should have multiple tick labels on the x-axis with the years between 1754 and 2015.

**User Story #13:** My heat map should have a legend with a corresponding `id="legend"`.

**User Story #14:** My legend should contain `rect` elements.

**User Story #15:** The `rect` elements in the legend should use at least 4 different fill colors.

**User Story #16:** I can mouse over an area and see a tooltip with a corresponding `id="tooltip"` which displays more information about the area.

**User Story #17:** My tooltip should have a `data-year` property that corresponds to the `data-year` of the active area.

Here is the dataset you will need to complete this project: `https://raw.githubusercontent.com/freeCodeCamp/ProjectReferenceData/master/global-temperature.json`

You can build your project by using this CodePen template and clicking `Save` to create your own pen. Or you can use this CDN link to run the tests in any environment you like: `https://cdn.freecodecamp.org/testable-projects-fcc/v1/bundle.js`

Once you're done, submit the URL to your working project with all its tests passing.""",
        codeSnippet: """// solution required""",
        hasImage: false,
      ),
      AppLesson(
        title: """Visualize Data with a Choropleth Map""",
        body: """**Objective:** Build an app that is functionally similar to this: https://choropleth-map.freecodecamp.rocks.

Fulfill the below user stories and get all of the tests to pass. Use whichever libraries or APIs you need. Give it your own personal style.

You can use HTML, JavaScript, CSS, and the D3 svg-based visualization library. Required DOM elements are queried on the moment of each test. If you use a front-end framework (like Vue for example), the test results may be inaccurate for dynamic content. We hope to accommodate them eventually, but these frameworks are not currently supported for D3 projects.

**User Story #1:** My choropleth should have a title with a corresponding `id="title"`.

**User Story #2:** My choropleth should have a description element with a corresponding `id="description"`.

**User Story #3:** My choropleth should have counties with a corresponding `class="county"` that represent the data.

**User Story #4:** There should be at least 4 different fill colors used for the counties.

**User Story #5:** My counties should each have `data-fips` and `data-education` properties containing their corresponding `fips` and `education` values.

**User Story #6:** My choropleth should have a county for each provided data point.

**User Story #7:** The counties should have `data-fips` and `data-education` values that match the sample data.

**User Story #8:** My choropleth should have a legend with a corresponding `id="legend"`.

**User Story #9:** There should be at least 4 different fill colors used for the legend.

**User Story #10:** I can mouse over an area and see a tooltip with a corresponding `id="tooltip"` which displays more information about the area.

**User Story #11:** My tooltip should have a `data-education` property that corresponds to the `data-education` of the active area.

Here are the datasets you will need to complete this project:

- **US Education Data:**`https://cdn.freecodecamp.org/testable-projects-fcc/data/choropleth_map/for_user_education.json`
- **US County Data:**`https://cdn.freecodecamp.org/testable-projects-fcc/data/choropleth_map/counties.json`

You can build your project by using this CodePen template and clicking `Save` to create your own pen. Or you can use this CDN link to run the tests in any environment you like: `https://cdn.freecodecamp.org/testable-projects-fcc/v1/bundle.js`

Once you're done, submit the URL to your working project with all its tests passing.""",
        codeSnippet: """// solution required""",
        hasImage: false,
      ),
      AppLesson(
        title: """Visualize Data with a Treemap Diagram""",
        body: """**Objective:** Build an app that is functionally similar to this: https://treemap-diagram.freecodecamp.rocks.

Fulfill the below user stories and get all of the tests to pass. Use whichever libraries or APIs you need. Give it your own personal style.

You can use HTML, JavaScript, CSS, and the D3 svg-based visualization library. The tests require axes to be generated using the D3 axis property, which automatically generates ticks along the axis. These ticks are required for passing the D3 tests because their positions are used to determine alignment of graphed elements. You will find information about generating axes at . Required DOM elements are queried on the moment of each test. If you use a front-end framework (like Vue for example), the test results may be inaccurate for dynamic content. We hope to accommodate them eventually, but these frameworks are not currently supported for D3 projects.

**User Story #1:** My tree map should have a title with a corresponding `id="title"`.

**User Story #2:** My tree map should have a description with a corresponding `id="description"`.

**User Story #3:** My tree map should have `rect` elements with a corresponding `class="tile"` that represent the data.

**User Story #4:** There should be at least 2 different fill colors used for the tiles.

**User Story #5:** Each tile should have the properties `data-name`, `data-category`, and `data-value` containing their corresponding `name`, `category`, and `value`.

**User Story #6:** The area of each tile should correspond to the `data-value` amount: tiles with a larger `data-value` should have a bigger area.

**User Story #7:** My tree map should have a legend with corresponding `id="legend"`.

**User Story #8:** My legend should have `rect` elements with a corresponding `class="legend-item"`.

**User Story #9:** The `rect` elements in the legend should use at least 2 different fill colors.

**User Story #10:** I can mouse over an area and see a tooltip with a corresponding `id="tooltip"` which displays more information about the area.

**User Story #11:** My tooltip should have a `data-value` property that corresponds to the `data-value` of the active area.

For this project you can use any of the following datasets:

- **Kickstarter Pledges:** `https://cdn.freecodecamp.org/testable-projects-fcc/data/tree_map/kickstarter-funding-data.json`
- **Movie Sales:** `https://cdn.freecodecamp.org/testable-projects-fcc/data/tree_map/movie-data.json`
- **Video Game Sales:** `https://cdn.freecodecamp.org/testable-projects-fcc/data/tree_map/video-game-sales-data.json`

You can build your project by using this CodePen template and clicking `Save` to create your own pen. Or you can use this CDN link to run the tests in any environment you like: `https://cdn.freecodecamp.org/testable-projects-fcc/v1/bundle.js`

Once you're done, submit the URL to your working project with all its tests passing.""",
        codeSnippet: """// solution required""",
        hasImage: false,
      )
    ],
  ),
  AppCourse(
    id: 'back-end-development-and-apis',
    title: """Back End Development and APIs""",
    description: """A freeCodeCamp curriculum covering Back End Development and APIs, with 39 lessons extracted from the local curriculum assets.""",
    instructor: 'freeCodeCamp',
    category: 'Web Development',
    difficulty: 'Intermediate',
    icon: Icons.code,
    color: Colors.blue,
    duration: '4 weeks',
    lessons: [
      AppLesson(
        title: """How to Use package.json, the Core of Any Node.js Project or npm Package""",
        body: """Working on these challenges will involve you writing your code using one of the following methods:

- Clone this GitHub repo and complete these challenges locally, using this guide to set up Node.js, npm, and run the backend projects on your machine.
- Use a site builder of your choice to complete the project. Be sure to incorporate all the files from our GitHub repo.

The `package.json` file is the center of any Node.js project or npm package. It stores information about your project. It consists of a single JSON object where information is stored in key-value pairs. There are only two required fields; `name` and `version`, but it's good practice to provide additional information.

You can create the `package.json` file from the terminal using the `npm init` command. This will run a guided setup. Using `npm init` with the `-y` flag will generate the file without having it ask any questions, `npm init -y`.

If you look at the file tree of your project, you will find the `package.json` file on the top level of the tree. This is the file that you will be improving in the next couple of challenges.

One of the most common pieces of information in this file is the `author` field. It specifies who created the project, and can consist of a string or an object with contact or other details. An object is recommended for bigger projects, but a simple string like the following example will do for this project.

Add your name as the `author` of the project in the `package.json` file.

**Note:** Remember that you're writing JSON, so all field names must use double-quotes (") and be separated with a comma (,).

Hint: `package.json` should have a valid "author" key""",
        codeSnippet: """"author": "Jane Doe",""",
        hasImage: false,
      ),
      AppLesson(
        title: """Add a Description to Your package.json""",
        body: """The next part of a good package.json file is the `description` field; where a short, but informative description about your project belongs.

If some day you plan to publish a package to npm, this is the string that should sell your idea to the user when they decide whether to install your package or not. However, that’s not the only use case for the description, it’s a great way to summarize what a project does. It’s just as important in any Node.js project to help other developers, future maintainers or even your future self understand the project quickly.

Regardless of what you plan for your project, a description is definitely recommended. Here's an example:

Add a `description` to the package.json file of your project.

**Note:** Remember to use double-quotes for field-names (") and commas (,) to separate fields.

Hint: package.json should have a valid "description" key""",
        codeSnippet: """"description": "A project that does something awesome",""",
        hasImage: false,
      ),
      AppLesson(
        title: """Add Keywords to Your package.json""",
        body: """The `keywords` field is where you can describe your project using related keywords. Here's an example:

As you can see, this field is structured as an array of double-quoted strings.

Add an array of suitable strings to the `keywords` field in the package.json file of your project.

One of the keywords should be "freecodecamp".

Hint: package.json should have a valid "keywords" key

"keywords" field should be an Array

"keywords" should include "freecodecamp\"""",
        codeSnippet: """"keywords": [ "descriptive", "related", "words" ],""",
        hasImage: false,
      ),
      AppLesson(
        title: """Add a License to Your package.json""",
        body: """The `license` field is where you inform users of what they are allowed to do with your project.

Some common licenses for open source projects include MIT and BSD. License information is not required, and copyright laws in most countries will give you ownership of what you create by default. However, it’s always a good practice to explicitly state what users can and can’t do. Here's an example of the license field:

Fill the `license` field in the package.json file of your project as you find suitable.

Hint: package.json should have a valid "license" key""",
        codeSnippet: """"license": "MIT",""",
        hasImage: false,
      ),
      AppLesson(
        title: """Add a Version to Your package.json""",
        body: """A `version` is one of the required fields of your package.json file. This field describes the current version of your project. Here's an example:

Add a `version` to the package.json file of your project.

Hint: package.json should have a valid "version" key""",
        codeSnippet: """"version": "1.2.0",""",
        hasImage: false,
      ),
      AppLesson(
        title: """Expand Your Project with External Packages from npm""",
        body: """One of the biggest reasons to use a package manager, is their powerful dependency management. Instead of manually having to make sure that you get all dependencies whenever you set up a project on a new computer, npm automatically installs everything for you. But how can npm know exactly what your project needs? Meet the `dependencies` section of your package.json file.

In this section, packages your project requires are stored using the following format:

Add version `1.1.0` of the `@freecodecamp/example` package to the `dependencies` field of your `package.json` file.

**Note:** `@freecodecamp/example` is a faux package used as a learning tool.

Hint: `"dependencies"` should include `"@freecodecamp/example"`.

`"@freecodecamp/example"` version should be `"1.1.0"`.""",
        codeSnippet: """"dependencies": {
  "package-name": "version",
  "express": "4.14.0"
}""",
        hasImage: false,
      ),
      AppLesson(
        title: """Manage npm Dependencies By Understanding Semantic Versioning""",
        body: """`Versions` of the npm packages in the dependencies section of your package.json file follow what’s called Semantic Versioning (SemVer), an industry standard for software versioning aiming to make it easier to manage dependencies. Libraries, frameworks or other tools published on npm should use SemVer in order to clearly communicate what kind of changes projects can expect if they update.

Knowing SemVer can be useful when you develop software that uses external dependencies (which you almost always do). One day, your understanding of these numbers will save you from accidentally introducing breaking changes to your project without understanding why things that worked yesterday suddenly don’t work today. This is how Semantic Versioning works according to the official website:

The MAJOR version should increment when you make incompatible API changes. The MINOR version should increment when you add functionality in a backwards-compatible manner. The PATCH version should increment when you make backwards-compatible bug fixes. This means that PATCHes are bug fixes and MINORs add new features but neither of them break what worked before. Finally, MAJORs add changes that won’t work with earlier versions.

In the dependencies section of your `package.json` file, change the version of `@freecodecamp/example` to match MAJOR version 1, MINOR version 2 and PATCH version 13

Hint: `"dependencies"` should include `"@freecodecamp/example"`.

`"@freecodecamp/example"` version should be `"1.2.13"`.""",
        codeSnippet: """"package": "MAJOR.MINOR.PATCH\"""",
        hasImage: false,
      ),
      AppLesson(
        title: """Use the Tilde-Character to Always Use the Latest Patch Version of a Dependency""",
        body: """In the last challenge, you told npm to only include a specific version of a package. That’s a useful way to freeze your dependencies if you need to make sure that different parts of your project stay compatible with each other. But in most use cases, you don’t want to miss bug fixes since they often include important security patches and (hopefully) don’t break things in doing so.

To allow an npm dependency to update to the latest PATCH version, you can prefix the dependency’s version with the tilde (`~`) character. Here's an example of how to allow updates to any `1.3.x` version.

In the package.json file, your current rule for how npm may upgrade `@freecodecamp/example` is to use a specific version (`1.2.13`). But now, you want to allow the latest `1.2.x` version.

Use the tilde (`~`) character to prefix the version of `@freecodecamp/example` in your dependencies, and allow npm to update it to any new _patch_ release.

**Note:** The version numbers themselves should not be changed.

Hint: `"dependencies"` should include `"@freecodecamp/example"`.

`"@freecodecamp/example"` version should match `"~1.2.13"`.""",
        codeSnippet: """"package": "~1.3.8\"""",
        hasImage: false,
      ),
      AppLesson(
        title: """Use the Caret-Character to Use the Latest Minor Version of a Dependency""",
        body: """Similar to how the tilde we learned about in the last challenge allows npm to install the latest PATCH for a dependency, the caret (`^`) allows npm to install future updates as well. The difference is that the caret will allow both MINOR updates and PATCHes.

Your current version of `@freecodecamp/example` should be `~1.2.13` which allows npm to install to the latest `1.2.x` version. If you were to use the caret (^) as a version prefix instead, npm would be allowed to update to any `1.x.x` version.

This would allow updates to any `1.x.x` version of the package.

Use the caret (`^`) to prefix the version of `@freecodecamp/example` in your dependencies and allow npm to update it to any new MINOR release.

**Note:** The version numbers themselves should not be changed.

Hint: `"dependencies"` should include `"@freecodecamp/example"`.

`"@freecodecamp/example"` version should match `"^1.x.x"`.""",
        codeSnippet: """"package": "^1.3.8\"""",
        hasImage: false,
      ),
      AppLesson(
        title: """Remove a Package from Your Dependencies""",
        body: """You have now tested a few ways you can manage dependencies of your project by using the package.json's dependencies section. You have also included external packages by adding them to the file and even told npm what types of versions you want, by using special characters such as the tilde or the caret.

But what if you want to remove an external package that you no longer need? You might already have guessed it, just remove the corresponding key-value pair for that package from your dependencies.

This same method applies to removing other fields in your package.json as well.

Remove the `@freecodecamp/example` package from your dependencies.

**Note:** Make sure you have the right amount of commas after removing it.

Hint: `"dependencies"` should not include `"@freecodecamp/example"`.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Meet the Node console""",
        body: """Working on these challenges will involve you writing your code using one of the following methods:

- Clone this GitHub repo and complete these challenges locally.
- Use a site builder of your choice to complete the project. Be sure to incorporate all the files from our GitHub repo.

During the development process, it is important to be able to check what’s going on in your code.

Node is just a JavaScript environment. Like client side JavaScript, you can use the console to display useful debug information. On your local machine, you would see console output in a terminal.

We recommend to keep the terminal open while working at these challenges. By reading the output in the terminal, you can see any errors that may occur.

The server must be restarted after making changes to its files.

You can stop the server from the terminal using `Ctrl + C` and start it using Node directly (`node mainEntryFile.js`) or using a run script in the `package.json` file with `npm run`.

For example, the `"start": "node server.js"` script would be run from the terminal using `npm run start`.

To implement server auto restarting on file save Node provides the `--watch` flag you can add to your start script `"start": "node --watch server.js"` or you can install an npm package like `nodemon`. We will leave this to you as an exercise.

Modify the `myApp.js` file to log "Hello World" to the console.

Hint: `"Hello World"` should be in the console""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Start a Working Express Server""",
        body: """In the first two lines of the file `myApp.js`, you can see how easy it is to create an Express app object. This object has several methods, and you will learn many of them in these challenges. One fundamental method is `app.listen(port)`. It tells your server to listen on a given port, putting it in running state. For testing reasons, we need the app to be running in the background so we added this method in the `server.js` file for you.

Let’s serve our first string! In Express, routes takes the following structure: `app.METHOD(PATH, HANDLER)`. METHOD is an http method in lowercase. PATH is a relative path on the server (it can be a string, or even a regular expression). HANDLER is a function that Express calls when the route is matched. Handlers take the form `function(req, res) {...}`, where req is the request object, and res is the response object. For example, the handler

will serve the string 'Response String'.

Use the `app.get()` method to serve the string "Hello Express" to GET requests matching the `/` (root) path. Be sure that your code works by looking at the logs.

**Note:** All the code for these lessons should be added in between the few lines of code we have started you off with.

Hint: Your app should serve the string 'Hello Express'""",
        codeSnippet: """function(req, res) {
  res.send('Response String');
}""",
        hasImage: false,
      ),
      AppLesson(
        title: """Serve an HTML File""",
        body: """You can respond to requests with a file using the `res.sendFile(path)` method. You can put it inside the `app.get('/', ...)` route handler. Behind the scenes, this method will set the appropriate headers to instruct your browser on how to handle the file you want to send, according to its type. Then it will read and send the file. This method needs an absolute file path. We recommend you to use the Node global variable `__dirname` to calculate the path like this:

Send the `/views/index.html` file as a response to GET requests to the `/` path. If you view your live app, you should see a big HTML heading (and a form that we will use later…), with no style applied.

**Note:** You can edit the solution of the previous challenge or create a new one. If you create a new solution, keep in mind that Express evaluates routes from top to bottom, and executes the handler for the first match. You have to comment out the preceding solution, or the server will keep responding with a string.

Hint: Your app should serve the file views/index.html""",
        codeSnippet: """absolutePath = __dirname + '/relativePath/file.ext'""",
        hasImage: false,
      ),
      AppLesson(
        title: """Serve Static Assets""",
        body: """An HTML server usually has one or more directories that are accessible by the user. You can place there the static assets needed by your application (stylesheets, scripts, images).

In Express, you can put in place this functionality using the middleware `express.static(path)`, where the `path` parameter is the absolute path of the folder containing the assets.

If you don’t know what middleware is... don’t worry, we will discuss in detail later. Basically, middleware are functions that intercept route handlers, adding some kind of information. A middleware needs to be mounted using the method `app.use(path, middlewareFunction)`. The first `path` argument is optional. If you don’t pass it, the middleware will be executed for all requests.

Mount the `express.static()` middleware to the path `/public` with `app.use()`. The absolute path to the assets folder is `__dirname + /public`.

Now your app should be able to serve a CSS stylesheet. Note that the `/public/style.css` file is referenced in the `/views/index.html` in the project boilerplate. Your front-page should look a little better now!

Hint: Your app should serve asset files from the `/public` directory to the `/public` path

Your app should not serve files from any other folders except from `/public` directory""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Serve JSON on a Specific Route""",
        body: """While an HTML server serves HTML, an API serves data. A REST (REpresentational State Transfer) API allows data exchange in a simple way, without the need for clients to know any detail about the server. The client only needs to know where the resource is (the URL), and the action it wants to perform on it (the verb). The GET verb is used when you are fetching some information, without modifying anything. These days, the preferred data format for moving information around the web is JSON. Simply put, JSON is a convenient way to represent a JavaScript object as a string, so it can be easily transmitted.

Let's create a simple API by creating a route that responds with JSON at the path `/json`. You can do it as usual, with the `app.get()` method. Inside the route handler, use the method `res.json()`, passing in an object as an argument. This method closes the request-response loop, returning the data. Behind the scenes, it converts a valid JavaScript object into a string, then sets the appropriate headers to tell your browser that you are serving JSON, and sends the data back. A valid object has the usual structure `{key: data}`. `data` can be a number, a string, a nested object or an array. `data` can also be a variable or the result of a function call, in which case it will be evaluated before being converted into a string.

Serve the object `{"message": "Hello json"}` as a response, in JSON format, to GET requests to the `/json` route. Then point your browser to `your-app-url/json`, you should see the message on the screen.

Hint: The endpoint `/json` should serve the JSON object `{"message": "Hello json"}`""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Use the .env File""",
        body: """The `.env` file is a hidden file that is used to pass environment variables to your application. This file is secret, no one but you can access it, and it can be used to store data that you want to keep private or hidden. For example, you can store API keys from external services or your database URI. You can also use it to store configuration options. By setting configuration options, you can change the behavior of your application, without the need to rewrite some code.

The environment variables are accessible from the app as `process.env.VAR_NAME`. The `process.env` object is a global Node object, and variables are passed as strings. By convention, the variable names are all uppercase, with words separated by an underscore. The `.env` is a shell file, so you don’t need to wrap names or values in quotes. It is also important to note that there cannot be space around the equals sign when you are assigning values to your variables, e.g. `VAR_NAME=value`. Usually, you will put each variable definition on a separate line.

Let's add an environment variable as a configuration option.

Create a `.env` file in the root of your project directory, and store the variable `MESSAGE_STYLE=uppercase` in it.

Then, in the `/json` GET route handler you created in the last challenge access `process.env.MESSAGE_STYLE` and transform the response object's `message` to uppercase if the variable equals `uppercase`. The response object should either be `{"message": "Hello json"}` or `{"message": "HELLO JSON"}`, depending on the `MESSAGE_STYLE` value. Note that you must read the value of `process.env.MESSAGE_STYLE` **inside** the route handler, not outside of it, due to the way our tests run.

You will need to use the `dotenv` package. It loads environment variables from your `.env` file into `process.env`. The `dotenv` package has already been installed, and is in your project's `package.json` file. At the top of your `myApp.js` file, add `require('dotenv').config()` to load the environment variables.

Hint: The response of the endpoint `/json` should change according to the environment variable `MESSAGE_STYLE`""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Implement a Root-Level Request Logger Middleware""",
        body: """Earlier, you were introduced to the `express.static()` middleware function. Now it’s time to see what middleware is, in more detail. Middleware functions are functions that take 3 arguments: the request object, the response object, and the next function in the application’s request-response cycle. These functions execute some code that can have side effects on the app, and usually add information to the request or response objects. They can also end the cycle by sending a response when some condition is met. If they don’t send the response when they are done, they start the execution of the next function in the stack. This triggers calling the 3rd argument, `next()`.

Look at the following example:

Let’s suppose you mounted this function on a route. When a request matches the route, it displays the string “I’m a middleware…”, then it executes the next function in the stack. In this exercise, you are going to build root-level middleware. As you have seen in challenge 4, to mount a middleware function at root level, you can use the `app.use()` method. In this case, the function will be executed for all the requests, but you can also set more specific conditions. For example, if you want a function to be executed only for POST requests, you could use `app.post()`. Analogous methods exist for all the HTTP verbs (GET, DELETE, PUT, …).

Build a simple logger. For every request, it should log to the console a string taking the following format: `method path - ip`. An example would look like this: `GET /json - ::ffff:127.0.0.1`. Note that there is a space between `method` and `path` and that the dash separating `path` and `ip` is surrounded by a space on both sides. You can get the request method (http verb), the relative route path, and the caller’s ip from the request object using `req.method`, `req.path` and `req.ip`. Remember to call `next()` when you are done, or your server will be stuck forever. Be sure to have the ‘Logs’ opened, and see what happens when some request arrives.

**Note:** Express evaluates functions in the order they appear in the code. This is true for middleware too. If you want it to work for all the routes, it should be mounted before them.

Hint: Root level logger middleware should be active""",
        codeSnippet: """function(req, res, next) {
  console.log("I'm a middleware...");
  next();
}""",
        hasImage: false,
      ),
      AppLesson(
        title: """Chain Middleware to Create a Time Server""",
        body: """Middleware can be mounted at a specific route using `app.METHOD(path, middlewareFunction)`. Middleware can also be chained within a route definition.

Look at the following example:

This approach is useful to split the server operations into smaller units. That leads to a better app structure, and the possibility to reuse code in different places. This approach can also be used to perform some validation on the data. At each point of the middleware stack you can block the execution of the current chain and pass control to functions specifically designed to handle errors. Or you can pass control to the next matching route, to handle special cases. We will see how in the advanced Express section.

In the route `app.get('/now', ...)` chain a middleware function and the final handler. In the middleware function you should add the current time to the request object in the `req.time` key. You can use `new Date().toString()`. In the handler, respond with a JSON object, taking the structure `{time: req.time}`.

**Note:** The test will not pass if you don’t chain the middleware. If you mount the function somewhere else, the test will fail, even if the output result is correct.

Hint: The /now endpoint should have mounted middleware

The `/now` endpoint should return the current time.""",
        codeSnippet: """app.get('/user', function(req, res, next) {
  req.user = getTheUserSync();  // Hypothetical synchronous operation
  next();
}, function(req, res) {
  res.send(req.user);
});""",
        hasImage: false,
      ),
      AppLesson(
        title: """Get Route Parameter Input from the Client""",
        body: """When building an API, we have to allow users to communicate to us what they want to get from our service. For example, if the client is requesting information about a user stored in the database, they need a way to let us know which user they're interested in. One possible way to achieve this result is by using route parameters. Route parameters are named segments of the URL, delimited by slashes (/). Each segment captures the value of the part of the URL which matches its position. The captured values can be found in the `req.params` object.

route_path: '/user/:userId/book/:bookId'actual_request_URL: '/user/546/book/6754' req.params: {userId: '546', bookId: '6754'}

Build an echo server, mounted at the route `GET /:word/echo`. Respond with a JSON object, taking the structure `{echo: word}`. You can find the word to be repeated at `req.params.word`. You can test your route from your browser's address bar, visiting some matching routes, e.g. `your-app-rootpath/freecodecamp/echo`.

Hint: Test 1 : Your echo server should repeat words correctly

Test 2 : Your echo server should repeat words correctly""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Get Query Parameter Input from the Client""",
        body: """Another common way to get input from the client is by encoding the data after the route path, using a query string. The query string is delimited by a question mark (?), and includes field=value couples. Each couple is separated by an ampersand (&). Express can parse the data from the query string, and populate the object `req.query`. Some characters, like the percent (%), cannot be in URLs and have to be encoded in a different format before you can send them. If you use the API from JavaScript, you can use specific methods to encode/decode these characters.

route_path: '/library'actual_request_URL: '/library?userId=546&#x26;bookId=6754' req.query: {userId: '546', bookId: '6754'}

Build an API endpoint, mounted at `GET /name`. Respond with a JSON document, taking the structure `{ name: 'firstname lastname'}`. The first and last name parameters should be encoded in a query string e.g. `?first=firstname&last=lastname`.

**Note:** In the following exercise you are going to receive data from a POST request, at the same `/name` route path. If you want, you can use the method `app.route(path).get(handler).post(handler)`. This syntax allows you to chain different verb handlers on the same path route. You can save a bit of typing, and have cleaner code.

Hint: Test 1 : Your API endpoint should respond with `{ "name": "Mick Jagger" }` when the `/name` endpoint is called with `?first=Mick&last=Jagger`

Test 2 : Your API endpoint should respond with `{ "name": "Keith Richards" }` when the `/name` endpoint is called with `?first=Keith&last=Richards`""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Use body-parser to Parse POST Requests""",
        body: """Besides GET, there is another common HTTP verb, it is POST. POST is the default method used to send client data with HTML forms. In REST convention, POST is used to send data to create new items in the database (a new user, or a new blog post). You don’t have a database in this project, but you are going to learn how to handle POST requests anyway.

In these kind of requests, the data doesn’t appear in the URL, it is hidden in the request body. The body is a part of the HTTP request, also called the payload. Even though the data is not visible in the URL, this does not mean that it is private. To see why, look at the raw content of an HTTP POST request:

As you can see, the body is encoded like the query string. This is the default format used by HTML forms. With Ajax, you can also use JSON to handle data having a more complex structure. There is also another type of encoding: multipart/form-data. This one is used to upload binary files. In this exercise, you will use a URL encoded body. To parse the data coming from POST requests, you must use the `body-parser` package. This package allows you to use a series of middleware, which can decode data in different formats.

`body-parser` has already been installed and is in your project's `package.json` file. `require` it at the top of the `myApp.js` file and store it in a variable named `bodyParser`. The middleware to handle URL encoded data is returned by `bodyParser.urlencoded({extended: false})`. Pass the function returned by the previous method call to `app.use()`. As usual, the middleware must be mounted before all the routes that depend on it.

**Note:** `extended` is a configuration option that tells `body-parser` which parsing needs to be used. When `extended=false` it uses the classic encoding `querystring` library. When `extended=true` it uses `qs` library for parsing. 

When using `extended=false`, values can be only strings or arrays. The object returned when using `querystring` does not prototypically inherit from the default JavaScript `Object`, which means functions like `hasOwnProperty`, `toString` will not be available. The extended version allows more data flexibility, but it is outmatched by JSON.

Hint: The 'body-parser' middleware should be mounted""",
        codeSnippet: """POST /path/subpath HTTP/1.0
From: john@example.com
User-Agent: someBrowser/1.0
Content-Type: application/x-www-form-urlencoded
Content-Length: 20

name=John+Doe&age=25""",
        hasImage: false,
      ),
      AppLesson(
        title: """Get Data from POST Requests""",
        body: """Mount a POST handler at the path `/name`. It’s the same path as before. We have prepared a form in the html frontpage. It will submit the same data of exercise 10 (Query string). If the body-parser is configured correctly, you should find the parameters in the object `req.body`. Have a look at the usual library example:

route: POST '/library'urlencoded_body: userId=546&#x26;bookId=6754 req.body: {userId: '546', bookId: '6754'}

Respond with the same JSON object as before: `{name: 'firstname lastname'}`. Test if your endpoint works using the html form we provided in the app frontpage.

Tip: There are several other http methods other than GET and POST. And by convention there is a correspondence between the http verb, and the operation you are going to execute on the server. The conventional mapping is:

POST (sometimes PUT) - Create a new resource using the information sent with the request,

GET - Read an existing resource without modifying it,

PUT or PATCH (sometimes POST) - Update a resource using the data sent,

DELETE - Delete a resource.

There are also a couple of other methods which are used to negotiate a connection with the server. Except for GET, all the other methods listed above can have a payload (i.e. the data into the request body). The body-parser middleware works with these methods as well.

Hint: Test 1 : Your API endpoint should respond with the correct name

Test 2 : Your API endpoint should respond with the correct name""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Install and Set Up Mongoose""",
        body: """Working on these challenges will involve you writing your code using one of the following methods:

- Clone this GitHub repo and complete these challenges locally.
- Use a site builder of your choice to complete the project. Be sure to incorporate all the files from our GitHub repo.

In this challenge, you will set up a MongoDB Atlas database and import the required packages to connect to it.

Follow this tutorial to set up a hosted database on MongoDB Atlas.

`mongoose@^5.11.15` has been added to your project’s `package.json` file. First, require mongoose as `mongoose` in `myApp.js`. Next, create a `.env` file and add a `MONGO_URI` variable to it. Its value should be your MongoDB Atlas database URI. Be sure to surround the URI with single or double quotes, and remember that you can't use spaces around the `=` in environment variables. For example, `MONGO_URI='VALUE'`.

When you are done, connect to the database by calling the `connect` method within your `myApp.js` file by using the following syntax:

Hint: "mongoose version ^5.11.15" dependency should be in package.json

"mongoose" should be connected to a database""",
        codeSnippet: """mongoose.connect(<Your URI>, { useNewUrlParser: true, useUnifiedTopology: true });""",
        hasImage: false,
      ),
      AppLesson(
        title: """Create a Model""",
        body: """**C**RUD Part I - CREATE

First of all, we need a Schema. Each schema maps to a MongoDB collection. It defines the shape of the documents within that collection. Schemas are building blocks for Models. They can be nested to create complex models, but in this case, we'll keep things simple. A model allows you to create instances of your objects, called documents.

In servers, the interactions with the database happen in handler functions. These functions are executed when some event happens (e.g. someone hits an endpoint on your API). We'll follow the same approach in these exercises. The `done()` function is a callback that tells us that we can proceed after completing an asynchronous operation such as inserting, searching, updating, or deleting. It's following the Node convention, and should be called as `done(null, data)` on success, or `done(err)` on error.

Warning - When interacting with remote services, errors may occur!

Create a person schema called `personSchema` with the following shape:

* A required `name` field of type `String`
* An `age` field of type `Number`
* A `favoriteFoods` field of type `[String]`

Use the Mongoose basic schema types. If you want you can also add more fields, use simple validators like required or unique, and set default values. See our Mongoose article.

Now, create a model from the `personSchema` and assign it to the existing variable `Person`.

Hint: Creating an instance from a mongoose schema should succeed""",
        codeSnippet: """/* Example */

const someFunc = function(done) {
  //... do something (risky) ...
  if (error) return done(error);
  done(null, result);
};""",
        hasImage: false,
      ),
      AppLesson(
        title: """Create and Save a Record of a Model""",
        body: """In this challenge you will have to create and save a record of a model.

Within the `createAndSavePerson` function, create a document instance using the `Person` model constructor you built before. Pass to the constructor an object having the fields `name`, `age`, and `favoriteFoods`. Their types must conform to the ones in the `personSchema`. Then, call the method `document.save()` on the returned document instance. Pass to it a callback using the Node convention. This is a common pattern; all the following CRUD methods take a callback function like this as the last argument.

Hint: Creating and saving a db item should succeed""",
        codeSnippet: """/* Example */

// ...
person.save(function(err, data) {
  //   ...do your stuff here...
});""",
        hasImage: false,
      ),
      AppLesson(
        title: """Create Many Records with model.create()""",
        body: """Sometimes you need to create many instances of your models, e.g. when seeding a database with initial data. `Model.create()` takes an array of objects like `[{name: 'John', ...}, {...}, ...]` as the first argument, and saves them all in the db.

Modify the `createManyPeople` function to create many people using `Model.create()` with the argument `arrayOfPeople`.

**Note:** You can reuse the model you instantiated in the previous exercise.

Hint: Creating many db items at once should succeed""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Use model.find() to Search Your Database""",
        body: """In its simplest usage, `Model.find()` accepts a query document (a JSON object) as the first argument, then a callback. It returns an array of matches. It supports an extremely wide range of search options. Read more in the docs.

Modify the `findPeopleByName` function to find all the people having a given name, using Model.find() -\\> [Person]

Use the function argument `personName` as the search key.

Hint: Find all items corresponding to a criteria should succeed""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Use model.findOne() to Return a Single Matching Document from Your Database""",
        body: """`Model.findOne()` behaves like `Model.find()`, but it returns only one document (not an array), even if there are multiple items. It is especially useful when searching by properties that you have declared as unique.

Modify the `findOneByFood` function to find just one person which has a certain food in the person's favorites, using `Model.findOne() -> Person`. Use the function argument `food` as search key.

Hint: Find one item should succeed""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Use model.findById() to Search Your Database By _id""",
        body: """When saving a document, MongoDB automatically adds the field `_id`, and set it to a unique alphanumeric key. Searching by `_id` is an extremely frequent operation, so Mongoose provides a dedicated method for it.

Modify the `findPersonById` to find the only person having a given `_id`, using `Model.findById() -> Person`. Use the function argument `personId` as the search key.

Hint: Find an item by Id should succeed""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Perform Classic Updates by Running Find, Edit, then Save""",
        body: """In the good old days, this was what you needed to do if you wanted to edit a document, and be able to use it somehow (e.g. sending it back in a server response). Mongoose has a dedicated updating method: `Model.update()`. It is bound to the low-level mongo driver. It can bulk-edit many documents matching certain criteria, but it doesn’t send back the updated document, only a 'status' message. Furthermore, it makes model validations difficult, because it just directly calls the mongo driver.

Modify the `findEditThenSave` function to find a person by `_id` (use any of the above methods) with the parameter `personId` as search key. Add `"hamburger"` to the list of the person's `favoriteFoods` (you can use `Array.push()`). Then - inside the find callback - `save()` the updated `Person`.

**Note:** This may be tricky, if in your Schema, you declared `favoriteFoods` as an Array, without specifying the type (i.e. `[String]`). In that case, `favoriteFoods` defaults to Mixed type, and you have to manually mark it as edited using `document.markModified('edited-field')`. See our Mongoose article.

Hint: Find-edit-update an item should succeed""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Perform New Updates on a Document Using model.findOneAndUpdate()""",
        body: """Recent versions of Mongoose have methods to simplify documents updating. Some more advanced features (i.e. pre/post hooks, validation) behave differently with this approach, so the classic method is still useful in many situations. `findByIdAndUpdate()` can be used when searching by id.

Modify the `findAndUpdate` function to find a person by `Name` and set the person's age to `20`. Use the function parameter `personName` as the search key.

**Note:** You should return the updated document. To do that, you need to pass the options document `{ new: true }` as the 3rd argument to `findOneAndUpdate()`. By default, these methods return the unmodified object.

Hint: findOneAndUpdate an item should succeed""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Delete One Document Using model.findByIdAndRemove""",
        body: """`findByIdAndRemove` and `findOneAndRemove` are like the previous update methods. They pass the removed document to the db. As usual, use the function argument `personId` as the search key.

Modify the `removeById` function to delete one person by the person's `_id`. You should use one of the methods `findByIdAndRemove()` or `findOneAndRemove()`.

Hint: Deleting an item should succeed""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Delete Many Documents with model.remove()""",
        body: """`Model.remove()` is useful to delete all the documents matching given criteria.

Modify the `removeManyPeople` function to delete all the people whose name is within the variable `nameToRemove`, using `Model.remove()`. Pass it to a query document with the `name` field set, and a callback.

**Note:** The `Model.remove()` doesn’t return the deleted document, but a JSON object containing the outcome of the operation, and the number of items affected. Don’t forget to pass it to the `done()` callback, since we use it in tests.

Hint: Deleting many items at once should succeed""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Chain Search Query Helpers to Narrow Search Results""",
        body: """If you don’t pass the callback as the last argument to `Model.find()` (or to the other search methods), the query is not executed. You can store the query in a variable for later use. This kind of object enables you to build up a query using chaining syntax. The actual db search is executed when you finally chain the method `.exec()`. You always need to pass your callback to this last method. There are many query helpers, here we'll use the most commonly used.

Modify the `queryChain` function to find people who like the food specified by the variable named `foodToSearch`. Sort them by `name`, limit the results to two documents, and hide their age. Chain `.find()`, `.sort()`, `.limit()`, `.select()`, and then `.exec()`. Pass the `done(err, data)` callback to `exec()`.

Hint: Chaining query helpers should succeed""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Timestamp Microservice""",
        body: """Build a full-stack JavaScript app that is functionally similar to this: https://timestamp-microservice.freecodecamp.rocks. Working on this project will involve you writing your code using one of the following methods:

- Clone this GitHub repo and complete your project locally.
- Use a site builder of your choice to complete the project. Be sure to incorporate all the files from our GitHub repo.

**Note:** Time zones conversion is not a purpose of this project, so assume all sent valid dates will be parsed with `new Date()` as GMT dates.

Hint: You should provide your own project, not the example URL.

A request to `/api/:date?` with a valid date should return a JSON object with a `unix` key that is a Unix timestamp of the input date in milliseconds (as type Number)

A request to `/api/:date?` with a valid date should return a JSON object with a `utc` key that is a string of the input date in the format: `Thu, 01 Jan 1970 00:00:00 GMT`

A request to `/api/1451001600000` should return `{ unix: 1451001600000, utc: "Fri, 25 Dec 2015 00:00:00 GMT" }`

Your project can handle dates that can be successfully parsed by `new Date(date_string)`

If the input date string is invalid, the API returns an object having the structure `{ error : "Invalid Date" }`

An empty date parameter should return the current time in a JSON object with a `unix` key

An empty date parameter should return the current time in a JSON object with a `utc` key""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Request Header Parser Microservice""",
        body: """Build a full-stack JavaScript app that is functionally similar to this: https://request-header-parser-microservice.freecodecamp.rocks/. Working on this project will involve you writing your code using one of the following methods:

- Clone this GitHub repo and complete your project locally.
- Use a site builder of your choice to complete the project. Be sure to incorporate all the files from our GitHub repo.

Hint: You should provide your own project, not the example URL.

A request to `/api/whoami` should return a JSON object with your IP address in the `ipaddress` key.

A request to `/api/whoami` should return a JSON object with your preferred language in the `language` key.

A request to `/api/whoami` should return a JSON object with your software in the `software` key.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """URL Shortener Microservice""",
        body: """Build a full-stack JavaScript app that is functionally similar to this: https://url-shortener-microservice.freecodecamp.rocks. Working on this project will involve you writing your code using one of the following methods:

- Clone this GitHub repo and complete your project locally.
- Use a site builder of your choice to complete the project. Be sure to incorporate all the files from our GitHub repo.

**HINT:** Do not forget to use a body parsing middleware to handle the POST requests. Also, you can use the function `dns.lookup(host, cb)` from the `dns` core module to verify a submitted URL.

Hint: You should provide your own project, not the example URL.

You can POST a URL to `/api/shorturl` and get a JSON response with `original_url` and `short_url` properties. Here's an example: `{ original_url : 'https://freeCodeCamp.org', short_url : 1}`

When you visit `/api/shorturl/`, you will be redirected to the original URL.

If you pass an invalid URL that doesn't follow the valid `http://www.example.com` format, the JSON response will contain `{ error: 'invalid url' }`""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Exercise Tracker""",
        body: """Build a full-stack JavaScript app that is functionally similar to this: https://exercise-tracker.freecodecamp.rocks. Working on this project will involve you writing your code using one of the following methods:

- Clone this GitHub repo and complete your project locally.
- Use a site builder of your choice to complete the project. Be sure to incorporate all the files from our GitHub repo.

Your responses should have the following structures.

Exercise:

User:

Log:

**Hint:** For the `date` property, the `toDateString` method of the `Date` API can be used to achieve the expected output.

Hint: You should provide your own project, not the example URL.

You can `POST` to `/api/users` with form data `username` to create a new user.

The returned response from `POST /api/users` with form data `username` will be an object with `username` and `_id` properties.

You can make a `GET` request to `/api/users` to get a list of all users.

The `GET` request to `/api/users` returns an array.

Each element in the array returned from `GET /api/users` is an object literal containing a user's `username` and `_id`.

You can `POST` to `/api/users/:_id/exercises` with form data `description`, `duration`, and optionally `date`. If no date is supplied, the current date will be used. 

The response returned from `POST /api/users/:_id/exercises` will be the user object with the exercise fields added.

You can make a `GET` request to `/api/users/:_id/logs` to retrieve a full exercise log of any user.

A request to a user's log `GET /api/users/:_id/logs` returns a user object with a `count` property representing the number of exercises that belong to that user.

A `GET` request to `/api/users/:_id/logs` will return the user object with a `log` array of all the exercises added.

Each item in the `log` array that is returned from `GET /api/users/:_id/logs` is an object that should have a `description`, `duration`, and `date` properties.

The `description` property of any object in the `log` array that is returned from `GET /api/users/:_id/logs` should be a string.

The `duration` property of any object in the `log` array that is returned from `GET /api/users/:_id/logs` should be a number.

The `date` property of any object in the `log` array that is returned from `GET /api/users/:_id/logs` should be a string. Use the `dateString` format of the `Date` API.

You can add `from`, `to` and `limit` parameters to a `GET /api/users/:_id/logs` request to retrieve part of the log of any user. `from` and `to` are dates in `yyyy-mm-dd` format. `limit` is an integer of how many logs to send back.""",
        codeSnippet: """{
  username: "fcc_test",
  description: "test",
  duration: 60,
  date: "Mon Jan 01 1990",
  _id: "5fb5853f734231456ccb3b05"
}""",
        hasImage: false,
      ),
      AppLesson(
        title: """File Metadata Microservice""",
        body: """Build a full-stack JavaScript app that is functionally similar to this: https://file-metadata-microservice.freecodecamp.rocks. Working on this project will involve you writing your code using one of the following methods:

- Clone this GitHub repo and complete your project locally.
- Use a site builder of your choice to complete the project. Be sure to incorporate all the files from our GitHub repo.

**HINT:** You can use the `multer` npm package to handle file uploading.

Hint: You should provide your own project, not the example URL.

You can submit a form that includes a file upload.

The form file input field has the `name` attribute set to `upfile`.

When you submit a file, you receive the file `name`, `type`, and `size` in bytes within the JSON response.""",
        codeSnippet: null,
        hasImage: false,
      )
    ],
  ),
  AppCourse(
    id: 'quality-assurance',
    title: """Quality Assurance""",
    description: """A freeCodeCamp curriculum covering Quality Assurance, with 52 lessons extracted from the local curriculum assets.""",
    instructor: 'freeCodeCamp',
    category: 'Web Development',
    difficulty: 'Intermediate',
    icon: Icons.code,
    color: Colors.blue,
    duration: '4 weeks',
    lessons: [
      AppLesson(
        title: """Learn How JavaScript Assertions Work""",
        body: """Working on these challenges will involve you writing your code using one of the following methods:

- Clone this GitHub repo and complete these challenges locally.
- Use a site builder of your choice to complete the project. Be sure to incorporate all the files from our GitHub repo.

Within `tests/1_unit-tests.js` under the test labeled `#1` in the `Basic Assertions` suite, change each `assert` to either `assert.isNull` or `assert.isNotNull` to make the test pass (should evaluate to `true`). Do not alter the arguments passed to the asserts.

Hint: All tests should pass.

You should choose the correct method for the first assertion - `isNull` vs. `isNotNull`.

You should choose the correct method for the second assertion - `isNull` vs. `isNotNull`.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Test if a Variable or Function is Defined""",
        body: """As a reminder, this project is being built upon the following starter project cloned from GitHub.

Within `tests/1_unit-tests.js` under the test labeled `#2` in the `Basic Assertions` suite, change each `assert` to either `assert.isDefined()` or `assert.isUndefined()` to make the test pass (should evaluate to `true`). Do not alter the arguments passed to the asserts.

Hint: All tests should pass.

You should choose the correct method for the first assertion - `isDefined` vs. `isUndefined`.

You should choose the correct method for the second assertion - `isDefined` vs. `isUndefined`.

You should choose the correct method for the third assertion - `isDefined` vs. `isUndefined`.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Use Assert.isOK and Assert.isNotOK""",
        body: """As a reminder, this project is being built upon the following starter project cloned from GitHub.

`isOk()` will test for a truthy value, and `isNotOk()` will test for a falsy value.

To learn more about truthy and falsy values, try our Falsy Bouncer challenge.

Within `tests/1_unit-tests.js` under the test labeled `#3` in the `Basic Assertions` suite, change each `assert` to either `assert.isOk()` or `assert.isNotOk()` to make the test pass (should evaluate to `true`). Do not alter the arguments passed to the asserts.

Hint: All tests should pass.

You should choose the correct method for the first assertion - `isOk` vs. `isNotOk`.

You should choose the correct method for the second assertion - `isOk` vs. `isNotOk`.

You should choose the correct method for the third assertion - `isOk` vs. `isNotOk`.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Test for Truthiness""",
        body: """As a reminder, this project is being built upon the following starter project cloned from GitHub.

`isTrue()` will test for the boolean value `true` and `isNotTrue()` will pass when given anything but the boolean value of `true`.

`isFalse()` and `isNotFalse()` also exist, and behave similarly to their true counterparts except they look for the boolean value of `false`.

Within `tests/1_unit-tests.js` under the test labeled `#4` in the `Basic Assertions` suite, change each `assert` to either `assert.isTrue` or `assert.isNotTrue` to make the test pass (should evaluate to `true`). Do not alter the arguments passed to the asserts.

Hint: All tests should pass.

You should choose the correct method for the first assertion - `isTrue` vs. `isNotTrue`.

You should choose the correct method for the second assertion - `isTrue` vs. `isNotTrue`.

You should choose the correct method for the third assertion - `isTrue` vs. `isNotTrue`.""",
        codeSnippet: """assert.isTrue(true, 'This will pass with the boolean value true');
assert.isTrue('true', 'This will NOT pass with the string value "true"');
assert.isTrue(1, 'This will NOT pass with the number value 1');""",
        hasImage: false,
      ),
      AppLesson(
        title: """Use the Double Equals to Assert Equality""",
        body: """As a reminder, this project is being built upon the following starter project cloned from GitHub.

`equal()` compares objects using `==`.

Within `tests/1_unit-tests.js` under the test labeled `#5` in the `Equality` suite, change each `assert` to either `assert.equal` or `assert.notEqual` to make the test pass (should evaluate to `true`). Do not alter the arguments passed to the asserts.

Hint: All tests should pass.

You should choose the correct method for the first assertion - `equal` vs. `notEqual`.

You should choose the correct method for the second assertion - `equal` vs. `notEqual`.

You should choose the correct method for the third assertion - `equal` vs. `notEqual`.

You should choose the correct method for the fourth assertion - `equal` vs. `notEqual`.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Use the Triple Equals to Assert Strict Equality""",
        body: """As a reminder, this project is being built upon the following starter project cloned from GitHub.

`strictEqual()` compares objects using `===`.

Within `tests/1_unit-tests.js` under the test labeled `#6` in the `Equality` suite, change each `assert` to either `assert.strictEqual` or `assert.notStrictEqual` to make the test pass (should evaluate to `true`). Do not alter the arguments passed to the asserts.

Hint: All tests should pass.

You should choose the correct method for the first assertion - `strictEqual` vs. `notStrictEqual`.

You should choose the correct method for the second assertion - `strictEqual` vs. `notStrictEqual`.

You should choose the correct method for the third assertion - `strictEqual` vs. `notStrictEqual`.

You should choose the correct method for the fourth assertion - `strictEqual` vs. `notStrictEqual`.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Assert Deep Equality with .deepEqual and .notDeepEqual""",
        body: """As a reminder, this project is being built upon the following starter project cloned from GitHub.

`deepEqual()` asserts that two objects are deep equal.

Within `tests/1_unit-tests.js` under the test labeled `#7` in the `Equality` suite, change each `assert` to either `assert.deepEqual` or `assert.notDeepEqual` to make the test pass (should evaluate to `true`). Do not alter the arguments passed to the asserts.

Hint: All tests should pass.

You should choose the correct method for the first assertion - `deepEqual` vs. `notDeepEqual`.

You should choose the correct method for the second assertion - `deepEqual` vs. `notDeepEqual`.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Compare the Properties of Two Elements""",
        body: """As a reminder, this project is being built upon the following starter project cloned from GitHub.

Within `tests/1_unit-tests.js` under the test labeled `#8` in the `Comparisons` suite, change each `assert` to either `assert.isAbove` or `assert.isAtMost` to make the test pass (should evaluate to `true`). Do not alter the arguments passed to the asserts.

Hint: All tests should pass.

You should choose the correct method for the first assertion - `isAbove` vs. `isAtMost`.

You should choose the correct method for the second assertion - `isAbove` vs. `isAtMost`.

You should choose the correct method for the third assertion - `isAbove` vs. `isAtMost`.

You should choose the correct method for the fourth assertion - `isAbove` vs. `isAtMost`.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Test if One Value is Below or At Least as Large as Another""",
        body: """As a reminder, this project is being built upon the following starter project cloned from GitHub.

Within `tests/1_unit-tests.js` under the test labelled `#9` in the `Comparisons` suite, change each `assert` to either `assert.isBelow` or `assert.isAtLeast` to make the test pass (should evaluate to `true`). Do not alter the arguments passed to the asserts.

Hint: All tests should pass.

You should choose the correct method for the first assertion - `isBelow` vs. `isAtLeast`.

You should choose the correct method for the second assertion - `isBelow` vs. `isAtLeast`.

You should choose the correct method for the third assertion - `isBelow` vs. `isAtLeast`.

You should choose the correct method for the fourth assertion - `isBelow` vs. `isAtLeast`.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Test if a Value Falls within a Specific Range""",
        body: """As a reminder, this project is being built upon the following starter project cloned from GitHub.

Asserts that the `actual` is equal to `expected`, to within a +/- `delta` range.

Within `tests/1_unit-tests.js` under the test labeled `#10` in the `Comparisons` suite, change each `assert` to `assert.approximately` to make the test pass (should evaluate to `true`).

Choose the minimum range (3rd parameter) to make the test always pass. It should be less than 1.

Hint: All tests should pass.

You should choose the correct range for the first assertion - `approximately(actual, expected, range)`.

You should choose the correct range for the second assertion - `approximately(actual, expected, range)`.""",
        codeSnippet: """.approximately(actual, expected, delta, [message])""",
        hasImage: false,
      ),
      AppLesson(
        title: """Test if a Value is an Array""",
        body: """As a reminder, this project is being built upon the following starter project cloned from GitHub.

Within `tests/1_unit-tests.js` under the test labeled `#11` in the `Arrays` suite, change each `assert` to either `assert.isArray` or `assert.isNotArray` to make the test pass (should evaluate to `true`). Do not alter the arguments passed to the asserts.

Hint: All tests should pass.

You should choose the correct method for the first assertion - `isArray` vs. `isNotArray`.

You should choose the correct method for the second assertion - `isArray` vs. `isNotArray`.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Test if an Array Contains an Item""",
        body: """As a reminder, this project is being built upon the following starter project cloned from GitHub.

Within `tests/1_unit-tests.js` under the test labeled `#12` in the `Arrays` suite, change each `assert` to either `assert.include` or `assert.notInclude` to make the test pass (should evaluate to `true`). Do not alter the arguments passed to the asserts.

Hint: All tests should pass.

You should choose the correct method for the first assertion - `include` vs. `notInclude`.

You should choose the correct method for the second assertion - `include` vs. `notInclude`.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Test if a Value is a String""",
        body: """As a reminder, this project is being built upon the following starter project cloned from GitHub.

`isString` or `isNotString` asserts that the actual value is a string.

Within `tests/1_unit-tests.js` under the test labeled `#13` in the `Strings` suite, change each `assert` to either `assert.isString` or `assert.isNotString` to make the test pass (should evaluate to `true`). Do not alter the arguments passed to the asserts.

Hint: All tests should pass.

You should choose the correct method for the first assertion - `isString` vs. `isNotString`.

You should choose the correct method for the second assertion - `isString` vs. `isNotString`.

You should choose the correct method for the third assertion - `isString` vs. `isNotString`.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Test if a String Contains a Substring""",
        body: """As a reminder, this project is being built upon the following starter project cloned from GitHub.

`include()` and `notInclude()` work for strings too! `include()` asserts that the actual string contains the expected substring.

Within `tests/1_unit-tests.js` under the test labeled `#14` in the `Strings` suite, change each `assert` to either `assert.include` or `assert.notInclude` to make the test pass (should evaluate to `true`). Do not alter the arguments passed to the asserts.

Hint: All tests should pass.

You should choose the correct method for the first assertion - `include` vs. `notInclude`.

You should choose the correct method for the second assertion - `include` vs. `notInclude`.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Use Regular Expressions to Test a String""",
        body: """As a reminder, this project is being built upon the following starter project cloned from GitHub.

`match()` asserts that the actual value matches the second argument regular expression.

Within `tests/1_unit-tests.js` under the test labeled `#15` in the `Strings` suite, change each `assert` to either `assert.match` or `assert.notMatch` to make the test pass (should evaluate to `true`). Do not alter the arguments passed to the asserts.

Hint: All tests should pass.

You should choose the correct method for the first assertion - `match` vs. `notMatch`.

You should choose the correct method for the second assertion - `match` vs. `notMatch`.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Test if an Object has a Property""",
        body: """As a reminder, this project is being built upon the following starter project cloned from GitHub.

`property` asserts that the actual object has a given property.

Within `tests/1_unit-tests.js` under the test labeled `#16` in the `Objects` suite, change each `assert` to either `assert.property` or `assert.notProperty` to make the test pass (should evaluate to `true`). Do not alter the arguments passed to the asserts.

Hint: All tests should pass.

You should choose the correct method for the first assertion - `property` vs. `notProperty`.

You should choose the correct method for the second assertion - `property` vs. `notProperty`.

You should choose the correct method for the third assertion - `property` vs. `notProperty`.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Test if a Value is of a Specific Data Structure Type""",
        body: """As a reminder, this project is being built upon the following starter project cloned from GitHub.

`#typeOf` asserts that value's type is the given string, as determined by `Object.prototype.toString`.

Within `tests/1_unit-tests.js` under the test labeled `#17` in the `Objects` suite, change each `assert` to either `assert.typeOf` or `assert.notTypeOf` to make the test pass (should evaluate to `true`). Do not alter the arguments passed to the asserts.

Hint: All tests should pass.

You should choose the correct method for the first assertion - `typeOf` vs. `notTypeOf`.

You should choose the correct method for the second assertion - `typeOf` vs. `notTypeOf`.

You should choose the correct method for the third assertion - `typeOf` vs. `notTypeOf`.

You should choose the correct method for the fourth assertion - `typeOf` vs. `notTypeOf`.

You should choose the correct method for the fifth assertion - `typeOf` vs. `notTypeOf`.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Test if an Object is an Instance of a Constructor""",
        body: """As a reminder, this project is being built upon the following starter project cloned from GitHub.

`#instanceOf` asserts that an object is an instance of a constructor.

Within `tests/1_unit-tests.js` under the test labeled `#18` in the `Objects` suite, change each `assert` to either `assert.instanceOf` or `assert.notInstanceOf` to make the test pass (should evaluate to `true`). Do not alter the arguments passed to the asserts.

Hint: All tests should pass.

You should choose the correct method for the first assertion - `instanceOf` vs. `notInstanceOf`.

You should choose the correct method for the second assertion - `instanceOf` vs. `notInstanceOf`.

You should choose the correct method for the third assertion - `instanceOf` vs. `notInstanceOf`.

You should choose the correct method for the fourth assertion - `instanceOf` vs. `notInstanceOf`.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Run Functional Tests on API Endpoints using Chai-HTTP""",
        body: """As a reminder, this project is being built upon the following starter project cloned from GitHub.

Mocha allows you to test asynchronous operations like calls to API endpoints with a plugin called `chai-http`.

The following is an example of a test using `chai-http` for a suite called `'GET /hello?name=[name] => "hello [name]"'`:

The test sends a `GET` request to the server with a name as a URL query string (`?name=John`). In the `end` method's callback function, the response object (`res`) is received and contains the `status` property.

The first `assert.equal` checks if the status is equal to `200`. The second `assert.equal` checks that the response string (`res.text`) is equal to `"hello John"`.

Also, notice the `done` parameter in the test's callback function. Calling it without an argument at the end of a test is necessary to signal that the asynchronous operation is complete.

Finally, note the `keepOpen` method just after the `request` method. Normally you would run your tests from the command line, or as part of an automated integration process, and you could let `chai-http` start and stop your server automatically.

However, the tests that run when you submit the link to your project require your server to be up, so you need to use the `keepOpen` method to prevent `chai-http` from stopping your server.

Within `tests/2_functional-tests.js`, alter the `'Test GET /hello with no name'` test (`// #1`) to assert the `status` and the `text` of the response to make the test pass. Do not alter the arguments passed to the asserts.

There should be no URL query. Without a name URL query, the endpoint responds with `hello Guest`.

Hint: All tests should pass

You should test for `res.status` == 200

You should test for `res.text` == `'hello Guest'`""",
        codeSnippet: """suite('GET /hello?name=[name] => "hello [name]"', function () {
  test('?name=John', function (done) {
    chai
      .request(server)
      .keepOpen()
      .get('/hello?name=John')
      .end(function (err, res) {
        assert.equal(res.status, 200, 'Response status should be 200');
        assert.equal(res.text, 'hello John', 'Response should be "hello John"');
        done();
      });
  });
});""",
        hasImage: false,
      ),
      AppLesson(
        title: """Run Functional Tests on API Endpoints using Chai-HTTP II""",
        body: """As a reminder, this project is being built upon the following starter project cloned from GitHub.

Within `tests/2_functional-tests.js`, alter the `'Test GET /hello with your name'` test (`// #2`) to assert the `status` and the `text` of the response to make the test pass.

Send your name as a URL query by appending `?name=` to the route. The endpoint responds with `'hello '`.

Hint: All tests should pass

You should test for `res.status` == 200

You should test for `res.text` == `'hello '`""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Run Functional Tests on an API Response using Chai-HTTP III - PUT method""",
        body: """As a reminder, this project is being built upon the following starter project cloned from GitHub.

When you test a `PUT` request, you'll often send data along with it. The data you include with your `PUT` request is called the body of the request.

To send a `PUT` request and a JSON object to the `'/travellers'` endpoint, you can use `chai-http` plugin's `put` and `send` methods:

And the route responds with:

See the server code for the different responses to the `'/travellers'` endpoint.

Within `tests/2_functional-tests.js`, alter the `'Send {surname: "Colombo"}'` test (`// #3`) and use the `put` and `send` methods to test the `'/travellers'` endpoint.

Send the following JSON object with your PUT request:

Check for the following within the `request.end` callback:

1. The `status` should be `200`
2. The `type` should be `application/json`
3. The `body.name` should be `Cristoforo`
4. The `body.surname` should be `Colombo`

Follow the assertion order above - we rely on it. Also, be sure to remove `assert.fail()` once complete.

Hint: All tests should pass.

You should test for `res.status` to be 200.

You should test for `res.type` to be `'application/json'`.

You should test for `res.body.name` to be `'Cristoforo'`.

You should test for `res.body.surname` to be `'Colombo'`.""",
        codeSnippet: """chai
  .request(server)
  .keepOpen()
  .put('/travellers')
  .send({
    "surname": [last name of a traveller of the past]
  })
  ...""",
        hasImage: false,
      ),
      AppLesson(
        title: """Run Functional Tests on an API Response using Chai-HTTP IV - PUT method""",
        body: """As a reminder, this project is being built upon the following starter project cloned from GitHub.

This exercise is similar to the previous one.

Now that you know how to test a `PUT` request, it's your turn to do it from scratch.

Within `tests/2_functional-tests.js`, alter the `'Send {surname: "da Verrazzano"}'` test (`// #4`) and use the `put` and `send` methods to test the `'/travellers'` endpoint.

Send the following JSON object with your PUT request:

Check for the following within the `request.end` callback:

1. The `status` should be `200`
2. The `type` should be `application/json`
3. The `body.name` should be `Giovanni`
4. The `body.surname` should be `da Verrazzano`

Follow the assertion order above - we rely on it. Also, be sure to remove `assert.fail()` once complete.

Hint: All tests should pass

You should test for `res.status` to be 200

You should test for `res.type` to be `'application/json'`

You should test for `res.body.name` to be `'Giovanni'`

You should test for `res.body.surname` to be `'da Verrazzano'`""",
        codeSnippet: """{
  "surname": "da Verrazzano"
}""",
        hasImage: false,
      ),
      AppLesson(
        title: """Simulate Actions Using a Headless Browser""",
        body: """As a reminder, this project is being built upon the following starter project cloned from GitHub.

In the next challenges, you'll simulate human interaction with a page by using a headless browser.

Headless browsers are web browsers without a GUI. They are able to render and interpret HTML, CSS, and JavaScript the same way a regular browser would, making them particularly useful for testing web pages.

For the following challenges you'll use Zombie.js, which is a lightweight headless browser that doesn't rely on additional binaries to be installed. But there are many other, more powerful headless browser options.

Mocha allows you to run some code before any of the actual tests run. This can be useful to do things like add entries to a database which will be used in the rest of the tests.

With a headless browser, before running tests, you need to **visit** the page you'll test.

The `suiteSetup` hook is executed only once at the beginning of a test suite.

There are several other hook types that can execute code before each test, after each test, or at the end of a test suite. See the Mocha docs for more information.

Within `tests/2_functional-tests.js`, immediately after the `Browser` declaration, add your project URL to the `site` property of the variable:

Then at the root level of the `'Functional Tests with Zombie.js'` suite, instantiate a new instance of the `Browser` object with the following code:

And use the `suiteSetup` hook to direct the `browser` to the `/` route with the following code. **Note**: `done` is passed as a callback to `browser.visit`, you should not invoke it.

Hint: All tests should pass.""",
        codeSnippet: """Browser.site = 'http://0.0.0.0:3000'; // Your URL here""",
        hasImage: false,
      ),
      AppLesson(
        title: """Run Functional Tests Using a Headless Browser""",
        body: """As a reminder, this project is being built upon the following starter project cloned from GitHub.

On the page there's an input form. It sends data to the `PUT /travellers` endpoint as an AJAX request.

When the request successfully completes, the client code appends a `` containing the information in the response to the DOM.

Here's an example of how to use Zombie.js to interact with the form:

First, the `fill` method of the `browser` object fills the `surname` field of the form with the value `'Polo'`. `fill` returns a promise, so `then` is chained off of it.

Within the `then` callback, the `pressButton` method of the `browser` object is used to invoke the form's `submit` event listener. The `pressButton` method is asynchronous.

Then, once a response is received from the AJAX request, a few assertions are made confirming:

1. The status of the response is `200`
2. The text within the `` element matches `'Marco'`
3. The text within the `` element matches `'Polo'`
4. There is `1` `` element.

Finally, the `done` callback is invoked, which is needed due to the asynchronous test.

Within `tests/2_functional-tests.js`, in the `'Submit the surname "Colombo" in the HTML form'` test (`// #5`), automate the following:

1. Fill in the form with the surname `Colombo`
2. Press the submit button

And within the `pressButton` callback:

1. Assert that status is OK `200`
2. Assert that the text inside the element `span#name` is `'Cristoforo'`
3. Assert that the text inside the element `span#surname` is `'Colombo'`
4. Assert that the element(s) `span#dates` exist and their count is `1`

Do not forget to remove the `assert.fail()` call.

Hint: All tests should pass.

You should assert that the headless browser request succeeded.

You should assert that the text inside the element `span#name` is `'Cristoforo'`.

You should assert that the text inside the element `span#surname` is `'Colombo'`.

You should assert that the element `span#dates` exist and its count is 1.""",
        codeSnippet: """test('Submit the surname "Polo" in the HTML form', function (done) {
  browser.fill('surname', 'Polo').then(() => {
    browser.pressButton('submit', () => {
      browser.assert.success();
      browser.assert.text('span#name', 'Marco');
      browser.assert.text('span#surname', 'Polo');
      browser.assert.elements('span#dates', 1);
      done();
    });
  });
});""",
        hasImage: false,
      ),
      AppLesson(
        title: """Run Functional Tests Using a Headless Browser II""",
        body: """As a reminder, this project is being built upon the following starter project cloned from GitHub.

Within `tests/2_functional-tests.js`, in the `'Submit the surname "Vespucci" in the HTML form'` test (`// #6`), automate the following:

1. Fill in the form with the surname `Vespucci`
2. Press the submit button

And within the `pressButton` callback:

1. Assert that status is OK `200`
2. Assert that the text inside the element `span#name` is `'Amerigo'`
3. Assert that the text inside the element `span#surname` is `'Vespucci'`
4. Assert that the element(s) `span#dates` exist and their count is `1`

Do not forget to remove the `assert.fail()` call.

Hint: All tests should pass.

You should assert that the headless browser request succeeded.

You should assert that the text inside the element `span#name` is `'Amerigo'`.

You should assert that the text inside the element `span#surname` is `'Vespucci'`.

You should assert that the element `span#dates` exist and its count is 1.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Set up a Template Engine""",
        body: """Working on these challenges will involve you writing your code using one of the following methods:

- Clone this GitHub repo and complete these challenges locally.
- Use a site builder of your choice to complete the project. Be sure to incorporate all the files from our GitHub repo.

A template engine enables you to use static template files (such as those written in *Pug*) in your app. At runtime, the template engine replaces variables in a template file with actual values which can be supplied by your server. Then it transforms the template into a static HTML file that is sent to the client. This approach makes it easier to design an HTML page and allows for displaying variables on the page without needing to make an API call from the client.

`pug@~3.0.0` has already been installed, and is listed as a dependency in your `package.json` file.

Express needs to know which template engine you are using. Use the `set` method to assign `pug` as the `view engine` property's value:

After that, add another `set` method that sets the `views` property of your `app` to point to the `./views/pug` directory. This tells Express to render all views relative to that directory.

Finally, use `res.render()` in the route for your home page, passing `index` as the first argument. This will render the `pug` template.

If all went as planned, your app home page will no longer be blank. Instead, it will display a message indicating you've successfully rendered the Pug template!

Submit your page when you think you've got it right. If you're running into errors, you can check out the project completed up to this point.

Hint: Pug should be a dependency.

View engine should be Pug.

You should set the `views` property of the application to `./views/pug`.

Use the correct ExpressJS method to render the index page from the response.

Pug should be working.""",
        codeSnippet: """app.set('view engine', 'pug');""",
        hasImage: false,
      ),
      AppLesson(
        title: """Use a Template Engine's Powers""",
        body: """One of the greatest features of using a template engine is being able to pass variables from the server to the template file before rendering it to HTML.

In your Pug file, you're able to use a variable by referencing the variable name as `#{variable_name}` inline with other text on an element or by using an equal sign on the element without a space such as `p=variable_name` which assigns the variable's value to the p element's text.

Pug is all about using whitespace and tabs to show nested elements and cutting down on the amount of code needed to make a beautiful site.

Take the following Pug code for example: 
 

The above yields the following HTML:

Your `index.pug` file included in your project, uses the variables `title` and `message`.

Pass those from your server to the Pug file by adding an object as a second argument to your `res.render` call with the variables and their values. Give the `title` a value of `Hello` and `message` a value of `Please log in`.

It should look like:

Now refresh your page, and you should see those values rendered in your view in the correct spot as laid out in your `index.pug` file!

Submit your page when you think you've got it right. If you're running into errors, you can check out the project completed up to this point.

Hint: Pug should correctly render variables.""",
        codeSnippet: """head
  script(type='text/javascript').
    if (foo) bar(1 + 5);
body
  if youAreUsingPug
      p You are amazing
    else
      p Get on it!""",
        hasImage: false,
      ),
      AppLesson(
        title: """Set up Passport""",
        body: """It's time to set up *Passport* so you can finally start allowing a user to register or log in to an account. In addition to Passport, you will use Express-session to handle sessions. Express-session has a ton of advanced features you can use, but for now you are just going to use the basics. Using this middleware saves the session id as a cookie in the client, and allows us to access the session data using that id on the server. This way, you keep personal account information out of the cookie used by the client to tell to your server clients are authenticated and keep the *key* to access the data stored on the server.

`passport@~0.4.1` and `express-session@~1.17.1` are already installed, and are both listed as dependencies in your `package.json` file.

You will need to set up the session settings and initialize Passport. First, create the variables `session` and `passport` to require `express-session` and `passport` respectively.

Then, set up your Express app to use the session by defining the following options:

Be sure to add `SESSION_SECRET` to your `.env` file, and give it a random value. This is used to compute the hash used to encrypt your cookie!

After you do all that, tell your express app to **use** `passport.initialize()` and `passport.session()`.

Submit your page when you think you've got it right. If you're running into errors, you can check out the project completed up to this point.

Hint: Passport and Express-session should be dependencies.

Dependencies should be correctly required.

Express app should use new dependencies.

Session and session secret should be correctly set up.""",
        codeSnippet: """app.use(session({
  secret: process.env.SESSION_SECRET,
  resave: true,
  saveUninitialized: true,
  cookie: { secure: false }
}));""",
        hasImage: false,
      ),
      AppLesson(
        title: """Serialization of a User Object""",
        body: """Serialization and deserialization are important concepts in regard to authentication. To serialize an object means to convert its contents into a small *key* that can then be deserialized into the original object. This is what allows us to know who has communicated with the server without having to send the authentication data, like the username and password, at each request for a new page.

To set this up properly, you need to have a serialize function and a deserialize function. In Passport, these can be created with:

The callback function passed to `serializeUser` is called with two arguments: the full user object, and a callback used by passport. 

The callback expects two arguments: An error, if any, and a unique key to identify the user that should be returned in the callback. You will use the user's `_id` in the object. This is guaranteed to be unique, as it is generated by MongoDB.

Similarly, `deserializeUser` is called with two arguments: the unique key, and a callback function.

This callback expects two arguments: An error, if any, and the full user object. To get the full user object, make a query search for a Mongo `_id`, as shown below:

Add the two functions above to your server. The `ObjectID` class comes from the `mongodb` package. `mongodb@~3.6.0` has already been added as a dependency. Declare this class with:

The `deserializeUser` will throw an error until you set up the database connection. So, for now, comment out the `myDatabase.findOne` call, and just call `done(null, null)` in the `deserializeUser` callback function.

Submit your page when you think you've got it right. If you're running into errors, you can check out the project completed up to this point.

Hint: You should serialize the user object correctly.

You should deserialize the user object correctly.

MongoDB should be a dependency.

Mongodb should be properly required including the ObjectId.""",
        codeSnippet: """passport.serializeUser(cb);
passport.deserializeUser(cb);""",
        hasImage: false,
      ),
      AppLesson(
        title: """Implement the Serialization of a Passport User""",
        body: """You are not loading an actual user object since the database is not set up. Connect to the database once, when you start the server, and keep a persistent connection for the full life-cycle of the app. To do this, add your database's connection string (for example: `mongodb+srv://:@cluster0-jvwxi.mongodb.net/?retryWrites=true&w=majority`) to the environment variable `MONGO_URI`. This is used in the `connection.js` file.

*If you are having issues setting up a free database on MongoDB Atlas, check out this tutorial.*

Now you want to connect to your database, then start listening for requests. The purpose of this is to not allow requests before your database is connected or if there is a database error. To accomplish this, encompass your serialization and app routes in the following code:

Be sure to uncomment the `myDataBase` code in `deserializeUser`, and edit your `done(null, null)` to include the `doc`.

Submit your page when you think you've got it right. If you're running into errors, you can check out the project completed up to this point.

Hint: Database connection should be present.

Deserialization should now be correctly using the DB and `done(null, null)` should be called with the `doc`.""",
        codeSnippet: """myDB(async client => {
  const myDataBase = await client.db('database').collection('users');

  // Be sure to change the title
  app.route('/').get((req, res) => {
    // Change the response to render the Pug template
    res.render('index', {
      title: 'Connected to Database',
      message: 'Please login'
    });
  });

  // Serialization and deserialization here...

  // Be sure to add this...
}).catch(e => {
  app.route('/').get((req, res) => {
    res.render('index', { title: e, message: 'Unable to connect to database' });
  });
});
// app.listen out here...""",
        hasImage: false,
      ),
      AppLesson(
        title: """Authentication Strategies""",
        body: """A strategy is a way of authenticating a user. You can use a strategy for allowing users to authenticate based on locally saved information (if you have them register first) or from a variety of providers such as Google or GitHub. For this project, we will use Passport middleware. Passport provides a comprehensive set of strategies that support authentication using a username and password, GitHub, Google, and more.

`passport-local@~1.0.0` has already been added as a dependency. Add it to your server as follows:

Tell passport to **use** an instantiated `LocalStrategy` object with a few settings defined. Make sure this (as well as everything from this point on) is encapsulated in the database connection since it relies on it!:

This is defining the process to use when you try to authenticate someone locally. First, it tries to find a user in your database with the username entered. Then, it checks for the password to match. Finally, if no errors have popped up that you checked for (e.g. an incorrect password), the `user` object is returned and they are authenticated.

Many strategies are set up using different settings. Generally, it is easy to set it up based on the README in that strategy's repository. A good example of this is the GitHub strategy where you don't need to worry about a username or password because the user will be sent to GitHub's auth page to authenticate. As long as they are logged in and agree then GitHub returns their profile for you to use.

In the next step, you will set up how to actually call the authentication strategy to validate a user based on form data.

Submit your page when you think you've got it right. If you're running into errors, you can check out the project completed up to this point.

Hint: Passport-local should be a dependency.

Passport-local should be correctly required and set up.""",
        codeSnippet: """const LocalStrategy = require('passport-local');""",
        hasImage: false,
      ),
      AppLesson(
        title: """How to Use Passport Strategies""",
        body: """In the `index.pug` file supplied, there is a login form. It is hidden because of the inline JavaScript `if showLogin` with the form indented after it.

In the `res.render` for that page, add a new variable to the object, `showLogin: true`. When you refresh your page, you should then see the form! This form is set up to **POST** on `/login`. So, this is where you should set up to accept the POST request and authenticate the user.

For this challenge, you should add the route `/login` to accept a POST request. To authenticate on this route, you need to add a middleware to do so before then sending a response. This is done by just passing another argument with the middleware before with your response. The middleware to use is `passport.authenticate('local')`.

`passport.authenticate` can also take some options as an argument such as `{ failureRedirect: '/' }` which is incredibly useful, so be sure to add that in as well. Add a response after using the middleware (which will only be called if the authentication middleware passes) that redirects the user to `/profile`. Add that route, as well, and make it render the view `profile.pug`.

If the authentication was successful, the user object will be saved in `req.user`.

At this point, if you enter a username and password in the form, it should redirect to the home page `/`, and the console of your server should display `'User {USERNAME} attempted to log in.'`, since we currently cannot login a user who isn't registered.

Submit your page when you think you've got it right. If you're running into errors, you can check out the project completed up to this point.

Hint: All steps should be correctly implemented in `server.js`.

A POST request to `/login` should correctly redirect to `/`.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Create New Middleware""",
        body: """As is, any user can just go to `/profile` whether they have authenticated or not by typing in the URL. You want to prevent this by checking if the user is authenticated first before rendering the profile page. This is the perfect example of when to create a middleware.

The challenge here is creating the middleware function `ensureAuthenticated(req, res, next)`, which will check if a user is authenticated by calling Passport's `isAuthenticated` method on the `request` which checks if `req.user` is defined. If it is, then `next()` should be called. Otherwise, you can just respond to the request with a redirect to your homepage to login.

An implementation of this middleware is:

Create the above middleware function, then pass `ensureAuthenticated` as middleware to requests for the profile page before the argument to the GET request:

Submit your page when you think you've got it right. If you're running into errors, you can check out the project completed up to this point.

Hint: The middleware `ensureAuthenticated` should be implemented and attached to the `/profile` route.

An unauthenticated GET request to `/profile` should correctly redirect to `/`.""",
        codeSnippet: """function ensureAuthenticated(req, res, next) {
  if (req.isAuthenticated()) {
    return next();
  }
  res.redirect('/');
};""",
        hasImage: false,
      ),
      AppLesson(
        title: """How to Put a Profile Together""",
        body: """Now that you can ensure the user accessing the `/profile` is authenticated, you can use the information contained in `req.user` on your page.

Pass an object containing the property `username` and value of `req.user.username` as the second argument for the `render` method of the profile view.

Then, go to your `profile.pug` view, and add the following line below the existing `h1` element, and at the same level of indentation:

This creates an `h2` element with the class `center` and id `welcome` containing the text `Welcome, ` followed by the username.

Also, in `profile.pug`, add a link referring to the `/logout` route, which will host the logic to unauthenticate a user:

Submit your page when you think you've got it right. If you're running into errors, you can check out the project completed up to this point.

Hint: You should correctly add a Pug render variable to `/profile`.""",
        codeSnippet: """h2.center#welcome Welcome, #{username}!""",
        hasImage: false,
      ),
      AppLesson(
        title: """Logging a User Out""",
        body: """Creating the logout logic is easy. The route should just unauthenticate the user, and redirect to the home page instead of rendering any view.

In passport, unauthenticating a user is as easy as just calling `req.logout()` before redirecting. Add this `/logout` route to do that:

You may have noticed that you are not handling missing pages (404). The common way to handle this in Node is with the following middleware. Go ahead and add this in after all your other routes:

Submit your page when you think you've got it right. If you're running into errors, you can check out the project completed up to this point.

Hint: `req.logout()` should be called in your `/logout` route.

`/logout` should redirect to the home page.""",
        codeSnippet: """app.route('/logout')
  .get((req, res) => {
    req.logout();
    res.redirect('/');
});""",
        hasImage: false,
      ),
      AppLesson(
        title: """Registration of New Users""",
        body: """Now you need to allow a new user on your site to register an account. In the `res.render` for the home page add a new variable to the object passed along - `showRegistration: true`. When you refresh your page, you should then see the registration form that was already created in your `index.pug` file. This form is set up to **POST** on `/register`, so create that route and have it add the user object to the database by following the logic below.

The logic of the registration route should be as follows:

1. Register the new user
2. Authenticate the new user
3. Redirect to `/profile`

The logic of step 1 should be as follows:

1. Query database with `findOne`
2. If there is an error, call `next` with the error
3. If a user is returned, redirect back to home
4. If a user is not found and no errors occur, then `insertOne` into the database with the username and password. As long as no errors occur there, call `next` to go to step 2, authenticating the new user, which you already wrote the logic for in your `POST /login` route.

Submit your page when you think you've got it right. If you're running into errors, you can check out the project completed up to this point.

**NOTE:** From this point onwards, issues can arise relating to the use of the *picture-in-picture* browser. If you are using an online IDE which offers a preview of the app within the editor, it is recommended to open this preview in a new tab.

Hint: You should have a `/register` route and display a registration form on the home page.

Registering should work.

Login should work.

Logout should work.

Profile should no longer work after logout.""",
        codeSnippet: """app.route('/register')
  .post((req, res, next) => {
    myDataBase.findOne({ username: req.body.username }, (err, user) => {
      if (err) {
        next(err);
      } else if (user) {
        res.redirect('/');
      } else {
        myDataBase.insertOne({
          username: req.body.username,
          password: req.body.password
        },
          (err, doc) => {
            if (err) {
              res.redirect('/');
            } else {
              // The inserted document is held within
              // the ops property of the doc
              next(null, doc.ops[0]);
            }
          }
        )
      }
    })
  },
    passport.authenticate('local', { failureRedirect: '/' }),
    (req, res, next) => {
      res.redirect('/profile');
    }
  );""",
        hasImage: false,
      ),
      AppLesson(
        title: """Hashing Your Passwords""",
        body: """Going back to the information security section, you may remember that storing plaintext passwords is *never* okay. Now it is time to implement BCrypt to solve this issue.

`bcrypt@~5.0.0` has already been added as a dependency, so require it in your server. You will need to handle hashing in 2 key areas: where you handle registering/saving a new account, and when you check to see that a password is correct on login.

Currently on your registration route, you insert a user's plaintext password into the database like so: `password: req.body.password`. Hash the passwords instead by adding the following before your database logic: `const hash = bcrypt.hashSync(req.body.password, 12);`, and replacing the `req.body.password` in the database saving with just `password: hash`.

On your authentication strategy, you check for the following in your code before completing the process: `if (password !== user.password) return done(null, false);`. After making the previous changes, now `user.password` is a hash. Before making a change to the existing code, notice how the statement is checking if the password is **not** equal then return non-authenticated. With this in mind, change that code to look as follows to properly check the password entered against the hash:

That is all it takes to implement one of the most important security features when you have to store passwords.

Submit your page when you think you've got it right. If you're running into errors, you can check out the project completed up to this point.

Hint: BCrypt should be a dependency.

BCrypt should be correctly required and implemented.""",
        codeSnippet: """if (!bcrypt.compareSync(password, user.password)) { 
  return done(null, false);
}""",
        hasImage: false,
      ),
      AppLesson(
        title: """Clean Up Your Project with Modules""",
        body: """Right now, everything you have is in your `server.js` file. This can lead to hard to manage code that isn't very expandable. Create 2 new files: `routes.js` and `auth.js`

Both should start with the following code:

Now, in the top of your server file, require these files like so: `const routes = require('./routes.js');` Right after you establish a successful connection with the database, instantiate each of them like so: `routes(app, myDataBase)`

Finally, take all of the routes in your server and paste them into your new files, and remove them from your server file. Also take the `ensureAuthenticated` function, since it was specifically created for routing. Now, you will have to correctly add the dependencies in which are used, such as `const passport = require('passport');`, at the very top, above the export line in your `routes.js` file.

Keep adding them until no more errors exist, and your server file no longer has any routing (**except for the route in the catch block**)!

Do the same thing in your `auth.js` file with all of the things related to authentication such as the serialization and the setting up of the local strategy and erase them from your server file. Be sure to add the dependencies in and call `auth(app, myDataBase)` in the server in the same spot.

Submit your page when you think you've got it right. If you're running into errors, you can check out an example of the completed project.

Hint: Modules should be present.""",
        codeSnippet: """module.exports = function (app, myDataBase) {

}""",
        hasImage: false,
      ),
      AppLesson(
        title: """Implementation of Social Authentication""",
        body: """The basic path this kind of authentication will follow in your app is:

1. User clicks a button or link sending them to your route to authenticate using a specific strategy (e.g. GitHub).
2. Your route calls `passport.authenticate('github')` which redirects them to GitHub.
3. The page the user lands on, on GitHub, allows them to login if they aren't already. It then asks them to approve access to their profile from your app.
4. The user is then returned to your app at a specific callback url with their profile if they are approved.
5. They are now authenticated, and your app should check if it is a returning profile, or save it in your database if it is not.

Strategies with OAuth require you to have at least a *Client ID* and a *Client Secret* which is a way for the service to verify who the authentication request is coming from and if it is valid. These are obtained from the site you are trying to implement authentication with, such as GitHub, and are unique to your app--**THEY ARE NOT TO BE SHARED** and should never be uploaded to a public repository or written directly in your code. A common practice is to put them in your `.env` file and reference them like so: `process.env.GITHUB_CLIENT_ID`. For this challenge you are going to use the GitHub strategy.

Follow these instructions to obtain your *Client ID and Secret* from GitHub. Set the homepage URL to your homepage (**not the project code's URL**), and set the callback URL to the same homepage URL with `/auth/github/callback` appended to the end. Save the client ID and your client secret in your project's `.env` file as `GITHUB_CLIENT_ID` and `GITHUB_CLIENT_SECRET`.

In your `routes.js` file, add `showSocialAuth: true` to the homepage route, after `showRegistration: true`. Now, create 2 routes accepting GET requests: `/auth/github` and `/auth/github/callback`. The first should only call passport to authenticate `'github'`. The second should call passport to authenticate `'github'` with a failure redirect to `/`, and then if that is successful redirect to `/profile` (similar to your last project).

An example of how `/auth/github/callback` should look is similar to how you handled a normal login:

Submit your page when you think you've got it right. If you're running into errors, you can check out the project up to this point.

Hint: Route `/auth/github` should be correct.

Route `/auth/github/callback` should be correct.""",
        codeSnippet: """app.route('/login')
  .post(passport.authenticate('local', { failureRedirect: '/' }), (req,res) => {
    res.redirect('/profile');
  });""",
        hasImage: false,
      ),
      AppLesson(
        title: """Implementation of Social Authentication II""",
        body: """The last part of setting up your GitHub authentication is to create the strategy itself. `passport-github@~1.1.0` has already been added as a dependency, so require it in your `auth.js` file as `GitHubStrategy` like this: `const GitHubStrategy = require('passport-github').Strategy;`. Do not forget to require and configure `dotenv` to use your environment variables.

To set up the GitHub strategy, you have to tell Passport to use an instantiated `GitHubStrategy`, which accepts 2 arguments: an object (containing `clientID`, `clientSecret`, and `callbackURL`) and a function to be called when a user is successfully authenticated, which will determine if the user is new and what fields to save initially in the user's database object. This is common across many strategies, but some may require more information as outlined in that specific strategy's GitHub README. For example, Google requires a *scope* as well which determines what kind of information your request is asking to be returned and asks the user to approve such access.

The current strategy you are implementing authenticates users using a GitHub account and OAuth 2.0 tokens. The client ID and secret obtained when creating an application are supplied as options when creating the strategy. The strategy also requires a `verify` callback, which receives the access token and optional refresh token, as well as `profile` which contains the authenticated user's GitHub profile. The `verify` callback must call `cb` providing a user to complete authentication.

Here's how your new strategy should look at this point:

Your authentication won't be successful yet, and it will actually throw an error without the database logic and callback, but it should log your GitHub profile to your console if you try it!

Submit your page when you think you've got it right. If you're running into errors, you can check out the project completed up to this point.

Hint: `passport-github` dependency should be added.

`passport-github` should be required.

GitHub strategy should be setup correctly thus far.""",
        codeSnippet: """passport.use(new GitHubStrategy({
  clientID: process.env.GITHUB_CLIENT_ID,
  clientSecret: process.env.GITHUB_CLIENT_SECRET,
  callbackURL: /*INSERT CALLBACK URL ENTERED INTO GITHUB HERE*/
},
  function(accessToken, refreshToken, profile, cb) {
    console.log(profile);
    //Database logic here with callback containing your user object
  }
));""",
        hasImage: false,
      ),
      AppLesson(
        title: """Implementation of Social Authentication III""",
        body: """The final part of the strategy is handling the profile returned from GitHub. We need to load the user's database object if it exists, or create one if it doesn't, and populate the fields from the profile, then return the user's object. GitHub supplies us a unique *id* within each profile which we can use to search with to serialize the user with (already implemented). Below is an example implementation you can use in your project--it goes within the function that is the second argument for the new strategy, right below where `console.log(profile);` currently is:

`findOneAndUpdate` allows you to search for an object and update it. If the object doesn't exist, it will be inserted and made available to the callback function. In this example, we always set `last_login`, increment the `login_count` by `1`, and only populate the majority of the fields when a new object (new user) is inserted. Notice the use of default values. Sometimes a profile returned won't have all the information filled out or the user will keep it private. In this case, you handle it to prevent an error.

You should be able to login to your app now. Try it!

Submit your page when you think you've got it right. If you're running into errors, you can check out the project completed up to this point.

Hint: GitHub strategy setup should be complete.""",
        codeSnippet: """myDataBase.findOneAndUpdate(
  { id: profile.id },
  {
    \$setOnInsert: {
      id: profile.id,
      username: profile.username,
      name: profile.displayName || 'John Doe',
      photo: profile.photos[0].value || '',
      email: Array.isArray(profile.emails)
        ? profile.emails[0].value
        : 'No public email',
      created_on: new Date(),
      provider: profile.provider || ''
    },
    \$set: {
      last_login: new Date()
    },
    \$inc: {
      login_count: 1
    }
  },
  { upsert: true, new: true },
  (err, doc) => {
    return cb(null, doc.value);
  }
);""",
        hasImage: false,
      ),
      AppLesson(
        title: """Set up the Environment""",
        body: """The following challenges will make use of the `chat.pug` file. So, in your `routes.js` file, add a GET route pointing to `/chat` which makes use of `ensureAuthenticated`, and renders `chat.pug`, with `{ user: req.user }` passed as an argument to the response. Now, alter your existing `/auth/github/callback` route to set the `req.session.user_id = req.user.id`, and redirect to `/chat`.

`socket.io@~2.3.0` has already been added as a dependency, so require/instantiate it in your server as follows with `http` (comes built-in with Node.js):

Now that the *http* server is mounted on the *express app*, you need to listen from the *http* server. Change the line with `app.listen` to `http.listen`.

The first thing needing to be handled is listening for a new connection from the client. The on keyword does just that- listen for a specific event. It requires 2 arguments: a string containing the title of the event that's emitted, and a function with which the data is passed through. In the case of our connection listener, use `socket` to define the data in the second argument. A socket is an individual client who is connected.

To listen for connections to your server, add the following within your database connection:

Now for the client to connect, you just need to add the following to your `client.js` which is loaded by the page after you've authenticated:

The comment suppresses the error you would normally see since 'io' is not defined in the file. You have already added a reliable CDN to the Socket.IO library on the page in `chat.pug`.

Now try loading up your app and authenticate and you should see in your server console `A user has connected`.

**Note:**`io()` works only when connecting to a socket hosted on the same url/server. For connecting to an external socket hosted elsewhere, you would use `io.connect('URL');`.

Submit your page when you think you've got it right. If you're running into errors, you can check out the project completed up to this point.

Hint: `socket.io` should be a dependency.

You should correctly require and instantiate `http` as `http`.

You should correctly require and instantiate `socket.io` as `io`.

Socket.IO should be listening for connections.

Your client should connect to your server.""",
        codeSnippet: """const http = require('http').createServer(app);
const io = require('socket.io')(http);""",
        hasImage: false,
      ),
      AppLesson(
        title: """Communicate by Emitting""",
        body: """Emit is the most common way of communicating you will use. When you emit something from the server to 'io', you send an event's name and data to all the connected sockets. A good example of this concept would be emitting the current count of connected users each time a new user connects!

Start by adding a variable to keep track of the users, just before where you are currently listening for connections.

Now, when someone connects, you should increment the count before emitting the count. So, you will want to add the incrementer within the connection listener.

Finally, after incrementing the count, you should emit the event (still within the connection listener). The event should be named 'user count', and the data should just be the `currentUsers`.

Now, you can implement a way for your client to listen for this event! Similar to listening for a connection on the server, you will use the `on` keyword.

Now, try loading up your app, authenticate, and you should see in your client console '1' representing the current user count! Try loading more clients up, and authenticating to see the number go up.

Submit your page when you think you've got it right. If you're running into errors, you can check out the project completed up to this point.

Hint: `currentUsers` should be defined.

Server should emit the current user count at each new connection.

Your client should be listening for `'user count'` event.""",
        codeSnippet: """let currentUsers = 0;""",
        hasImage: false,
      ),
      AppLesson(
        title: """Handle a Disconnect""",
        body: """You may notice that up to now you have only been increasing the user count. Handling a user disconnecting is just as easy as handling the initial connect, except you have to listen for it on each socket instead of on the whole server.

To do this, add another listener inside the existing `'connect'` listener that listens for `'disconnect'` on the socket with no data passed through. You can test this functionality by just logging that a user has disconnected to the console.

To make sure clients continuously have the updated count of current users, you should decrease `currentUsers` by 1 when the disconnect happens then emit the `'user count'` event with the updated count.

**Note:** Just like `'disconnect'`, all other events that a socket can emit to the server should be handled within the connecting listener where we have 'socket' defined.

Submit your page when you think you've got it right. If you're running into errors, you can check out the project completed up to this point.

Hint: Server should handle the event disconnect from a socket.

Your client should be listening for `'user count'` event.""",
        codeSnippet: """socket.on('disconnect', () => {
  /*anything you want to do on disconnect*/
});""",
        hasImage: false,
      ),
      AppLesson(
        title: """Authentication with Socket.IO""",
        body: """Currently, you cannot determine who is connected to your web socket. While `req.user` contains the user object, that's only when your user interacts with the web server, and with web sockets you have no `req` (request) and therefore no user data. One way to solve the problem of knowing who is connected to your web socket is by parsing and decoding the cookie that contains the passport session then deserializing it to obtain the user object. Luckily, there is a package on NPM just for this that turns a once complex task into something simple!

`passport.socketio@~3.7.0`, `connect-mongo@~3.2.0`, and `cookie-parser@~1.4.5` have already been added as dependencies. Require them as `passportSocketIo`, `MongoStore`, and `cookieParser` respectively. Also, we need to initialize a new memory store, from `express-session` which we previously required. It should look like this:

Now we just have to tell Socket.IO to use it and set the options. Be sure this is added before the existing socket code and not in the existing connection listener. For your server, it should look like this:

Note that configuring Passport authentication for Socket.IO is very similar to the way we configured the `session` middleware for the API. This is because they are meant to use the same authentication method — get the session id from a cookie and validate it.

Previously, when we configured the `session` middleware, we didn't explicitly set the cookie name for session (`key`). This is because the `session` package was using the default value. Now that we've added another package which needs access to the same value from the cookies, we need to explicitly set the `key` value in both configuration objects.

Be sure to add the `key` with the cookie name to the `session` middleware that matches the Socket.IO key. Also, add the `store` reference to the options, near where we set `saveUninitialized: true`. This is necessary to tell Socket.IO which session to relate to.

Now, define the `success`, and `fail` callback functions:

The user object is now accessible on your socket object as `socket.request.user`. For example, now you can add the following:

It will log to the server console who has connected!

Submit your page when you think you've got it right. If you're running into errors, you can check out the project up to this point.

Hint: `passport.socketio` should be a dependency.

`cookie-parser` should be a dependency.

passportSocketIo should be properly required.

passportSocketIo should be properly setup.""",
        codeSnippet: """const MongoStore = require('connect-mongo')(session);
const URI = process.env.MONGO_URI;
const store = new MongoStore({ url: URI });""",
        hasImage: false,
      ),
      AppLesson(
        title: """Announce New Users""",
        body: """Many chat rooms are able to announce when a user connects or disconnects and then display that to all of the connected users in the chat. Seeing as though you already are emitting an event on connect and disconnect, you will just have to modify this event to support such a feature. The most logical way of doing so is sending 3 pieces of data with the event: the username of the user who connected/disconnected, the current user count, and if that username connected or disconnected.

Change the event name to `'user'`, and pass an object along containing the fields `username`, `currentUsers`, and `connected` (to be `true` in case of connection, or `false` for disconnection of the user sent). Be sure to change both `'user count'` events and set the disconnect one to send `false` for the field `connected` instead of `true` like the event emitted on connect.

Now your client will have all the necessary information to correctly display the current user count and announce when a user connects or disconnects! To handle this event on the client side we should listen for `'user'`, then update the current user count by using jQuery to change the text of `#num-users` to `'{NUMBER} users online'`, as well as append a `` to the unordered list with id `messages` with `'{NAME} has {joined/left} the chat.'`.

An implementation of this could look like the following:

Submit your page when you think you've got it right. If you're running into errors, you can check out the project completed up to this point .

Hint: Event `'user'` should be emitted with `username`, `currentUsers`, and `connected`.

Client should properly handle and display the new data from event `'user'`.""",
        codeSnippet: """io.emit('user', {
  username: socket.request.user.username,
  currentUsers,
  connected: true
});""",
        hasImage: false,
      ),
      AppLesson(
        title: """Send and Display Chat Messages""",
        body: """It's time you start allowing clients to send a chat message to the server to emit to all the clients! In your `client.js` file, you should see there is already a block of code handling when the message form is submitted.

Within the form submit code, you should emit an event after you define `messageToSend` but before you clear the text box `#m`. The event should be named `'chat message'` and the data should just be `messageToSend`.

Now, on your server, you should be listening to the socket for the event `'chat message'` with the data being named `message`. Once the event is received, it should emit the event `'chat message'` to all sockets using `io.emit`, sending a data object containing the `username` and `message`.

In `client.js`, you should now listen for event `'chat message'` and, when received, append a list item to `#messages` with the username, a colon, and the message!

At this point, the chat should be fully functional and sending messages across all clients!

Submit your page when you think you've got it right. If you're running into errors, you can check out the project completed up to this point.

Hint: Server should listen for `'chat message'` and then emit it properly.

Client should properly handle and display the new data from event `'chat message'`.""",
        codeSnippet: """\$('form').submit(function() {
  /*logic*/
});""",
        hasImage: false,
      ),
      AppLesson(
        title: """Metric-Imperial Converter""",
        body: """Build a full-stack JavaScript app that is functionally similar to this: https://metric-imperial-converter.freecodecamp.rocks/. Working on this project will involve you writing your code using one of the following methods:

- Clone this GitHub repo and complete your project locally.
- Use a site builder of your choice to complete the project. Be sure to incorporate all the files from our GitHub repo.

**Note:** This project's tests do not work when using `glitch.com`.

- Complete the necessary conversion logic in `/controllers/convertHandler.js`
- Complete the necessary routes in `/routes/api.js`
- Copy the `sample.env` file to `.env` and set the variables appropriately
- To run the tests automatically, add `NODE_ENV=test` in your `.env` file
- To run the tests in the console, use the command `npm run test`.

Write the following tests in `tests/1_unit-tests.js`:

- `convertHandler` should correctly read a whole number input.
- `convertHandler` should correctly read a decimal number input.
- `convertHandler` should correctly read a fractional input.
- `convertHandler` should correctly read a fractional input with a decimal.
- `convertHandler` should correctly return an error on a double-fraction (i.e. `3/2/3`).
- `convertHandler` should correctly default to a numerical input of `1` when no numerical input is provided.
- `convertHandler` should correctly read each valid input unit.
- `convertHandler` should correctly return an error for an invalid input unit.
- `convertHandler` should return the correct return unit for each valid input unit.
- `convertHandler` should correctly return the spelled-out string unit for each valid input unit.
- `convertHandler` should correctly convert `gal` to `L`.
- `convertHandler` should correctly convert `L` to `gal`.
- `convertHandler` should correctly convert `mi` to `km`.
- `convertHandler` should correctly convert `km` to `mi`.
- `convertHandler` should correctly convert `lbs` to `kg`.
- `convertHandler` should correctly convert `kg` to `lbs`.

Write the following tests in `tests/2_functional-tests.js`:

- Convert a valid input such as `10L`: `GET` request to `/api/convert`.
- Convert an invalid input such as `32g`: `GET` request to `/api/convert`.
- Convert an invalid number such as `3/7.2/4kg`: `GET` request to `/api/convert`.
- Convert an invalid number AND unit such as `3/7.2/4kilomegagram`: `GET` request to `/api/convert`.
- Convert with no number such as `kg`: `GET` request to `/api/convert`.

Hint: You can provide your own project, not the example URL.

You can `GET` `/api/convert` with a single parameter containing an accepted number and unit and have it converted. (Hint: Split the input by looking for the index of the first character which will mark the start of the unit)

You can convert `'gal'` to `'L'` and vice versa. (1 gal to 3.78541 L)

You can convert `'lbs'` to `'kg'` and vice versa. (1 lbs to 0.453592 kg)

You can convert `'mi'` to `'km'` and vice versa. (1 mi to 1.60934 km)

All incoming units should be accepted in both upper and lower case, but should be returned in both the `initUnit` and `returnUnit` in lower case, except for liter, which should be represented as an uppercase `'L'`.

If the unit of measurement is invalid, returned will be `'invalid unit'`.

If the number is invalid, returned will be `'invalid number'`.

If both the unit and number are invalid, returned will be `'invalid number and unit'`.

You can use fractions, decimals or both in the parameter (ie. 5, 1/2, 2.5/6), but if nothing is provided it will default to 1.

Your return will consist of the `initNum`, `initUnit`, `returnNum`, `returnUnit`, and `string` spelling out units in the format `'{initNum} {initUnitString} converts to {returnNum} {returnUnitString}'` with the result rounded to 5 decimals.

All 16 unit tests are complete and passing.

All 5 functional tests are complete and passing.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Issue Tracker""",
        body: """Build a full-stack JavaScript app that is functionally similar to this: https://issue-tracker.freecodecamp.rocks/. Working on this project will involve you writing your code using one of the following methods:

- Clone this GitHub repo and complete your project locally.
- Use a site builder of your choice to complete the project. Be sure to incorporate all the files from our GitHub repo.

- Complete the necessary routes in `/routes/api.js`
- Create all of the functional tests in `tests/2_functional-tests.js`
- Copy the `sample.env` file to `.env` and set the variables appropriately
- To run the tests automatically, add `NODE_ENV=test` in your `.env` file
- To run the tests in the console, use the command `npm run test`

Write the following tests in `tests/2_functional-tests.js`:

- Create an issue with every field: POST request to `/api/issues/{project}`
- Create an issue with only required fields: POST request to `/api/issues/{project}`
- Create an issue with missing required fields: POST request to `/api/issues/{project}`
- View issues on a project: GET request to `/api/issues/{project}`
- View issues on a project with one filter: GET request to `/api/issues/{project}`
- View issues on a project with multiple filters: GET request to `/api/issues/{project}`
- Update one field on an issue: PUT request to `/api/issues/{project}`
- Update multiple fields on an issue: PUT request to `/api/issues/{project}`
- Update an issue with missing `_id`: PUT request to `/api/issues/{project}`
- Update an issue with no fields to update: PUT request to `/api/issues/{project}`
- Update an issue with an invalid `_id`: PUT request to `/api/issues/{project}`
- Delete an issue: DELETE request to `/api/issues/{project}`
- Delete an issue with an invalid `_id`: DELETE request to `/api/issues/{project}`
- Delete an issue with missing `_id`: DELETE request to `/api/issues/{project}`

Hint: You can provide your own project, not the example URL.

You can send a `POST` request to `/api/issues/{projectname}` with form data containing the required fields `issue_title`, `issue_text`, `created_by`, and optionally `assigned_to` and `status_text`.

The `POST` request to `/api/issues/{projectname}` will return the created object, and must include all of the submitted fields. Excluded optional fields will be returned as empty strings. Additionally, include `created_on` (date/time), `updated_on` (date/time), `open` (boolean, `true` for open - default value, `false` for closed), and `_id`.

If you send a `POST` request to `/api/issues/{projectname}` without the required fields, returned will be the error `{ error: 'required field(s) missing' }`

You can send a `GET` request to `/api/issues/{projectname}` for an array of all issues for that specific `projectname`, with all the fields present for each issue.

You can send a `GET` request to `/api/issues/{projectname}` and filter the request by also passing along any field and value as a URL query (ie. `/api/issues/{project}?open=false`). You can pass one or more field/value pairs at once.

You can send a `PUT` request to `/api/issues/{projectname}` with an `_id` and one or more fields to update. On success, the `updated_on` field should be updated, and returned should be `{ result: 'successfully updated', '_id': _id }`.

When the `PUT` request sent to `/api/issues/{projectname}` does not include an `_id`, the return value is `{ error: 'missing _id' }`.

When the `PUT` request sent to `/api/issues/{projectname}` does not include update fields, the return value is `{ error: 'no update field(s) sent', '_id': _id }`. On any other error, the return value is `{ error: 'could not update', '_id': _id }`.

You can send a `DELETE` request to `/api/issues/{projectname}` with an `_id` to delete an issue. If no `_id` is sent, the return value is `{ error: 'missing _id' }`. On success, the return value is `{ result: 'successfully deleted', '_id': _id }`. On failure, the return value is `{ error: 'could not delete', '_id': _id }`.

All 14 functional tests are complete and passing.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Personal Library""",
        body: """Build a full-stack JavaScript app that is functionally similar to this: https://personal-library.freecodecamp.rocks/. Working on this project will involve you writing your code using one of the following methods:

- Clone this GitHub repo and complete your project locally.
- Use a site builder of your choice to complete the project. Be sure to incorporate all the files from our GitHub repo.

1. Add your MongoDB connection string to `.env` without quotes as `DB`
 Example: `DB=mongodb://admin:pass@1234.mlab.com:1234/fccpersonallib`
2. In your `.env` file set `NODE_ENV` to `test`, without quotes
3. You need to create all routes within `routes/api.js`
4. You will create all functional tests in `tests/2_functional-tests.js`

Hint: You can provide your own project, not the example URL.

You can send a POST request to `/api/books` with `title` as part of the form data to add a book. The returned response will be an object with the `title` and a unique `_id` as keys. If `title` is not included in the request, the returned response should be the string `missing required field title`.

You can send a GET request to `/api/books` and receive a JSON response representing all the books. The JSON response will be an array of objects with each object (book) containing `title`, `_id`, and `commentcount` properties.

You can send a GET request to `/api/books/{_id}` to retrieve a single object of a book containing the properties `title`, `_id`, and a `comments` array (empty array if no comments present). If no book is found, return the string `no book exists`.

You can send a POST request containing `comment` as the form body data to `/api/books/{_id}` to add a comment to a book. The returned response will be the books object similar to GET `/api/books/{_id}` request in an earlier test. If `comment` is not included in the request, return the string `missing required field comment`. If no book is found, return the string `no book exists`.

You can send a DELETE request to `/api/books/{_id}` to delete a book from the collection. The returned response will be the string `delete successful` if successful. If no book is found, return the string `no book exists`.

You can send a DELETE request to `/api/books` to delete all books in the database. The returned response will be the string `complete delete successful` if successful.

All 10 functional tests required are complete and passing.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Sudoku Solver""",
        body: """Build a full-stack JavaScript app that is functionally similar to this: https://sudoku-solver.freecodecamp.rocks/. Working on this project will involve you writing your code using one of the following methods:

- Clone this GitHub repo and complete your project locally.
- Use a site builder of your choice to complete the project. Be sure to incorporate all the files from our GitHub repo.

- All puzzle logic can go into `/controllers/sudoku-solver.js`
 - The `validate` function should take a given puzzle string and check it to see if it has 81 valid characters for the input.
 - The `check` functions should be validating against the *current* state of the board.
 - The `solve` function should handle solving any given valid puzzle string, not just the test inputs and solutions. You are expected to write out the logic to solve this.
- All routing logic can go into `/routes/api.js`
- See the `puzzle-strings.js` file in `/controllers` for some sample puzzles your application should solve
- To run the challenge tests on this page, set `NODE_ENV` to `test` without quotes in the `.env` file
- To run the tests in the console, use the command `npm run test`.

Write the following tests in `tests/1_unit-tests.js`:

- Logic handles a valid puzzle string of 81 characters
- Logic handles a puzzle string with invalid characters (not 1-9 or `.`)
- Logic handles a puzzle string that is not 81 characters in length
- Logic handles a valid row placement
- Logic handles an invalid row placement
- Logic handles a valid column placement
- Logic handles an invalid column placement
- Logic handles a valid region (3x3 grid) placement
- Logic handles an invalid region (3x3 grid) placement
- Valid puzzle strings pass the solver
- Invalid puzzle strings fail the solver
- Solver returns the expected solution for an incomplete puzzle

Write the following tests in `tests/2_functional-tests.js`

- Solve a puzzle with valid puzzle string: POST request to `/api/solve`
- Solve a puzzle with missing puzzle string: POST request to `/api/solve`
- Solve a puzzle with invalid characters: POST request to `/api/solve`
- Solve a puzzle with incorrect length: POST request to `/api/solve`
- Solve a puzzle that cannot be solved: POST request to `/api/solve`
- Check a puzzle placement with all fields: POST request to `/api/check`
- Check a puzzle placement with single placement conflict: POST request to `/api/check`
- Check a puzzle placement with multiple placement conflicts: POST request to `/api/check`
- Check a puzzle placement with all placement conflicts: POST request to `/api/check`
- Check a puzzle placement with missing required fields: POST request to `/api/check`
- Check a puzzle placement with invalid characters: POST request to `/api/check`
- Check a puzzle placement with incorrect length: POST request to `/api/check`
- Check a puzzle placement with invalid placement coordinate: POST request to `/api/check`
- Check a puzzle placement with invalid placement value: POST request to `/api/check`

Hint: You should provide your own project, not the example URL.

You can `POST` `/api/solve` with form data containing `puzzle` which will be a string containing a combination of numbers (1-9) and periods `.` to represent empty spaces. The returned object will contain a `solution` property with the solved puzzle.

If the object submitted to `/api/solve` is missing `puzzle`, the returned value will be `{ error: 'Required field missing' }`

If the puzzle submitted to `/api/solve` contains values which are not numbers or periods, the returned value will be `{ error: 'Invalid characters in puzzle' }`

If the puzzle submitted to `/api/solve` is greater or less than 81 characters, the returned value will be `{ error: 'Expected puzzle to be 81 characters long' }`

If the puzzle submitted to `/api/solve` is invalid or cannot be solved, the returned value will be `{ error: 'Puzzle cannot be solved' }`

You can `POST` to `/api/check` an object containing `puzzle`, `coordinate`, and `value` where the `coordinate` is the letter A-I indicating the row, followed by a number 1-9 indicating the column, and `value` is a number from 1-9.

The return value from the `POST` to `/api/check` will be an object containing a `valid` property, which is `true` if the number may be placed at the provided coordinate and `false` if the number may not. If false, the returned object will also contain a `conflict` property which is an array containing the strings `"row"`, `"column"`, and/or `"region"` depending on which makes the placement invalid.

If `value` submitted to `/api/check` is already placed in `puzzle` on that `coordinate`, the returned value will be an object containing a `valid` property with `true` if `value` is not conflicting.

If the puzzle submitted to `/api/check` contains values which are not numbers or periods, the returned value will be `{ error: 'Invalid characters in puzzle' }`

If the puzzle submitted to `/api/check` is greater or less than 81 characters, the returned value will be `{ error: 'Expected puzzle to be 81 characters long' }`

If the object submitted to `/api/check` is missing `puzzle`, `coordinate` or `value`, the returned value will be `{ error: 'Required field(s) missing' }`

If the coordinate submitted to `api/check` does not point to an existing grid cell, the returned value will be `{ error: 'Invalid coordinate'}`

If the `value` submitted to `/api/check` is not a number between 1 and 9, the returned value will be `{ error: 'Invalid value' }`

All 12 unit tests are complete and passing.

All 14 functional tests are complete and passing.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """American British Translator""",
        body: """Build a full-stack JavaScript app that is functionally similar to this: https://american-british-translator.freecodecamp.rocks/. Working on this project will involve you writing your code using one of the following methods:

- Clone this GitHub repo and complete your project locally.
- Use a site builder of your choice to complete the project. Be sure to incorporate all the files from our GitHub repo.

- All logic can go into `/components/translator.js`
- Complete the `/api/translate` route in `/routes/api.js`
- Create all of the unit/functional tests in `tests/1_unit-tests.js` and `tests/2_functional-tests.js`
- See the JavaScript files in `/components` for the different spelling and terms your application should translate
- To run the tests automatically, set `NODE_ENV` to `test` without quotes in the `.env` file
- To run the tests in the console, use the command `npm run test`.

Write the following tests in `tests/1_unit-tests.js`:

- Translate `Mangoes are my favorite fruit.` to British English
- Translate `I ate yogurt for breakfast.` to British English
- Translate `We had a party at my friend's condo.` to British English
- Translate `Can you toss this in the trashcan for me?` to British English
- Translate `The parking lot was full.` to British English
- Translate `Like a high tech Rube Goldberg machine.` to British English
- Translate `To play hooky means to skip class or work.` to British English
- Translate `No Mr. Bond, I expect you to die.` to British English
- Translate `Dr. Grosh will see you now.` to British English
- Translate `Lunch is at 12:15 today.` to British English
- Translate `We watched the footie match for a while.` to American English
- Translate `Paracetamol takes up to an hour to work.` to American English
- Translate `First, caramelise the onions.` to American English
- Translate `I spent the bank holiday at the funfair.` to American English
- Translate `I had a bicky then went to the chippy.` to American English
- Translate `I've just got bits and bobs in my bum bag.` to American English
- Translate `The car boot sale at Boxted Airfield was called off.` to American English
- Translate `Have you met Mrs Kalyani?` to American English
- Translate `Prof Joyner of King's College, London.` to American English
- Translate `Tea time is usually around 4 or 4.30.` to American English
- Highlight translation in `Mangoes are my favorite fruit.`
- Highlight translation in `I ate yogurt for breakfast.`
- Highlight translation in `We watched the footie match for a while.`
- Highlight translation in `Paracetamol takes up to an hour to work.`

Write the following tests in `tests/2_functional-tests.js`:

- Translation with text and locale fields: POST request to `/api/translate`
- Translation with text and invalid locale field: POST request to `/api/translate`
- Translation with missing text field: POST request to `/api/translate`
- Translation with missing locale field: POST request to `/api/translate`
- Translation with empty text: POST request to `/api/translate`
- Translation with text that needs no translation: POST request to `/api/translate`

Hint: You should provide your own project, not the example URL.

You can `POST` to `/api/translate` with a body containing `text` with the text to translate and `locale` with either `american-to-british` or `british-to-american`. The returned object should contain the submitted `text` and `translation` with the translated text.

The `/api/translate` route should handle the way time is written in American and British English. For example, ten thirty is written as "10.30" in British English and "10:30" in American English. The `span` element should wrap the entire time string, i.e. `10:30`.

The `/api/translate` route should also handle the way titles/honorifics are abbreviated in American and British English. For example, Doctor Wright is abbreviated as "Dr Wright" in British English and "Dr. Wright" in American English. See `/components/american-to-british-titles.js` for the different titles your application should handle.

Wrap any translated spelling or terms with `...` tags so they appear in green.

If one or more of the required fields is missing, return `{ error: 'Required field(s) missing' }`.

If `text` is empty, return `{ error: 'No text to translate' }`

If `locale` does not match one of the two specified locales, return `{ error: 'Invalid value for locale field' }`.

If `text` requires no translation, return `"Everything looks good to me!"` for the `translation` value.

All 24 unit tests are complete and passing.

All 6 functional tests are complete and passing.""",
        codeSnippet: null,
        hasImage: false,
      )
    ],
  ),
  AppCourse(
    id: 'scientific-computing-with-python',
    title: """Scientific Computing with Python""",
    description: """A freeCodeCamp curriculum covering Scientific Computing with Python, with 60 lessons extracted from the local curriculum assets.""",
    instructor: 'freeCodeCamp',
    category: 'Web Development',
    difficulty: 'Intermediate',
    icon: Icons.code,
    color: Colors.blue,
    duration: '4 weeks',
    lessons: [
      AppLesson(
        title: """Step 1""",
        body: """Variables are an essential part of Python and any programming language. A variable is a name that references or points to an object. You can declare a variable by writing the variable name on the left side of the assignment operator `=` and specifying the value to assign to that variable on the right side of the assignment operator:

Create a variable called `number` and assign the value `5` to your new variable.

Hint: You should declare a variable called `number`. Pay attention to place the variable name at the beginning of the line.

You should assign the value `5` to your `number` variable.

Your code contains invalid syntax and/or invalid indentation.""",
        codeSnippet: """variable_name = value""",
        hasImage: false,
      ),
      AppLesson(
        title: """Step 2""",
        body: """Variables can store values of different data types. You just assigned an integer value, but if you want to represent some text, you need to assign a string. Strings are sequences of characters enclosed by single or double quotes, but you cannot start a string with a single quote and end it with a double quote or vice versa:

Delete your `number` variable and its value. Then, declare another variable called `text` and assign the string `'Hello World'` to this variable.

Hint: You should not have `number = 5` in your code.

You should declare a variable called `text`. Pay attention to place the variable name at the beginning of the line.

You should assign the string `'Hello World'` to your `text` variable. Remember to use either single or double quotes to enclose the string and pay attention to the letter case.

Your code contains invalid syntax and/or invalid indentation.""",
        codeSnippet: """string_1 = "I am a string"
string_2 = 'I am also a string'
string_3 = 'This is not valid\"""",
        hasImage: false,
      ),
      AppLesson(
        title: """Step 3""",
        body: """You can use the built-in function `print()` to print the output of your code on the terminal.

Functions are reusable code blocks that you can call, or invoke, to run their code when you need them. To call a function, you just need to write a pair of parentheses next to its name. You will learn more about functions very soon.

For now, go to a new line and add an empty call to the `print()` function. You should not see any output yet.

Hint: You should have `print()` in your code. Pay attention to place the function call at the beginning of the line.

Your code contains invalid syntax and/or invalid indentation.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Step 4""",
        body: """An *argument* is an object or an expression passed to a function — added between the opening and closing parentheses — when it is called:

The code in the example above would print the string `'Hello!'`, which is the value of the variable `greet` passed to `print()` as the argument.

Print your `text` variable to the screen by passing the `text` variable as the argument to the `print()` function.

Hint: You should pass `text` to the `print()` function by adding the name of this variable within the opening and closing parentheses. Pay attention to place the function call at the beginning of the line.

Your code contains invalid syntax and/or invalid indentation.""",
        codeSnippet: """greet = 'Hello!'
print(greet)""",
        hasImage: false,
      ),
      AppLesson(
        title: """Step 5""",
        body: """Each string character can be referenced by a numerical index. The index count starts at zero. So the first character of a string has an index of `0`. For example, in the string `'Hello World'`, `'H'` is at index `0`, `'e'` is at index `1`, and so on. 

Each character of a string can be accessed by using bracket notation. You need to write the variable name followed by square brackets and add the index of the character between the brackets:

Now, instead of printing `text`, print just the character at index `6`.

Hint: You should still call the `print()` function.

You should pass `text[6]` to the `print()` function by including it between the parentheses. Pay attention to place the function call at the beginning of the line.

Your code contains invalid syntax and/or invalid indentation.""",
        codeSnippet: """text = 'Hello World'
r = text[8]""",
        hasImage: false,
      ),
      AppLesson(
        title: """Step 6""",
        body: """You can also access string characters starting from the end of the string. The last character has an index of `-1`, the second to last `-2` and so on.

Now modify your existing `print()` call to print the last character in your string.

Hint: You should still call the `print()` function.

You should pass `text[-1]` to the `print()` function by including it between the parentheses. Pay attention to place the function call at the beginning of the line.

Your code contains invalid syntax and/or invalid indentation.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Step 7""",
        body: """You can access the number of characters in a string with the built-in `len()` function.

Modify your existing `print()` call by passing `len(text)` instead of `text[-1]`.

Hint: You should call the `len()` function.

You should pass the variable `text` to the `len()` function by including it between the parentheses.

You should pass `len(text)` to the `print()` function by including it between the parentheses. Pay attention to place the function call at the beginning of the line.

You should not have `print(text[-1])` in your code.

Your code contains invalid syntax and/or invalid indentation.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Step 8""",
        body: """You can see `11` printed on the terminal because `'Hello World'` contains 11 characters.

Another useful built-in function is `type()`, which returns the data type of a variable. Modify your `print()` call to print the data type of `text`.

Hint: You should call the `type()` function.

You should pass `text` to the `type()` function by including it between the parentheses.

You should pass `type(text)` to the `print()` function by including it between the parentheses. Pay attention to place the function call at the beginning of the line.

You should not have `print(len(text))` in your code.

Your code contains invalid syntax and/or invalid indentation.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Step 9""",
        body: """As you can see, the output of printing `type(text)` is ``, which means that your variable is a string, indicated as `str`.

Now go to a new line and create another variable called `shift` and assign the value `3` to this variable.

Hint: You should declare a variable called `shift`. Pay attention to place the variable name at the beginning of the line.

You should assign the value `3` to your `shift` variable.

Your code contains invalid syntax and/or invalid indentation.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Step 10""",
        body: """And now print your new variable.

Hint: You should not remove your existing `print(type(text))` call.

You should call the `print()` function passing in the `shift` variable. Pay attention to place the function call at the beginning of the line.

Your code contains invalid syntax and/or invalid indentation.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Step 11""",
        body: """Modify your `print(shift)` call to print the data type of your `shift` variable.

Hint: You should keep your existing `print(type(text))` call.

You should pass `shift` to the `type()` function.

You should pass `type(shift)` to your `print()` function. Pay attention to place the function call at the beginning of the line.

You should not have `print(shift)` in your code.

Your code contains invalid syntax and/or invalid indentation.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Step 12""",
        body: """Key aspects of variable naming in Python are:

- Some words are reserved keywords (e.g. `for`, `while`, `True`). They have a special meaning in Python, so you cannot use them for variable names.
- Variable names cannot start with a number, and they can only contain alpha-numeric characters or underscores.
- Variable names are case sensitive, i.e. `my_var` is different from `my_Var` and `MY_VAR`.
- Finally, it is a common convention to write variable names using `snake_case`, where each space is replaced by an underscore character and the words are written in lowercase letters.

Remove both calls to `print()` and declare another variable called `alphabet`. Assign the string `'abcdefghijklmnopqrstuvwxyz'` to this variable.

Hint: You should not have `print(type(text))` in your code.

You should not have `print(type(shift))` in your code.

You should declare a variable called `alphabet`. Pay attention to place the variable name at the beginning of the line.

You should assign the string `'abcdefghijklmnopqrstuvwxyz'` to your `alphabet` variable. Remember to use either single or double quotes to enclose the string.

Your code contains invalid syntax and/or invalid indentation.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Step 13""",
        body: """You are going to use the `.find()` method to find the position in the alphabet of each letter in your message. A method is similar to a function, but it belongs to an object.

Above, the `.find()` method is *called on* `sentence` (the string to search in), and `'r'` (the character to locate) is passed as the argument. The `sentence.find('r')` call will return `4`, which is the index of the first occurrence of `'r'` in `sentence`.

At the end of your code, call `.find()` on `alphabet` and pass `'z'` as the argument to the method.

Hint: You should call the `.find()` method.

You should call the `.find()` method on the `alphabet` variable.

You should call the `.find()` method on the `alphabet` variable and pass `'z'` to the method. Pay attention to place the method call at the beginning of the line.

Your code contains invalid syntax and/or invalid indentation.""",
        codeSnippet: """sentence = 'My brain hurts!'
sentence.find('r')""",
        hasImage: false,
      ),
      AppLesson(
        title: """Step 14""",
        body: """The first kind of cipher you are going to build is called a *Caesar* cipher. Specifically, you will take each letter in your message, find its position in the alphabet, take the letter located after 3 positions in the alphabet, and replace the original letter with the new letter.

To implement this, you will use the `.find()` method discussed in the previous step. Modify your existing `.find()` call passing it `text[0]` as the argument instead of `'z'`.

Hint: You should modify your existing `alphabet.find('z')` call passing `text[0]` to the method.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Step 15""",
        body: """The `print()` function gives you only an output in the console, but functions and methods can have a return value that you can use in your code.

Now assign `alphabet.find(text[0])` to a variable named `index`. In this way, `index` will store the value returned by `alphabet.find(text[0])`.

Hint: You should declare a variable named `index`. Pay attention to place the variable name at the beginning of the line.

You should assign the value returned by `alphabet.find(text[0])` to your `index` variable.

Your code contains invalid syntax and/or invalid indentation.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Step 16""",
        body: """Next, print the `index` variable to the console.

Hint: You should print your `index` variable. Pay attention to place the function call at the beginning of the line.

Your code contains invalid syntax and/or invalid indentation.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Step 17""",
        body: """`.find()` returns the index of the matching character inside the string. If the character is not found, it returns `-1`. As you can see, the first character in `text`, uppercase `'H'`, is not found, since `alphabet` contains only lowercase letters.

You can transform a string into its lowercase equivalent with the `.lower()` method. Add another `print()` call to print `text.lower()` and see the output.

Hint: You should still have `print(index)` in your code. Pay attention to have the function call at the beginning of the line.

You should print `text.lower()`. Pay attention to place the function call at the beginning of the line.

Your code contains invalid syntax and/or invalid indentation.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Step 18""",
        body: """Remove the last `print()` call. Then, instead of `text[0]`, pass `text[0].lower()` as the argument to your `.find()` call and see the output.

Hint: You should not have `print(text.lower())` in your code.

You should still print your `index` variable.

You should update your `alphabet.find(text[0])` call to use `text[0].lower()` as the argument. Pay attention to place the method call at the beginning of the line.

Your code contains invalid syntax and/or invalid indentation.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Step 19""",
        body: """Declare a new variable named `shifted`. Use the bracket notation to access the value of `alphabet` at index `index` and assign it to your new variable.

Hint: You should declare a variable named `shifted`. Pay attention to place the variable name at the beginning of the line.

You should assign `alphabet[index]` to your `shifted` variable.

Your code contains invalid syntax and/or invalid indentation.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Step 20""",
        body: """Print your `shifted` variable.

Hint: You should print your `shifted` variable. Pay attention to place the function call at the beginning of the line.

Your code contains invalid syntax and/or invalid indentation.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Step 21""",
        body: """As you can see from the output, `'h'` is at index `7` in the `alphabet` string. Now you need to find the letter at index `7` plus the value of `shift`. For that, you can use the addition operator, `+`, in the same way you would use it for a mathematical addition.

Modify your `shifted` variable so that it stores the value of `alphabet` at index `index + shift`.

Hint: You should assign `alphabet[index + shift]` to your `shifted` variable.

Your code contains invalid syntax and/or invalid indentation.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Step 22""",
        body: """Repeating the process of locating the letter inside the alphabet and determine the shifted letter for each character in `text` can be tedious. Thankfully, you can simplify it using a loop.

For now, remove all the lines of code below the declaration of the `alphabet` variable.

Hint: You should still have `text = 'Hello World'` in your code.

You should still have `shift = 3` in your code.

You should still have `alphabet = 'abcdefghijklmnopqrstuvwxyz'` in your code.

You should delete `index` variable and its value.

You should not have `print(index)` in your code.

You should delete the `shifted` variable and its value.

You should not have `print(shifted)` in your code.

Your code contains invalid syntax and/or invalid indentation.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Step 23""",
        body: """A loop allows you to systematically go through a sequence of elements and execute actions on each one.

In this case, you'll employ a `for` loop. Here's how you can iterate over `text`:

`for` is the keyword denoting the loop type. `i` is a variable that sequentially takes the value of the elements in `text`. The statement ends with a colon, `:`.

Below the line where you declared `alphabet`, write a `for` loop to iterate over `text`. Use `i` as the loop variable.

Doing so, there is an error in the terminal. You will learn about it in the next step.

Hint: You should use the `for` keyword to create a loop. Make sure to place the `for` keyword at the beginning of the line and leave a white space after the keyword.

You should write the `i` variable after the `for` keyword.

You should write the `in` keyword after `for i `. Make sure to leave a space around the `in` keyword.

You should write `text` after `for i in `. Don't forget to add the final `:`.

Your `for` loop should be placed below the line of code `alphabet = 'abcdefghijklmnopqrstuvwxyz'`.""",
        codeSnippet: """for i in text:""",
        hasImage: false,
      ),
      AppLesson(
        title: """Step 24""",
        body: """The code to execute at each iteration — placed after the `:` — constitutes the body of the loop. This code must be indented. In Python, it is recommended to use 4 spaces per indentation level. This indented level is a code block.

Python relies on indentation to indicate blocks of code. A colon at the end of a line is a signal that a new indented block of code will follow.

So, when no indented block is found after the final colon, the code execution stops and an `IndentationError` is thrown. This code will not show the output and instead raise an `IndentationError`:

Give your `for` loop a body by adding a call to `print(i)`. Remember to indent the loop body.

Hint: You should add `print(i)` to your `for` loop body. Pay attention to the indentation. 

Your code contains invalid syntax and/or invalid indentation.""",
        codeSnippet: """for i in text:
    print(i)""",
        hasImage: false,
      ),
      AppLesson(
        title: """Step 25""",
        body: """The iteration variable can have any valid name, but it's convenient to give it a meaningful name.

Rename your `i` variable to `char`.

Hint: You should replace `i` with `char`. 

Your code contains invalid syntax and/or invalid indentation.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Step 26""",
        body: """Inside the `for` loop, before printing the current character, declare a variable called `index` and assign the value returned by `alphabet.find(char)` to this variable.

Hint: You should declare a new variable named `index` at the beginning of your `for` loop.

You should assign `alphabet.find(char)` to your new `index` variable.

Your code contains invalid syntax and/or invalid indentation.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Step 27""",
        body: """Currently, the `print()` function is taking a single argument `char`, but it can take multiple arguments, separated by a comma.

Add a second argument to `print(char)` so that it prints the character and its index inside the alphabet.

Hint: You should add `index` as the second argument to your existing `print(char)` call. Don't forget to separate the arguments with a comma.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Step 28""",
        body: """`find` is again returning `-1` for uppercase letters, and for the space character, too. You are going to take care of the space later on.

For now, instead of iterating over `text`, change the `for` loop to iterate over `text.lower()`.

Hint: You should modify your `for` loop to iterate over `text.lower()` instead of `text`.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Step 29""",
        body: """At the end of your loop body, declare a variable called `new_index` and assign the value of `index + shift` to this variable.

Hint: You should declare a variable called `new_index` inside your `for` loop.

You should assign `index + shift` to your new variable at the end of your `for` loop body.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Step 30""",
        body: """Strings are immutable, which means they cannot be changed once created. For example, you might think that the following code changes the value of `my_string` into the string `'train'`, but this is not valid:

Confirm that by using the bracket notation to access the first letter in `text` and try to change it into a character of your choice. You will see the output disappear and an error appear.

Hint: You should still have `text = 'Hello World'` in your code.

You should access the first letter in `text` with `text[0]`.

You should use the `=` operator to assign a character of your choice to `text[0]`. Don't forget to enclose the character in either single or double quotes.""",
        codeSnippet: """my_string = 'brain'
my_string[0] = 't'""",
        hasImage: false,
      ),
      AppLesson(
        title: """Step 31""",
        body: """When you try to change the individual characters of a string as you did in the previous step, you get a `TypeError`, which occurs when an object of inappropriate type is used in your code.

As you can see from the error message, strings do not support item assignment, because they are immutable. However, a variable can be reassigned another string:

Delete the `text[0]` line and reassign `text` the string `'Albatross'`.

Hint: You should not have `text[0] = 'C'` in your code.

You should reassign `text` the string `'Albatross'`. Do not modify `text = 'Hello World'`.""",
        codeSnippet: """message = 'Hello World'
message = 'Hello there!'""",
        hasImage: false,
      ),
      AppLesson(
        title: """Step 32""",
        body: """As you can see, each character of the reassigned string gets printed inside the loop.

Go back to the original string by deleting the `text` reassignment.

Hint: You should not have `text = 'Albatross'` in your code.

You should still have a `text` variable with the value `'Hello World'`.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Step 33""",
        body: """Now you need to create a `new_char` variable at the end of your loop body. Set its value to `alphabet[new_index]`.

Hint: You should create a `new_char` variable inside your `for` loop.

You should set your `new_char` variable to `alphabet[new_index]` at the end of your loop body.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Step 34""",
        body: """Next, print `new_char` and see the output.

Hint: You should print your `new_char` variable.

You should print your `new_char` variable at the end of your loop body.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Step 35""",
        body: """Clean the output a bit. Delete `print(char, index)`, and turn the last `print()` call into `print('char:', char, 'new char:', new_char)`.

Hint: You should not have `print(char, index)` in your code.

You should change `print(new_char)` into `print('char:', char, 'new char:', new_char)`.

Your code contains invalid syntax and/or invalid indentation.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Step 36""",
        body: """At the moment, the encrypted character is updated in every iteration. It would be better to store the encrypted string in a new variable. Before your `for` loop, declare a variable called `encrypted_text` and assign an empty string (`''`) to this variable.

Hint: You should declare a variable called `encrypted_text` before your `for` loop.

You should assign an empty string to your `encrypted_text` variable.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Step 37""",
        body: """Now, replace `new_char` with `encrypted_text`. Also, modify the `print()` call into `print('char:', char, 'encrypted text:', encrypted_text)` to reflect this change.

Hint: You should replace `new_char` with `encrypted_text` inside your `for` loop.

You should turn your `print()` call into `print('char:', char, 'encrypted text:', encrypted_text)` inside your `for` loop.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Step 38""",
        body: """Instead of assigning `alphabet[new_index]` to `encrypted_text`, assign the current value of `encrypted_text` plus `alphabet[new_index]` to this variable.

Hint: You should assign `encrypted_text + alphabet[new_index]` to your `encrypted_text` variable.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Step 39""",
        body: """You can obtain the same effect of `a = a + b` by using the addition assignment operator:

The addition assignment operator enables you to add a value to a variable and then assign the result to that variable.

Use the `+=` operator to add a value and assign it at the same time to `encrypted_text`.

Hint: You should use the addition assignment operator to add `alphabet[new_index]` to the current value of `encrypted_text` inside your loop body.""",
        codeSnippet: """a += b""",
        hasImage: false,
      ),
      AppLesson(
        title: """Step 40""",
        body: """Comparison operators allow you to compare two objects based on their values. You can use a comparison operator by placing it between the objects you want to compare.
They return a *Boolean* value — namely `True` or `False` — depending on the truthfulness of the expression.

Python has the following comparison operators:

 
 
 Operator
 Meaning
 
 
 
 
 ==
 Equal
 
 
 !=
 Not equal
 
 
 &gt;
 Greater than
 
 
 &lt;
 Less than
 
 
 &gt;=
 Greater than or equal to
 
 
 &lt;=
 Less than or equal to
 
 

At the beginning of your loop body, print the result of comparing `char` with a space (`' '`). Use the equality operator `==` for that.

Hint: You should compare `char` with a space using the equality operator inside your `for` loop.

You should print the result of comparing `char` with a space inside your `for` loop.

You should print the result of comparing `char` with a space at the beginning of your loop.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Step 41""",
        body: """Currently, spaces get encrypted as `'c'`. To maintain the original spacing in the plain message, you'll require a conditional `if` statement. This is composed of the `if` keyword, a condition, and a colon `:`.

In the example above, the condition of the `if` statement is `x != 0`. The code `print(x)`, inside the `if` statement body, runs only when the condition evaluates to `True` (in this example, meaning that `x` is different from zero).

At the top of your for loop, replace `print(char == ' ')` with an `if` statement. The condition of this `if` statement should evaluate to `True` if `char` is an empty space and `False` otherwise. Inside the `if` body, print the string `'space!'`. Remember to indent this line.

Hint: You should not have `print(char == ' ')` in your code.

You should replace `print(char == ' ')` with an `if` statement that triggers when `char == ' '`. Do not use parentheses to enclose the `if` condition and remember to include the final colon.

You should print the string `'space!'` inside your new `if` statement.

Your code contains invalid syntax and/or invalid indentation.""",
        codeSnippet: """if x != 0:
    print(x)""",
        hasImage: false,
      ),
      AppLesson(
        title: """Step 42""",
        body: """Now, instead of printing `'space!'`, use the addition assignment operator to add the space (currently stored in `char`) to the current value of `encrypted_text`.

Hint: You should not have `print('space!')` in your code.

You should use the `+=` operator to add `char` to the current value of `encrypted_text` inside your new `if` statement.

Your code contains invalid syntax and/or invalid indentation.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Step 43""",
        body: """A conditional statement can also have an `else` clause. This clause can be added to the end of an `if` statement to execute alternative code if the condition of the `if` statement is false:

As you can see in your output, when the loop iterations reach the space, a space is added to the encrypted string. Then the code outside the `if` block executes and a `c` is added to the encrypted string.

To fix it, add an `else` clause after `encrypted_text += char` and indent all the subsequent lines of code except the `print()` call.

Hint: You should create an `else` clause. Remember to include the final colon.

You should indent the lines of code after your `else` clause except the `print()` call.

Your code contains invalid syntax and/or invalid indentation.""",
        codeSnippet: """if x != 0:
    print(x)
else:
    print('x = 0')""",
        hasImage: false,
      ),
      AppLesson(
        title: """Step 44""",
        body: """Try to assign the string `'Hello Zaira'` to your `text` variable and see what happens in the terminal.

You'll see a `string index out of range` exception. Don't worry, you'll figure out how to fix it soon!

Hint: You should have a `text` variable.

You should assign the string `'Hello Zaira'` to your `text` variable.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Step 45""",
        body: """When the loop reaches the letter `Z`, the sum `index + shift` exceeds the last index of the string `alphabet`. Therefore, `alphabet[new_index]` is trying to use an invalid index, which causes an `IndexError` to be thrown.

You can notice that the output in the terminal stops at the space immediately before the `Z`, the last `print` before the error is thrown.

In this case, the modulo operator (`%`) can be used to return the remainder of the division between two numbers. For example: `5 % 2` is equal to `1`, because 5 divided by 2 has a quotient of 2 and a remainder of 1.

Surround `index + shift` with parentheses, and modulo the expression with `26`, which is the `alphabet` length.

Hint: You should have `new_index = (index + shift) % 26` in your `else` statement.

Your code contains invalid syntax and/or invalid indentation.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Step 46""",
        body: """If you wish to incorporate additional characters into the `alphabet` string, such as digits or special characters, you'll find it's necessary to manually modify the right operand of the modulo operation.

Replace `26` with `len(alphabet)` to avoid this issue.

Hint: You should modify the `new_index` value replacing `26` with `len(alphabet)`.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Step 47""",
        body: """Next, modify your `print()` call to print `'encrypted text:', encrypted_text` and put it outside the `for` loop, so that the encrypted string is printed one time.

Hint: You should print `'encrypted text:', encrypted_text` after your for loop.

You should not have `print('char:', char, 'encrypted text:', encrypted_text)` in your code.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Step 48""",
        body: """Right before the `print` call, add another one and pass `'plain text:', text` as the arguments to `print()`. Use the same indentation.

Hint: You should print `'plain text:', text` after your for loop.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Step 49""",
        body: """A function is essentially a reusable block of code. You have already met some built-in functions, like `print()`, `find()` and `len()`. But you can also define custom functions like this:

A function declaration starts with the `def` keyword followed by the function name — a valid variable name — and a pair of parentheses. The declaration ends with a colon.

Right after your `shift` variable, declare a function called `caesar` and indent all the following lines to give your new function a body.

Hint: You should use the `def` keyword to declare a new function.

You should write `caesar` as the function name after the `def` keyword. Remember to add a space after `def`.

You should add a pair of parentheses after the function name. Don't forget the final colon.

You should indent all the lines after `shift = 3` so that they become your new function body.""",
        codeSnippet: """def function_name():
    <code>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Step 50""",
        body: """In Python, the *scope* of a variable determines where that variable can be accessed:

- Variables defined outside a function have a *global* scope and they can be accessed from any part of your code.

- Variables defined inside a function are *local* to that function and cannot be accessed outside of it.

To see this in action, try to print the `alphabet` variable at the end of your code. This will raise a `NameError` exception.

You should see an error message indicating that `alphabet` is not defined. This is because `alphabet` is defined inside the `caesar` function and is not accessible outside of it.

Hint: You should attempt to print the `alphabet` variable outside the caesar function.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Step 51""",
        body: """Now, fix the error by removing the line that tries to print the `alphabet` variable outside of the `caesar` function.

Hint: You should remove the `print(alphabet)` line.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Step 52""",
        body: """To execute, a function needs to be called (or invoked) by appending a pair of parentheses after its name, like this:

At the end of your code, call your `caesar` function. Pay attention to the indentation.

Hint: You should call your `caesar` function. Make sure to write the function call at the beginning of the line.""",
        codeSnippet: """function_name()""",
        hasImage: false,
      ),
      AppLesson(
        title: """Step 53""",
        body: """Now you should see the output again. Although this approach works, it doesn't significantly enhance the code's reusability. Repeatedly calling your function will result in the same outcome. However, functions can be declared with *parameters* to introduce versatility and customization:

Parameters are variables that you can use inside your function. A function can be declared with different number of parameters. In the example above, `param_1` and `param_2` are parameters.

Modify your function declaration so that it takes two parameters called `message` and `offset`.

After that, you'll see an error appear in the terminal. You'll see how to solve it in the next steps.

Hint: Your `caesar` function should take `message` and `offset` as the parameters. Remember to separate the parameters with a comma.""",
        codeSnippet: """def function_name(param_1, param_2):
    <code>""",
        hasImage: false,
      ),
      AppLesson(
        title: """Step 54""",
        body: """Inside your function body, rename the `text` and `shift` variables to `message` and `offset`, respectively.

Hint: You should rename all occurrences of `text` to `message`.

You should rename `shift` to `offset`.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Step 55""",
        body: """Currently, your code raises a `TypeError`, because the `caesar` function is defined with two parameters (`message` and `offset`), therefore it expects to be called with two *arguments*.

Calling `caesar()` without the required arguments stops the execution of the code.

Give `message` and `offset` values, by passing `text` and `shift` as arguments to the `caesar` function call.

Hint: You should pass `text` and `shift` as the arguments to your function call by including them inside the parentheses. Don't forget to separate the arguments with a comma.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Step 56""",
        body: """At the bottom of your code, after your existing `caesar(text, shift)` call, call your function again.

This time, pass the `text` variable and the integer `13` as arguments.

Hint: You should call your function again, this time passing `text` and `13` as arguments.

You should keep the existing function call.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Step 57""",
        body: """Currently, every single letter is always encrypted with the same letter, depending on the specified offset. What if the offset were different for each letter? That would be much more difficult to decrypt. This algorithm is referred to as the Vigenère cipher, where the offset for each letter is determined by another text, called the *key*.

Start transforming your Caesar cipher into a Vigenère cipher by removing the two function calls.

Hint: You should remove your two `caesar()` function calls.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Step 58""",
        body: """Now modify your function declaration: change the function name into `vigenere` and the second parameter into `key`.

Hint: You should modify your function name into `vigenere`.

Your `vigenere` function should take `message` and `key` as the parameters.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Step 59""",
        body: """Delete your `shift` variable. Then, declare a new variable called `custom_key` and assign the value of the string `'python'` to this variable.

Hint: You should delete the `shift` variable and its value.

You should declare a variable called `custom_key`.

You should assign the string `'python'` to your `custom_key` variable.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Step 60""",
        body: """Since your key is shorter than the text that you will have to encrypt, you will need to repeat it to generate the whole encrypted text.
At the beginning of your function body, declare a `key_index` variable and set it to zero.

Hint: You should declare a variable called `key_index` at the beginning of your function body.

You should assign `0` to your `key_index` variable.

Your code contains invalid syntax and/or invalid indentation.""",
        codeSnippet: null,
        hasImage: false,
      )
    ],
  ),
  AppCourse(
    id: 'data-analysis-with-python',
    title: """Data Analysis with Python""",
    description: """A freeCodeCamp curriculum covering Data Analysis with Python, with 42 lessons extracted from the local curriculum assets.""",
    instructor: 'freeCodeCamp',
    category: 'Web Development',
    difficulty: 'Intermediate',
    icon: Icons.code,
    color: Colors.blue,
    duration: '4 weeks',
    lessons: [
      AppLesson(
        title: """Introduction to Data Analysis""",
        body: """Data analysis is the act of turning raw, messy data into useful insights by cleaning the data up, transforming it, manipulating it, and inspecting it.

More resources:

\\- News article""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Data Analysis Example A""",
        body: """*Instead of using notebooks.ai like it shows in the video, you can use Google Colab instead.*

More resources:

- Notebooks on GitHub
- How to open Notebooks from GitHub using Google Colab.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Data Analysis Example B""",
        body: """*Instead of using notebooks.ai like it shows in the video, you can use Google Colab instead.*

More resources:

- Notebooks on GitHub
- How to open Notebooks from GitHub using Google Colab.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """How to use Jupyter Notebooks Intro""",
        body: """*Instead of using notebooks.ai like it shows in the video, you can use Google Colab instead.*

More resources:

- Notebooks on GitHub
- How to open Notebooks from GitHub using Google Colab.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Jupyter Notebooks Cells""",
        body: """*Instead of using notebooks.ai like it shows in the video, you can use Google Colab instead.*

More resources:

- Notebooks on GitHub
- How to open Notebooks from GitHub using Google Colab.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Jupyter Notebooks Importing and Exporting Data""",
        body: """*Instead of using notebooks.ai like it shows in the video, you can use Google Colab instead.*

More resources:

- Notebooks on GitHub
- How to open Notebooks from GitHub using Google Colab.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Numpy Introduction A""",
        body: """*Instead of using notebooks.ai like it shows in the video, you can use Google Colab instead.*

More resources:

- Notebooks on GitHub
- How to open Notebooks from GitHub using Google Colab.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Numpy Introduction B""",
        body: """*Instead of using notebooks.ai like it shows in the video, you can use Google Colab instead.*

More resources:

- Notebooks on GitHub
- How to open Notebooks from GitHub using Google Colab.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Numpy Arrays""",
        body: """*Instead of using notebooks.ai like it shows in the video, you can use Google Colab instead.*

More resources:

- Notebooks on GitHub
- How to open Notebooks from GitHub using Google Colab.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Numpy Operations""",
        body: """*Instead of using notebooks.ai like it shows in the video, you can use Google Colab instead.*

More resources:

- Notebooks on GitHub
- How to open Notebooks from GitHub using Google Colab.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Numpy Boolean Arrays""",
        body: """*Instead of using notebooks.ai like it shows in the video, you can use Google Colab instead.*

More resources:

- Notebooks on GitHub
- How to open Notebooks from GitHub using Google Colab.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Numpy Algebra and Size""",
        body: """*Instead of using notebooks.ai like it shows in the video, you can use Google Colab instead.*

More resources:

- Notebooks on GitHub
- How to open Notebooks from GitHub using Google Colab.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Pandas Introduction""",
        body: """*Instead of using notebooks.ai like it shows in the video, you can use Google Colab instead.*

More resources:

- Notebooks on GitHub
- How to open Notebooks from GitHub using Google Colab.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Pandas Indexing and Conditional Selection""",
        body: """*Instead of using notebooks.ai like it shows in the video, you can use Google Colab instead.*

More resources:

- Notebooks on GitHub
- How to open Notebooks from GitHub using Google Colab.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Pandas DataFrames""",
        body: """*Instead of using notebooks.ai like it shows in the video, you can use Google Colab instead.*

More resources:

- Notebooks on GitHub
- How to open Notebooks from GitHub using Google Colab.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Pandas Conditional Selection and Modifying DataFrames""",
        body: """*Instead of using notebooks.ai like it shows in the video, you can use Google Colab instead.*

More resources:

- Notebooks on GitHub
- How to open Notebooks from GitHub using Google Colab.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Pandas Creating Columns""",
        body: """*Instead of using notebooks.ai like it shows in the video, you can use Google Colab instead.*

More resources:

- Notebooks on GitHub
- How to open Notebooks from GitHub using Google Colab.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Data Cleaning Introduction""",
        body: """*Instead of using notebooks.ai like it shows in the video, you can use Google Colab instead.*

More resources:

- Notebooks on GitHub
- How to open Notebooks from GitHub using Google Colab.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Data Cleaning with DataFrames""",
        body: """*Instead of using notebooks.ai like it shows in the video, you can use Google Colab instead.*

More resources:

- Notebooks on GitHub
- How to open Notebooks from GitHub using Google Colab.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Data Cleaning Duplicates""",
        body: """*Instead of using notebooks.ai like it shows in the video, you can use Google Colab instead.*

More resources:

- Notebooks on GitHub
- How to open Notebooks from GitHub using Google Colab.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Data Cleaning and Visualizations""",
        body: """*Instead of using notebooks.ai like it shows in the video, you can use Google Colab instead.*

More resources:

- Notebooks on GitHub
- How to open Notebooks from GitHub using Google Colab.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Reading Data Introduction""",
        body: """*Instead of using notebooks.ai like it shows in the video, you can use Google Colab instead.*

More resources:

- Notebooks on GitHub
- How to open Notebooks from GitHub using Google Colab.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Reading Data CSV and TXT""",
        body: """*Instead of using notebooks.ai like it shows in the video, you can use Google Colab instead.*

More resources:

- Notebooks on GitHub
- How to open Notebooks from GitHub using Google Colab.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Reading Data from Databases""",
        body: """*Instead of using notebooks.ai like it shows in the video, you can use Google Colab instead.*

More resources:

- Notebooks on GitHub
- How to open Notebooks from GitHub using Google Colab.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Parsing HTML and Saving Data""",
        body: """*Instead of using notebooks.ai like it shows in the video, you can use Google Colab instead.*

More resources:

- Notebooks on GitHub
- How to open Notebooks from GitHub using Google Colab.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Python Introduction""",
        body: """*Instead of using notebooks.ai like it shows in the video, you can use Google Colab instead.*

More resources:

- Notebooks on GitHub
- How to open Notebooks from GitHub using Google Colab.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Python Functions and Collections""",
        body: """*Instead of using notebooks.ai like it shows in the video, you can use Google Colab instead.*

More resources:

- Notebooks on GitHub
- How to open Notebooks from GitHub using Google Colab.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Python Iteration and Modules""",
        body: """*Instead of using notebooks.ai like it shows in the video, you can use Google Colab instead.*

More resources:

- Notebooks on GitHub
- How to open Notebooks from GitHub using Google Colab.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """What is NumPy""",
        body: """What is NumPy""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Basics of Numpy""",
        body: """Basics of Numpy""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Accessing and Changing Elements, Rows, Columns""",
        body: """Accessing and Changing Elements, Rows, Columns""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Initializing Different Arrays""",
        body: """Initializing Different Arrays""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Initialize Array Problem""",
        body: """Initialize Array Problem""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Copying Arrays Warning""",
        body: """Copying Arrays Warning""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Mathematics""",
        body: """Mathematics""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Reorganizing Arrays""",
        body: """Reorganizing Arrays""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Loading Data and Advanced Indexing""",
        body: """Loading Data and Advanced Indexing""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Mean-Variance-Standard Deviation Calculator""",
        body: """You will be working on this project with our Ona starter code.

We are still developing the interactive instructional part of the Python curriculum. For now, here are some videos on the freeCodeCamp.org YouTube channel that will teach you everything you need to know to complete this project:

- Python for Everybody Video Course (14 hours)

- How to Analyze Data with Python Pandas (10 hours)

Create a function named `calculate()` in `mean_var_std.py` that uses Numpy to output the mean, variance, standard deviation, max, min, and sum of the rows, columns, and elements in a 3 x 3 matrix.

The input of the function should be a list containing 9 digits. The function should convert the list into a 3 x 3 Numpy array, and then return a dictionary containing the mean, variance, standard deviation, max, min, and sum along both axes and for the flattened matrix.

The returned dictionary should follow this format:

If a list containing less than 9 elements is passed into the function, it should raise a `ValueError` exception with the message: "List must contain nine numbers." The values in the returned dictionary should be lists and not Numpy arrays.

For example, `calculate([0,1,2,3,4,5,6,7,8])` should return:

## Development

Write your code in `mean_var_std.py`. For development, you can use `main.py` to test your code. In 
order to run your code, type `python3 main.py` into the Ona terminal and hit enter. This will cause the included CPython interpreter to run the `main.py` file. 

## Testing

The unit tests for this project are in `test_module.py`. We imported the tests from `test_module.py` to `main.py` for your convenience.

## Submitting

Copy your project's URL and submit it to freeCodeCamp.

Hint: It should pass all Python tests.""",
        codeSnippet: """  # Python challenges don't need solutions,
  # because they would need to be tested against a full working project.
  # Please check our contributing guidelines to learn more.""",
        hasImage: false,
      ),
      AppLesson(
        title: """Demographic Data Analyzer""",
        body: """You will be working on this project with our Ona starter code.

We are still developing the interactive instructional part of the Python curriculum. For now, here are some videos on the freeCodeCamp.org YouTube channel that will teach you everything you need to know to complete this project:

- Python for Everybody Video Course (14 hours)

- How to Analyze Data with Python Pandas (10 hours)

In this challenge you must analyze demographic data using Pandas. You are given a dataset of demographic data that was extracted from the 1994 Census database. Here is a sample of what the data looks like:

You must use Pandas to answer the following questions:

- How many people of each race are represented in this dataset? This should be a Pandas series with race names as the index labels. (`race` column)
- What is the average age of men?
- What is the percentage of people who have a Bachelor's degree?
- What percentage of people with advanced education (`Bachelors`, `Masters`, or `Doctorate`) make more than 50K?
- What percentage of people without advanced education make more than 50K?
- What is the minimum number of hours a person works per week?
- What percentage of the people who work the minimum number of hours per week have a salary of more than 50K?
- What country has the highest percentage of people that earn >50K and what is that percentage?
- Identify the most popular occupation for those who earn >50K in India.

Use the starter code in the file `demographic_data_analyzer.py`. Update the code so all variables set to `None` are set to the appropriate calculation or code. Round all decimals to the nearest tenth.

## Development

Write your code in `demographic_data_analyzer.py`. For development, you can use `main.py` to test your code.

## Testing

The unit tests for this project are in `test_module.py`. We imported the tests from `test_module.py` to `main.py` for your convenience.

## Submitting

Copy your project's URL and submit it to freeCodeCamp.

## Dataset Source

Dua, D. and Graff, C. (2019). UCI Machine Learning Repository. Irvine, CA: University of California, School of Information and Computer Science.

Hint: It should pass all Python tests.""",
        codeSnippet: """  # Python challenges don't need solutions,
  # because they would need to be tested against a full working project.
  # Please check our contributing guidelines to learn more.""",
        hasImage: false,
      ),
      AppLesson(
        title: """Medical Data Visualizer""",
        body: """You will be working on this project with our Ona starter code.

We are still developing the interactive instructional part of the Python curriculum. For now, here are some videos on the freeCodeCamp.org YouTube channel that will teach you everything you need to know to complete this project:

- Python for Everybody Video Course (14 hours)

- How to Analyze Data with Python Pandas (10 hours)

In this project, you will visualize and make calculations from medical examination data using `matplotlib`, `seaborn`, and `pandas`. The dataset values were collected during medical examinations.

## Data description

The rows in the dataset represent patients and the columns represent information like body measurements, results from various blood tests, and lifestyle choices. You will use the dataset to explore the relationship between cardiac disease, body measurements, blood markers, and lifestyle choices.

File name: medical_examination.csv

| Feature | Variable Type | Variable | Value Type |
|:-------:|:------------:|:-------------:|:----------:|
| Age | Objective Feature | `age` | int (days) |
| Height | Objective Feature | `height` | int (cm) |
| Weight | Objective Feature | `weight` | float (kg) |
| Gender | Objective Feature | `gender` | categorical code |
| Systolic blood pressure | Examination Feature | `ap_hi` | int |
| Diastolic blood pressure | Examination Feature | `ap_lo` | int |
| Cholesterol | Examination Feature | `cholesterol` | 1: normal, 2: above normal, 3: well above normal |
| Glucose | Examination Feature | `gluc` | 1: normal, 2: above normal, 3: well above normal |
| Smoking | Subjective Feature | `smoke` | binary |
| Alcohol intake | Subjective Feature | `alco` | binary |
| Physical activity | Subjective Feature | `active` | binary |
| Presence or absence of cardiovascular disease | Target Variable | `cardio` | binary |

## Instructions

Create a chart similar to `examples/Figure_1.png`, where we show the counts of good and bad outcomes for the `cholesterol`, `gluc`, `alco`, `active`, and `smoke` variables for patients with `cardio=1` and `cardio=0` in different panels.

By each number in the `medical_data_visualizer.py` file, add the code from the associated instruction number below.

1. Import the data from `medical_examination.csv` and assign it to the `df` variable.
2. Add an `overweight` column to the data. To determine if a person is overweight, first calculate their BMI by dividing their weight in kilograms by the square of their height in meters. If that value is > 25 then the person is overweight. Use the value `0` for NOT overweight and the value `1` for overweight.
3. Normalize data by making `0` always good and `1` always bad. If the value of `cholesterol` or `gluc` is 1, set the value to `0`. If the value is more than `1`, set the value to `1`.
4. Draw the Categorical Plot in the `draw_cat_plot` function.
5. Create a DataFrame for the cat plot using `pd.melt` with values from `cholesterol`, `gluc`, `smoke`, `alco`, `active`, and `overweight` in the `df_cat` variable.
6. Group and reformat the data in `df_cat` to split it by `cardio`. Show the counts of each feature. You will have to rename one of the columns for the `catplot` to work correctly.
7. Convert the data into `long` format and create a chart that shows the value counts of the categorical features using the following method provided by the seaborn library import: `sns.catplot()`.
8. Get the figure for the output and store it in the `fig` variable.
9. Do not modify the next two lines.
10. Draw the Heat Map in the `draw_heat_map` function.
11. Clean the data in the `df_heat` variable by filtering out the following patient segments that represent incorrect data:
 - diastolic pressure is higher than systolic (Keep the correct data with `(df['ap_lo'] = df['height'].quantile(0.025))`)
 - height is more than the 97.5th percentile
 - weight is less than the 2.5th percentile
 - weight is more than the 97.5th percentile
12. Calculate the correlation matrix and store it in the `corr` variable.
13. Generate a mask for the upper triangle and store it in the `mask` variable.
14. Set up the `matplotlib` figure.
15. Plot the correlation matrix using the method provided by the `seaborn` library import: `sns.heatmap()`.
16. Do not modify the next two lines.

## Development

Write your code in `medical_data_visualizer.py`. For development, you can use `main.py` to test your code.

## Testing

The unit tests for this project are in `test_module.py`. We imported the tests from `test_module.py` to `main.py` for your convenience.

## Submitting

Copy your project's URL and submit it to freeCodeCamp.

Hint: It should pass all Python tests.""",
        codeSnippet: """  # Python challenges don't need solutions,
  # because they would need to be tested against a full working project.
  # Please check our contributing guidelines to learn more.""",
        hasImage: false,
      ),
      AppLesson(
        title: """Page View Time Series Visualizer""",
        body: """You will be working on this project with our Ona starter code.

We are still developing the interactive instructional part of the Python curriculum. For now, here are some videos on the freeCodeCamp.org YouTube channel that will teach you everything you need to know to complete this project:

- Python for Everybody Video Course (14 hours)

- How to Analyze Data with Python Pandas (10 hours)

For this project you will visualize time series data using a line chart, bar chart, and box plots. You will use Pandas, Matplotlib, and Seaborn to visualize a dataset containing the number of page views each day on the freeCodeCamp.org forum from 2016-05-09 to 2019-12-03. The data visualizations will help you understand the patterns in visits and identify yearly and monthly growth.

Use the data to complete the following tasks:

- Use Pandas to import the data from "fcc-forum-pageviews.csv". Set the index to the `date` column.
- Clean the data by filtering out days when the page views were in the top 2.5% of the dataset or bottom 2.5% of the dataset.
- Create a `draw_line_plot` function that uses Matplotlib to draw a line chart similar to "examples/Figure_1.png". The title should be `Daily freeCodeCamp Forum Page Views 5/2016-12/2019`. The label on the x axis should be `Date` and the label on the y axis should be `Page Views`.
- Create a `draw_bar_plot` function that draws a bar chart similar to "examples/Figure_2.png". It should show average daily page views for each month grouped by year. The legend should show month labels and have a title of `Months`. On the chart, the label on the x axis should be `Years` and the label on the y axis should be `Average Page Views`.
- Create a `draw_box_plot` function that uses Seaborn to draw two adjacent box plots similar to "examples/Figure_3.png". These box plots should show how the values are distributed within a given year or month and how it compares over time. The title of the first chart should be `Year-wise Box Plot (Trend)` and the title of the second chart should be `Month-wise Box Plot (Seasonality)`. Make sure the month labels on bottom start at `Jan` and the x and y axis are labeled correctly. The boilerplate includes commands to prepare the data.

For each chart, make sure to use a copy of the data frame.

The boilerplate also includes commands to save and return the image.

## Development

Write your code in `time_series_visualizer.py`. For development, you can use `main.py` to test your code.

## Testing

The unit tests for this project are in `test_module.py`. We imported the tests from `test_module.py` to `main.py` for your convenience.

## Submitting

Copy your project's URL and submit it to freeCodeCamp.

Hint: It should pass all Python tests.""",
        codeSnippet: """  # Python challenges don't need solutions,
  # because they would need to be tested against a full working project.
  # Please check our contributing guidelines to learn more.""",
        hasImage: false,
      ),
      AppLesson(
        title: """Sea Level Predictor""",
        body: """You will be working on this project with our Ona starter code.

We are still developing the interactive instructional part of the Python curriculum. For now, here are some videos on the freeCodeCamp.org YouTube channel that will teach you everything you need to know to complete this project:

- Python for Everybody Video Course (14 hours)

- How to Analyze Data with Python Pandas (10 hours)

You will analyze a dataset of the global average sea level change since 1880. You will use the data to predict the sea level change through year 2050.

Use the data to complete the following tasks:

- Use Pandas to import the data from `epa-sea-level.csv`.
- Use matplotlib to create a scatter plot using the `Year` column as the x-axis and the `CSIRO Adjusted Sea Level` column as the y-axis.
- Use the `linregress` function from `scipy.stats` to get the slope and y-intercept of the line of best fit. Plot the line of best fit over the top of the scatter plot. Make the line go through the year 2050 to predict the sea level rise in 2050.
- Plot a new line of best fit just using the data from year 2000 through the most recent year in the dataset. Make the line also go through the year 2050 to predict the sea level rise in 2050 if the rate of rise continues as it has since the year 2000.
- The x label should be `Year`, the y label should be `Sea Level (inches)`, and the title should be `Rise in Sea Level`.

The boilerplate also includes commands to save and return the image.

## Development

Write your code in `sea_level_predictor.py`. For development, you can use `main.py` to test your code.

## Testing

The unit tests for this project are in `test_module.py`. We imported the tests from `test_module.py` to `main.py` for your convenience.

## Submitting

Copy your project's URL and submit it to freeCodeCamp.

## Data Source
Global Average Absolute Sea Level Change, 1880-2014 from the US Environmental Protection Agency using data from CSIRO, 2015; NOAA, 2015.

Hint: It should pass all Python tests.""",
        codeSnippet: """  # Python challenges don't need solutions,
  # because they would need to be tested against a full working project.
  # Please check our contributing guidelines to learn more.""",
        hasImage: false,
      )
    ],
  ),
  AppCourse(
    id: 'information-security',
    title: """Information Security""",
    description: """A freeCodeCamp curriculum covering Information Security, with 26 lessons extracted from the local curriculum assets.""",
    instructor: 'freeCodeCamp',
    category: 'Web Development',
    difficulty: 'Intermediate',
    icon: Icons.code,
    color: Colors.blue,
    duration: '4 weeks',
    lessons: [
      AppLesson(
        title: """Install and Require Helmet""",
        body: """Working on these challenges will involve you writing your code using one of the following methods:

- Clone this GitHub repo and complete these challenges locally.
- Use a site builder of your choice to complete the project. Be sure to incorporate all the files from our GitHub repo.

Helmet helps you secure your Express apps by setting various HTTP headers.

All your code for these lessons goes in the `myApp.js` file between the lines of code we have started you off with. Do not change or delete the code we have added for you.

Helmet version `3.21.3` has already been installed, so require it as `helmet` in `myApp.js`.

Hint: `helmet` version `3.21.3` should be in `package.json`""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Hide Potentially Dangerous Information Using helmet.hidePoweredBy()""",
        body: """As a reminder, this project is being built upon the following starter project cloned from GitHub.

Hackers can exploit known vulnerabilities in Express/Node if they see that your site is powered by Express. `X-Powered-By: Express` is sent in every request coming from Express by default. Use the `helmet.hidePoweredBy()` middleware to remove the X-Powered-By header.

Hint: helmet.hidePoweredBy() middleware should be mounted correctly""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Mitigate the Risk of Clickjacking with helmet.frameguard()""",
        body: """As a reminder, this project is being built upon the following starter project cloned from GitHub.

Your page could be put in a `` or `` without your consent. This can result in clickjacking attacks, among other things. Clickjacking is a technique of tricking a user into interacting with a page different from what the user thinks it is. This can be obtained by executing your page in a malicious context, by means of iframing. In that context, a hacker can put a hidden layer over your page. Hidden buttons can be used to run bad scripts. This middleware sets the X-Frame-Options header. It restricts who can put your site in a frame. It has three modes: DENY, SAMEORIGIN, and ALLOW-FROM.

We don’t need our app to be framed.

Use `helmet.frameguard()` passing with the configuration object `{action: 'deny'}`.

Hint: helmet.frameguard() middleware should be mounted correctly

helmet.frameguard() 'action' should be set to 'DENY'""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """>-""",
        body: """As a reminder, this project is being built upon the following starter project cloned from GitHub.

Cross-site scripting (XSS) is a frequent type of attack where malicious scripts are injected into vulnerable pages, with the purpose of stealing sensitive data like session cookies, or passwords.

The basic rule to lower the risk of an XSS attack is simple: "Never trust user's input". As a developer you should always sanitize all the input coming from the outside. This includes data coming from forms, GET query urls, and even from POST bodies. Sanitizing means that you should find and encode the characters that may be dangerous e.g. &lt;, >.

Modern browsers can help mitigating the risk by adopting better software strategies. Often these are configurable via http headers.

The X-XSS-Protection HTTP header is a basic protection. The browser detects a potential injected script using a heuristic filter. If the header is enabled, the browser changes the script code, neutralizing it. It still has limited support.

Use `helmet.xssFilter()` to sanitize input sent to your server.

Hint: helmet.xssFilter() middleware should be mounted correctly""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Avoid Inferring the Response MIME Type with helmet.noSniff()""",
        body: """As a reminder, this project is being built upon the following starter project cloned from GitHub.

Browsers can use content or MIME sniffing to override the `Content-Type` header of a response to guess and process the data using an implicit content type. While this can be convenient in some scenarios, it can also lead to some dangerous attacks. This middleware sets the `X-Content-Type-Options` header to `nosniff`, instructing the browser to not bypass the provided `Content-Type`.

Use the `helmet.noSniff()` method on your server.

Hint: helmet.noSniff() middleware should be mounted correctly""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Prevent IE from Opening Untrusted HTML with helmet.ieNoOpen()""",
        body: """As a reminder, this project is being built upon the following starter project cloned from GitHub.

Some web applications will serve untrusted HTML for download. Some versions of Internet Explorer by default open those HTML files in the context of your site. This means that an untrusted HTML page could start doing bad things in the context of your pages. This middleware sets the X-Download-Options header to noopen. This will prevent IE users from executing downloads in the trusted site's context.

Use the `helmet.ieNoOpen()` method on your server.

Hint: helmet.ieNoOpen() middleware should be mounted correctly""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Ask Browsers to Access Your Site via HTTPS Only with helmet.hsts()""",
        body: """As a reminder, this project is being built upon the following starter project cloned from GitHub.

HTTP Strict Transport Security (HSTS) is a web security policy which helps to protect websites against protocol downgrade attacks and cookie hijacking. If your website can be accessed via HTTPS you can ask user’s browsers to avoid using insecure HTTP. By setting the header Strict-Transport-Security, you tell the browsers to use HTTPS for the future requests in a specified amount of time. This will work for the requests coming after the initial request.

Configure `helmet.hsts()` to use HTTPS for the next 90 days. Pass the config object `{maxAge: timeInSeconds, force: true}`. You can create a variable `ninetyDaysInSeconds = 90*24*60*60;` to use for the `timeInSeconds`.

Note: Configuring HTTPS on a custom website requires the acquisition of a domain, and an SSL/TLS Certificate.

Hint: helmet.hsts() middleware should be mounted correctly

maxAge should be equal to 7776000 s (90 days)""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Disable DNS Prefetching with helmet.dnsPrefetchControl()""",
        body: """As a reminder, this project is being built upon the following starter project cloned from GitHub.

To improve performance, most browsers prefetch DNS records for the links in a page. In that way the destination ip is already known when the user clicks on a link. This may lead to over-use of the DNS service (if you own a big website, visited by millions people…), privacy issues (one eavesdropper could infer that you are on a certain page), or page statistics alteration (some links may appear visited even if they are not). If you have high security needs you can disable DNS prefetching, at the cost of a performance penalty.

Use the `helmet.dnsPrefetchControl()` method on your server.

Hint: helmet.dnsPrefetchControl() middleware should be mounted correctly""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Disable Client-Side Caching with helmet.noCache()""",
        body: """As a reminder, this project is being built upon the following starter project cloned from GitHub.

If you are releasing an update for your website, and you want the users to always download the newer version, you can (try to) disable caching on client’s browser. It can be useful in development too. Caching has performance benefits, which you will lose, so only use this option when there is a real need.

Use the `helmet.noCache()` method on your server.

Hint: helmet.noCache() middleware should be mounted correctly""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Set a Content Security Policy with helmet.contentSecurityPolicy()""",
        body: """As a reminder, this project is being built upon the following starter project cloned from GitHub.

This challenge highlights one promising new defense that can significantly reduce the risk and impact of many type of attacks in modern browsers. By setting and configuring a Content Security Policy you can prevent the injection of anything unintended into your page. This will protect your app from XSS vulnerabilities, undesired tracking, malicious frames, and much more. CSP works by defining an allowed list of content sources which are trusted. You can configure them for each kind of resource a web page may need (scripts, stylesheets, fonts, frames, media, and so on...). There are multiple directives available, so a website owner can have a granular control. See HTML 5 Rocks, KeyCDN for more details. Unfortunately CSP is unsupported by older browsers.

By default, directives are wide open, so it’s important to set the defaultSrc directive as a fallback. Helmet supports both defaultSrc and default-src naming styles. The fallback applies for most of the unspecified directives.

In this exercise, use `helmet.contentSecurityPolicy()`. Configure it by adding a `directives` object. In the object, set the `defaultSrc` to `["'self'"]` (the list of allowed sources must be in an array), in order to trust only your website address by default. Also set the `scriptSrc` directive so that you only allow scripts to be downloaded from your website (`'self'`), and from the domain `'trusted-cdn.com'`.

Hint: in the `'self'` keyword, the single quotes are part of the keyword itself, so it needs to be enclosed in double quotes to be working.

Hint: helmet.contentSecurityPolicy() middleware should be mounted correctly

Your csp config is not correct. defaultSrc should be ["'self'"] and scriptSrc should be ["'self'", 'trusted-cdn.com']""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Configure Helmet Using the ‘parent’ helmet() Middleware""",
        body: """As a reminder, this project is being built upon the following starter project cloned from GitHub.

`app.use(helmet())` will automatically include all the middleware introduced above, except `noCache()`, and `contentSecurityPolicy()`, but these can be enabled if necessary. You can also disable or configure any other middleware individually, using a configuration object.

**Example:**

We introduced each middleware separately for teaching purposes and for ease of testing. Using the ‘parent’ `helmet()` middleware is easy to implement in a real project.

Hint: no tests - it's a descriptive challenge""",
        codeSnippet: """app.use(helmet({
  frameguard: {         // configure
    action: 'deny'
  },
  contentSecurityPolicy: {    // enable and configure
    directives: {
      defaultSrc: ["'self'"],
      styleSrc: ['style.com'],
    }
  },
  dnsPrefetchControl: false     // disable
}))""",
        hasImage: false,
      ),
      AppLesson(
        title: """Understand BCrypt Hashes""",
        body: """For the following challenges, you will be working with a new starter project that is different from the previous one. You can find the new starter project to clone on GitHub.

BCrypt hashes are very secure. A hash is basically a fingerprint of the original data- always unique. This is accomplished by feeding the original data into an algorithm and returning a fixed length result. To further complicate this process and make it more secure, you can also *salt* your hash. Salting your hash involves adding random data to the original data before the hashing process which makes it even harder to crack the hash.

BCrypt hashes will always look like `\$2a\$13\$ZyprE5MRw2Q3WpNOGZWGbeG7ADUre1Q8QO.uUUtcbqloU0yvzavOm` which does have a structure. The first small bit of data `\$2a` is defining what kind of hash algorithm was used. The next portion `\$13` defines the *cost*. Cost is about how much power it takes to compute the hash. It is on a logarithmic scale of 2^cost and determines how many times the data is put through the hashing algorithm. For example, at a cost of 10 you are able to hash 10 passwords a second on an average computer, however at a cost of 15 it takes 3 seconds per hash... and to take it further, at a cost of 31 it would take multiple days to complete a hash. A cost of 12 is considered very secure at this time. The last portion of your hash `\$ZyprE5MRw2Q3WpNOGZWGbeG7ADUre1Q8QO.uUUtcbqloU0yvzavOm`, looks like one large string of numbers, periods, and letters but it is actually two separate pieces of information. The first 22 characters is the salt in plain text, and the rest is the hashed password!

Add all your code for these lessons in the `server.js` file between the code we have started you off with. Do not change or delete the code we have added for you.

BCrypt has already been added as a dependency, so require it as `bcrypt` in your server.

Submit your page when you think you've got it right.

Hint: BCrypt should be a dependency.

BCrypt should be properly required.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Hash and Compare Passwords Asynchronously""",
        body: """As a reminder, this project is being built upon the following starter project cloned from GitHub.

As hashing is designed to be computationally intensive, it is recommended to do so asynchronously on your server as to avoid blocking incoming connections while you hash. All you have to do to hash a password asynchronous is call

Add this hashing function to your server (we've already defined the variables used in the function for you to use) and log it to the console for you to see! At this point you would normally save the hash to your database.

Now when you need to figure out if a new input is the same data as the hash you would just use the compare function.

Add this into your existing hash function (since you need to wait for the hash to complete before calling the compare function) after you log the completed hash and log 'res' to the console within the compare. You should see in the console a hash, and then 'true' is printed! If you change 'myPlaintextPassword' in the compare function to 'someOtherPlaintextPassword', then it should say false.

Submit your page when you think you've got it right.

Hint: Async hash should be generated and correctly compared.""",
        codeSnippet: """bcrypt.hash(myPlaintextPassword, saltRounds, (err, hash) => {
  /*Store hash in your db*/
});""",
        hasImage: false,
      ),
      AppLesson(
        title: """Hash and Compare Passwords Synchronously""",
        body: """As a reminder, this project is being built upon the following starter project cloned from GitHub.

Hashing synchronously is just as easy to do but can cause lag if using it server side with a high cost or with hashing done very often. Hashing with this method is as easy as calling

Add this method of hashing to your code and then log the result to the console. Again, the variables used are already defined in the server so you won't need to adjust them. You may notice even though you are hashing the same password as in the async function, the result in the console is different- this is due to the salt being randomly generated each time as seen by the first 22 characters in the third string of the hash. Now to compare a password input with the new sync hash, you would use the compareSync method:

with the result being a boolean true or false.

Add the function in and log the result to the console to see it working.

Submit your page when you think you've got it right.

Hint: Sync hash should be generated and correctly compared.""",
        codeSnippet: """var hash = bcrypt.hashSync(myPlaintextPassword, saltRounds);""",
        hasImage: false,
      ),
      AppLesson(
        title: """Introduction and Setup""",
        body: """Introduction and Setup""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Understanding Sockets and Creating a TCP Server""",
        body: """Understanding Sockets and Creating a TCP Server""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Creating a TCP Client""",
        body: """Creating a TCP Client""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Developing an Nmap Scanner part 1""",
        body: """Developing an Nmap Scanner part 1""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Developing an Nmap Scanner part 2""",
        body: """Developing an Nmap Scanner part 2""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Developing a Banner Grabber""",
        body: """Developing a Banner Grabber""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Developing a Port Scanner""",
        body: """Developing a Port Scanner""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Stock Price Checker""",
        body: """Build a full-stack JavaScript app that is functionally similar to this: https://stock-price-checker.freecodecamp.rocks/.

Since all reliable stock price APIs require an API key, we've built a workaround. Use https://stock-price-checker-proxy.freecodecamp.rocks/ to get up-to-date stock price information without needing to sign up for your own key. 

Working on this project will involve you writing your code using one of the following methods:

- Clone this GitHub repo and complete your project locally.
- Use a site builder of your choice to complete the project. Be sure to incorporate all the files from our GitHub repo.

1. Set the `NODE_ENV` environment variable to `test`, without quotes
2. Complete the project in `routes/api.js` or by creating a handler/controller
3. You will add any security features to `server.js`
4. You will create all of the functional tests in `tests/2_functional-tests.js`

**Note** Privacy Considerations: Due to the requirement that only 1 like per IP should be accepted, you will have to save IP addresses. It is important to remain compliant with data privacy laws such as the General Data Protection Regulation. One option is to get permission to save the user's data, but it is much simpler to anonymize it. For this challenge, remember to anonymize IP addresses before saving them to the database. If you need ideas on how to do this, you may choose to hash the data, truncate it, or set part of the IP address to 0.

Write the following tests in `tests/2_functional-tests.js`:

- Viewing one stock: GET request to `/api/stock-prices/`
- Viewing one stock and liking it: GET request to `/api/stock-prices/`
- Viewing the same stock and liking it again: GET request to `/api/stock-prices/`
- Viewing two stocks: GET request to `/api/stock-prices/`
- Viewing two stocks and liking them: GET request to `/api/stock-prices/`

Hint: You can provide your own project, not the example URL.

You should set the content security policies to only allow loading of scripts and CSS from your server.

You can send a `GET` request to `/api/stock-prices`, passing a NASDAQ stock symbol to a `stock` query parameter. The returned object will contain a property named `stockData`.

The `stockData` property includes the `stock` symbol as a string, the `price` as a number, and `likes` as a number.

You can also pass along a `like` field as `true` (boolean) to have your like added to the stock(s). Only 1 like per IP should be accepted.

If you pass along 2 stocks, the returned value will be an array with information about both stocks. Instead of `likes`, it will display `rel_likes` (the difference between the likes on both stocks) for both `stockData` objects.

All 5 functional tests are complete and passing.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Anonymous Message Board""",
        body: """Build a full-stack JavaScript app that is functionally similar to this: https://anonymous-message-board.freecodecamp.rocks/.

Working on this project will involve you writing your code using one of the following methods:

- Clone this GitHub repo and complete your project locally.
- Use a site builder of your choice to complete the project. Be sure to incorporate all the files from our GitHub repo.

1. Set `NODE_ENV` to test without quotes when ready to write tests and DB to your databases connection string (in `.env`)
2. Recommended to create controllers/handlers and handle routing in `routes/api.js`
3. You will add any security features to `server.js`

Write the following tests in `tests/2_functional-tests.js`:

- Creating a new thread: POST request to `/api/threads/{board}`
- Viewing the 10 most recent threads with 3 replies each: GET request to `/api/threads/{board}`
- Deleting a thread with the incorrect password: DELETE request to `/api/threads/{board}` with an invalid `delete_password`
- Deleting a thread with the correct password: DELETE request to `/api/threads/{board}` with a valid `delete_password`
- Reporting a thread: PUT request to `/api/threads/{board}`
- Creating a new reply: POST request to `/api/replies/{board}`
- Viewing a single thread with all replies: GET request to `/api/replies/{board}`
- Deleting a reply with the incorrect password: DELETE request to `/api/replies/{board}` with an invalid `delete_password`
- Deleting a reply with the correct password: DELETE request to `/api/replies/{board}` with a valid `delete_password`
- Reporting a reply: PUT request to `/api/replies/{board}`

Hint: You can provide your own project, not the example URL.

Only allow your site to be loaded in an iFrame on your own pages.

Do not allow DNS prefetching.

Only allow your site to send the referrer for your own pages.

You can send a POST request to `/api/threads/{board}` with form data including `text` and `delete_password`. The saved database record will have at least the fields `_id`, `text`, `created_on`(date & time), `bumped_on`(date & time, starts same as `created_on`), `reported` (boolean), `delete_password`, & `replies` (array).

You can send a POST request to `/api/replies/{board}` with form data including `text`, `delete_password`, & `thread_id`. This will update the `bumped_on` date to the comment's date. In the thread's `replies` array, an object will be saved with at least the properties `_id`, `text`, `created_on`, `delete_password`, & `reported`.

You can send a GET request to `/api/threads/{board}`. Returned will be an array of the most recent 10 bumped threads on the board with only the most recent 3 replies for each. The `reported` and `delete_password` fields will not be sent to the client.

You can send a GET request to `/api/replies/{board}?thread_id={thread_id}`. Returned will be the entire thread with all its replies, also excluding the same fields from the client as the previous test.

You can send a DELETE request to `/api/threads/{board}` and pass along the `thread_id` & `delete_password` to delete the thread. Returned will be the string `incorrect password` or `success`.

You can send a DELETE request to `/api/replies/{board}` and pass along the `thread_id`, `reply_id`, & `delete_password`. Returned will be the string `incorrect password` or `success`. On success, the text of the `reply_id` will be changed to `[deleted]`.

You can send a PUT request to `/api/threads/{board}` and pass along the `thread_id`. Returned will be the string `reported`. The `reported` value of the `thread_id` will be changed to `true`.

You can send a PUT request to `/api/replies/{board}` and pass along the `thread_id` & `reply_id`. Returned will be the string `reported`. The `reported` value of the `reply_id` will be changed to `true`.

All 10 functional tests are complete and passing.""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Port Scanner""",
        body: """You will be working on this project with our Ona starter code.

We are still developing the interactive instructional part of the Python curriculum. For now, here are some videos on the freeCodeCamp.org YouTube channel that will teach you everything you need to know to complete this project:

- Python for Everybody Video Course (14 hours)

- Learn Python Basics in Depth (4 hours)

- Intermediate Python Course (6 hours)

Create a port scanner using Python.

In the `port_scanner.py` file, create a function called `get_open_ports` that takes a `target` argument and a `port_range` argument. `target` can be a URL or IP address. `port_range` is a list of two numbers indicating the first and last numbers of the range of ports to check.

Here are examples of how the function may be called:

The function should return a list of open ports in the given range.

The `get_open_ports` function should also take an optional third argument of `True` to indicate "Verbose" mode. If this is set to true, the function should return a descriptive string instead of a list of ports.

Here is the format of the string that should be returned in verbose mode (text inside `{}` indicates the information that should appear):

You can use the dictionary in `common_ports.py` to get the correct service name for each port.

For example, if the function is called like this:

It should return the following:

Make sure to include proper spacing and new line characters.

If the URL passed into the `get_open_ports` function is invalid, the function should return the string: "Error: Invalid hostname".

If the IP address passed into the `get_open_ports` function is invalid, the function should return the string: "Error: Invalid IP address".

## Development

Write your code in `port_scanner.py`. For development, you can use `main.py` to test your code.

## Testing

The unit tests for this project are in `test_module.py`. We imported the tests from `test_module.py` to `main.py` for your convenience.

## Submitting

Copy your project's URL and submit it to freeCodeCamp.

Hint: It should pass all Python tests.""",
        codeSnippet: """  # Python challenges don't need solutions,
  # because they would need to be tested against a full working project.
  # Please check our contributing guidelines to learn more.""",
        hasImage: false,
      ),
      AppLesson(
        title: """SHA-1 Password Cracker""",
        body: """You will be working on this project with our Ona starter code.

We are still developing the interactive instructional part of the Python curriculum. For now, here are some videos on the freeCodeCamp.org YouTube channel that will teach you everything you need to know to complete this project:

- Python for Everybody Video Course (14 hours)

- Learn Python Basics in Depth (4 hours)

- Intermediate Python Course (6 hours)

Passwords should never be stored in plain text. They should be stored as hashes, just in case the password list is discovered. However, not all hashes are created equal.

For this project you will learn about the importance of good security by creating a password cracker to figure out passwords that were hashed using SHA-1.

Create a function that takes in a SHA-1 hash of a password and returns the password if it is one of the top 10,000 passwords used. If the SHA-1 hash is NOT of a password in the database, return "PASSWORD NOT IN DATABASE".

The function should hash each password from `top-10000-passwords.txt` and compare it to the hash passed into the function.

The function should take an optional second argument named `use_salts`. If set to true, each salt string from the file `known-salts.txt` should be appended AND prepended to each password from `top-10000-passwords.txt` before hashing and before comparing it to the hash passed into the function.

Here are some hashed passwords to test the function with:

- `b305921a3723cd5d70a375cd21a61e60aabb84ec` should return "sammy123"
- `c7ab388a5ebefbf4d550652f1eb4d833e5316e3e` should return "abacab"
- `5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8` should return "password"

Here are some hashed passwords to test the function with when `use_salts` is set to `True`:

- `53d8b3dc9d39f0184144674e310185e41a87ffd5` should return "superman"
- `da5a4e8cf89539e66097acd2f8af128acae2f8ae` should return "q1w2e3r4t5"
- `ea3f62d498e3b98557f9f9cd0d905028b3b019e1` should return "bubbles1"

The `hashlib` library has been imported for you. You should consider using it in your code. Learn more about "hashlib" here.

## Development

Write your code in `password_cracker.py`. For development, you can use `main.py` to test your code.

## Testing

The unit tests for this project are in `test_module.py`. We imported the tests from `test_module.py` to `main.py` for your convenience.

## Submitting

Copy your project's URL and submit it to freeCodeCamp.

Hint: It should pass all Python tests.""",
        codeSnippet: """  # Python challenges don't need solutions,
  # because they would need to be tested against a full working project.
  # Please check our contributing guidelines to learn more.""",
        hasImage: false,
      ),
      AppLesson(
        title: """Secure Real Time Multiplayer Game""",
        body: """Develop a 2D real time multiplayer game using the HTML Canvas API and Socket.io that is functionally similar to this: https://secure-real-time-multiplayer-game.freecodecamp.rocks/. Working on this project will involve you writing your code using one of the following methods:

- Clone this GitHub repo and complete your project locally.
- Use a site builder of your choice to complete the project. Be sure to incorporate all the files from our GitHub repo.

Create a secure multiplayer game in which each player can move their avatar, there is at least one collectible item, and the rank of the players is calculated based on their score.

For details consult the tests below.

Make sure that your game is secure! Include these security measures:

- The client should not be able to guess/sniff the MIME type
- Prevent XSS attacks
- Do not cache anything from the website in the client
- The headers say that the site is powered by `PHP 7.4.3`

**Note**: `helmet@^3.21.3` is needed for the user stories. This means you will need to use the previous version of Helmet's docs, for information on how to achieve the user stories.

Hint: You can provide your own project, not the example URL.

Multiple players can connect to a server and play.

Each player has an avatar.

Each player is represented by an object created by the `Player` class in `Player.mjs`.

At a minimum, each player object should contain a unique `id`, a `score`, and `x` and `y` coordinates representing the player's current position.

The game has at least one type of collectible item. Complete the `Collectible` class in `Collectible.mjs` to implement this.

At a minimum, each collectible item object created by the `Collectible` class should contain a unique `id`, a `value`, and `x` and `y` coordinates representing the item's current position.

Players can use the WASD and/or arrow keys to move their avatar. Complete the `movePlayer` method in `Player.mjs` to implement this.

The `movePlayer` method should accept two arguments: a string of "up", "down", "left", or "right", and a number for the amount of pixels the player's position should change. `movePlayer` should adjust the `x` and `y` coordinates of the player object it's called from.

The player's score should be used to calculate their rank among the other players. Complete the `calculateRank` method in the `Player` class to implement this.

The `calculateRank` method should accept an array of objects representing all connected players and return the string `Rank: currentRanking/totalPlayers`. For example, in a game with two players, if Player A has a score of 3 and Player B has a score of 5, `calculateRank` for Player A should return `Rank: 2/2`.

Players can collide with a collectible item. Complete the `collision` method in `Player.mjs` to implement this.

The `collision` method should accept a collectible item's object as an argument. If the player's avatar intersects with the item, the `collision` method should return `true`.

All players are kept in sync.

Players can disconnect from the game at any time.

Prevent the client from trying to guess / sniff the MIME type.

Prevent cross-site scripting (XSS) attacks.

Nothing from the website is cached in the client.

The headers say that the site is powered by "PHP 7.4.3" even though it isn't (as a security measure).""",
        codeSnippet: null,
        hasImage: false,
      )
    ],
  ),
  AppCourse(
    id: 'machine-learning-with-python',
    title: """Machine Learning with Python""",
    description: """A freeCodeCamp curriculum covering Machine Learning with Python, with 41 lessons extracted from the local curriculum assets.""",
    instructor: 'freeCodeCamp',
    category: 'Web Development',
    difficulty: 'Intermediate',
    icon: Icons.code,
    color: Colors.blue,
    duration: '4 weeks',
    lessons: [
      AppLesson(
        title: """Introduction: Machine Learning Fundamentals""",
        body: """Introduction: Machine Learning Fundamentals""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Introduction to TensorFlow""",
        body: """The next few video lessons will reference [this Colab notebook](https://colab.research.google.com/drive/1F_EWVKa8rbMXi3_fG0w7AtcscFq7Hi7B#forceEdit=true&sandboxMode=true).""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Core Learning Algorithms""",
        body: """The next few video lessons will reference [this Colab notebook](https://colab.research.google.com/drive/15Cyy2H7nT40sGR7TBN5wBvgTd57mVKay#forceEdit=true&sandboxMode=true).""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Core Learning Algorithms: Working with Data""",
        body: """Core Learning Algorithms: Working with Data""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Core Learning Algorithms: Training and Testing Data""",
        body: """Core Learning Algorithms: Training and Testing Data""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Core Learning Algorithms: The Training Process""",
        body: """Core Learning Algorithms: The Training Process""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Core Learning Algorithms: Classification""",
        body: """Core Learning Algorithms: Classification""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Core Learning Algorithms: Building the Model""",
        body: """Core Learning Algorithms: Building the Model""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Core Learning Algorithms: Clustering""",
        body: """Core Learning Algorithms: Clustering""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Core Learning Algorithms: Hidden Markov Models""",
        body: """Core Learning Algorithms: Hidden Markov Models""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Core Learning Algorithms: Using Probabilities to make Predictions""",
        body: """Core Learning Algorithms: Using Probabilities to make Predictions""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Neural Networks with TensorFlow""",
        body: """The next few video lessons will reference [this Colab notebook](https://colab.research.google.com/drive/1m2cg3D1x3j5vrFc-Cu0gMvc48gWyCOuG#forceEdit=true&sandboxMode=true).""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Neural Networks: Activation Functions""",
        body: """Neural Networks: Activation Functions""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Neural Networks: Optimizers""",
        body: """Neural Networks: Optimizers""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Neural Networks: Creating a Model""",
        body: """Neural Networks: Creating a Model""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Convolutional Neural Networks""",
        body: """The next few video lessons will reference [this Colab notebook](https://colab.research.google.com/drive/1ZZXnCjFEOkp_KdNcNabd14yok0BAIuwS#forceEdit=true&sandboxMode=true).""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Convolutional Neural Networks: The Convolutional Layer""",
        body: """Convolutional Neural Networks: The Convolutional Layer""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Creating a Convolutional Neural Network""",
        body: """Creating a Convolutional Neural Network""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Convolutional Neural Networks: Evaluating the Model""",
        body: """Convolutional Neural Networks: Evaluating the Model""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Convolutional Neural Networks: Picking a Pretrained Model""",
        body: """Convolutional Neural Networks: Picking a Pretrained Model""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Natural Language Processing With RNNs""",
        body: """The next few video lessons will reference [this Colab notebook](https://colab.research.google.com/drive/1ysEKrw_LE2jMndo1snrZUh5w87LQsCxk#forceEdit=true&sandboxMode=true).""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Natural Language Processing With RNNs: Part 2""",
        body: """Natural Language Processing With RNNs: Part 2""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Natural Language Processing With RNNs: Recurring Neural Networks""",
        body: """Natural Language Processing With RNNs: Recurring Neural Networks""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Natural Language Processing With RNNs: Sentiment Analysis""",
        body: """Natural Language Processing With RNNs: Sentiment Analysis""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Natural Language Processing With RNNs: Making Predictions""",
        body: """Natural Language Processing With RNNs: Making Predictions""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Natural Language Processing With RNNs: Create a Play Generator""",
        body: """Natural Language Processing With RNNs: Create a Play Generator""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Natural Language Processing With RNNs: Building the Model""",
        body: """Natural Language Processing With RNNs: Building the Model""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Natural Language Processing With RNNs: Training the Model""",
        body: """Natural Language Processing With RNNs: Training the Model""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Reinforcement Learning With Q-Learning""",
        body: """The next few video lessons will reference [this Colab notebook](https://colab.research.google.com/drive/1IlrlS3bB8t1Gd5Pogol4MIwUxlAjhWOQ#forceEdit=true&sandboxMode=true).""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Reinforcement Learning With Q-Learning: Part 2""",
        body: """Reinforcement Learning With Q-Learning: Part 2""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Reinforcement Learning With Q-Learning: Example""",
        body: """Reinforcement Learning With Q-Learning: Example""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Conclusion""",
        body: """Conclusion""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """How Deep Neural Networks Work""",
        body: """How Deep Neural Networks Work""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Recurrent Neural Networks RNN and Long Short Term Memory LSTM""",
        body: """Recurrent Neural Networks RNN and Long Short Term Memory LSTM""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Deep Learning Demystified""",
        body: """Deep Learning Demystified""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """How Convolutional Neural Networks work""",
        body: """How Convolutional Neural Networks work""",
        codeSnippet: null,
        hasImage: false,
      ),
      AppLesson(
        title: """Rock Paper Scissors""",
        body: """For this challenge, you will create a program to play Rock, Paper, Scissors. A program that picks at random will usually win 50% of the time. To pass this challenge your program must play matches against four different bots, winning at least 60% of the games in each match.

You will be working on this project with our Ona starter code.

We are still developing the interactive instructional part of the machine learning curriculum. For now, you will have to use other resources to learn how to pass this challenge.

In the file `RPS.py` you are provided with a function called `player`. The function takes an argument that is a string describing the last move of the opponent ("R", "P", or "S"). The function should return a string representing the next move for it to play ("R", "P", or "S").

A player function will receive an empty string as an argument for the first game in a match since there is no previous play.

The file `RPS.py` shows an example function that you will need to update. The example function is defined with two arguments (`player(prev_play, opponent_history = [])`). The function is never called with a second argument so that one is completely optional. The reason why the example function contains a second argument (`opponent_history = []`) is because that is the only way to save state between consecutive calls of the `player` function. You only need the `opponent_history` argument if you want to keep track of the opponent_history.

*Hint: To defeat all four opponents, your program may need to have multiple strategies that change depending on the plays of the opponent.*

## Development

Do not modify `RPS_game.py`. Write all your code in `RPS.py`. For development, you can use `main.py` to test your code. 

`main.py` imports the game function and bots from `RPS_game.py`.

To test your code, play a game with the `play` function. The `play` function takes four arguments:

- two players to play against each other (the players are actually functions)
- the number of games to play in the match
- an optional argument to see a log of each game. Set it to `True` to see these messages.

For example, here is how you would call the function if you want `player` and `quincy` to play 1000 games against each other and you want to see the results of each game:

## Testing

The unit tests for this project are in `test_module.py`. We imported the tests from `test_module.py` to `main.py` for your convenience. If you uncomment the last line in `main.py`, the tests will run automatically whenever you run `python main.py` in the console.

## Submitting

Copy your project's URL and submit it to freeCodeCamp.

Hint: It should pass all Python tests.""",
        codeSnippet: """  # Python challenges don't need solutions,
  # because they would need to be tested against a full working project.
  # Please check our contributing guidelines to learn more.""",
        hasImage: false,
      ),
      AppLesson(
        title: """Cat and Dog Image Classifier""",
        body: """You will be working on this project with Google Colaboratory.

After going to that link, create a copy of the notebook either in your own account or locally. Once you complete the project and it passes the test (included at that link), submit your project link below. If you are submitting a Google Colaboratory link, make sure to turn on link sharing for "anyone with the link."

We are still developing the interactive instructional content for the machine learning curriculum. For now, you can go through the video challenges in this certification. You may also have to seek out additional learning resources, similar to what you would do when working on a real-world project.

For this challenge, you will complete the code to classify images of dogs and cats. You will use TensorFlow 2.0 and Keras to create a convolutional neural network that correctly classifies images of cats and dogs at least 63% of the time. (Extra credit if you get it to 70% accuracy!)

Some of the code is given to you but some code you must fill in to complete this challenge. Read the instruction in each text cell so you will know what you have to do in each code cell.

The first code cell imports the required libraries. The second code cell downloads the data and sets key variables. The third cell is the first place you will write your own code.

The structure of the dataset files that are downloaded looks like this (You will notice that the test directory has no subdirectories and the images are not labeled):

You can tweak epochs and batch size if you like, but it is not required.

The following instructions correspond to specific cell numbers, indicated with a comment at the top of the cell (such as `# 3`).

## Cell 3

Now it is your turn! Set each of the variables in this cell correctly. (They should no longer equal `None`.)

Create image generators for each of the three image data sets (train, validation, test). Use `ImageDataGenerator` to read / decode the images and convert them into floating point tensors. Use the `rescale` argument (and no other arguments for now) to rescale the tensors from values between 0 and 255 to values between 0 and 1.

For the `*_data_gen` variables, use the `flow_from_directory` method. Pass in the batch size, directory, target size (`(IMG_HEIGHT, IMG_WIDTH)`), class mode, and anything else required. `test_data_gen` will be the trickiest one. For `test_data_gen`, make sure to pass in `shuffle=False` to the `flow_from_directory` method. This will make sure the final predictions stay in the order that our test expects. For `test_data_gen` it will also be helpful to observe the directory structure.

After you run the code, the output should look like this:

## Cell 4

The `plotImages` function will be used a few times to plot images. It takes an array of images and a probabilities list, although the probabilities list is optional. This code is given to you. If you created the `train_data_gen` variable correctly, then running this cell will plot five random training images.

## Cell 5

Recreate the `train_image_generator` using `ImageDataGenerator`. 

Since there are a small number of training examples, there is a risk of overfitting. One way to fix this problem is by creating more training data from existing training examples by using random transformations.

Add 4-6 random transformations as arguments to `ImageDataGenerator`. Make sure to rescale the same as before.

## Cell 6

You don't have to do anything for this cell. `train_data_gen` is created just like before but with the new `train_image_generator`. Then, a single image is plotted five different times using different variations.

## Cell 7

In this cell, create a model for the neural network that outputs class probabilities. It should use the Keras Sequential model. It will probably involve a stack of Conv2D and MaxPooling2D layers and then a fully connected layer on top that is activated by a ReLU activation function.

Compile the model passing the arguments to set the optimizer and loss. Also pass in `metrics=['accuracy']` to view training and validation accuracy for each training epoch.

## Cell 8

Use the `fit` method on your `model` to train the network. Make sure to pass in arguments for `x`, `steps_per_epoch`, `epochs`, `validation_data`, and `validation_steps`.

## Cell 9

Run this cell to visualize the accuracy and loss of the model.

## Cell 10

Now it is time to use your model to predict whether a brand new image is a cat or a dog.

In this cell, get the probability that each test image (from `test_data_gen`) is a dog or a cat. `probabilities` should be a list of integers. 

Call the `plotImages` function and pass in the test images and the probabilities corresponding to each test image.

After you run the cell, you should see all 50 test images with a label showing the percentage of "sure" that the image is a cat or a dog. The accuracy will correspond to the accuracy shown in the graph above (after running the previous cell). More training images could lead to a higher accuracy.

## Cell 11

Run this final cell to see if you passed the challenge or if you need to keep trying.

Hint: It should pass all Python tests.""",
        codeSnippet: """  # Python challenges don't need solutions,
  # because they would need to be tested against a full working project.
  # Please check our contributing guidelines to learn more.""",
        hasImage: false,
      ),
      AppLesson(
        title: """Book Recommendation Engine using KNN""",
        body: """You will be working on this project with Google Colaboratory.

After going to that link, create a copy of the notebook either in your own account or locally. Once you complete the project and it passes the test (included at that link), submit your project link below. If you are submitting a Google Colaboratory link, make sure to turn on link sharing for "anyone with the link."

We are still developing the interactive instructional content for the machine learning curriculum. For now, you can go through the video challenges in this certification. You may also have to seek out additional learning resources, similar to what you would do when working on a real-world project.

In this challenge, you will create a book recommendation algorithm using **K-Nearest Neighbors**.

In this project, you will use the Book-Crossings dataset, which contains 1.1 million ratings (scale of 1-10) of 270,000 books by 90,000 users. The dataset is already imported in the notebook, so no additional download is required.

Use `NearestNeighbors` from `sklearn.neighbors` to develop a model that shows books that are similar to a given book. The Nearest Neighbors algorithm measures the distance to determine the “closeness” of instances.

Create a function named `get_recommends` that takes a book title (from the dataset) as an argument and returns a list of 5 similar books with their distances from the book argument.

This code:

should return:

Notice that the data returned from `get_recommends()` is a list. The first element in the list is the book title passed into the function. The second element in the list is a list of five more lists. Each of the five lists contains a recommended book and the distance from the recommended book to the book passed into the function.

If you graph the dataset (optional), you will notice that most books are not rated frequently. To ensure statistical significance, remove from the dataset users with less than 200 ratings and books with less than 100 ratings.

The first three cells import libraries you may need and the data to use. The final cell is for testing. Write all your code in between those cells.

Hint: It should pass all Python tests.""",
        codeSnippet: """  # Python challenges don't need solutions,
  # because they would need to be tested against a full working project.
  # Please check our contributing guidelines to learn more.""",
        hasImage: false,
      ),
      AppLesson(
        title: """Linear Regression Health Costs Calculator""",
        body: """You will be working on this project with Google Colaboratory.

After going to that link, create a copy of the notebook either in your own account or locally. Once you complete the project and it passes the test (included at that link), submit your project link below. If you are submitting a Google Colaboratory link, make sure to turn on link sharing for "anyone with the link."

We are still developing the interactive instructional content for the machine learning curriculum. For now, you can go through the video challenges in this certification. You may also have to seek out additional learning resources, similar to what you would do when working on a real-world project.

In this challenge, you will predict healthcare costs using a regression algorithm.

You are given a dataset that contains information about different people including their healthcare costs. Use the data to predict healthcare costs based on new data.

The first two cells of this notebook import libraries and the data.

Make sure to convert categorical data to numbers. Use 80% of the data as the `train_dataset` and 20% of the data as the `test_dataset`.

`pop` off the "expenses" column from these datasets to create new datasets called `train_labels` and `test_labels`. Use these labels when training your model.

Create a model and train it with the `train_dataset`. Run the final cell in this notebook to check your model. The final cell will use the unseen `test_dataset` to check how well the model generalizes.

To pass the challenge, `model.evaluate` must return a Mean Absolute Error of under 3500. This means it predicts health care costs correctly within \$3500.

The final cell will also predict expenses using the `test_dataset` and graph the results.

Hint: It should pass all Python tests.""",
        codeSnippet: """  # Python challenges don't need solutions,
  # because they would need to be tested against a full working project.
  # Please check our contributing guidelines to learn more.""",
        hasImage: false,
      ),
      AppLesson(
        title: """Neural Network SMS Text Classifier""",
        body: """You will be working on this project with Google Colaboratory.

After going to that link, create a copy of the notebook either in your own account or locally. Once you complete the project and it passes the test (included at that link), submit your project link below. If you are submitting a Google Colaboratory link, make sure to turn on link sharing for "anyone with the link."

We are still developing the interactive instructional content for the machine learning curriculum. For now, you can go through the video challenges in this certification. You may also have to seek out additional learning resources, similar to what you would do when working on a real-world project.

In this challenge, you need to create a machine learning model that will classify SMS messages as either "ham" or "spam". A "ham" message is a normal message sent by a friend. A "spam" message is an advertisement or a message sent by a company.

You should create a function called `predict_message` that takes a message string as an argument and returns a list. The first element in the list should be a number between zero and one that indicates the likeliness of "ham" (0) or "spam" (1). The second element in the list should be the word "ham" or "spam", depending on which is most likely.

For this challenge, you will use the SMS Spam Collection dataset. The dataset has already been grouped into train data and test data.

The first two cells import the libraries and data. The final cell tests your model and function. Add your code in between these cells.

Hint: It should pass all Python tests.""",
        codeSnippet: """  # Python challenges don't need solutions,
  # because they would need to be tested against a full working project.
  # Please check our contributing guidelines to learn more.""",
        hasImage: false,
      )
    ],
  )
];
