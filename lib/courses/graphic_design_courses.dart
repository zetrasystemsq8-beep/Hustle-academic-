// ============================================================
// GRAPHIC DESIGN COURSES
// lib/courses/graphic_design_courses.dart
// ============================================================
// Add this import to main.dart:
// import 'courses/graphic_design_courses.dart';
// Then spread it inside kCourses:
// ...graphicDesignCourses,
// ============================================================

import 'package:flutter/material.dart';
import '../main.dart';

final List<AppCourse> graphicDesignCourses = [
  AppCourse(
    id: 'graphic_design_fundamentals_101',
    title: 'Graphic Design Fundamentals',
    description:
        "Learn the core principles every designer needs before touching software — composition, color, contrast, and visual hierarchy.",
    instructor: 'Ngozi Adichie-Obi',
    category: 'Graphic Design',
    difficulty: 'Beginner',
    icon: Icons.palette,
    color: Colors.pink,
    duration: '6h 10m',
    lessons: [
      AppLesson(
        title: 'What Graphic Design Actually Is',
        hasImage: true,
        body:
            "Graphic design is the practice of solving visual communication problems. It is not decoration for its own sake — every color choice, every line, every piece of spacing exists to move information from your head into someone else's, as clearly and persuasively as possible. A flyer, a logo, an app icon, and a billboard are all the same discipline wearing different clothes: take a message, an audience, and a constraint, and produce an image that does its job.\n\nBeginners often think design is about making things 'look nice.' Professionals think about function first — what does this piece need to do? A restaurant menu needs to guide the eye toward high-margin items. A road sign needs to be readable at 100km/h. A wedding invitation needs to feel warm and personal. Aesthetics matter, but they are in service of the message, not a replacement for it.\n\nThroughout this course you will learn the visual vocabulary — color, type, layout, contrast, hierarchy — and how to combine them intentionally. By the end, you should be able to look at any design, professional or amateur, and explain in plain language why it works or why it doesn't.",
      ),
      AppLesson(
        title: 'Visual Hierarchy: Guiding the Eye',
        body:
            "Visual hierarchy is the order in which a viewer's eye moves through a design. You control this order using size, weight, color, and position. The biggest, boldest, highest-contrast element usually gets seen first; smaller, quieter elements get seen later or not at all unless the viewer chooses to look for them.\n\nThink about a typical event poster: the event name is huge and bold, the date and venue are medium-sized, and the sponsor logos at the bottom are small. This isn't accidental — it mirrors what the audience actually needs to know first, second, and third. If you made the sponsor logos as big as the event title, you would confuse the hierarchy and the poster would fail its job even if every individual element looked good.\n\nA simple exercise: squint at any design. The shapes that are still visible when everything is blurry are the ones dominating your hierarchy. If the wrong element wins that squint test — say, a background pattern outshines your headline — your hierarchy needs fixing.",
        codeSnippet:
            "Hierarchy checklist for any layout:\n1. What is the ONE thing the viewer must see first? Make it biggest/boldest.\n2. What is the second most important thing? Give it clear but lesser weight.\n3. Everything else is supporting detail — keep it small and low-contrast.\n4. Squint-test the design. Confirm the top 2 items still dominate.",
      ),
      AppLesson(
        title: 'Color Theory for Designers',
        hasImage: true,
        body:
            "Color is the fastest way to communicate mood before a single word is read. Warm colors (red, orange, yellow) feel energetic, urgent, and appetite-inducing — which is why fast food brands love them. Cool colors (blue, green, purple) feel calm, trustworthy, and professional — which is why banks and tech companies lean on them heavily.\n\nThe color wheel gives you reliable combination strategies. Complementary colors (opposite on the wheel, like blue and orange) create high energy and strong contrast, great for calls-to-action. Analogous colors (next to each other, like blue, teal, and green) feel harmonious and calm, good for backgrounds and editorial work. Monochromatic schemes (one hue, varying lightness) feel sophisticated and are hard to get wrong.\n\nIn West African markets specifically, color carries cultural weight beyond Western color psychology — green and white read as Nigerian national identity, gold often signals prosperity and celebration, and certain color combinations are strongly tied to specific ethnic textiles and festivals. A good designer researches these associations before finalizing a palette for a local audience.",
        codeSnippet:
            "Quick palette formula (use in any design tool):\nPrimary color   – 60% of the design (backgrounds, large shapes)\nSecondary color – 30% of the design (supporting elements)\nAccent color    – 10% of the design (buttons, highlights, CTAs)\n\nExample palette for a fintech app:\nPrimary:  #0B3D2E (deep green — trust, money)\nSecondary:#F4F1EA (warm off-white — clean, readable)\nAccent:   #E8A33D (gold — premium, celebratory)",
      ),
      AppLesson(
        title: 'Typography Basics',
        body:
            "Typography is 90% of most design work whether designers admit it or not — logos, posters, apps, and packaging are mostly words arranged well. The first rule is legibility: if people have to work to read your text, you have already lost. Choose fonts that are clear at the size they'll actually be viewed.\n\nFonts fall into families with different personalities. Serif fonts (with small feet on the letters, like Times New Roman) feel traditional, trustworthy, and editorial — common in newspapers and law firms. Sans-serif fonts (clean, no feet, like Helvetica) feel modern, neutral, and digital-friendly — dominant in tech and app design. Script fonts feel personal and elegant but are hard to read in long blocks, so use them sparingly, usually just for a name or headline.\n\nA common beginner mistake is using too many fonts in one design. A safe rule: pick one font family for headlines and one (often different) for body text — two total, maybe three if one is used only for small accents like a date or tag. Consistency in type choice makes a design feel intentional rather than chaotic.",
      ),
      AppLesson(
        title: 'Contrast and Readability',
        body:
            "Contrast isn't just about color — it's about difference in general: size, weight, color, texture, or spacing. Strong contrast between elements creates focus and drama; weak contrast creates calm and unity. Both are useful, but only when chosen deliberately.\n\nThe most common contrast failure is text-on-background contrast that's too low to read comfortably — light grey text on a white background, or a busy photo behind bold headline text with no darkening overlay. The Web Content Accessibility Guidelines (WCAG) recommend a contrast ratio of at least 4.5:1 for normal body text, and most design tools can check this ratio for you before you export anything.\n\nA practical habit: after finishing any design, view it in grayscale. If you can still clearly tell your elements apart with the color removed, your contrast is solid. If everything blends into the same grey mush, you're relying on color alone to do a job that value (lightness/darkness) should be doing.",
      ),
      AppLesson(
        title: 'Layout, Grids, and Alignment',
        hasImage: true,
        body:
            "A grid is an invisible structure of rows and columns that keeps elements aligned to consistent lines, even when a viewer never consciously notices the grid itself. Grids are why professional layouts feel calm and organized while amateur layouts feel scattered — even with identical content, gridded work reads as more trustworthy.\n\nThe most common grid in digital design is the 12-column grid, because 12 divides evenly into halves, thirds, and quarters, giving you flexible layout options. Print designers often use column grids too, alongside margins and gutters (the space between columns) to control breathing room. Whatever grid you choose, commit to it — inconsistent alignment is one of the fastest ways to make a design look unprofessional.\n\nAlignment itself is a hierarchy tool. Left-aligned text is easiest to read for large blocks (in left-to-right languages). Centered text works for short, ceremonial content like invitations or quotes, but becomes hard to read in long paragraphs because the eye has to search for the start of each new line. When in doubt, align left and align consistently.",
      ),
      AppLesson(
        title: 'White Space Is Not Wasted Space',
        body:
            "Beginners often feel the urge to fill every empty pixel with something — another icon, another line of text, a decorative border. Experienced designers do the opposite: they protect empty space (also called negative space or white space) as deliberately as they place content, because it's what lets the eye rest and lets important elements breathe.\n\nWhite space has two jobs. Macro white space is the large breathing room around a whole composition — the margin around a poster, or the padding around an app screen. Micro white space is the smaller spacing between related elements, like the line spacing between paragraphs or the gap between an icon and its label. Both need to be consistent and intentional.\n\nLuxury and premium brands lean especially hard on white space, because generous empty space unconsciously signals confidence — the brand doesn't need to shout to be noticed. A cluttered layout, by contrast, often signals desperation or a lack of prioritization: if everything is shouting for attention, nothing actually stands out.",
      ),
      AppLesson(
        title: 'Balance and Composition',
        body:
            "Balance is the visual weight distribution across a design — does one side feel heavier than the other in a way that feels unintentional? Symmetrical balance mirrors elements around a central axis and feels formal, stable, and calm — think government seals or wedding invitations. Asymmetrical balance uses different elements of different sizes on each side that still feel equally weighted, like a small dark shape balancing a larger light shape — this feels more dynamic and modern.\n\nVisual weight isn't just about size. A small, saturated red dot can visually balance a much larger pale grey shape, because color intensity and contrast also carry weight. Texture, isolation (an element alone in space draws more attention), and position (elements near the top or right often feel 'heavier' in Western reading patterns) all factor into perceived balance.\n\nA good habit when composing any layout is to mentally place a fulcrum in the center of your canvas and ask: if this were a see-saw, would it tip? Adjusting size, color, or position of a single element is often enough to fix an unbalanced composition.",
      ),
      AppLesson(
        title: 'Working with Images and Icons',
        hasImage: true,
        body:
            "Images and icons carry meaning instantly, often faster than text — which makes them powerful but also risky if chosen carelessly. A stock photo that looks generic or culturally mismatched can undercut an otherwise strong design faster than any typography mistake. Always ask: does this image actually represent my audience and message, or is it just filler?\n\nIcons should be used as a consistent set, not mixed from different styles — combining a thin-line icon with a solid-filled icon in the same row instantly looks unpolished, because the visual weight and style language clash. Icon libraries like Material Icons, Feather, or Font Awesome each maintain internal consistency; stick to one library per project.\n\nImage cropping and framing also communicate intent. A tight crop on a face feels intimate and emotional; a wide shot with lots of environment feels documentary and contextual. Before placing any image, crop deliberately to support the story you're telling, rather than just fitting whatever space is left over.",
      ),
      AppLesson(
        title: 'Mini Project: Redesign a Flyer',
        hasImage: true,
        body:
            "For this final project, take any poorly designed flyer or poster you can find — a WhatsApp forward, an old event flyer, a market advertisement — and redesign it applying everything from this course. You are not copying the content; you are rebuilding the visual communication.\n\nStart by identifying the single most important piece of information (the hierarchy problem), then choose a two-color palette using the 60/30/10 rule, pick one heading font and one body font, and lay everything out on a simple grid with generous white space around the edges. Resist the urge to add decoration until the core hierarchy, color, and type choices are solid.\n\nWhen you're done, compare your version to the original side by side and write two sentences explaining, in plain language, why your version communicates the message faster and more clearly. This habit — being able to articulate 'why' in words, not just 'it looks better' — is what separates designers who can defend their work in client meetings from those who can't.",
      ),
    ],
  ),
  AppCourse(
    id: 'graphic_design_photoshop_101',
    title: 'Adobe Photoshop Mastery',
    description:
        "Go from a blank canvas to professional photo edits and composites using layers, masks, and retouching techniques.",
    instructor: 'Emeka Uzodinma',
    category: 'Graphic Design',
    difficulty: 'Intermediate',
    icon: Icons.photo_filter,
    color: Colors.blue,
    duration: '7h 45m',
    lessons: [
      AppLesson(
        title: 'The Photoshop Workspace and Canvas Basics',
        hasImage: true,
        body:
            "Before editing anything, you need to understand how Photoshop organizes work. The canvas is your document; the Layers panel (usually bottom-right) stacks every element — image, text, shape, adjustment — on top of each other like sheets of glass. Nothing in Photoshop is truly 'merged' unless you flatten it, which means you can always go back and adjust a single layer without touching the rest.\n\nResolution and color mode matter before you even start designing. For anything destined for print, work at 300 DPI (dots per inch) in CMYK color mode. For anything destined for screens — websites, social media, apps — work at 72 DPI in RGB color mode. Starting in the wrong mode is one of the most common beginner mistakes, and it often only becomes obvious after printing, when colors come out muddy or dull.\n\nGet comfortable with the Move tool (V), the Zoom tool (Z), and keyboard shortcuts for zooming (Ctrl/Cmd + Plus/Minus) early. Professional Photoshop users barely touch the mouse for navigation — most of the workflow speed comes from muscle memory on the keyboard.",
        codeSnippet:
            "New document settings cheat sheet:\nPrint flyer (A4):        2480 x 3508 px, 300 DPI, CMYK\nInstagram post:          1080 x 1080 px, 72 DPI, RGB\nInstagram story:         1080 x 1920 px, 72 DPI, RGB\nFacebook cover photo:    820 x 312 px, 72 DPI, RGB\nBillboard (large format):scale down proportionally, 150 DPI, CMYK",
      ),
      AppLesson(
        title: 'Understanding Layers and the Layers Panel',
        body:
            "Layers are the single most important concept in Photoshop. Each layer can hold an image, text, a shape, or an adjustment, and layers stack in order from bottom to top — anything on a higher layer visually covers whatever is beneath it, unless transparency or blend modes say otherwise. Naming your layers clearly ('Headline Text', 'Background Photo', 'Logo') rather than leaving them as 'Layer 1', 'Layer 2' will save you enormous time on any project with more than a handful of elements.\n\nLayer groups (folders) let you bundle related layers together — for example, all the elements of a logo lockup can live in one folder that you move, hide, or scale as a single unit. Grouping is essential once a file grows past 15-20 layers, which happens quickly on any real project.\n\nLayer opacity and blend modes change how a layer interacts with what's beneath it. Multiply darkens, Screen lightens, Overlay adds contrast while preserving shadows and highlights — these three blend modes alone cover a huge percentage of professional compositing and color-grading work.",
      ),
      AppLesson(
        title: 'Selections: The Foundation of Editing',
        body:
            "You cannot edit part of an image without first selecting it, and Photoshop offers many selection tools because different image content needs different approaches. The Rectangular and Elliptical Marquee tools make basic geometric selections. The Lasso tool makes freehand selections. The Magic Wand and Quick Selection tools select based on color similarity, which works well on images with clear color separation between subject and background.\n\nFor complex subjects like hair or fur, none of the basic tools give a clean result — this is where Select and Mask (found under Select > Select and Mask) becomes essential. It offers edge-refinement brushes that can intelligently detect fine detail like individual hair strands, producing far cleaner cutouts than a manual lasso ever could.\n\nOnce you have a selection, remember that selections are additive and subtractive: hold Shift while selecting to add to your current selection, hold Alt/Option to subtract from it. This lets you build up complex, irregular selections from several simple tool strokes rather than trying to get one perfect selection on the first try.",
        codeSnippet:
            "Selection modifier keys (hold while using any selection tool):\nShift  = ADD to current selection\nAlt/Option = SUBTRACT from current selection\nShift+Alt  = INTERSECT with current selection\nCtrl/Cmd+D = Deselect everything",
      ),
      AppLesson(
        title: 'Layer Masks: Non-Destructive Hiding',
        hasImage: true,
        body:
            "A layer mask lets you hide part of a layer without deleting any pixels — which means you can always paint the hidden part back in later. This is the core of non-destructive editing: instead of erasing something permanently with the Eraser tool, you add a mask and paint on the mask itself. White reveals, black conceals — that's the entire rule, and once it clicks, masking becomes second nature.\n\nTo add a mask, select a layer and click the mask icon at the bottom of the Layers panel (a rectangle with a circle inside it). Then select the Brush tool, and paint with black to hide parts of that layer, or white to bring them back. Because the mask is just a greyscale image sitting alongside your layer, you can also use gradients on masks to create smooth, gradual fades between two images — a common technique in double-exposure effects and banner design.\n\nMasks paired with selections are extremely powerful: make a selection first (say, around a person using Select and Mask), then click the mask button while that selection is active, and Photoshop automatically converts your selection into a mask — revealing the selected area and hiding everything else, instantly.",
      ),
      AppLesson(
        title: 'Adjustment Layers and Color Correction',
        body:
            "Adjustment layers let you change color, brightness, and contrast without permanently altering your original pixels — they sit as a separate layer that affects everything beneath them, and can be edited, hidden, or deleted at any time. This is dramatically safer than using Image > Adjustments directly on a pixel layer, which bakes the change in permanently.\n\nLevels and Curves are the two most powerful color-correction adjustment layers. Levels lets you set the black point, white point, and midtone (gamma) of an image using a histogram — dragging the black and white point sliders inward instantly increases contrast by making the darkest pixels truly black and the lightest truly white. Curves does the same job with more precision, letting you adjust specific tonal ranges (shadows, midtones, highlights) independently by bending a diagonal line.\n\nHue/Saturation adjustment layers let you shift specific color ranges — for example, making just the reds in a photo more vibrant without touching the blues. This kind of targeted, selective color grading is what separates a flat, unedited photo from one that feels intentional and polished.",
      ),
      AppLesson(
        title: 'Retouching Portraits',
        hasImage: true,
        body:
            "Portrait retouching is a delicate skill — the goal is almost always to enhance, not to erase someone's identity. The Spot Healing Brush and Healing Brush intelligently sample nearby texture to remove blemishes, while preserving the underlying skin tone and lighting, unlike the Clone Stamp, which copies pixels exactly and can look obviously 'pasted' if used carelessly.\n\nFrequency separation is the professional standard technique for skin retouching: it splits an image into a 'low frequency' layer (color and tone, no texture) and a 'high frequency' layer (texture and detail, no color). This lets you smooth out blotchy skin tone on the low-frequency layer while keeping every pore and skin texture crisp on the high-frequency layer — producing results that look real rather than plastic and overly airbrushed.\n\nDodge and Burn — lightening and darkening specific areas — is how retouchers sculpt the appearance of facial structure and add dimension, done on a separate 50% grey layer set to Overlay blend mode so the effect stays fully non-destructive and adjustable. This technique takes practice, but subtle dodge and burn work is often the single biggest difference between an amateur portrait edit and a professional one.",
        codeSnippet:
            "Non-destructive Dodge & Burn setup:\n1. Create a new layer, fill with 50% grey (#808080)\n2. Set the layer's blend mode to 'Overlay'\n3. Select the Brush tool, set to low opacity (10-15%)\n4. Paint WHITE to lighten (dodge) areas\n5. Paint BLACK to darken (burn) areas\n6. Adjust the grey layer's overall opacity anytime to control effect strength",
      ),
      AppLesson(
        title: 'Compositing Multiple Images Together',
        body:
            "Compositing is combining multiple separate photos into one believable scene — a person cut out and placed into a new background, for example. The technical cutout is usually the easy part; the hard part is making lighting, color, and scale match convincingly so the final image doesn't look obviously 'photoshopped.'\n\nMatch the light direction first: if your background has shadows falling to the right, any subject you composite in needs shadows falling the same direction, or the image will feel physically wrong even to viewers who can't articulate why. Match color temperature next — a subject shot in cool daylight placed into a warm sunset background will look pasted in, so use a Color Balance or Curves adjustment layer clipped to the subject to shift its tones toward the background's palette.\n\nFinally, add a cast shadow beneath your subject on a new layer, softened with Gaussian Blur and set to low opacity — even a very simple shadow does more to sell a composite as 'real' than almost any other single step, because human vision is extremely sensitive to missing or mismatched shadows.",
      ),
      AppLesson(
        title: 'Working with Text and Typography in Photoshop',
        body:
            "Photoshop's Type tool creates fully editable text layers, which remain editable as long as you don't rasterize them (convert them to plain pixels). Keep text layers editable for as long as possible in your workflow — rasterizing early means you can't fix a typo without retyping the whole layer from scratch.\n\nCharacter and Paragraph panels (Window > Character / Window > Paragraph) give you fine control over tracking (letter spacing), leading (line spacing), and alignment — all far more precise than eyeballing it. For headline text, slightly tightening tracking (negative values) often looks more polished; for body text, default or slightly loosened tracking improves readability.\n\nLayer styles (double-click any layer to open them) let you add drop shadows, strokes, and glows to text non-destructively. A subtle drop shadow can help white text stand out against a busy photo background without needing a solid color box behind it, keeping the design feeling lighter and more integrated with the image.",
      ),
      AppLesson(
        title: 'Exporting for Web and Print',
        body:
            "Exporting the wrong way is one of the most common ways good design work gets ruined at the last step. For web and social media, use File > Export > Save for Web (Legacy) or the newer Export As dialog, choosing JPEG for photos (smaller file size, some quality loss) or PNG for anything needing transparency or sharp text (larger file size, no quality loss).\n\nFor print, always export a flattened, high-resolution file — typically a PDF or TIFF at 300 DPI in CMYK color mode, with bleed added if the design touches the edge of the page (usually 3mm extra on each side, so ink still covers the edge after trimming). Skipping bleed is a classic beginner mistake that results in visible white slivers at the edge of printed materials.\n\nAlways keep your original layered .PSD file even after exporting flattened versions — clients and future you will inevitably ask for edits, and starting from a flattened JPEG to make text changes is painful and often impossible without recreating work from scratch.",
        codeSnippet:
            "Export settings quick reference:\nWeb photo:        JPEG, Quality 70-80%, sRGB\nWeb graphic w/ transparency: PNG-24\nSocial media post: PNG or JPEG, sRGB, 1080px min width\nPrint flyer:       PDF/X-1a, 300 DPI, CMYK, 3mm bleed\nLogo for client:   PNG (transparent) + vector AI/EPS if available",
      ),
      AppLesson(
        title: 'Mini Project: Full Portrait Composite',
        hasImage: true,
        body:
            "For this final project, source two images: a portrait photo and a separate background image (a stock photo, a texture, or your own photography). Cut the subject out cleanly using Select and Mask, composite them into the new background, and match lighting and color temperature using adjustment layers clipped to the subject.\n\nAdd a soft cast shadow beneath the subject, do light retouching on the skin using the Spot Healing Brush and a basic frequency separation pass, and finish with subtle dodge and burn to add dimension to the face and clothing. Add a title using proper type hierarchy if the final piece is meant to double as a poster or promotional graphic.\n\nExport two versions: a web-ready JPEG at 1080px wide for social sharing, and a flattened high-resolution TIFF suitable for print. Comparing both exports will make the DPI and color mode differences from earlier lessons concrete rather than theoretical.",
      ),
    ],
  ),
  AppCourse(
    id: 'graphic_design_illustrator_101',
    title: 'Adobe Illustrator for Vector Art',
    description:
        "Master vector graphics — the format every logo, icon, and print-ready design ultimately needs to exist in.",
    instructor: 'Fatima Bello',
    category: 'Graphic Design',
    difficulty: 'Intermediate',
    icon: Icons.brush,
    color: Colors.orange,
    duration: '6h 50m',
    lessons: [
      AppLesson(
        title: 'Vector vs Raster: Why It Matters',
        hasImage: true,
        body:
            "Raster images (like JPEGs and PNGs from Photoshop) are made of a fixed grid of pixels. Zoom in far enough and you'll see individual colored squares — this means raster images have a maximum useful resolution, and enlarging them beyond that makes them blurry or blocky. Vector images (like the ones you create in Illustrator) are made of mathematical paths — lines and curves defined by coordinates and formulas, not pixels.\n\nBecause vectors are math, not a pixel grid, they can be scaled infinitely — from a favicon 16 pixels wide to a building-sized banner — with zero loss in quality. This is exactly why logos absolutely must exist as vector files: a client might need that logo on a business card today and a billboard next year, and only a vector file handles both without quality loss.\n\nThe tradeoff is that vectors are best suited to flat, graphic shapes — logos, icons, illustrations, typography — rather than photorealistic detail. Photographs stay in raster formats because photographic detail doesn't translate well into clean mathematical paths. Understanding when to use each format, and how they can work together, is core professional knowledge.",
      ),
      AppLesson(
        title: 'The Pen Tool: Your Most Important Skill',
        body:
            "The Pen tool is intimidating for almost every beginner and is also, without exaggeration, the single most valuable skill in all of vector design. It draws paths using anchor points connected by straight or curved segments, and mastering it unlocks the ability to trace, illustrate, and create precise custom shapes rather than being limited to Illustrator's built-in shape tools.\n\nA straight-line anchor point is created with a simple click. A curved anchor point is created by clicking and dragging, which pulls out two 'handles' that control the curve's direction and intensity on either side of that point. The angle and length of these handles determine exactly how the curve bends — shorter handles create tighter curves, longer handles create more gradual ones.\n\nPractice by tracing simple shapes first — a leaf, a coffee cup silhouette, a speech bubble — before attempting anything complex like a detailed logo or character illustration. Like typing, Pen tool fluency comes from repetition, not from understanding the theory alone; expect your first 20-30 hours of practice to feel clumsy before it starts feeling natural.",
        codeSnippet:
            "Pen tool basics:\nClick only           = straight line anchor point\nClick + drag         = curved anchor point (pulls out handles)\nAlt/Option + drag on a handle = break symmetry, create a corner\nCtrl/Cmd + click elsewhere = temporarily switch to Selection tool\nEsc or Enter         = finish the current path",
      ),
      AppLesson(
        title: 'Shape Tools and the Shape Builder',
        body:
            "Illustrator's basic shape tools — Rectangle, Ellipse, Polygon, Star — create precise geometric shapes instantly, and are the fastest starting point for most logo and icon work, since a huge percentage of real logos are built from combinations of simple circles, squares, and triangles rather than freehand illustration.\n\nThe Shape Builder tool (Shift+M) lets you merge, subtract, and combine overlapping shapes visually, by simply dragging across the areas you want to merge or clicking with Alt/Option held to remove areas. This is dramatically faster than manually adjusting anchor points when you're combining several basic shapes into a more complex icon or logomark.\n\nThe Pathfinder panel (Window > Pathfinder) offers similar boolean operations — Unite, Minus Front, Intersect, Exclude — as one-click buttons rather than a drag-based tool. Many professional logo designers work almost entirely with basic shapes plus Shape Builder and Pathfinder, only reaching for the Pen tool to fine-tune specific curves afterward.",
      ),
      AppLesson(
        title: 'Working with Color and Swatches',
        hasImage: true,
        body:
            "Illustrator manages color through the Swatches panel, where you can save and reuse exact colors across an entire project — critical for brand consistency, since a logo's blue needs to be pixel-for-pixel identical whether it appears on a business card or a website. Global swatches update everywhere they're used automatically if you change the base color later, saving huge amounts of rework time.\n\nFor any project connected to a real brand, always work in the correct color mode: CMYK for anything print-bound, RGB for anything screen-bound, and ideally define Pantone (spot color) values too if the client has an official brand guide, since Pantone colors print more consistently across different printers than CMYK approximations do.\n\nGradients and gradient meshes let you add depth and dimension to vector shapes — useful for more illustrative logo styles, badge designs, or app icons that want a glossy, 3D-influenced feel rather than a completely flat aesthetic. Use gradients sparingly in logo work specifically, though, since flat, single-color logos tend to reproduce more reliably across every medium (embroidery, engraving, single-color stamps) than gradient-dependent ones.",
      ),
      AppLesson(
        title: 'Typography and Text in Illustrator',
        body:
            "Illustrator treats text as fully editable vector shapes until you choose to convert it — Type > Create Outlines turns live text into pure vector paths that can no longer be edited as text, but can be freely reshaped, distorted, or combined with other vector shapes. This is standard practice for logo work: you never send a client or printer a logo with live, editable text, because if they don't have the exact font installed, the text will reflow or substitute into a different font entirely.\n\nBefore outlining text, do all your kerning (letter spacing) and tracking adjustments while it's still live and editable — it's much easier to fine-tune than after outlining, when each letter becomes an independent shape you'd need to move manually.\n\nFor logotypes specifically (logos that are primarily typographic), it's common practice to take outlined letterforms and further customize them — adjusting individual curves, connecting letters, or modifying strokes — to create something more distinctive than an off-the-shelf font alone could provide. This is what separates a truly custom logotype from 'text set in a nice font.'",
      ),
      AppLesson(
        title: 'Gradients, Patterns, and Textures',
        body:
            "Beyond flat colors, Illustrator lets you fill shapes with gradients (smooth transitions between colors), patterns (repeating tiled artwork), and even imported textures for a more tactile, less digital-feeling result. The Gradient panel lets you control the type (linear, radial, or freeform), the angle, and add multiple color stops along the gradient's length.\n\nPattern swatches are especially useful for packaging design and textile-adjacent work — you design one small repeating tile, save it as a pattern swatch, and Illustrator seamlessly tiles it to fill any shape at any scale. Getting a pattern to tile seamlessly (no visible seams where one tile repeats into the next) takes practice, particularly matching elements that cross the tile's edges.\n\nFor a more organic, hand-crafted feel, some designers import scanned textures (paper grain, watercolor washes, ink splatters) as raster images and use them as clipping masks or blend them with vector shapes — a hybrid raster-vector approach that's increasingly common in modern branding work that wants to avoid looking too clean or corporate.",
      ),
      AppLesson(
        title: 'Building a Logo from Scratch',
        hasImage: true,
        body:
            "Logo design follows a fairly consistent professional process. Start with research and sketching on paper — many of the world's most iconic logos began as quick pencil thumbnails, because sketching lets you generate and discard ideas far faster than working directly in software. Aim for at least 20-30 rough thumbnail concepts before picking your top 3-5 to develop digitally.\n\nOnce you move into Illustrator, build the logo using simple geometric shapes and the Pen tool, working only in black and white first — color is a separate decision layered on afterward, and a logo that doesn't work in pure black should be redesigned rather than 'saved' with color. Test the logo at multiple sizes early: does it still read clearly as a 16px favicon? Does it hold up printed 3 meters wide on a banner?\n\nFinal logo delivery to a client should always include: the vector source file (.AI), an outlined/print-ready PDF, high-resolution PNGs with transparent backgrounds (both full-color and single-color/black versions), and ideally a one-page usage guide showing minimum size, clear space, and colors not to use.",
        codeSnippet:
            "Logo design checklist before final delivery:\n[ ] Works in pure black and white (no color dependency)\n[ ] Legible as a 16x16px favicon\n[ ] Holds up enlarged to billboard size\n[ ] Has a single-color / one-ink version\n[ ] Delivered as: .AI, print PDF, transparent PNG (color + black)\n[ ] Clear space and minimum size documented",
      ),
      AppLesson(
        title: 'Icon Design Principles',
        body:
            "Icons are a specialized form of logo design — small, simple, and meant to be instantly recognizable at tiny sizes, often just 24x24 or 48x48 pixels. Because of this extreme size constraint, icon design demands even more ruthless simplification than logo design: every unnecessary detail that survives at large size will simply disappear or turn to visual mud at icon size.\n\nConsistency across an icon set matters more than any individual icon's cleverness. Stroke weight, corner radius, and overall visual style (line-based vs. filled, flat vs. slightly 3D) should stay identical across every icon in a set — mixing styles within one set is one of the fastest ways to make an interface feel unpolished, even if each icon looks fine in isolation.\n\nDesign on a fixed pixel grid (commonly 24x24 with a 2px safe margin) and snap your anchor points to whole pixel values where possible — this keeps edges crisp rather than slightly blurry when the icon is eventually rendered at its target size, a subtle but very noticeable quality difference in professional icon work.",
      ),
      AppLesson(
        title: 'Preparing Files for Print and Client Handoff',
        body:
            "A design isn't finished until it's correctly packaged for whoever receives it next — a printer, a developer, or a client. For print, always convert all text to outlines (removing any font-dependency risk), embed all linked images rather than leaving them linked externally, and set your document color mode to CMYK with any spot colors clearly labeled.\n\nUse File > Package (Illustrator's built-in packaging feature) to automatically collect all linked files, fonts, and a copy of the document into one organized folder — this eliminates the common problem of sending a client an .AI file that opens with missing images or substituted fonts on their machine.\n\nWhen handing off to developers for app or web use, export individual assets as SVG (Scalable Vector Graphics) for icons and logos meant to stay crisp at any screen size, since SVG is natively supported by both web browsers and Flutter, and keeps file sizes tiny compared to exporting large PNGs at every possible resolution.",
      ),
      AppLesson(
        title: 'Mini Project: Complete Brand Mark',
        hasImage: true,
        body:
            "For your final project, design a complete logo and matching icon for a fictional small business of your choosing — a café, a tailoring shop, a tech startup, anything with a name and a clear personality. Start with paper thumbnails, select your strongest concept, and build it in Illustrator using shapes, the Pen tool, and Shape Builder.\n\nDevelop the logo in black and white first, confirm it holds up at both favicon and billboard scale, then apply a considered color palette using the color theory principles from earlier in this course. Create a simplified icon version of the same mark suitable for a 48x48px app icon, keeping the same visual DNA as the full logo but simplified for tiny-size legibility.\n\nPackage your final deliverables exactly as a real client would expect: outlined vector file, print-ready PDF, transparent PNGs in full color and single-color, and an SVG of the icon version. This full pipeline — concept to client-ready handoff — is the exact workflow used in professional freelance and agency logo work.",
      ),
    ],
  ),
  AppCourse(
    id: 'graphic_design_typography_101',
    title: 'Typography Design',
    description:
        "Understand type as a craft — anatomy, pairing, hierarchy, and how to make words as expressive as images.",
    instructor: 'Chinedu Okafor',
    category: 'Graphic Design',
    difficulty: 'Beginner',
    icon: Icons.text_fields,
    color: Colors.purple,
    duration: '5h 20m',
    lessons: [
      AppLesson(
        title: 'The Anatomy of a Letterform',
        hasImage: true,
        body:
            "Every letter has parts, and knowing their names lets you talk precisely about type choices instead of vaguely saying a font 'feels wrong.' The baseline is the invisible line letters sit on. The x-height is the height of lowercase letters like 'x' and 'n' — a taller x-height generally makes small text more readable, which is why many screen-friendly fonts have generous x-heights.\n\nAscenders are the parts of letters that rise above the x-height, like the top of a 'b' or 'h'. Descenders drop below the baseline, like the tail of a 'g' or 'y'. Serifs are the small feet or strokes at the ends of letters in serif typefaces; sans-serif fonts lack them entirely, giving a cleaner, more geometric appearance.\n\nCounters are the enclosed or partially enclosed spaces within letters, like the hole in an 'o' or 'e' — the size and shape of counters heavily influences how open or dense a typeface feels at small sizes. Learning to spot these details trains your eye to notice quality differences between fonts that might otherwise look 'basically the same' to an untrained viewer.",
      ),
      AppLesson(
        title: 'Serif vs Sans-Serif vs Display Fonts',
        body:
            "Serif fonts carry small decorative strokes at the end of letters and generally read as traditional, authoritative, and editorial — think newspapers, legal documents, and literary book covers. The serifs are believed to help guide the eye along a line of text in dense print material, though on low-resolution screens this advantage mostly disappears.\n\nSans-serif fonts strip away those decorative strokes for a cleaner, more geometric, and more modern appearance. They dominate digital interfaces, tech branding, and modern editorial design because they render crisply at small screen sizes and feel neutral rather than tied to a specific era or tradition.\n\nDisplay fonts are decorative, highly stylized typefaces meant for large sizes only — headlines, logos, posters — never body text, because their exaggerated features that look striking at 72pt become nearly unreadable at 10pt. A common and serious beginner mistake is setting an entire paragraph in a display font because it 'looks cool' in the headline; save display fonts strictly for short bursts of large text.",
      ),
      AppLesson(
        title: 'Font Pairing Principles',
        hasImage: true,
        body:
            "Pairing two fonts well in one design is a skill with real rules, not just trial and error. The most reliable strategy is contrast with connection: pick two fonts that are clearly different from each other (a bold serif headline with a clean sans-serif body, for example) but that share some underlying quality — similar x-height, similar mood, similar era — so they feel like they belong in the same family of choices even though they're visually distinct.\n\nAvoid pairing two fonts that are similar-but-not-identical, like two different sans-serif fonts that are almost the same weight and width — this reads as an accident or inconsistency rather than an intentional choice, because the eye can tell something is 'off' without being able to say exactly what.\n\nA safe, well-tested formula for beginners: pair a bold, characterful serif or display font for headlines with a simple, neutral sans-serif (like Inter, Helvetica, or Roboto) for body text. This combination appears constantly in professional editorial and branding work because it reliably balances personality (in the headline) with readability (in the body).",
        codeSnippet:
            "Beginner-safe font pairing formulas:\n1. Bold serif headline + neutral sans body\n   e.g. Playfair Display (headline) + Inter (body)\n2. Geometric sans headline + humanist sans body\n   e.g. Poppins (headline) + Open Sans (body)\n3. Monospace accent + clean sans body\n   e.g. JetBrains Mono (labels/tags) + Roboto (body)",
      ),
      AppLesson(
        title: 'Kerning, Tracking, and Leading',
        body:
            "Kerning is the spacing adjustment between two specific letters — some letter combinations (like 'AV' or 'To') have awkward default gaps that need manual tightening to look visually even, especially at large headline sizes where spacing errors become very obvious. Most design software has an 'optical kerning' auto-mode that handles this reasonably well, but large headline type often still benefits from manual fine-tuning.\n\nTracking is the spacing adjustment applied uniformly across a whole word, line, or block of text, rather than between individual letter pairs. Slightly negative tracking (tightening) often makes bold headlines feel more confident and connected; slightly positive tracking (loosening) on all-caps text — like a small label or eyebrow heading — tends to look more elegant and easier to read than default spacing.\n\nLeading (pronounced 'ledding') is the vertical space between lines of text, named after the strips of lead type-setters once used to physically separate lines of metal type. As a starting rule of thumb, body text leading should be around 120-145% of the font size — text set with leading equal to font size feels visually cramped and tiring to read for more than a sentence or two.",
      ),
      AppLesson(
        title: 'Establishing a Type Scale',
        body:
            "A type scale is a predefined, consistent set of font sizes used throughout a design or app, rather than picking sizes arbitrarily for each new headline or label. Using a scale keeps hierarchy consistent across many screens or pages, and makes a design feel systematic and considered rather than improvised piece by piece.\n\nA common way to build a scale is using a fixed ratio — each step is the previous size multiplied by a constant, like 1.25 (the 'Major Third' ratio) or 1.333 (the 'Perfect Fourth'). Starting from a 16px base body size and multiplying up gives you a mathematically related family of sizes for captions, body text, subheadings, and headlines that feel harmonious together, rather than arbitrary.\n\nIn app design specifically, it's common to define just 5-7 sizes total (e.g., caption, body, subhead, title, headline) and reuse them everywhere rather than introducing a new custom size for every new screen — this constraint might feel limiting at first, but it's exactly what keeps a large app feeling visually consistent as more screens get added over time.",
        codeSnippet:
            "Example type scale (base 16px, 1.25 ratio):\nCaption:    12.8px  ~ 13px\nBody:       16px    (base)\nSubhead:    20px\nTitle:      25px\nHeadline:   31px\nDisplay:    39px",
      ),
      AppLesson(
        title: 'Typography for Screens vs Print',
        hasImage: true,
        body:
            "Screen and print typography share the same underlying principles, but the physical medium changes some practical decisions. Screens are backlit and emit light directly into the eye, so text generally needs slightly more line spacing and slightly larger minimum sizes than the equivalent printed page to remain comfortable to read for long periods.\n\nScreen resolution also varies wildly — a font that looks crisp on a high-density phone screen might look slightly different on an older, lower-resolution device, so digital designers should always test text at multiple real device sizes rather than trusting only their design software's preview. Print, by contrast, has a single fixed resolution once it leaves the printer, so what you see (at 300 DPI) is very close to the final result.\n\nColor contrast standards also differ: on-screen text benefits from following WCAG accessibility contrast ratios (as covered in the Fundamentals course), while print text has more flexibility because ink on paper generally produces higher real-world contrast than a backlit screen at the same nominal color values.",
      ),
      AppLesson(
        title: 'Using Type Expressively',
        body:
            "Beyond pure legibility, typography can carry emotional and conceptual meaning through deliberate choices — this is sometimes called 'expressive typography.' A horror movie poster might squeeze letters into jagged, uneven shapes to feel unsettling; a children's brand might use rounded, bouncy letterforms to feel playful and friendly; a luxury brand might use extremely wide letter spacing on a thin, elegant font to feel exclusive and unhurried.\n\nOne powerful expressive technique is making the meaning of a word visually reinforce its actual meaning — setting the word 'shrinking' in progressively smaller letters, or the word 'melt' with letters that appear to drip. This technique, sometimes called 'concrete' or 'visual' typography, should be used sparingly and only for short, punchy moments — a whole paragraph of visually distorted type becomes exhausting and illegible fast.\n\nExpressive type choices always need to be balanced against the core rule from lesson one: communication first. A beautifully expressive headline that nobody can actually read has failed at its most basic job, no matter how creative the concept behind it was.",
      ),
      AppLesson(
        title: 'Working with Nigerian and African Scripts and Languages',
        body:
            "Designing for Nigerian and broader West African audiences often means typesetting text that includes special characters beyond the basic Latin alphabet — for example, Yoruba text uses diacritical marks (tonal accents) above and below certain vowels and consonants (like ẹ, ọ, ṣ) that carry real meaning and cannot simply be dropped for convenience. Always verify that any font you choose fully supports these characters before finalizing a design meant to include them.\n\nMany popular Western-designed fonts silently fail to include these diacritics, either omitting the accent entirely or substituting a generic fallback glyph that looks visually inconsistent with the rest of the typeface — check a font's full character set (often visible in a 'glyphs' panel in your design software) before committing to it for any multilingual Nigerian project.\n\nBeyond the technical character-support question, there's a growing movement of African type designers creating original typefaces informed by regional visual traditions — Adinkra symbols, traditional textile patterns, indigenous calligraphic styles — rather than defaulting to Western typefaces for every project. Exploring this space, even just for inspiration, can help your typography choices feel more locally authentic rather than imported.",
      ),
      AppLesson(
        title: 'Mini Project: Type-Only Poster',
        hasImage: true,
        body:
            "For this final project, design a poster using type alone — no photos, no illustrations, no icons — for a short phrase or quote of your choosing (a proverb, a song lyric, a personal motto). The entire visual impact must come from font choice, size, weight, color, spacing, and layout.\n\nStart by choosing a font pairing using the contrast-with-connection principle, establish a type scale for the different words or lines of your phrase, and experiment with at least one expressive typography technique where the visual treatment reinforces the meaning of a specific word.\n\nBuild the composition on a grid, apply real hierarchy so the eye knows where to look first, and refine your kerning and leading by eye rather than relying only on software defaults. When finished, step back and ask honestly: does this poster communicate instantly, or does it require effort to read? A type-only design lives or dies entirely on the typographic decisions you made.",
      ),
    ],
  ),
  AppCourse(
    id: 'graphic_design_branding_101',
    title: 'Logo & Brand Identity Design',
    description:
        "Go beyond a single logo and build a complete, consistent brand identity system that scales across every touchpoint.",
    instructor: 'Amina Suleiman',
    category: 'Graphic Design',
    difficulty: 'Advanced',
    icon: Icons.emoji_objects,
    color: Colors.teal,
    duration: '8h 15m',
    lessons: [
      AppLesson(
        title: 'What Brand Identity Really Means',
        hasImage: true,
        body:
            "A logo is one artifact; a brand identity is the entire system of visual and verbal decisions that make a business instantly recognizable and consistently understood, across every single place a customer encounters it — packaging, social media, a delivery rider's uniform, an invoice, a WhatsApp status update. Confusing 'I designed a logo' with 'I built a brand identity' is one of the most common gaps between amateur and professional design work.\n\nA strong brand identity answers a set of questions consistently, every time: what does this business stand for, who is it for, and how does it want to make people feel? These answers should be documented in a brand strategy before any visual design work starts — designing a logo without first agreeing on brand strategy is like decorating a house before deciding how many bedrooms it needs.\n\nThe deliverables of a complete brand identity project typically include: a logo suite (primary, secondary, icon-only versions), a defined color palette, a typography system, supporting graphic elements (patterns, icons, illustration style), and a brand guidelines document that ties it all together so anyone — an internal marketing team, an external printer, a social media freelancer — can apply the identity consistently without needing to ask the original designer every time.",
      ),
      AppLesson(
        title: 'Brand Strategy Before Visuals',
        body:
            "Before opening any design software, a professional brand identity project starts with discovery — understanding the client's business, competitors, and target audience deeply enough to make informed visual decisions rather than guesses. Key questions include: who exactly is the target customer, what makes this business different from competitors, and what single feeling should someone have when they encounter this brand?\n\nA competitor audit is essential and often skipped by beginners — look at 5-10 direct competitors' visual identities to understand the existing visual language of the category, and then deliberately decide whether your client's brand should blend in (signal 'we belong in this industry') or stand out (signal 'we're different from everyone else'). Both are valid strategies depending on the business's goals, but it must be a deliberate choice, not an accident.\n\nDefining 3-5 brand personality adjectives (for example: 'confident, warm, modern, unpretentious') gives you a concrete filter for every subsequent visual decision. When choosing between two font options or two color palettes later in the project, you can test each against these adjectives: does this choice feel 'confident and warm', or does it accidentally feel 'aggressive and cold'? This turns subjective design decisions into something you can defend with logic.",
        codeSnippet:
            "Brand discovery question template (fill out before designing):\n1. What does this business actually do, in one sentence?\n2. Who is the target customer? (age, income level, lifestyle)\n3. Who are 3-5 direct competitors, and how do they look visually?\n4. Should we blend in with the industry or stand out from it?\n5. List 3-5 personality adjectives this brand should feel like.\n6. What is the ONE feeling a customer should have after one interaction?",
      ),
      AppLesson(
        title: 'Designing the Logo Suite',
        hasImage: true,
        body:
            "A professional logo is never delivered as a single fixed image — it's delivered as a suite of related variations built to handle every real-world context. The primary logo (usually the full lockup with icon and wordmark together) is the default version. A secondary or stacked version rearranges the same elements for square or vertical spaces, like a social media profile picture, where the primary horizontal lockup wouldn't fit well.\n\nAn icon-only or 'mark' version strips the logo down to just its symbol, with no text — used for tiny spaces like a favicon, an app icon, or a watermark, where a full wordmark would be illegible. Every element of the suite must share the same visual DNA — the same shapes, the same color logic, the same overall feeling — so that even the icon-only version is instantly recognizable as belonging to the same brand as the full lockup.\n\nDesigners should also prepare monochrome versions (pure black, and pure white/reversed) of every variation in the suite, for situations where full color reproduction isn't possible or appropriate — a single-color engraving, a fax, a black-and-white newspaper ad, or an embroidered uniform patch that can only use one thread color.",
      ),
      AppLesson(
        title: 'Building a Full Color System',
        body:
            "A brand color system goes beyond the two or three colors used directly in the logo — it typically defines a primary palette (the core 2-4 brand colors), a secondary/supporting palette (additional colors for backgrounds, illustrations, and variety), and functional colors (specific colors reserved for success messages, errors, warnings, especially relevant for a brand that includes a digital app).\n\nEvery color in the system should be documented with exact values across every color mode it might be needed in: HEX for digital/web, RGB for screen design software, CMYK for print, and ideally Pantone if the brand will regularly use professional offset printing. Without this documentation, different people applying the brand across different mediums will inevitably produce slightly different, inconsistent versions of 'the brand blue.'\n\nAccessibility should be checked at the system level, not just per-design: does the primary color combination meet WCAG contrast requirements when used as text on the brand's typical background colors? A beautiful brand palette that fails basic accessibility standards will create real problems once the brand is applied to an actual app or website with real users, some of whom have visual impairments.",
      ),
      AppLesson(
        title: 'Typography Systems for Brands',
        body:
            "A brand typography system typically defines a primary typeface (used for headlines and brand moments) and a secondary typeface (used for body text and functional UI content), similar to font pairing principles but formalized into strict, documented rules rather than case-by-case choices. Some brands add a third, tertiary typeface reserved for very specific uses — a monospace font for displaying prices or codes, for example.\n\nLicensing matters enormously at the brand level in a way it doesn't for a single personal project — a font that's free for personal use may require a paid commercial license once it's applied across a business's branding, marketing, packaging, and app. Always verify licensing terms before finalizing a brand's official typefaces, since a brand relaunch due to font licensing issues is an expensive, embarrassing mistake.\n\nDocument the full type system with exact size, weight, and use-case rules — 'Headline: [Font] Bold, 32px, used only for page titles' — so that whoever implements the typography in an app, website, or printed material afterward has zero ambiguity about which font, weight, and size to use in any given context.",
      ),
      AppLesson(
        title: 'Supporting Graphic Elements',
        hasImage: true,
        body:
            "Beyond the logo, color, and type, strong brand identities usually include a set of supporting graphic elements that extend the brand's visual language into everyday materials — a custom pattern derived from the logo's shapes, a consistent icon style used across the app or website, or an illustration style guide if the brand uses custom illustrations rather than photography.\n\nThese supporting elements are what make a brand feel rich and complete rather than just 'a logo slapped on things.' A pattern built from a simplified, repeated version of the logo's icon can appear on packaging, business cards, or app loading screens, reinforcing brand recognition even in places where the full logo doesn't appear.\n\nPhotography style is another often-overlooked supporting element — should brand photography be bright and airy, or moody and high-contrast? Should it feature real customers, or professional models? Should it be shot on white backgrounds, or in real, lived-in environments? Documenting these preferences prevents a brand's photography from feeling inconsistent across different photographers and campaigns over time.",
      ),
      AppLesson(
        title: 'Writing Brand Guidelines Documents',
        body:
            "A brand guidelines document (sometimes called a 'brand book' or 'style guide') is the single reference document that ties an entire identity system together, and is arguably the most valuable deliverable in a branding project because it's what makes the identity usable by people who aren't the original designer, for years after the project ends.\n\nA solid guidelines document typically covers: the logo suite with correct and incorrect usage examples (showing what NOT to do is often more instructive than only showing correct usage), minimum size and clear space requirements, the full color system with exact values, the typography system with size and weight rules, and examples of the identity applied to real materials — a business card, a social media post, a product label — so readers can see the system in context rather than only in the abstract.\n\nGuidelines documents should be realistic about their audience: assume the person applying the brand later may have very little design training. Write instructions in plain, specific language rather than vague design jargon, and show, don't just tell — a single labeled diagram of 'correct clear space' communicates more instantly than a paragraph describing it in words.",
        codeSnippet:
            "Brand guidelines document — standard sections:\n1. Brand story & personality (1-2 pages)\n2. Logo suite + correct/incorrect usage examples\n3. Clear space & minimum size rules\n4. Full color palette (HEX/RGB/CMYK/Pantone)\n5. Typography system (fonts, sizes, weights, use-cases)\n6. Supporting graphic elements (patterns, icons, photography style)\n7. Applied examples (business card, social post, packaging mockup)",
      ),
      AppLesson(
        title: 'Applying the Brand Across Touchpoints',
        body:
            "A brand identity is only proven to work once it's tested across real, varied touchpoints — not just admired as a logo on a white background. Design a handful of realistic application mockups as part of any branding project: a business card, a social media post template, an invoice or letterhead, and if relevant, an app screen or packaging label.\n\nEach touchpoint has its own constraints that stress-test the identity in different ways. A business card is tiny and needs the logo and type to stay legible at a physical size of roughly 85x55mm. A social media post needs the brand to hold up next to bright, competing content in a crowded feed. An app screen needs the color palette to work as functional UI colors (buttons, states, backgrounds), not just decorative brand colors.\n\nIf a brand identity breaks down or needs significant compromise at any of these real touchpoints — the logo becomes illegible at business card size, the color palette doesn't have enough contrast options for a usable app UI — that's a sign the core identity needs revision, not that each individual application needs a workaround. A truly strong system should flex gracefully across contexts without needing fundamental exceptions.",
      ),
      AppLesson(
        title: 'Presenting and Defending Design Decisions to Clients',
        body:
            "Presenting brand work professionally is a distinct skill from designing it, and weak presentation can sink genuinely strong design work just as easily as weak design can. Never present a logo or brand concept without context — always reconnect each visual decision back to the brand strategy and personality adjectives established earlier, so the client understands the 'why', not just the 'what.'\n\nPresent options with intention rather than overwhelming a client with too many undifferentiated choices. A common professional structure is presenting 2-3 genuinely distinct directions (not just color variations of the same concept), each clearly explained in terms of the strategic reasoning behind it, letting the client choose a direction to refine rather than trying to please everyone with one compromise concept.\n\nWhen a client pushes back or requests changes, resist the instinct to immediately agree or immediately defend without listening — first ask clarifying questions to understand the actual concern behind the feedback ('the logo feels too corporate' might really mean 'it doesn't feel warm enough for our personality adjectives'), then respond with reasoning tied back to the agreed brand strategy, rather than purely aesthetic opinion.",
      ),
      AppLesson(
        title: 'Mini Project: Full Brand Identity System',
        hasImage: true,
        body:
            "For your final project, choose a fictional or real small business and build a complete brand identity from scratch, following the full professional process from this course. Start with a written brand strategy document — target customer, competitor audit, and 3-5 personality adjectives — before touching any design software.\n\nDesign a full logo suite (primary, secondary/stacked, and icon-only versions, each in full color and monochrome), define a complete color system with documented HEX/RGB/CMYK values, and establish a typography system with primary and secondary typefaces and documented size/weight rules. Add at least one supporting graphic element, such as a simple pattern derived from the logo.\n\nCompile everything into a brand guidelines document following the standard section structure, and create at least two realistic application mockups — a business card and a social media post — to prove the system holds up in real-world use. This complete pipeline, from strategy to guidelines to applied mockups, mirrors exactly what a paying client expects from a professional branding engagement.",
      ),
    ],
  ),
  AppCourse(
    id: 'graphic_design_uiux_101',
    title: 'UI/UX Design Basics',
    description:
        "Learn to design digital interfaces that are both beautiful and genuinely usable, from wireframe to polished screen.",
    instructor: 'Tobenna Nwachukwu',
    category: 'Graphic Design',
    difficulty: 'Intermediate',
    icon: Icons.web,
    color: Colors.indigo,
    duration: '7h 05m',
    lessons: [
      AppLesson(
        title: 'UI vs UX: What\'s the Difference?',
        hasImage: true,
        body:
            "UX (User Experience) design is concerned with how something works — the flow, the logic, the ease of accomplishing a task. UI (User Interface) design is concerned with how something looks — the colors, the type, the visual polish applied to that flow. They are deeply connected but genuinely distinct skills, and confusing them causes real problems: a beautiful UI on top of a confusing UX still produces a frustrating product.\n\nA useful analogy is a building: UX is the architect's floor plan — where the rooms are, how people move between them, whether the layout actually makes sense for how the building will be used. UI is the interior designer's work — the paint colors, the furniture, the lighting fixtures, layered on top of a floor plan that (hopefully) already makes functional sense.\n\nIn practice, most working designers do both, especially at smaller companies and startups, which is why courses like this one teach them together. But understanding them as separate disciplines helps you diagnose problems accurately: if users are getting lost or confused, that's usually a UX (flow/logic) problem, even if the interface looks visually impressive.",
      ),
      AppLesson(
        title: 'User Research Basics',
        body:
            "Good UI/UX design starts with understanding real users, not assumptions about them. Even lightweight research — five informal conversations with real or potential users — reveals assumptions that turn out to be wrong far more often than designers expect, and catching those assumptions early is dramatically cheaper than discovering them after a full app is built.\n\nUser interviews should ask about behavior and past experience, not hypothetical future behavior — asking 'would you use a feature like X?' tends to produce overly optimistic, unreliable answers, because people are bad at predicting their own future behavior. Asking 'walk me through the last time you tried to do X' produces much more reliable, concrete insight into real pain points and workarounds people already use.\n\nPersonas — semi-fictional profiles representing key user types, built from real research rather than guesswork — help keep a design team aligned on who they're actually designing for throughout a project. A simple persona includes a name, key goals, key frustrations, and relevant context (tech comfort level, typical device, connectivity constraints) — for a Nigerian app specifically, things like typical data costs and common device specs are often more relevant context than they would be for a similar app built primarily for a different market.",
      ),
      AppLesson(
        title: 'Information Architecture and User Flows',
        hasImage: true,
        body:
            "Information architecture is how content and features are organized and labeled within an app — which screen has what, and how everything is grouped into a navigable structure. Before designing a single screen, map out the full structure: what are the main sections, and how does a user move between them? A simple way to start is a sitemap — a tree diagram showing every screen and how they connect.\n\nUser flows go one level more specific than a sitemap: they map the exact step-by-step path a user takes to complete one specific task, like 'sign up for an account' or 'purchase a product.' Mapping flows before designing screens reveals friction points early — if a simple task requires eight screens and eleven taps, that's a problem worth solving in the flow stage, long before any visual design work begins, when fixing it is still cheap.\n\nA common mistake is jumping straight into visual screen design before either of these steps, which usually results in a structure that technically works but wasn't deliberately planned — extra screens bolted on as afterthoughts, inconsistent navigation patterns between sections, or features that are hard to find because they were never mapped against how users actually think about the app's structure.",
      ),
      AppLesson(
        title: 'Wireframing: Designing the Skeleton',
        body:
            "Wireframes are low-fidelity, deliberately unpolished layouts — usually greyscale boxes and placeholder text — that establish where things go on a screen before any visual design (color, imagery, final type) is applied. The point of low fidelity is speed and honest feedback: stakeholders reviewing a rough wireframe give feedback on structure and flow, while stakeholders reviewing a polished, colorful mockup tend to fixate on surface details like color choice instead.\n\nWireframing forces you to make structural decisions explicitly: where does the primary action button go? How much content fits above the fold before scrolling? What's the priority order of elements on this screen? These are UX decisions, and making them clearly in wireframe form before adding visual polish keeps the two concerns (structure vs. style) properly separated.\n\nMost designers now wireframe digitally (Figma is the current industry standard) rather than on paper, because digital wireframes can be quickly turned into clickable, testable prototypes — but starting with quick pen-and-paper sketches for early exploration is still extremely common and often faster for rapidly generating and discarding layout ideas before committing to one in a design tool.",
      ),
      AppLesson(
        title: 'Design Systems and Component Libraries',
        hasImage: true,
        body:
            "A design system is a reusable library of components — buttons, input fields, cards, navigation bars — built once with consistent styling, then reused throughout an entire app rather than redesigned from scratch on every new screen. This is the professional standard for any app beyond a handful of screens, because it guarantees visual consistency and dramatically speeds up designing new screens later.\n\nEach component in a design system typically has defined states — a button has a default state, a hover/pressed state, a disabled state, and sometimes a loading state — all designed and documented up front, so developers implementing the design know exactly how each component should behave in every situation, not just its default appearance.\n\nDesign systems pair naturally with the type scale and color system concepts from earlier courses — a button component references specific colors and font sizes from the system's defined palette and scale, rather than using one-off custom values. This linkage is what makes design systems 'systems' rather than just a loose collection of reusable pieces: change a core color value, and every component referencing it updates automatically.",
      ),
      AppLesson(
        title: 'Mobile-First Design Principles',
        body:
            "Designing mobile-first means starting the design process for the smallest, most constrained screen size first, then expanding to larger screens (tablet, desktop) afterward — rather than the reverse. This constraint-first approach tends to produce cleaner, more focused designs, because the small screen forces genuinely difficult prioritization decisions that get skipped if you start with generous desktop screen space.\n\nTouch targets need to be considerably larger than mouse-click targets — Apple and Google both recommend a minimum touch target size around 44-48 logical pixels, because a finger is far less precise than a mouse cursor, and a button that's too small causes frustrating mis-taps, especially for users with larger fingers or reduced dexterity.\n\nThumb-reach zones matter enormously on mobile: on a typical one-handed phone grip, the bottom third of the screen is easiest to reach, the middle is reachable with some stretch, and the top corners are hardest to reach comfortably. This is exactly why primary navigation and key actions are increasingly placed at the bottom of mobile apps (bottom nav bars, floating action buttons) rather than the top, which was the older desktop-influenced convention.",
        codeSnippet:
            "Mobile touch target minimums:\niOS (Apple HIG):     44 x 44 pt minimum\nAndroid (Material):  48 x 48 dp minimum\nSpacing between adjacent tappable targets: 8dp minimum\nRule of thumb: if you'd need a fingernail, not a fingertip, to tap it — make it bigger.",
      ),
      AppLesson(
        title: 'Usability Testing Basics',
        body:
            "Usability testing means watching real people attempt real tasks using your design, and observing where they struggle — it is the single most reliable way to catch UX problems before launch, and it's astonishing how often even very experienced designers are surprised by what testing reveals about their own work. A test with just five participants typically uncovers the large majority of major usability problems in a design, a well-established finding in UX research.\n\nDuring a test, give participants a realistic task ('find and buy the cheapest data plan on this screen') rather than asking them to simply 'look around and give feedback' — task-based testing reveals real friction, while open browsing tends to produce vague, less actionable feedback. Resist the urge to help or explain when someone gets stuck; the moment of confusion is exactly the valuable data you're trying to observe and later fix.\n\nTest with low-fidelity prototypes as early as possible — even a clickable wireframe prototype in Figma can reveal major flow problems, and testing early means structural issues get fixed before expensive visual design and development work has been invested in a flawed flow. Testing only after full development is far more costly to fix.",
      ),
      AppLesson(
        title: 'Accessibility in UI Design',
        hasImage: true,
        body:
            "Accessible design means an interface can be used by people with a wide range of abilities — visual, motor, cognitive, and hearing — and it is not an optional 'nice to have' add-on but a core requirement of professional UI/UX work. Roughly 1 in 6 people globally live with some form of significant disability, meaning inaccessible design actively excludes a meaningful portion of any app's potential user base.\n\nColor contrast (covered earlier for print) applies with even more rigor to app UI, since screens are viewed in wildly variable lighting conditions, including bright outdoor sunlight where low-contrast text becomes genuinely unreadable. Never rely on color alone to convey information either — an error state shown only as 'red text' fails for colorblind users; pairing color with an icon or explicit text label ('Error: invalid phone number') fixes this reliably.\n\nText size should be resizable and never locked to a fixed pixel value that ignores a user's device accessibility settings — many users, especially older users, increase their device's default text size, and an app that breaks or clips text when this happens creates real, unnecessary frustration for exactly the users who need that flexibility most.",
      ),
      AppLesson(
        title: 'From Design to Developer Handoff',
        body:
            "A finished design isn't useful until it's successfully translated into working code, and handoff quality dramatically affects how accurately a developer can implement a design. Modern tools like Figma allow developers to inspect exact spacing, colors, font sizes, and component structure directly from the design file, removing most of the ambiguity that used to require constant back-and-forth clarification.\n\nAnnotate anything that isn't visually obvious from the static design alone — what happens when this list is empty? What's the loading state for this screen? What's the exact error message copy when this form field is invalid? These 'edge case' states are frequently missed in the initial screen design but are exactly the states real users encounter constantly in a live app.\n\nMaintain an open, collaborative relationship with developers rather than treating handoff as a one-way delivery — developers often surface genuine technical constraints (certain animations being expensive on lower-end Android devices, certain layouts being genuinely difficult in Flutter's widget system) that are far better addressed as a design adjustment early than discovered as a broken promise late in development.",
      ),
      AppLesson(
        title: 'Mini Project: Design a Three-Screen App Flow',
        hasImage: true,
        body:
            "For your final project, choose a simple app concept (a food delivery app, a savings/budgeting app, a local services marketplace — anything with a clear core task) and design a complete three-screen user flow: an onboarding/home screen, a core task screen, and a confirmation/success screen.\n\nStart with a simple user flow diagram mapping the exact steps between the three screens, then build low-fidelity wireframes for each screen before adding any visual polish. Once your structure is solid, apply a small design system: define a color palette, a type scale, and reusable button/input component styles, and use them consistently across all three screens.\n\nDesign at least one accessibility consideration explicitly — verify your text contrast ratios and ensure your primary touch targets meet the 44-48px minimum. If possible, show your wireframes to one real person and watch them attempt to 'complete' the flow verbally, noting any point of confusion — this small test mirrors the real usability testing process from this course, at a scale achievable for a student project.",
      ),
    ],
  ),
  AppCourse(
    id: 'graphic_design_canva_101',
    title: 'Canva for Social Media Graphics',
    description:
        "Produce fast, professional-looking social media content using Canva — no complex software required.",
    instructor: 'Halima Yusuf',
    category: 'Graphic Design',
    difficulty: 'Beginner',
    icon: Icons.image,
    color: Colors.green,
    duration: '4h 40m',
    lessons: [
      AppLesson(
        title: 'Why Canva and When to Use It',
        hasImage: true,
        body:
            "Canva is a browser-based design tool built around templates and drag-and-drop editing, making it dramatically faster to learn than Photoshop or Illustrator while still producing genuinely professional results for the right use cases — social media posts, simple flyers, presentation slides, and basic marketing graphics. It is not a replacement for Illustrator on precise vector logo work, or Photoshop on advanced photo retouching, but for fast-turnaround social content, it's often the better professional choice.\n\nThe core Canva workflow is starting from a template close to what you need, then customizing it — swapping colors, fonts, images, and text to match your brand — rather than building from a completely blank canvas every time. This template-first approach is exactly why Canva is so fast: you're editing a pre-solved layout rather than solving hierarchy and composition problems from zero on every single post.\n\nFor a business or personal brand posting regularly on social media, Canva's speed advantage compounds quickly — a designer who might spend 45 minutes on a single Instagram post in Photoshop can often produce an equally polished post in Canva in 10-15 minutes once a brand kit and a few core templates are set up, which matters enormously for anyone who needs to post consistently rather than occasionally.",
      ),
      AppLesson(
        title: 'Setting Up Brand Kit',
        body:
            "Canva's Brand Kit feature (available on Canva Pro) lets you save your brand's exact colors, fonts, and logo once, then apply them instantly to any new design with a couple of clicks rather than manually re-entering hex codes and re-uploading logo files every single time. Setting this up correctly at the start saves enormous time across dozens or hundreds of future posts.\n\nUpload your logo in multiple formats within Brand Kit — full color, white/reversed version for dark backgrounds, and icon-only version — so the correct version is always one click away regardless of what background color a given post uses. Also save your exact brand colors as hex codes rather than eyeballing similar-looking colors each time, which prevents color drift across dozens of posts over months.\n\nUpload your brand fonts if they're custom or paid fonts not in Canva's free default library, and clearly label font pairs for headline vs. body use within your own notes, so that even if you're not the one creating every single post (a social media assistant might be), brand consistency is maintained without requiring deep design knowledge from whoever is actually building the posts day to day.",
      ),
      AppLesson(
        title: 'Understanding Platform-Specific Sizes',
        hasImage: true,
        body:
            "Every social platform has different optimal image dimensions, and designing at the wrong size leads to awkward cropping or wasted empty space once a platform resizes your upload to fit its own layout. Canva includes built-in size presets for most major platforms, which removes most of the guesswork, but it's still worth understanding the core dimensions for the platforms you use most.\n\nInstagram feed posts work best as a 1:1 square (1080x1080px) or 4:5 portrait (1080x1350px) — portrait format is increasingly preferred because it takes up more vertical space in the feed, increasing visibility relative to a square post. Instagram and TikTok/Reels vertical video and story formats use a 9:16 ratio (1080x1920px), filling the entire phone screen.\n\nFacebook and Twitter/X have their own slightly different optimal dimensions, and using the exact same square Instagram graphic across every platform without adjustment often results in awkward cropping on story formats, or excessive empty space on wider formats. Always check Canva's specific size preset for the exact platform and post type before beginning a new design, rather than assuming one universal size fits everywhere.",
        codeSnippet:
            "Common social media size cheat sheet:\nInstagram feed (square):    1080 x 1080 px\nInstagram feed (portrait):  1080 x 1350 px\nInstagram/TikTok Story/Reel:1080 x 1920 px\nFacebook post:               1200 x 630 px\nTwitter/X post:               1200 x 675 px\nLinkedIn post:                1200 x 627 px\nYouTube thumbnail:            1280 x 720 px",
      ),
      AppLesson(
        title: 'Choosing and Customizing Templates',
        body:
            "Start any new design by searching Canva's template library using specific keywords related to your goal — 'sale announcement', 'quote post', 'event flyer' — rather than browsing generically, since specific searches surface templates already close to your actual layout need. Once you find a promising template, evaluate it structurally first: does the hierarchy and layout make sense for your content, ignoring its current colors and fonts for a moment?\n\nCustomizing a template well means replacing every element with your own brand — colors from your Brand Kit, your own fonts, your own images or icons — not just swapping the headline text and leaving the rest as-is. A post that still visibly uses a template's original stock colors and default font looks generic and is often recognizable as 'a Canva template' to anyone who uses the platform regularly, undermining a sense of unique brand identity.\n\nDon't be afraid to combine elements from multiple templates — copy a layout structure you like from one template, but a color treatment or icon style from another — Canva makes it easy to duplicate elements between open designs. This mix-and-match approach, applied consistently with your Brand Kit, produces results that feel custom even though you started from templates rather than a blank canvas.",
      ),
      AppLesson(
        title: 'Working with Text and Text Effects',
        hasImage: true,
        body:
            "Canva's text tool includes built-in effects — shadow, outline, curve, background highlight — accessible from the Effects panel once a text box is selected, letting you add visual polish quickly without needing separate design software. Use these deliberately rather than defaulting to a heavy effect on every headline; a subtle shadow to lift text off a busy photo background often looks more professional than an elaborate curved-and-outlined treatment.\n\nCanva also supports combining multiple text boxes with different sizes and weights to build a clear hierarchy within one graphic — a small 'eyebrow' label above a large bold headline, followed by smaller supporting body text below, mirroring the same hierarchy principles from the Fundamentals course, just applied inside Canva's specific interface.\n\nFor social posts specifically, keep text minimal and large — platforms like Instagram display images at relatively small sizes within a crowded, fast-scrolling feed, so a post with a dense paragraph of small text will simply not get read. A strong headline of 3-8 words, readable even as a thumbnail while scrolling quickly, will outperform a text-heavy post nearly every time on social platforms.",
      ),
      AppLesson(
        title: 'Using Photos, Elements, and Stickers Effectively',
        body:
            "Canva's built-in photo library, alongside icons ('elements'), and stickers gives you a huge amount of visual material without needing external design assets — but overusing decorative stickers and clashing icon styles is one of the fastest ways to make a Canva design look amateur and cluttered rather than polished.\n\nWhen searching Canva's stock photo library, favor images that feel authentic and locally relevant over generic, obviously staged stock photography — for a Nigerian audience specifically, seek out photos featuring Nigerian people, settings, and products where relevant, since audiences respond more strongly to imagery that reflects their own reality rather than generic international stock photography.\n\nWhen using icon 'elements,' stick to one consistent style (all line icons, or all solid/filled icons) throughout a single design, exactly as covered in the Illustrator course's icon design principles — Canva's element library spans many different icon styles, so it's easy to accidentally mix them if you're not deliberately filtering by a consistent style as you search and select.",
      ),
      AppLesson(
        title: 'Creating Templates for Consistent Branding',
        hasImage: true,
        body:
            "Once you've built one social post you're happy with, save it as a reusable template within your own Canva account (using the 'Create a template' feature on Canva Pro, or simply duplicating the file as a starting point) rather than rebuilding the same structure from scratch for every future post. This is how professional social media managers maintain visual consistency across hundreds of posts over months, without each one needing an independent design decision from zero.\n\nBuild templates for your recurring content types specifically — a quote post template, a product announcement template, a testimonial post template — each with the layout and hierarchy already solved, needing only new text and images swapped in for each new instance. This dramatically speeds up ongoing content production while guaranteeing every post feels like it belongs to the same consistent brand.\n\nReview your template set periodically (every few months) against your actual brand evolution — as a brand's visual identity naturally evolves, old templates can start to feel dated even if each individual post still looks fine in isolation, so refreshing templates periodically keeps an ongoing content calendar feeling current rather than stuck in an earlier design era.",
      ),
      AppLesson(
        title: 'Animation and Simple Motion in Canva',
        body:
            "Canva supports simple animation — applying pre-built animation styles to text, images, or entire pages — which is especially useful for Instagram/TikTok Stories and Reels, where motion tends to capture attention more effectively than a fully static image in a fast-scrolling, video-heavy feed environment.\n\nUse animation deliberately and sparingly rather than applying a different flashy effect to every single element on a page — a single well-chosen entrance animation on a headline, combined with static supporting elements, usually looks more professional and intentional than a page where every element bounces, flies, or fades in with a different effect simultaneously.\n\nCanva also supports exporting designs directly as MP4 video or animated GIF, which is necessary if you're posting animated content to platforms that require video format specifically (like Instagram Reels or TikTok) rather than a static image — check your target platform's accepted formats before exporting, since posting the wrong file type is a common and easily avoidable beginner mistake.",
      ),
      AppLesson(
        title: 'Batch Content Creation Workflow',
        body:
            "Producing social content consistently, week after week, requires a repeatable workflow rather than starting from zero for every single post — this is where Canva's speed advantage becomes most valuable for anyone managing an ongoing content calendar rather than a single one-off design.\n\nA practical batch workflow: plan a week or month of content in advance (topics, key messages) before opening Canva at all, then use your saved brand templates to quickly produce all the graphics for that period in one focused working session, rather than designing reactively one post at a time right before each posting deadline. Batching this way is significantly more efficient than context-switching between planning and designing throughout the week.\n\nCanva's 'Bulk Create' feature (Pro feature) can even auto-generate multiple versions of a template from a connected spreadsheet of text data — useful for producing many similar posts quickly, like a week of daily quote posts or a set of product announcement graphics for an entire catalog, each pulling different text and images from spreadsheet rows into the same consistent template structure.",
      ),
      AppLesson(
        title: 'Mini Project: One Week of Social Content',
        hasImage: true,
        body:
            "For your final project, design a full week of social media content (5-7 posts) for a fictional or real small business, using everything covered in this course. Start by setting up a Brand Kit with a chosen color palette, font pairing, and logo placement, then plan your week's content topics before opening any templates.\n\nBuild at least two reusable templates — for example, one for quote/tip posts and one for product or promotion announcements — and use them to quickly produce your full week of content, applying consistent hierarchy, text treatment, and photo/icon style across every post. Ensure every post uses the correct platform-specific dimensions for its intended destination (feed post vs. Story format).\n\nAs a final step, animate at least one post for use as an Instagram/TikTok Story, applying a single deliberate entrance animation rather than combining several competing effects. Export your full batch in the correct formats and sizes, exactly as you would deliver a finished week of content to a real client managing their social media presence.",
      ),
    ],
  ),
  AppCourse(
    id: 'graphic_design_print_101',
    title: 'Print Design & Layout',
    description:
        "Master the technical realities of print — bleed, CMYK, paper stock, and multi-page layout for brochures and booklets.",
    instructor: 'Ikechukwu Obiora',
    category: 'Graphic Design',
    difficulty: 'Advanced',
    icon: Icons.print,
    color: Colors.brown,
    duration: '6h 30m',
    lessons: [
      AppLesson(
        title: 'How Printing Actually Works',
        hasImage: true,
        body:
            "Most commercial printing uses the CMYK (Cyan, Magenta, Yellow, Key/Black) process, where four ink layers are printed on top of each other in tiny dots to create the illusion of full color when viewed at normal distance — this is fundamentally different from how screens create color, which mix red, green, and blue light directly. Understanding this difference explains why colors sometimes shift unexpectedly between what you see on screen and what comes out of a printer.\n\nOffset printing (used for large runs — thousands of copies) uses metal plates and is extremely cost-efficient at scale but has a higher upfront setup cost, making it uneconomical for small quantities. Digital printing (used for small runs — from 1 to a few hundred copies) works more like a very high-end office printer, with lower setup cost but a higher per-unit cost, making it the better choice for smaller orders or one-off proofs.\n\nUnderstanding your actual print quantity before designing matters because it affects real decisions — a design with many spot colors or elaborate finishing techniques (foil stamping, embossing) makes more financial sense for a large offset run where the setup cost is spread across thousands of units, but the same techniques might be prohibitively expensive for a short digital run of 50 business cards.",
      ),
      AppLesson(
        title: 'Bleed, Trim, and Safe Zones',
        hasImage: true,
        body:
            "Bleed is extra artwork extended beyond the final trim edge of a printed piece — typically 3mm on each side — that gets physically cut away during the trimming process. Bleed exists because paper-cutting is never perfectly precise at industrial scale; without bleed, any tiny misalignment in cutting would reveal a thin sliver of unprinted white paper at the edge of your design.\n\nThe trim line marks exactly where the final piece will be cut — this is your design's actual final size. The safe zone is an additional margin (commonly 3-5mm) inside the trim line, within which you should keep all critical content like text and logos, because cutting tolerance means content very close to the trim line risks being cut off entirely on some copies within a print run.\n\nAny background color, image, or pattern that touches the edge of your design must be extended into the bleed area at final export — leaving it stopping exactly at the trim line is one of the single most common and easily avoidable errors that gets a print job rejected or reprinted at the designer's expense by a professional print shop.",
        codeSnippet:
            "Standard print safety margins (business card example, 90x54mm):\nFinal trim size:   90mm x 54mm\nBleed (extend to): 96mm x 60mm (adds 3mm each side)\nSafe zone (keep text/logo inside): 84mm x 48mm (3mm margin inside trim)\n\nRule: backgrounds/images extend to bleed edge.\nRule: important text/logos stay inside safe zone.",
      ),
      AppLesson(
        title: 'Paper Stock and Finishing Options',
        body:
            "Paper stock choice significantly affects how a printed piece feels and how colors actually render, and it's a decision every professional print designer needs to make deliberately rather than leaving to a printer's default. Weight (measured in gsm — grams per square meter) affects sturdiness and perceived quality — business cards typically use heavier stock (300-400gsm) than a multi-page brochure's interior pages (130-170gsm), which need to stay flexible enough to fold and bind.\n\nFinish affects both look and color accuracy: gloss finish makes colors appear more vibrant and saturated but increases glare and can make text harder to read under certain lighting; matte finish produces more muted, sophisticated-looking colors with no glare, often preferred for premium or minimalist brand work. Uncoated stock feels more tactile and 'natural,' often used for stationery or brands wanting an artisanal, less corporate feel.\n\nSpecial finishing techniques — spot UV (glossy raised coating on specific areas), foil stamping (metallic finish, often gold or silver), embossing/debossing (raised or recessed texture) — add significant tactile and visual distinction but also significantly add to cost and production time, so they're typically reserved for premium materials like invitations, luxury packaging, or a flagship brand's business cards, rather than everyday high-volume print materials.",
      ),
      AppLesson(
        title: 'Multi-Page Layout: Grids for Brochures and Booklets',
        hasImage: true,
        body:
            "Multi-page print pieces — brochures, booklets, magazines — require a consistent grid system applied across every page, exactly as covered in the Fundamentals course, but with the added complexity of designing spreads (two facing pages viewed together) rather than isolated single pages, since that's how a reader actually experiences a bound piece once opened.\n\nMaster pages (a feature in InDesign, the industry-standard tool for this kind of layout work) let you define repeating elements — page numbers, running headers, consistent margins — once, and have them automatically apply across every page in the document, rather than manually recreating them on each individual page and risking inconsistency.\n\nWhen designing spreads, be conscious of the gutter — the inner margin where two pages meet at the spine — and keep important content, especially text, away from this area, since content placed too close to the spine can become difficult to read or even physically obscured depending on the binding method used (saddle-stitch, perfect binding, spiral) once the piece is actually bound and opened.",
      ),
      AppLesson(
        title: 'Working with InDesign for Long Documents',
        body:
            "Adobe InDesign is the industry-standard tool specifically for multi-page layout work — while Illustrator and Photoshop can technically create single-page designs, InDesign's page management, master pages, and text-flow features make it dramatically more efficient for anything beyond a handful of pages, like a magazine, book, catalog, or extended brochure.\n\nText threading is one of InDesign's most powerful features for long documents: when text overflows a text box, InDesign lets you 'thread' the overflow into a new text box (potentially on a different page), and the text automatically reflows across all threaded boxes as you edit content earlier in the chain — essential for anything with substantial body copy, like a multi-page article or report.\n\nParagraph and character styles (similar in concept to CSS styles for web design) let you define formatting rules once — 'Heading 1: Bold, 24pt, brand blue' — and apply them consistently across an entire long document with one click, then update every instance at once by editing the style definition rather than manually reformatting dozens of individual headings if the design changes.",
        codeSnippet:
            "InDesign paragraph style example (conceptual):\nStyle name: 'Body Text'\n  Font: [Brand secondary font], Regular\n  Size: 10pt\n  Leading: 14pt (140% of size)\n  Space after paragraph: 6pt\n  Alignment: Left, no hyphenation\n\nApply once → update the style definition later → every tagged paragraph updates automatically.",
      ),
      AppLesson(
        title: 'Preflighting and Preparing Print-Ready Files',
        body:
            "Preflighting is the final technical check performed before sending any file to a printer, catching issues that would otherwise cause a rejected job, unexpected reprint costs, or a finished product with visible errors. InDesign includes a built-in Preflight panel that automatically flags common problems in real time as you work — missing fonts, low-resolution images, or content that isn't within the printable bleed area.\n\nBefore exporting a final print-ready PDF, verify: all fonts are either embedded or outlined (to prevent substitution on a different machine), all linked images are at least 300 DPI at their final placed size (a low-resolution image that looked fine small can become visibly blurry when placed larger), and the color mode is CMYK throughout, not accidentally left in RGB from an earlier stage of the design process.\n\nMost professional print shops request a specific PDF export standard called PDF/X-1a, which automatically enforces many of these requirements (embedding fonts, flattening transparency, converting to CMYK) at export time — using this standard, rather than a generic 'Print' PDF preset, significantly reduces the chance of technical rejection once the file reaches the actual print shop.",
      ),
      AppLesson(
        title: 'Designing for Different Print Products',
        hasImage: true,
        body:
            "Different print products carry their own specific technical requirements beyond the general bleed/safe-zone/CMYK rules already covered. Business cards need to account for standard sizes that vary slightly by region (Nigeria and much of Africa commonly use 90x54mm, close to the European standard, while the US uses a slightly different 89x51mm) — always confirm the exact expected size with your specific printer before finalizing a layout.\n\nFolded materials — brochures, tri-folds, invitation cards — require accounting for the folding mechanism itself in your layout: a standard tri-fold brochure's three panels are not perfectly equal width, because the innermost folding panel needs to be very slightly narrower than the others so it tucks cleanly inside without buckling against the outer panels once folded.\n\nLarge format prints — banners, roll-up stands, billboards — are typically designed at a reduced scale (say, 1:10) rather than at true final size, since working at true billboard size in design software is impractical, but this requires extra care to ensure text and detail remain legible once scaled back up to full size — a good rule is to step back from your screen and view the reduced-scale design from a proportionally similar distance to how the final large piece will actually be viewed.",
      ),
      AppLesson(
        title: 'Working with Local Nigerian Print Vendors',
        body:
            "Working with local Nigerian print vendors often involves practical realities that differ from the idealized international print production standards described in design textbooks — many local print shops have specific, sometimes non-standard preferences for file formats, color profiles, or even preferred software (some smaller shops still primarily work with CorelDRAW rather than the Adobe suite), so always ask a specific vendor about their exact requirements before finalizing a file, rather than assuming a generic international standard will be accepted without discussion.\n\nColor accuracy can vary more between different local print shops than between well-calibrated international presses, partly due to equipment age and maintenance variability — requesting and reviewing a physical printed proof before committing to a full print run is especially valuable advice in this context, since a screen preview or even a home inkjet printout can differ meaningfully from a shop's actual commercial press output.\n\nTurnaround time and minimum order quantities also vary significantly between vendors — some smaller local shops are flexible on very small quantities but have longer turnaround times, while larger commercial printers offer faster turnaround but often require higher minimum order quantities to be cost-effective. Factoring these practical business constraints into a project timeline, not just the design work itself, is part of professional print design practice.",
      ),
      AppLesson(
        title: 'Mini Project: Tri-Fold Brochure',
        hasImage: true,
        body:
            "For your final project, design a complete tri-fold brochure (A4 size, three panels) for a fictional or real business, applying every technical principle from this course. Start by mapping out the six total panel spaces (three on the front when folded, three on the inside spread when opened) and planning what content belongs on each, considering the natural reading order as someone unfolds the brochure.\n\nBuild your layout on a consistent grid across all panels, account for the slightly narrower innermost folding panel so it tucks correctly, and extend all background colors and images fully into a 3mm bleed on every edge. Keep all text and logos within a safe zone margin, and choose a paper stock and finish (gloss, matte, or uncoated) appropriate to the brochure's intended purpose and brand feeling.\n\nExport your final file as a print-ready PDF/X-1a with all fonts embedded or outlined, all images at 300 DPI minimum, and the color mode set correctly to CMYK throughout. If possible, print a physical proof (even on a home printer) to check how your on-screen colors and layout translate to a real, tangible printed piece before considering the project complete.",
      ),
    ],
  ),
];
