import 'package:flutter/material.dart';
import '../models/app_course.dart';

final copywritingCourses = <AppCourse>[

AppCourse(
  id: "copy_1",
  title: "Copywriting",
  description: "Copywriting",
  instructor: "Hustle Academy",
  category: "Copywriting",
  difficulty: "Intermediate",
  icon: Icons.edit,
  color: Colors.deepPurple,
  duration: "3 Lessons",
  lessons: [
    AppLesson(
      title: "Skill",
      body: r"""---
name: copywriting
version: 1.0.0
description: When the user wants to write, rewrite, or improve marketing copy for any page — including homepage, landing pages, pricing pages, feature pages, about pages, or product pages. Also use when the user says \"write copy for,\" \"improve this copy,\" \"rewrite this page,\" \"marketing copy,\" \"headline help,\" or \"CTA copy.\" For email copy, see email-sequence. For popup copy, see popup-cro.
---

# Copywriting

You are an expert conversion copywriter. Your goal is to write marketing copy that is clear, compelling, and drives action.

## Before Writing

**Check for product marketing context first:**
If `.claude/product-marketing-context.md` exists, read it before asking questions. Use that context and only ask for information not already covered or specific to this task.

Gather this context (ask if not provided):

### 1. Page Purpose
- What type of page? (homepage, landing page, pricing, feature, about)
- What is the ONE primary action you want visitors to take?

### 2. Audience
- Who is the ideal customer?
- What problem are they trying to solve?
- What objections or hesitations do they have?
- What language do they use to describe their problem?

### 3. Product/Offer
- What are you selling or offering?
- What makes it different from alternatives?
- What's the key transformation or outcome?
- Any proof points (numbers, testimonials, case studies)?

### 4. Context
- Where is traffic coming from? (ads, organic, email)
- What do visitors already know before arriving?

---

## Copywriting Principles

### Clarity Over Cleverness
If you have to choose between clear and creative, choose clear.

### Benefits Over Features
Features: What it does. Benefits: What that means for the customer.

### Specificity Over Vagueness
- Vague: \"Save time on your workflow\"
- Specific: \"Cut your weekly reporting from 4 hours to 15 minutes\"

### Customer Language Over Company Language
Use words your customers use. Mirror voice-of-customer from reviews, interviews, support tickets.

### One Idea Per Section
Each section should advance one argument. Build a logical flow down the page.

---

## Writing Style Rules

### Core Principles

1. **Simple over complex** — \"Use\" not \"utilize,\" \"help\" not \"facilitate\"
2. **Specific over vague** — Avoid \"streamline,\" \"optimize,\" \"innovative\"
3. **Active over passive** — \"We generate reports\" not \"Reports are generated\"
4. **Confident over qualified** — Remove \"almost,\" \"very,\" \"really\"
5. **Show over tell** — Describe the outcome instead of using adverbs
6. **Honest over sensational** — Never fabricate statistics or testimonials

### Quick Quality Check

- Jargon that could confuse outsiders?
- Sentences trying to do too much?
- Passive voice constructions?
- Exclamation points? (remove them)
- Marketing buzzwords without substance?

For thorough line-by-line review, use the **copy-editing** skill after your draft.

---

## Best Practices

### Be Direct
Get to the point. Don't bury the value in qualifications.

❌ Slack lets you share files instantly, from documents to images, directly in your conversations

✅ Need to share a screenshot? Send as many documents, images, and audio files as your heart desires.

### Use Rhetorical Questions
Questions engage readers and make them think about their own situation.
- \"Hate returning stuff to Amazon?\"
- \"Tired of chasing approvals?\"

### Use Analogies When Helpful
Analogies make abstract concepts concrete and memorable.

### Pepper in Humor (When Appropriate)
Puns and wit make copy memorable—but only if it fits the brand and doesn't undermine clarity.

---

## Page Structure Framework

### Above the Fold

**Headline**
- Your single most important message
- Communicate core value proposition
- Specific > generic

**Example formulas:**
- \"{Achieve outcome} without {pain point}\"
- \"The {category} for {audience}\"
- \"Never {unpleasant event} again\"
- \"{Question highlighting main pain point}\"

**For comprehensive headline formulas**: See [references/copy-frameworks.md](references/copy-frameworks.md)

**For natural transition phrases**: See [references/natural-transitions.md](references/natural-transitions.md)

**Subheadline**
- Expands on headline
- Adds specificity
- 1-2 sentences max

**Primary CTA**
- Action-oriented button text
- Communicate what they get: \"Start Free Trial\" > \"Sign Up\"

### Core Sections

| Section | Purpose |
|---------|---------|
| Social Proof | Build credibility (logos, stats, testimonials) |
| Problem/Pain | Show you understand their situation |
| Solution/Benefits | Connect to outcomes (3-5 key benefits) |
| How It Works | Reduce perceived complexity (3-4 steps) |
| Objection Handling | FAQ, comparisons, guarantees |
| Final CTA | Recap value, repeat CTA, risk reversal |

**For detailed section types and page templates**: See [references/copy-frameworks.md](references/copy-frameworks.md)

---

## CTA Copy Guidelines

**Weak CTAs (avoid):**
- Submit, Sign Up, Learn More, Click Here, Get Started

**Strong CTAs (use):**
- Start Free Trial
- Get [Specific Thing]
- See [Product] in Action
- Create Your First [Thing]
- Download the Guide

**Formula:** [Action Verb] + [What They Get] + [Qualifier if needed]

Examples:
- \"Start My Free Trial\"
- \"Get the Complete Checklist\"
- \"See Pricing for My Team\"

---

## Page-Specific Guidance

### Homepage
- Serve multiple audiences without being generic
- Lead with broadest value proposition
- Provide clear paths for different visitor intents

### Landing Page
- Single message, single CTA
- Match headline to ad/traffic source
- Complete argument on one page

### Pricing Page
- Help visitors choose the right plan
- Address \"which is right for me?\" anxiety
- Make recommended plan obvious

### Feature Page
- Connect feature → benefit → outcome
- Show use cases and examples
- Clear path to try or buy

### About Page
- Tell the story of why you exist
- Connect mission to customer benefit
- Still include a CTA

---

## Voice and Tone

Before writing, establish:

**Formality level:**
- Casual/conversational
- Professional but friendly
- Formal/enterprise

**Brand personality:**
- Playful or serious?
- Bold or understated?
- Technical or accessible?

Maintain consistency, but adjust intensity:
- Headlines can be bolder
- Body copy should be clearer
- CTAs should be action-oriented

---

## Output Format

When writing copy, provide:

### Page Copy
Organized by section:
- Headline, Subheadline, CTA
- Section headers and body copy
- Secondary CTAs

### Annotations
For key elements, explain:
- Why you made this choice
- What principle it applies

### Alternatives
For headlines and CTAs, provide 2-3 options:
- Option A: [copy] — [rationale]
- Option B: [copy] — [rationale]

### Meta Content (if relevant)
- Page title (for SEO)
- Meta description

---

## Related Skills

- **copy-editing**: For polishing existing copy (use after your draft)
- **page-cro**: If page structure/strategy needs work, not just copy
- **email-sequence**: For email copywriting
- **popup-cro**: For popup and modal copy
- **ab-test-setup**: To test copy variations""",
    ),

    AppLesson(
      title: "Copy Frameworks",
      body: r"""# Copy Frameworks Reference

Headline formulas, page section types, and structural templates.

## Headline Formulas

### Outcome-Focused

**{Achieve desirable outcome} without {pain point}**
> Understand how users are really experiencing your site without drowning in numbers

**{Achieve desirable outcome} by {how product makes it possible}**
> Generate more leads by seeing which companies visit your site

**Turn {input} into {outcome}**
> Turn your hard-earned sales into repeat customers

**[Achieve outcome] in [timeframe]**
> Get your tax refund in 10 days

---

### Problem-Focused

**Never {unpleasant event} again**
> Never miss a sales opportunity again

**{Question highlighting the main pain point}**
> Hate returning stuff to Amazon?

**Stop [pain]. Start [pleasure].**
> Stop chasing invoices. Start getting paid on time.

---

### Audience-Focused

**{Key feature/product type} for {target audience}**
> Advanced analytics for Shopify e-commerce

**{Key feature/product type} for {target audience} to {what it's used for}**
> An online whiteboard for teams to ideate and brainstorm together

**You don't have to {skills or resources} to {achieve desirable outcome}**
> With Ahrefs, you don't have to be an SEO pro to rank higher and get more traffic

---

### Differentiation-Focused

**The {opposite of usual process} way to {achieve desirable outcome}**
> The easiest way to turn your passion into income

**The [category] that [key differentiator]**
> The CRM that updates itself

---

### Proof-Focused

**[Number] [people] use [product] to [outcome]**
> 50,000 marketers use Drip to send better emails

**{Key benefit of your product}**
> Sound clear in online meetings

---

### Additional Formulas

**The simple way to {outcome}**
> The simple way to track your time

**Finally, {category} that {benefit}**
> Finally, accounting software that doesn't suck

**{Outcome} without {common pain}**
> Build your website without writing code

**Get {benefit} from your {thing}**
> Get more revenue from your existing traffic

**{Action verb} your {thing} like {admirable example}**
> Market your SaaS like a Fortune 500

**What if you could {desirable outcome}?**
> What if you could close deals 30% faster?

**Everything you need to {outcome}**
> Everything you need to launch your course

**The {adjective} {category} built for {audience}**
> The lightweight CRM built for startups

---

## Landing Page Section Types

### Core Sections

**Hero (Above the Fold)**
- Headline + subheadline
- Primary CTA
- Supporting visual (product screenshot, hero image)
- Optional: Social proof bar

**Social Proof Bar**
- Customer logos (recognizable > many)
- Key metric (\"10,000+ teams\")
- Star rating with review count
- Short testimonial snippet

**Problem/Pain Section**
- Articulate their problem better than they can
- Create recognition (\"that's exactly my situation\")
- Hint at cost of not solving it

**Solution/Benefits Section**
- Bridge from problem to your solution
- 3-5 key benefits (not 10)
- Each: headline + explanation + proof if available

**How It Works**
- 3-4 numbered steps
- Reduces perceived complexity
- Each step: action + outcome

**Final CTA Section**
- Recap value proposition
- Repeat primary CTA
- Risk reversal (guarantee, free trial)

---

### Supporting Sections

**Testimonials**
- Full quotes with names, roles, companies
- Photos when possible
- Specific results over vague praise
- Formats: quote cards, video, tweet embeds

**Case Studies**
- Problem → Solution → Results
- Specific metrics and outcomes
- Customer name and context
- Can be snippets with \"Read more\" links

**Use Cases**
- Different ways product is used
- Helps visitors self-identify
- \"For marketers who need X\" format

**Personas / \"Built For\" Sections**
- Explicitly call out target audience
- \"Perfect for [role]\" blocks
- Addresses \"Is this for me?\" question

**FAQ Section**
- Address common objections
- Good for SEO
- Reduces support burden
- 5-10 most common questions

**Comparison Section**
- vs. competitors (name them or don't)
- vs. status quo (spreadsheets, manual processes)
- Tables or side-by-side format

**Integrations / Partners**
- Logos of tools you connect with
- \"Works with your stack\" messaging
- Builds credibility

**Founder Story / Manifesto**
- Why you built this
- What you believe
- Emotional connection
- Differentiates from faceless competitors

**Demo / Product Tour**
- Interactive demos
- Video walkthroughs
- GIF previews
- Shows product in action

**Pricing Preview**
- Teaser even on non-pricing pages
- Starting price or \"from \$X/mo\"
- Moves decision-makers forward

**Guarantee / Risk Reversal**
- Money-back guarantee
- Free trial terms
- \"Cancel anytime\"
- Reduces friction

**Stats Section**
- Key metrics that build credibility
- \"10,000+ customers\"
- \"4.9/5 rating\"
- \"\$2M saved for customers\"

---

## Page Structure Templates

### Feature-Heavy Page (Weak)

```
1. Hero
2. Feature 1
3. Feature 2
4. Feature 3
5. Feature 4
6. CTA
```

This is a list, not a persuasive narrative.

---

### Varied, Engaging Page (Strong)

```
1. Hero with clear value prop
2. Social proof bar (logos or stats)
3. Problem/pain section
4. How it works (3 steps)
5. Key benefits (2-3, not 10)
6. Testimonial
7. Use cases or personas
8. Comparison to alternatives
9. Case study snippet
10. FAQ
11. Final CTA with guarantee
```

This tells a story and addresses objections.

---

### Compact Landing Page

```
1. Hero (headline, subhead, CTA, image)
2. Social proof bar
3. 3 key benefits with icons
4. Testimonial
5. How it works (3 steps)
6. Final CTA with guarantee
```

Good for ad landing pages where brevity matters.

---

### Enterprise/B2B Landing Page

```
1. Hero (outcome-focused headline)
2. Logo bar (recognizable companies)
3. Problem section (business pain)
4. Solution overview
5. Use cases by role/department
6. Security/compliance section
7. Integration logos
8. Case study with metrics
9. ROI/value section
10. Contact/demo CTA
```

Addresses enterprise buyer concerns.

---

### Product Launch Page

```
1. Hero with launch announcement
2. Video demo or walkthrough
3. Feature highlights (3-5)
4. Before/after comparison
5. Early testimonials
6. Launch pricing or early access offer
7. CTA with urgency
```

Good for ProductHunt, launches, or announcements.

---

## Section Writing Tips

### Problem Section

Start with phrases like:
- \"You know the feeling...\"
- \"If you're like most [role]...\"
- \"Every day, [audience] struggles with...\"
- \"We've all been there...\"

Then describe:
- The specific frustration
- The time/money wasted
- The impact on their work/life

### Benefits Section

For each benefit, include:
- **Headline**: The outcome they get
- **Body**: How it works (1-2 sentences)
- **Proof**: Number, testimonial, or example (optional)

### How It Works Section

Each step should be:
- **Numbered**: Creates sense of progress
- **Simple verb**: \"Connect,\" \"Set up,\" \"Get\"
- **Outcome-oriented**: What they get from this step

Example:
1. Connect your tools (takes 2 minutes)
2. Set your preferences
3. Get automated reports every Monday

### Testimonial Selection

Best testimonials include:
- Specific results (\"increased conversions by 32%\")
- Before/after context (\"We used to spend hours...\")
- Role + company for credibility
- Something quotable and specific

Avoid testimonials that just say:
- \"Great product!\"
- \"Love it!\"
- "Easy to use!"
    ),

    AppLesson(
      title: "Natural Transitions",
      body: r"""# Natural Transitions

Transitional phrases to guide readers through your content. Good signposting improves readability, user engagement, and helps search engines understand content structure.

Adapted from: University of Manchester Academic Phrasebank (2023), Plain English Campaign, web content best practices

---

## Previewing Content Structure

Use to orient readers and set expectations:

- Here's what we'll cover...
- This guide walks you through...
- Below, you'll find...
- We'll start with X, then move to Y...
- First, let's look at...
- Let's break this down step by step.
- The sections below explain...

---

## Introducing a New Topic

- When it comes to X,...
- Regarding X,...
- Speaking of X,...
- Now let's talk about X.
- Another key factor is...
- X is worth exploring because...

---

## Referring Back

Use to connect ideas and reinforce key points:

- As mentioned earlier,...
- As we covered above,...
- Remember when we discussed X?
- Building on that point,...
- Going back to X,...
- Earlier, we explained that...

---

## Moving Between Sections

- Now let's look at...
- Next up:...
- Moving on to...
- With that covered, let's turn to...
- Now that you understand X, here's Y.
- That brings us to...

---

## Indicating Addition

- Also,...
- Plus,...
- On top of that,...
- What's more,...
- Another benefit is...
- Beyond that,...
- In addition,...
- There's also...

**Note:** Use \"moreover\" and \"furthermore\" sparingly. They can sound AI-generated when overused.

---

## Indicating Contrast

- However,...
- But,...
- That said,...
- On the flip side,...
- In contrast,...
- Unlike X, Y...
- While X is true, Y...
- Despite this,...

---

## Indicating Similarity

- Similarly,...
- Likewise,...
- In the same way,...
- Just like X, Y also...
- This mirrors...
- The same applies to...

---

## Indicating Cause and Effect

- So,...
- This means...
- As a result,...
- That's why...
- Because of this,...
- This leads to...
- The outcome?...
- Here's what happens:...

---

## Giving Examples

- For example,...
- For instance,...
- Here's an example:...
- Take X, for instance.
- Consider this:...
- A good example is...
- To illustrate,...
- Like when...
- Say you want to...

---

## Emphasising Key Points

- Here's the key takeaway:...
- The important thing is...
- What matters most is...
- Don't miss this:...
- Pay attention to...
- This is critical:...
- The bottom line?...

---

## Providing Evidence

Use when citing sources, data, or expert opinions:

### Neutral attribution
- According to [Source],...
- [Source] reports that...
- Research shows that...
- Data from [Source] indicates...
- A study by [Source] found...

### Expert quotes
- As [Expert] puts it,...
- [Expert] explains,...
- In the words of [Expert],...
- [Expert] notes that...

### Supporting claims
- This is backed by...
- Evidence suggests...
- The numbers confirm...
- This aligns with findings from...

---

## Summarising Sections

- To recap,...
- Here's the short version:...
- In short,...
- The takeaway?...
- So what does this mean?...
- Let's pull this together:...
- Quick summary:...

---

## Concluding Content

- Wrapping up,...
- The bottom line is...
- Here's what to do next:...
- To sum up,...
- Final thoughts:...
- Ready to get started?...
- Now it's your turn.

**Note:** Avoid \"In conclusion\" at the start of a paragraph. It's overused and signals AI writing.

---

## Question-Based Transitions

Useful for conversational tone and featured snippet optimization:

- So what does this mean for you?
- But why does this matter?
- How do you actually do this?
- What's the catch?
- Sound complicated? It's not.
- Wondering where to start?
- Still not sure? Here's the breakdown.

---

## List Introductions

For numbered lists and step-by-step content:

- Here's how to do it:
- Follow these steps:
- The process is straightforward:
- Here's what you need to know:
- Key things to consider:
- The main factors are:

---

## Hedging Language

For claims that need qualification or aren't absolute:

- may, might, could
- tends to, generally
- often, usually, typically
- in most cases
- it appears that
- evidence suggests
- this can help
- many experts believe

---

## Best Practice Guidelines

1. **Match tone to audience**: B2B content can be slightly more formal; B2C often benefits from conversational transitions
2. **Vary your transitions**: Repeating the same phrase gets noticed (and not in a good way)
3. **Don't over-signpost**: Trust your reader; every sentence doesn't need a transition
4. **Use for scannability**: Transitions at paragraph starts help skimmers navigate
5. **Keep it natural**: Read aloud; if it sounds forced, simplify
6. **Front-load key info**: Put the important word or phrase early in the transition

---

## Transitions to Avoid (AI Tells)

These phrases are overused in AI-generated content:

- \"That being said,...\"
- \"It's worth noting that...\"
- \"At its core,...\"
- \"In today's digital landscape,...\"
- \"When it comes to the realm of...\"
- \"This begs the question...\"
- \"Let's delve into...\"

See the seo-audit skill's `references/ai-writing-detection.md` for a complete list of AI writing tells.""",
    ),

  ],
),

AppCourse(
  id: "copy_2",
  title: "Copy Editing",
  description: "Copy Editing",
  instructor: "Hustle Academy",
  category: "Copywriting",
  difficulty: "Intermediate",
  icon: Icons.edit,
  color: Colors.deepPurple,
  duration: "2 Lessons",
  lessons: [
    AppLesson(
      title: "Skill",
      body: r"""---
name: copy-editing
version: 1.0.0
description: \"When the user wants to edit, review, or improve existing marketing copy. Also use when the user mentions 'edit this copy,' 'review my copy,' 'copy feedback,' 'proofread,' 'polish this,' 'make this better,' or 'copy sweep.' This skill provides a systematic approach to editing marketing copy through multiple focused passes.\"
---

# Copy Editing

You are an expert copy editor specializing in marketing and conversion copy. Your goal is to systematically improve existing copy through focused editing passes while preserving the core message.

## Core Philosophy

**Check for product marketing context first:**
If `.claude/product-marketing-context.md` exists, read it before editing. Use brand voice and customer language from that context to guide your edits.

Good copy editing isn't about rewriting—it's about enhancing. Each pass focuses on one dimension, catching issues that get missed when you try to fix everything at once.

**Key principles:**
- Don't change the core message; focus on enhancing it
- Multiple focused passes beat one unfocused review
- Each edit should have a clear reason
- Preserve the author's voice while improving clarity

---

## The Seven Sweeps Framework

Edit copy through seven sequential passes, each focusing on one dimension. After each sweep, loop back to check previous sweeps aren't compromised.

### Sweep 1: Clarity

**Focus:** Can the reader understand what you're saying?

**What to check:**
- Confusing sentence structures
- Unclear pronoun references
- Jargon or insider language
- Ambiguous statements
- Missing context

**Common clarity killers:**
- Sentences trying to say too much
- Abstract language instead of concrete
- Assuming reader knowledge they don't have
- Burying the point in qualifications

**Process:**
1. Read through quickly, highlighting unclear parts
2. Don't correct yet—just note problem areas
3. After marking issues, recommend specific edits
4. Verify edits maintain the original intent

**After this sweep:** Confirm the \"Rule of One\" (one main idea per section) and \"You Rule\" (copy speaks to the reader) are intact.

---

### Sweep 2: Voice and Tone

**Focus:** Is the copy consistent in how it sounds?

**What to check:**
- Shifts between formal and casual
- Inconsistent brand personality
- Mood changes that feel jarring
- Word choices that don't match the brand

**Common voice issues:**
- Starting casual, becoming corporate
- Mixing \"we\" and \"the company\" references
- Humor in some places, serious in others (unintentionally)
- Technical language appearing randomly

**Process:**
1. Read aloud to hear inconsistencies
2. Mark where tone shifts unexpectedly
3. Recommend edits that smooth transitions
4. Ensure personality remains throughout

**After this sweep:** Return to Clarity Sweep to ensure voice edits didn't introduce confusion.

---

### Sweep 3: So What

**Focus:** Does every claim answer \"why should I care?\"

**What to check:**
- Features without benefits
- Claims without consequences
- Statements that don't connect to reader's life
- Missing \"which means...\" bridges

**The So What test:**
For every statement, ask \"Okay, so what?\" If the copy doesn't answer that question with a deeper benefit, it needs work.

❌ \"Our platform uses AI-powered analytics\"
*So what?*
✅ \"Our AI-powered analytics surface insights you'd miss manually—so you can make better decisions in half the time\"

**Common So What failures:**
- Feature lists without benefit connections
- Impressive-sounding claims that don't land
- Technical capabilities without outcomes
- Company achievements that don't help the reader

**Process:**
1. Read each claim and literally ask \"so what?\"
2. Highlight claims missing the answer
3. Add the benefit bridge or deeper meaning
4. Ensure benefits connect to real reader desires

**After this sweep:** Return to Voice and Tone, then Clarity.

---

### Sweep 4: Prove It

**Focus:** Is every claim supported with evidence?

**What to check:**
- Unsubstantiated claims
- Missing social proof
- Assertions without backup
- \"Best\" or \"leading\" without evidence

**Types of proof to look for:**
- Testimonials with names and specifics
- Case study references
- Statistics and data
- Third-party validation
- Guarantees and risk reversals
- Customer logos
- Review scores

**Common proof gaps:**
- \"Trusted by thousands\" (which thousands?)
- \"Industry-leading\" (according to whom?)
- \"Customers love us\" (show them saying it)
- Results claims without specifics

**Process:**
1. Identify every claim that needs proof
2. Check if proof exists nearby
3. Flag unsupported assertions
4. Recommend adding proof or softening claims

**After this sweep:** Return to So What, Voice and Tone, then Clarity.

---

### Sweep 5: Specificity

**Focus:** Is the copy concrete enough to be compelling?

**What to check:**
- Vague language (\"improve,\" \"enhance,\" \"optimize\")
- Generic statements that could apply to anyone
- Round numbers that feel made up
- Missing details that would make it real

**Specificity upgrades:**

| Vague | Specific |
|-------|----------|
| Save time | Save 4 hours every week |
| Many customers | 2,847 teams |
| Fast results | Results in 14 days |
| Improve your workflow | Cut your reporting time in half |
| Great support | Response within 2 hours |

**Common specificity issues:**
- Adjectives doing the work nouns should do
- Benefits without quantification
- Outcomes without timeframes
- Claims without concrete examples

**Process:**
1. Highlight vague words and phrases
2. Ask \"Can this be more specific?\"
3. Add numbers, timeframes, or examples
4. Remove content that can't be made specific (it's probably filler)

**After this sweep:** Return to Prove It, So What, Voice and Tone, then Clarity.

---

### Sweep 6: Heightened Emotion

**Focus:** Does the copy make the reader feel something?

**What to check:**
- Flat, informational language
- Missing emotional triggers
- Pain points mentioned but not felt
- Aspirations stated but not evoked

**Emotional dimensions to consider:**
- Pain of the current state
- Frustration with alternatives
- Fear of missing out
- Desire for transformation
- Pride in making smart choices
- Relief from solving the problem

**Techniques for heightening emotion:**
- Paint the \"before\" state vividly
- Use sensory language
- Tell micro-stories
- Reference shared experiences
- Ask questions that prompt reflection

**Process:**
1. Read for emotional impact—does it move you?
2. Identify flat sections that should resonate
3. Add emotional texture while staying authentic
4. Ensure emotion serves the message (not manipulation)

**After this sweep:** Return to Specificity, Prove It, So What, Voice and Tone, then Clarity.

---

### Sweep 7: Zero Risk

**Focus:** Have we removed every barrier to action?

**What to check:**
- Friction near CTAs
- Unanswered objections
- Missing trust signals
- Unclear next steps
- Hidden costs or surprises

**Risk reducers to look for:**
- Money-back guarantees
- Free trials
- \"No credit card required\"
- \"Cancel anytime\"
- Social proof near CTA
- Clear expectations of what happens next
- Privacy assurances

**Common risk issues:**
- CTA asks for commitment without earning trust
- Objections raised but not addressed
- Fine print that creates doubt
- Vague \"Contact us\" instead of clear next step

**Process:**
1. Focus on sections near CTAs
2. List every reason someone might hesitate
3. Check if the copy addresses each concern
4. Add risk reversals or trust signals as needed

**After this sweep:** Return through all previous sweeps one final time: Heightened Emotion, Specificity, Prove It, So What, Voice and Tone, Clarity.

---

## Quick-Pass Editing Checks

Use these for faster reviews when a full seven-sweep process isn't needed.

### Word-Level Checks

**Cut these words:**
- Very, really, extremely, incredibly (weak intensifiers)
- Just, actually, basically (filler)
- In order to (use \"to\")
- That (often unnecessary)
- Things, stuff (vague)

**Replace these:**

| Weak | Strong |
|------|--------|
| Utilize | Use |
| Implement | Set up |
| Leverage | Use |
| Facilitate | Help |
| Innovative | New |
| Robust | Strong |
| Seamless | Smooth |
| Cutting-edge | New/Modern |

**Watch for:**
- Adverbs (usually unnecessary)
- Passive voice (switch to active)
- Nominalizations (verb → noun: \"make a decision\" → \"decide\")

### Sentence-Level Checks

- One idea per sentence
- Vary sentence length (mix short and long)
- Front-load important information
- Max 3 conjunctions per sentence
- No more than 25 words (usually)

### Paragraph-Level Checks

- One topic per paragraph
- Short paragraphs (2-4 sentences for web)
- Strong opening sentences
- Logical flow between paragraphs
- White space for scannability

---

## Copy Editing Checklist

### Before You Start
- [ ] Understand the goal of this copy
- [ ] Know the target audience
- [ ] Identify the desired action
- [ ] Read through once without editing

### Clarity (Sweep 1)
- [ ] Every sentence is immediately understandable
- [ ] No jargon without explanation
- [ ] Pronouns have clear references
- [ ] No sentences trying to do too much

### Voice & Tone (Sweep 2)
- [ ] Consistent formality level throughout
- [ ] Brand personality maintained
- [ ] No jarring shifts in mood
- [ ] Reads well aloud

### So What (Sweep 3)
- [ ] Every feature connects to a benefit
- [ ] Claims answer \"why should I care?\"
- [ ] Benefits connect to real desires
- [ ] No impressive-but-empty statements

### Prove It (Sweep 4)
- [ ] Claims are substantiated
- [ ] Social proof is specific and attributed
- [ ] Numbers and stats have sources
- [ ] No unearned superlatives

### Specificity (Sweep 5)
- [ ] Vague words replaced with concrete ones
- [ ] Numbers and timeframes included
- [ ] Generic statements made specific
- [ ] Filler content removed

### Heightened Emotion (Sweep 6)
- [ ] Copy evokes feeling, not just information
- [ ] Pain points feel real
- [ ] Aspirations feel achievable
- [ ] Emotion serves the message authentically

### Zero Risk (Sweep 7)
- [ ] Objections addressed near CTA
- [ ] Trust signals present
- [ ] Next steps are crystal clear
- [ ] Risk reversals stated (guarantee, trial, etc.)

### Final Checks
- [ ] No typos or grammatical errors
- [ ] Consistent formatting
- [ ] Links work (if applicable)
- [ ] Core message preserved through all edits

---

## Common Copy Problems & Fixes

### Problem: Wall of Features
**Symptom:** List of what the product does without why it matters
**Fix:** Add \"which means...\" after each feature to bridge to benefits

### Problem: Corporate Speak
**Symptom:** \"Leverage synergies to optimize outcomes\"
**Fix:** Ask \"How would a human say this?\" and use those words

### Problem: Weak Opening
**Symptom:** Starting with company history or vague statements
**Fix:** Lead with the reader's problem or desired outcome

### Problem: Buried CTA
**Symptom:** The ask comes after too much buildup, or isn't clear
**Fix:** Make the CTA obvious, early, and repeated

### Problem: No Proof
**Symptom:** \"Customers love us\" with no evidence
**Fix:** Add specific testimonials, numbers, or case references

### Problem: Generic Claims
**Symptom:** \"We help businesses grow\"
**Fix:** Specify who, how, and by how much

### Problem: Mixed Audiences
**Symptom:** Copy tries to speak to everyone, resonates with no one
**Fix:** Pick one audience and write directly to them

### Problem: Feature Overload
**Symptom:** Listing every capability, overwhelming the reader
**Fix:** Focus on 3-5 key benefits that matter most to the audience

---

## Working with Copy Sweeps

When editing collaboratively:

1. **Run a sweep and present findings** - Show what you found, why it's an issue
2. **Recommend specific edits** - Don't just identify problems; propose solutions
3. **Request the updated copy** - Let the author make final decisions
4. **Verify previous sweeps** - After each round of edits, re-check earlier sweeps
5. **Repeat until clean** - Continue until a full sweep finds no new issues

This iterative process ensures each edit doesn't create new problems while respecting the author's ownership of the copy.

---

## References

- [Plain English Alternatives](references/plain-english-alternatives.md): Replace complex words with simpler alternatives

---

## Task-Specific Questions

1. What's the goal of this copy? (Awareness, conversion, retention)
2. What action should readers take?
3. Are there specific concerns or known issues?
4. What proof/evidence do you have available?

---

## Related Skills

- **copywriting**: For writing new copy from scratch (use this skill to edit after your first draft is complete)
- **page-cro**: For broader page optimization beyond copy
- **marketing-psychology**: For understanding why certain edits improve conversion
- **ab-test-setup**: For testing copy variations

---

## When to Use Each Skill

| Task | Skill to Use |
|------|--------------|
| Writing new page copy from scratch | copywriting |
| Reviewing and improving existing copy | copy-editing (this skill) |
| Editing copy you just wrote | copy-editing (this skill) |
| Structural or strategic page changes | page-cro |""",
    ),

    AppLesson(
      title: "Plain English Alternatives",
      body: r"""# Plain English Alternatives

Replace complex or pompous words with plain English alternatives.

Source: Plain English Campaign A-Z of Alternative Words (2001), Australian Government Style Manual (2024), plainlanguage.gov

---

## A

| Complex | Plain Alternative |
|---------|-------------------|
| (an) absence of | no, none |
| abundance | enough, plenty, many |
| accede to | allow, agree to |
| accelerate | speed up |
| accommodate | meet, hold, house |
| accomplish | do, finish, complete |
| accordingly | so, therefore |
| acknowledge | thank you for, confirm |
| acquire | get, buy, obtain |
| additional | extra, more |
| adjacent | next to |
| advantageous | useful, helpful |
| advise | tell, say, inform |
| aforesaid | this, earlier |
| aggregate | total |
| alleviate | ease, reduce |
| allocate | give, share, assign |
| alternative | other, choice |
| ameliorate | improve |
| anticipate | expect |
| apparent | clear, obvious |
| appreciable | large, noticeable |
| appropriate | proper, right, suitable |
| approximately | about, roughly |
| ascertain | find out |
| assistance | help |
| at the present time | now |
| attempt | try |
| authorise | allow, let |

---

## B

| Complex | Plain Alternative |
|---------|-------------------|
| belated | late |
| beneficial | helpful, useful |
| bestow | give |
| by means of | by |

---

## C

| Complex | Plain Alternative |
|---------|-------------------|
| calculate | work out |
| cease | stop, end |
| circumvent | avoid, get around |
| clarification | explanation |
| commence | start, begin |
| communicate | tell, talk, write |
| competent | able |
| compile | collect, make |
| complete | fill in, finish |
| component | part |
| comprise | include, make up |
| (it is) compulsory | (you) must |
| conceal | hide |
| concerning | about |
| consequently | so |
| considerable | large, great, much |
| constitute | make up, form |
| consult | ask, talk to |
| consumption | use |
| currently | now |

---

## D

| Complex | Plain Alternative |
|---------|-------------------|
| deduct | take off |
| deem | treat as, consider |
| defer | delay, put off |
| deficiency | lack |
| delete | remove, cross out |
| demonstrate | show, prove |
| denote | show, mean |
| designate | name, appoint |
| despatch/dispatch | send |
| determine | decide, find out |
| detrimental | harmful |
| diminish | reduce, lessen |
| discontinue | stop |
| disseminate | spread, distribute |
| documentation | papers, documents |
| due to the fact that | because |
| duration | time, length |
| dwelling | home |

---

## E

| Complex | Plain Alternative |
|---------|-------------------|
| economical | cheap, good value |
| eligible | allowed, qualified |
| elucidate | explain |
| enable | allow |
| encounter | meet |
| endeavour | try |
| enquire | ask |
| ensure | make sure |
| entitlement | right |
| envisage | expect |
| equivalent | equal, the same |
| erroneous | wrong |
| establish | set up, show |
| evaluate | assess, test |
| excessive | too much |
| exclusively | only |
| exempt | free from |
| expedite | speed up |
| expenditure | spending |
| expire | run out |

---

## F

| Complex | Plain Alternative |
|---------|-------------------|
| fabricate | make |
| facilitate | help, make possible |
| finalise | finish, complete |
| following | after |
| for the purpose of | to, for |
| for the reason that | because |
| forthwith | now, at once |
| forward | send |
| frequently | often |
| furnish | give, provide |
| furthermore | also, and |

---

## G-H

| Complex | Plain Alternative |
|---------|-------------------|
| generate | produce, create |
| henceforth | from now on |
| hitherto | until now |

---

## I

| Complex | Plain Alternative |
|---------|-------------------|
| if and when | if, when |
| illustrate | show |
| immediately | at once, now |
| implement | carry out, do |
| imply | suggest |
| in accordance with | under, following |
| in addition to | and, also |
| in conjunction with | with |
| in excess of | more than |
| in lieu of | instead of |
| in order to | to |
| in receipt of | receive |
| in relation to | about |
| in respect of | about, for |
| in the event of | if |
| in the majority of instances | most, usually |
| in the near future | soon |
| in view of the fact that | because |
| inception | start |
| indicate | show, suggest |
| inform | tell |
| initiate | start, begin |
| insert | put in |
| instances | cases |
| irrespective of | despite |
| issue | give, send |

---

## L-M

| Complex | Plain Alternative |
|---------|-------------------|
| (a) large number of | many |
| liaise with | work with, talk to |
| locality | place, area |
| locate | find |
| magnitude | size |
| (it is) mandatory | (you) must |
| manner | way |
| modification | change |
| moreover | also, and |

---

## N-O

| Complex | Plain Alternative |
|---------|-------------------|
| negligible | small |
| nevertheless | but, however |
| notify | tell |
| notwithstanding | despite, even if |
| numerous | many |
| objective | aim, goal |
| (it is) obligatory | (you) must |
| obtain | get |
| occasioned by | caused by |
| on behalf of | for |
| on numerous occasions | often |
| on receipt of | when you get |
| on the grounds that | because |
| operate | work, run |
| optimum | best |
| option | choice |
| otherwise | or |
| outstanding | unpaid |
| owing to | because |

---

## P

| Complex | Plain Alternative |
|---------|-------------------|
| partially | partly |
| participate | take part |
| particulars | details |
| per annum | a year |
| perform | do |
| permit | let, allow |
| personnel | staff, people |
| peruse | read |
| possess | have, own |
| practically | almost |
| predominant | main |
| prescribe | set |
| preserve | keep |
| previous | earlier, before |
| principal | main |
| prior to | before |
| proceed | go ahead |
| procure | get |
| prohibit | ban, stop |
| promptly | quickly |
| provide | give |
| provided that | if |
| provisions | rules, terms |
| proximity | nearness |
| purchase | buy |
| pursuant to | under |

---

## R

| Complex | Plain Alternative |
|---------|-------------------|
| reconsider | think again |
| reduction | cut |
| referred to as | called |
| regarding | about |
| reimburse | repay |
| reiterate | repeat |
| relating to | about |
| remain | stay |
| remainder | rest |
| remuneration | pay |
| render | make, give |
| represent | stand for |
| request | ask |
| require | need |
| residence | home |
| retain | keep |
| revised | changed, new |

---

## S

| Complex | Plain Alternative |
|---------|-------------------|
| scrutinise | examine, check |
| select | choose |
| solely | only |
| specified | given, stated |
| state | say |
| statutory | legal, by law |
| subject to | depending on |
| submit | send, give |
| subsequent to | after |
| subsequently | later |
| substantial | large, much |
| sufficient | enough |
| supplement | add to |
| supplementary | extra |

---

## T-U

| Complex | Plain Alternative |
|---------|-------------------|
| terminate | end, stop |
| thereafter | then |
| thereby | by this |
| thus | so |
| to date | so far |
| transfer | move |
| transmit | send |
| ultimately | in the end |
| undertake | agree, do |
| uniform | same |
| utilise | use |

---

## V-Z

| Complex | Plain Alternative |
|---------|-------------------|
| variation | change |
| virtually | almost |
| visualise | imagine, see |
| ways and means | ways |
| whatsoever | any |
| with a view to | to |
| with effect from | from |
| with reference to | about |
| with regard to | about |
| with respect to | about |
| zone | area |

---

## Phrases to Remove Entirely

These phrases often add nothing. Delete them:

- a total of
- absolutely
- actually
- all things being equal
- as a matter of fact
- at the end of the day
- at this moment in time
- basically
- currently (when \"now\" or nothing works)
- I am of the opinion that (use: I think)
- in due course (use: soon, or say when)
- in the final analysis
- it should be understood
- last but not least
- obviously
- of course
- quite
- really
- the fact of the matter is
- to all intents and purposes
- very""",
    ),

  ],
),

AppCourse(
  id: "copy_3",
  title: "Email Sequence",
  description: "Email Sequence",
  instructor: "Hustle Academy",
  category: "Copywriting",
  difficulty: "Intermediate",
  icon: Icons.edit,
  color: Colors.deepPurple,
  duration: "4 Lessons",
  lessons: [
    AppLesson(
      title: "Skill",
      body: r"""---
name: email-sequence
version: 1.0.0
description: When the user wants to create or optimize an email sequence, drip campaign, automated email flow, or lifecycle email program. Also use when the user mentions \"email sequence,\" \"drip campaign,\" \"nurture sequence,\" \"onboarding emails,\" \"welcome sequence,\" \"re-engagement emails,\" \"email automation,\" or \"lifecycle emails.\" For in-app onboarding, see onboarding-cro.
---

# Email Sequence Design

You are an expert in email marketing and automation. Your goal is to create email sequences that nurture relationships, drive action, and move people toward conversion.

## Initial Assessment

**Check for product marketing context first:**
If `.claude/product-marketing-context.md` exists, read it before asking questions. Use that context and only ask for information not already covered or specific to this task.

Before creating a sequence, understand:

1. **Sequence Type**
   - Welcome/onboarding sequence
   - Lead nurture sequence
   - Re-engagement sequence
   - Post-purchase sequence
   - Event-based sequence
   - Educational sequence
   - Sales sequence

2. **Audience Context**
   - Who are they?
   - What triggered them into this sequence?
   - What do they already know/believe?
   - What's their current relationship with you?

3. **Goals**
   - Primary conversion goal
   - Relationship-building goals
   - Segmentation goals
   - What defines success?

---

## Core Principles

### 1. One Email, One Job
- Each email has one primary purpose
- One main CTA per email
- Don't try to do everything

### 2. Value Before Ask
- Lead with usefulness
- Build trust through content
- Earn the right to sell

### 3. Relevance Over Volume
- Fewer, better emails win
- Segment for relevance
- Quality > frequency

### 4. Clear Path Forward
- Every email moves them somewhere
- Links should do something useful
- Make next steps obvious

---

## Email Sequence Strategy

### Sequence Length
- Welcome: 3-7 emails
- Lead nurture: 5-10 emails
- Onboarding: 5-10 emails
- Re-engagement: 3-5 emails

Depends on:
- Sales cycle length
- Product complexity
- Relationship stage

### Timing/Delays
- Welcome email: Immediately
- Early sequence: 1-2 days apart
- Nurture: 2-4 days apart
- Long-term: Weekly or bi-weekly

Consider:
- B2B: Avoid weekends
- B2C: Test weekends
- Time zones: Send at local time

### Subject Line Strategy
- Clear > Clever
- Specific > Vague
- Benefit or curiosity-driven
- 40-60 characters ideal
- Test emoji (they're polarizing)

**Patterns that work:**
- Question: \"Still struggling with X?\"
- How-to: \"How to [achieve outcome] in [timeframe]\"
- Number: \"3 ways to [benefit]\"
- Direct: \"[First name], your [thing] is ready\"
- Story tease: \"The mistake I made with [topic]\"

### Preview Text
- Extends the subject line
- ~90-140 characters
- Don't repeat subject line
- Complete the thought or add intrigue

---

## Sequence Types Overview

### Welcome Sequence (Post-Signup)
**Length**: 5-7 emails over 12-14 days
**Goal**: Activate, build trust, convert

Key emails:
1. Welcome + deliver promised value (immediate)
2. Quick win (day 1-2)
3. Story/Why (day 3-4)
4. Social proof (day 5-6)
5. Overcome objection (day 7-8)
6. Core feature highlight (day 9-11)
7. Conversion (day 12-14)

### Lead Nurture Sequence (Pre-Sale)
**Length**: 6-8 emails over 2-3 weeks
**Goal**: Build trust, demonstrate expertise, convert

Key emails:
1. Deliver lead magnet + intro (immediate)
2. Expand on topic (day 2-3)
3. Problem deep-dive (day 4-5)
4. Solution framework (day 6-8)
5. Case study (day 9-11)
6. Differentiation (day 12-14)
7. Objection handler (day 15-18)
8. Direct offer (day 19-21)

### Re-Engagement Sequence
**Length**: 3-4 emails over 2 weeks
**Trigger**: 30-60 days of inactivity
**Goal**: Win back or clean list

Key emails:
1. Check-in (genuine concern)
2. Value reminder (what's new)
3. Incentive (special offer)
4. Last chance (stay or unsubscribe)

### Onboarding Sequence (Product Users)
**Length**: 5-7 emails over 14 days
**Goal**: Activate, drive to aha moment, upgrade
**Note**: Coordinate with in-app onboarding—email supports, doesn't duplicate

Key emails:
1. Welcome + first step (immediate)
2. Getting started help (day 1)
3. Feature highlight (day 2-3)
4. Success story (day 4-5)
5. Check-in (day 7)
6. Advanced tip (day 10-12)
7. Upgrade/expand (day 14+)

**For detailed templates**: See [references/sequence-templates.md](references/sequence-templates.md)

---

## Email Types by Category

### Onboarding Emails
- New users series
- New customers series
- Key onboarding step reminders
- New user invites

### Retention Emails
- Upgrade to paid
- Upgrade to higher plan
- Ask for review
- Proactive support offers
- Product usage reports
- NPS survey
- Referral program

### Billing Emails
- Switch to annual
- Failed payment recovery
- Cancellation survey
- Upcoming renewal reminders

### Usage Emails
- Daily/weekly/monthly summaries
- Key event notifications
- Milestone celebrations

### Win-Back Emails
- Expired trials
- Cancelled customers

### Campaign Emails
- Monthly roundup / newsletter
- Seasonal promotions
- Product updates
- Industry news roundup
- Pricing updates

**For detailed email type reference**: See [references/email-types.md](references/email-types.md)

---

## Email Copy Guidelines

### Structure
1. **Hook**: First line grabs attention
2. **Context**: Why this matters to them
3. **Value**: The useful content
4. **CTA**: What to do next
5. **Sign-off**: Human, warm close

### Formatting
- Short paragraphs (1-3 sentences)
- White space between sections
- Bullet points for scanability
- Bold for emphasis (sparingly)
- Mobile-first (most read on phone)

### Tone
- Conversational, not formal
- First-person (I/we) and second-person (you)
- Active voice
- Read it out loud—does it sound human?

### Length
- 50-125 words for transactional
- 150-300 words for educational
- 300-500 words for story-driven

### CTA Guidelines
- Buttons for primary actions
- Links for secondary actions
- One clear primary CTA per email
- Button text: Action + outcome

**For detailed copy, personalization, and testing guidelines**: See [references/copy-guidelines.md](references/copy-guidelines.md)

---

## Output Format

### Sequence Overview
```
Sequence Name: [Name]
Trigger: [What starts the sequence]
Goal: [Primary conversion goal]
Length: [Number of emails]
Timing: [Delay between emails]
Exit Conditions: [When they leave the sequence]
```

### For Each Email
```
Email [#]: [Name/Purpose]
Send: [Timing]
Subject: [Subject line]
Preview: [Preview text]
Body: [Full copy]
CTA: [Button text] → [Link destination]
Segment/Conditions: [If applicable]
```

### Metrics Plan
What to measure and benchmarks

---

## Task-Specific Questions

1. What triggers entry to this sequence?
2. What's the primary goal/conversion action?
3. What do they already know about you?
4. What other emails are they receiving?
5. What's your current email performance?

---

## Tool Integrations

For implementation, see the [tools registry](../../tools/REGISTRY.md). Key email tools:

| Tool | Best For | MCP | Guide |
|------|----------|:---:|-------|
| **Customer.io** | Behavior-based automation | - | [customer-io.md](../../tools/integrations/customer-io.md) |
| **Mailchimp** | SMB email marketing | ✓ | [mailchimp.md](../../tools/integrations/mailchimp.md) |
| **Resend** | Developer-friendly transactional | ✓ | [resend.md](../../tools/integrations/resend.md) |
| **SendGrid** | Transactional email at scale | - | [sendgrid.md](../../tools/integrations/sendgrid.md) |
| **Kit** | Creator/newsletter focused | - | [kit.md](../../tools/integrations/kit.md) |

---

## Related Skills

- **onboarding-cro**: For in-app onboarding (email supports this)
- **copywriting**: For landing pages emails link to
- **ab-test-setup**: For testing email elements
- **popup-cro**: For email capture popups""",
    ),

    AppLesson(
      title: "Copy Guidelines",
      body: r"""# Email Copy Guidelines

## Structure

1. **Hook**: First line grabs attention
2. **Context**: Why this matters to them
3. **Value**: The useful content
4. **CTA**: What to do next
5. **Sign-off**: Human, warm close

## Formatting

- Short paragraphs (1-3 sentences)
- White space between sections
- Bullet points for scanability
- Bold for emphasis (sparingly)
- Mobile-first (most read on phone)

## Tone

- Conversational, not formal
- First-person (I/we) and second-person (you)
- Active voice
- Match your brand but lean friendly
- Read it out loud—does it sound human?

## Length

- Shorter is usually better
- 50-125 words for transactional
- 150-300 words for educational
- 300-500 words for story-driven
- If it's long, it better be good

## CTA Buttons vs. Links

- Buttons: Primary actions, high-visibility
- Links: Secondary actions, in-text
- One clear primary CTA per email
- Button text: Action + outcome

---

## Personalization

### Merge Fields
- First name (fallback to \"there\" or \"friend\")
- Company name (B2B)
- Relevant data (usage, plan, etc.)

### Dynamic Content
- Based on segment
- Based on behavior
- Based on stage

### Triggered Emails
- Action-based sends
- More relevant than time-based
- Examples: Feature used, milestone hit, inactivity

---

## Segmentation Strategies

### By Behavior
- Openers vs. non-openers
- Clickers vs. non-clickers
- Active vs. inactive

### By Stage
- Trial vs. paid
- New vs. long-term
- Engaged vs. at-risk

### By Profile
- Industry/role (B2B)
- Use case / goal
- Company size

---

## Testing and Optimization

### What to Test
- Subject lines (highest impact)
- Send times
- Email length
- CTA placement and copy
- Personalization level
- Sequence timing

### How to Test
- A/B test one variable at a time
- Sufficient sample size
- Statistical significance
- Document learnings

### Metrics to Track
- Open rate (benchmark: 20-40%)
- Click rate (benchmark: 2-5%)
- Unsubscribe rate (keep under 0.5%)
- Conversion rate (specific to sequence goal)
- Revenue per email (if applicable)""",
    ),

    AppLesson(
      title: "Email Types",
      body: r"""# Email Types Reference

A comprehensive guide to lifecycle and campaign emails. Use this as an audit checklist and implementation reference.

## Onboarding Emails

### New Users Series
**Trigger**: User signs up (free or trial)
**Goal**: Activate user, drive to aha moment
**Typical sequence**: 5-7 emails over 14 days

- Email 1: Welcome + single next step (immediate)
- Email 2: Quick win / getting started (day 1)
- Email 3: Key feature highlight (day 3)
- Email 4: Success story / social proof (day 5)
- Email 5: Check-in + offer help (day 7)
- Email 6: Advanced tip (day 10)
- Email 7: Upgrade prompt or next milestone (day 14)

**Key metrics**: Activation rate, feature adoption

---

### New Customers Series
**Trigger**: User converts to paid
**Goal**: Reinforce purchase decision, drive adoption, reduce early churn
**Typical sequence**: 3-5 emails over 14 days

- Email 1: Thank you + what's next (immediate)
- Email 2: Getting full value — setup checklist (day 2)
- Email 3: Pro tips for paid features (day 5)
- Email 4: Success story from similar customer (day 7)
- Email 5: Check-in + introduce support resources (day 14)

**Key point**: Different from new user series—they've committed. Focus on reinforcement and expansion, not conversion.

---

### Key Onboarding Step Reminder
**Trigger**: User hasn't completed critical setup step after X time
**Goal**: Nudge completion of high-value action
**Format**: Single email or 2-3 email mini-sequence

**Example triggers**:
- Hasn't connected integration after 48 hours
- Hasn't invited team member after 3 days
- Hasn't completed profile after 24 hours

**Copy approach**:
- Remind them what they started
- Explain why this step matters
- Make it easy (direct link to complete)
- Offer help if stuck

---

### New User Invite
**Trigger**: Existing user invites teammate
**Goal**: Activate the invited user
**Recipient**: The person being invited

- Email 1: You've been invited (immediate)
- Email 2: Reminder if not accepted (day 2)
- Email 3: Final reminder (day 5)

**Copy approach**:
- Personalize with inviter's name
- Explain what they're joining
- Single CTA to accept invite
- Social proof optional

---

## Retention Emails

### Upgrade to Paid
**Trigger**: Free user shows engagement, or trial ending
**Goal**: Convert free to paid
**Typical sequence**: 3-5 emails

**Trigger options**:
- Time-based (trial day 10, 12, 14)
- Behavior-based (hit usage limit, used premium feature)
- Engagement-based (highly active free user)

**Sequence structure**:
- Value summary: What they've accomplished
- Feature comparison: What they're missing
- Social proof: Who else upgraded
- Urgency: Trial ending, limited offer
- Final: Last chance + easy path

---

### Upgrade to Higher Plan
**Trigger**: User approaching plan limits or using features available on higher tier
**Goal**: Upsell to next tier
**Format**: Single email or 2-3 email sequence

**Trigger examples**:
- 80% of seat limit reached
- 90% of storage/usage limit
- Tried to use higher-tier feature
- Power user behavior patterns

**Copy approach**:
- Acknowledge their growth (positive framing)
- Show what next tier unlocks
- Quantify value vs. cost
- Easy upgrade path

---

### Ask for Review
**Trigger**: Customer milestone (30/60/90 days, key achievement, support resolution)
**Goal**: Generate social proof on G2, Capterra, app stores
**Format**: Single email

**Best timing**:
- After positive support interaction
- After achieving measurable result
- After renewal
- NOT after billing issues or bugs

**Copy approach**:
- Thank them for being a customer
- Mention specific value/milestone if possible
- Explain why reviews matter (help others decide)
- Direct link to review platform
- Keep it short—this is an ask

---

### Offer Support Proactively
**Trigger**: Signs of struggle (drop in usage, failed actions, error encounters)
**Goal**: Save at-risk user, improve experience
**Format**: Single email

**Trigger examples**:
- Usage dropped significantly week-over-week
- Multiple failed attempts at action
- Viewed help docs repeatedly
- Stuck at same onboarding step

**Copy approach**:
- Genuine concern tone
- Specific: \"I noticed you...\" (if data allows)
- Offer direct help (not just link to docs)
- Personal from support or CSM
- No sales pitch—pure help

---

### Product Usage Report
**Trigger**: Time-based (weekly, monthly, quarterly)
**Goal**: Demonstrate value, drive engagement, reduce churn
**Format**: Single email, recurring

**What to include**:
- Key metrics/activity summary
- Comparison to previous period
- Achievements/milestones
- Suggestions for improvement
- Light CTA to explore more

**Examples**:
- \"You saved X hours this month\"
- \"Your team completed X projects\"
- \"You're in the top X% of users\"

**Key point**: Make them feel good and remind them of value delivered.

---

### NPS Survey
**Trigger**: Time-based (quarterly) or event-based (post-milestone)
**Goal**: Measure satisfaction, identify promoters and detractors
**Format**: Single email

**Best practices**:
- Keep it simple: Just the NPS question initially
- Follow-up form for \"why\" based on score
- Personal sender (CEO, founder, CSM)
- Tell them how you'll use feedback

**Follow-up based on score**:
- Promoters (9-10): Thank + ask for review/referral
- Passives (7-8): Ask what would make it a 10
- Detractors (0-6): Personal outreach to understand issues

---

### Referral Program
**Trigger**: Customer milestone, promoter NPS score, or campaign
**Goal**: Generate referrals
**Format**: Single email or periodic reminders

**Good timing**:
- After positive NPS response
- After customer achieves result
- After renewal
- Seasonal campaigns

**Copy approach**:
- Remind them of their success
- Explain the referral offer clearly
- Make sharing easy (unique link)
- Show what's in it for them AND referee

---

## Billing Emails

### Switch to Annual
**Trigger**: Monthly subscriber at renewal time or campaign
**Goal**: Convert monthly to annual (improve LTV, reduce churn)
**Format**: Single email or 2-email sequence

**Value proposition**:
- Calculate exact savings
- Additional benefits (if any)
- Lock in current price messaging
- Easy one-click switch

**Best timing**:
- Around monthly renewal date
- End of year / new year
- After 3-6 months of loyalty
- Price increase announcement (lock in old rate)

---

### Failed Payment Recovery
**Trigger**: Payment fails
**Goal**: Recover revenue, retain customer
**Typical sequence**: 3-4 emails over 7-14 days

**Sequence structure**:
- Email 1 (Day 0): Friendly notice, update payment link
- Email 2 (Day 3): Reminder, service may be interrupted
- Email 3 (Day 7): Urgent, account will be suspended
- Email 4 (Day 10-14): Final notice, what they'll lose

**Copy approach**:
- Assume it's an accident (card expired, etc.)
- Clear, direct, no guilt
- Single CTA to update payment
- Explain what happens if not resolved

**Key metrics**: Recovery rate, time to recovery

---

### Cancellation Survey
**Trigger**: User cancels subscription
**Goal**: Learn why, opportunity to save
**Format**: Single email (immediate)

**Options**:
- In-app survey at cancellation (better completion)
- Follow-up email if they skip in-app
- Personal outreach for high-value accounts

**Questions to ask**:
- Primary reason for cancelling
- What could we have done better
- Would anything change your mind
- Can we help with transition

**Winback opportunity**: Based on reason, offer targeted save (discount, pause, downgrade, training).

---

### Upcoming Renewal Reminder
**Trigger**: X days before renewal (14 or 30 days typical)
**Goal**: No surprise charges, opportunity to expand
**Format**: Single email

**What to include**:
- Renewal date and amount
- What's included in renewal
- How to update payment/plan
- Changes to pricing/features (if any)
- Optional: Upsell opportunity

**Required for**: Annual subscriptions, high-value contracts

---

## Usage Emails

### Daily/Weekly/Monthly Summary
**Trigger**: Time-based
**Goal**: Drive engagement, demonstrate value
**Format**: Single email, recurring

**Content by frequency**:
- **Daily**: Notifications, quick stats (for high-engagement products)
- **Weekly**: Activity summary, highlights, suggestions
- **Monthly**: Comprehensive report, achievements, ROI if calculable

**Structure**:
- Key metrics at a glance
- Notable achievements
- Activity breakdown
- Suggestions / what to try next
- CTA to dive deeper

**Personalization**: Must be relevant to their actual usage. Empty reports are worse than no report.

---

### Key Event or Milestone Notifications
**Trigger**: Specific achievement or event
**Goal**: Celebrate, drive continued engagement
**Format**: Single email per event

**Milestone examples**:
- First [action] completed
- 10th/100th [thing] created
- Goal achieved
- Team collaboration milestone
- Usage streak

**Copy approach**:
- Celebration tone
- Specific achievement
- Context (compared to others, compared to before)
- What's next / next milestone

---

## Win-Back Emails

### Expired Trials
**Trigger**: Trial ended without conversion
**Goal**: Convert or re-engage
**Typical sequence**: 3-4 emails over 30 days

**Sequence structure**:
- Email 1 (Day 1 post-expiry): Trial ended, here's what you're missing
- Email 2 (Day 7): What held you back? (gather feedback)
- Email 3 (Day 14): Incentive offer (discount, extended trial)
- Email 4 (Day 30): Final reach-out, door is open

**Segmentation**: Different approach based on trial engagement level:
- High engagement: Focus on removing friction to convert
- Low engagement: Offer fresh start, more onboarding help
- No engagement: Ask what happened, offer demo/call

---

### Cancelled Customers
**Trigger**: Time after cancellation (30, 60, 90 days)
**Goal**: Win back churned customers
**Typical sequence**: 2-3 emails spread over 90 days

**Sequence structure**:
- Email 1 (Day 30): What's new since you left
- Email 2 (Day 60): We've addressed [common reason]
- Email 3 (Day 90): Special offer to return

**Copy approach**:
- No guilt, no desperation
- Genuine updates and improvements
- Personalize based on cancellation reason if known
- Make return easy

**Key point**: They're more likely to return if their reason was addressed.

---

## Campaign Emails

### Monthly Roundup / Newsletter
**Trigger**: Time-based (monthly)
**Goal**: Engagement, brand presence, content distribution
**Format**: Single email, recurring

**Content mix**:
- Product updates and tips
- Customer stories
- Educational content
- Company news
- Industry insights

**Best practices**:
- Consistent send day/time
- Scannable format
- Mix of content types
- One primary CTA focus
- Unsubscribe is okay—keeps list healthy

---

### Seasonal Promotions
**Trigger**: Calendar events (Black Friday, New Year, etc.)
**Goal**: Drive conversions with timely offer
**Format**: Campaign burst (2-4 emails)

**Common opportunities**:
- New Year (fresh start, annual planning)
- End of fiscal year (budget spending)
- Black Friday / Cyber Monday
- Industry-specific seasons
- Back to school / work

**Sequence structure**:
- Announcement: Offer reveal
- Reminder: Midway through promotion
- Last chance: Final hours

---

### Product Updates
**Trigger**: New feature release
**Goal**: Adoption, engagement, demonstrate momentum
**Format**: Single email per major release

**What to include**:
- What's new (clear and simple)
- Why it matters (benefit, not just feature)
- How to use it (direct link)
- Who asked for it (community acknowledgment)

**Segmentation**: Consider targeting based on relevance:
- Users who would benefit most
- Users who requested feature
- Power users first (for beta feel)

---

### Industry News Roundup
**Trigger**: Time-based (weekly or monthly)
**Goal**: Thought leadership, engagement, brand value
**Format**: Curated newsletter

**Content**:
- Curated news and links
- Your take / commentary
- What it means for readers
- How your product helps

**Best for**: B2B products where customers care about industry trends.

---

### Pricing Update
**Trigger**: Price change announcement
**Goal**: Transparent communication, minimize churn
**Format**: Single email (or sequence for major changes)

**Timeline**:
- Announce 30-60 days before change
- Reminder 14 days before
- Final notice 7 days before

**Copy approach**:
- Clear, direct, transparent
- Explain the why (value delivered, costs increased)
- Grandfather if possible (lock in old rate)
- Give options (annual lock-in, downgrade)

**Important**: Honesty and advance notice build trust even when price increases.

---

## Email Audit Checklist

Use this to audit your current email program:

### Onboarding
- [ ] New users series
- [ ] New customers series
- [ ] Key onboarding step reminders
- [ ] New user invite sequence

### Retention
- [ ] Upgrade to paid sequence
- [ ] Upgrade to higher plan triggers
- [ ] Ask for review (timed properly)
- [ ] Proactive support outreach
- [ ] Product usage reports
- [ ] NPS survey
- [ ] Referral program emails

### Billing
- [ ] Switch to annual campaign
- [ ] Failed payment recovery sequence
- [ ] Cancellation survey
- [ ] Upcoming renewal reminders

### Usage
- [ ] Daily/weekly/monthly summaries
- [ ] Key event notifications
- [ ] Milestone celebrations

### Win-Back
- [ ] Expired trial sequence
- [ ] Cancelled customer sequence

### Campaigns
- [ ] Monthly roundup / newsletter
- [ ] Seasonal promotion calendar
- [ ] Product update announcements
- [ ] Pricing update communications""",
    ),

    AppLesson(
      title: "Sequence Templates",
      body: r"""# Email Sequence Templates

Detailed templates for common email sequences.

## Welcome Sequence (Post-Signup)

**Email 1: Welcome (Immediate)**
- Subject: Welcome to [Product] — here's your first step
- Deliver what was promised (lead magnet, access, etc.)
- Single next action
- Set expectations for future emails

**Email 2: Quick Win (Day 1-2)**
- Subject: Get your first [result] in 10 minutes
- Enable small success
- Build confidence
- Link to helpful resource

**Email 3: Story/Why (Day 3-4)**
- Subject: Why we built [Product]
- Origin story or mission
- Connect emotionally
- Show you understand their problem

**Email 4: Social Proof (Day 5-6)**
- Subject: How [Customer] achieved [Result]
- Case study or testimonial
- Relatable to their situation
- Soft CTA to explore

**Email 5: Overcome Objection (Day 7-8)**
- Subject: \"I don't have time for X\" — sound familiar?
- Address common hesitation
- Reframe the obstacle
- Show easy path forward

**Email 6: Core Feature (Day 9-11)**
- Subject: Have you tried [Feature] yet?
- Highlight underused capability
- Show clear benefit
- Direct CTA to try it

**Email 7: Conversion (Day 12-14)**
- Subject: Ready to [upgrade/buy/commit]?
- Summarize value
- Clear offer
- Urgency if appropriate
- Risk reversal (guarantee, trial)

---

## Lead Nurture Sequence (Pre-Sale)

**Email 1: Deliver + Introduce (Immediate)**
- Deliver the lead magnet
- Brief intro to who you are
- Preview what's coming

**Email 2: Expand on Topic (Day 2-3)**
- Related insight to lead magnet
- Establish expertise
- Light CTA to content

**Email 3: Problem Deep-Dive (Day 4-5)**
- Articulate their problem deeply
- Show you understand
- Hint at solution

**Email 4: Solution Framework (Day 6-8)**
- Your approach/methodology
- Educational, not salesy
- Builds toward your product

**Email 5: Case Study (Day 9-11)**
- Real results from real customer
- Specific and relatable
- Soft CTA

**Email 6: Differentiation (Day 12-14)**
- Why your approach is different
- Address alternatives
- Build preference

**Email 7: Objection Handler (Day 15-18)**
- Common concern addressed
- FAQ or myth-busting
- Reduce friction

**Email 8: Direct Offer (Day 19-21)**
- Clear pitch
- Strong value proposition
- Specific CTA
- Urgency if available

---

## Re-Engagement Sequence

**Email 1: Check-In (Day 30-60 of inactivity)**
- Subject: Is everything okay, [Name]?
- Genuine concern
- Ask what happened
- Easy win to re-engage

**Email 2: Value Reminder (Day 2-3 after)**
- Subject: Remember when you [achieved X]?
- Remind of past value
- What's new since they left
- Quick CTA

**Email 3: Incentive (Day 5-7 after)**
- Subject: We miss you — here's something special
- Offer if appropriate
- Limited time
- Clear CTA

**Email 4: Last Chance (Day 10-14 after)**
- Subject: Should we stop emailing you?
- Honest and direct
- One-click to stay or go
- Clean the list if no response

---

## Onboarding Sequence (Product Users)

Coordinate with in-app onboarding. Email supports, doesn't duplicate.

**Email 1: Welcome + First Step (Immediate)**
- Confirm signup
- One critical action
- Link directly to that action

**Email 2: Getting Started Help (Day 1)**
- If they haven't completed step 1
- Quick tip or video
- Support option

**Email 3: Feature Highlight (Day 2-3)**
- Key feature they should know
- Specific use case
- In-app link

**Email 4: Success Story (Day 4-5)**
- Customer who succeeded
- Relatable journey
- Motivational

**Email 5: Check-In (Day 7)**
- How's it going?
- Ask for feedback
- Offer help

**Email 6: Advanced Tip (Day 10-12)**
- Power feature
- For engaged users
- Level-up content

**Email 7: Upgrade/Expand (Day 14+)**
- For trial users: conversion push
- For free users: upgrade prompt
- For paid: expansion opportunity""",
    ),

  ],
),

AppCourse(
  id: "copy_4",
  title: "Content Strategy",
  description: "Content Strategy",
  instructor: "Hustle Academy",
  category: "Copywriting",
  difficulty: "Intermediate",
  icon: Icons.edit,
  color: Colors.deepPurple,
  duration: "1 Lessons",
  lessons: [
    AppLesson(
      title: "Skill",
      body: r"""---
name: content-strategy
version: 1.0.0
description: When the user wants to plan a content strategy, decide what content to create, or figure out what topics to cover. Also use when the user mentions \"content strategy,\" \"what should I write about,\" \"content ideas,\" \"blog strategy,\" \"topic clusters,\" or \"content planning.\" For writing individual pieces, see copywriting. For SEO-specific audits, see seo-audit.
---

# Content Strategy

You are a content strategist. Your goal is to help plan content that drives traffic, builds authority, and generates leads by being either searchable, shareable, or both.

## Before Planning

**Check for product marketing context first:**
If `.claude/product-marketing-context.md` exists, read it before asking questions. Use that context and only ask for information not already covered or specific to this task.

Gather this context (ask if not provided):

### 1. Business Context
- What does the company do?
- Who is the ideal customer?
- What's the primary goal for content? (traffic, leads, brand awareness, thought leadership)
- What problems does your product solve?

### 2. Customer Research
- What questions do customers ask before buying?
- What objections come up in sales calls?
- What topics appear repeatedly in support tickets?
- What language do customers use to describe their problems?

### 3. Current State
- Do you have existing content? What's working?
- What resources do you have? (writers, budget, time)
- What content formats can you produce? (written, video, audio)

### 4. Competitive Landscape
- Who are your main competitors?
- What content gaps exist in your market?

---

## Searchable vs Shareable

Every piece of content must be searchable, shareable, or both. Prioritize in that order—search traffic is the foundation.

**Searchable content** captures existing demand. Optimized for people actively looking for answers.

**Shareable content** creates demand. Spreads ideas and gets people talking.

### When Writing Searchable Content

- Target a specific keyword or question
- Match search intent exactly—answer what the searcher wants
- Use clear titles that match search queries
- Structure with headings that mirror search patterns
- Place keywords in title, headings, first paragraph, URL
- Provide comprehensive coverage (don't leave questions unanswered)
- Include data, examples, and links to authoritative sources
- Optimize for AI/LLM discovery: clear positioning, structured content, brand consistency across the web

### When Writing Shareable Content

- Lead with a novel insight, original data, or counterintuitive take
- Challenge conventional wisdom with well-reasoned arguments
- Tell stories that make people feel something
- Create content people want to share to look smart or help others
- Connect to current trends or emerging problems
- Share vulnerable, honest experiences others can learn from

---

## Content Types

### Searchable Content Types

**Use-Case Content**
Formula: [persona] + [use-case]. Targets long-tail keywords.
- \"Project management for designers\"
- \"Task tracking for developers\"
- \"Client collaboration for freelancers\"

**Hub and Spoke**
Hub = comprehensive overview. Spokes = related subtopics.
```
/topic (hub)
├── /topic/subtopic-1 (spoke)
├── /topic/subtopic-2 (spoke)
└── /topic/subtopic-3 (spoke)
```
Create hub first, then build spokes. Interlink strategically.

**Note:** Most content works fine under `/blog`. Only use dedicated hub/spoke URL structures for major topics with layered depth (e.g., Atlassian's `/agile` guide). For typical blog posts, `/blog/post-title` is sufficient.

**Template Libraries**
High-intent keywords + product adoption.
- Target searches like \"marketing plan template\"
- Provide immediate standalone value
- Show how product enhances the template

### Shareable Content Types

**Thought Leadership**
- Articulate concepts everyone feels but hasn't named
- Challenge conventional wisdom with evidence
- Share vulnerable, honest experiences

**Data-Driven Content**
- Product data analysis (anonymized insights)
- Public data analysis (uncover patterns)
- Original research (run experiments, share results)

**Expert Roundups**
15-30 experts answering one specific question. Built-in distribution.

**Case Studies**
Structure: Challenge → Solution → Results → Key learnings

**Meta Content**
Behind-the-scenes transparency. \"How We Got Our First \$5k MRR,\" \"Why We Chose Debt Over VC.\"

For programmatic content at scale, see **programmatic-seo** skill.

---

## Content Pillars and Topic Clusters

Content pillars are the 3-5 core topics your brand will own. Each pillar spawns a cluster of related content.

Most of the time, all content can live under `/blog` with good internal linking between related posts. Dedicated pillar pages with custom URL structures (like `/guides/topic`) are only needed when you're building comprehensive resources with multiple layers of depth.

### How to Identify Pillars

1. **Product-led**: What problems does your product solve?
2. **Audience-led**: What does your ICP need to learn?
3. **Search-led**: What topics have volume in your space?
4. **Competitor-led**: What are competitors ranking for?

### Pillar Structure

```
Pillar Topic (Hub)
├── Subtopic Cluster 1
│   ├── Article A
│   ├── Article B
│   └── Article C
├── Subtopic Cluster 2
│   ├── Article D
│   ├── Article E
│   └── Article F
└── Subtopic Cluster 3
    ├── Article G
    ├── Article H
    └── Article I
```

### Pillar Criteria

Good pillars should:
- Align with your product/service
- Match what your audience cares about
- Have search volume and/or social interest
- Be broad enough for many subtopics

---

## Keyword Research by Buyer Stage

Map topics to the buyer's journey using proven keyword modifiers:

### Awareness Stage
Modifiers: \"what is,\" \"how to,\" \"guide to,\" \"introduction to\"

Example: If customers ask about project management basics:
- \"What is Agile Project Management\"
- \"Guide to Sprint Planning\"
- \"How to Run a Standup Meeting\"

### Consideration Stage
Modifiers: \"best,\" \"top,\" \"vs,\" \"alternatives,\" \"comparison\"

Example: If customers evaluate multiple tools:
- \"Best Project Management Tools for Remote Teams\"
- \"Asana vs Trello vs Monday\"
- \"Basecamp Alternatives\"

### Decision Stage
Modifiers: \"pricing,\" \"reviews,\" \"demo,\" \"trial,\" \"buy\"

Example: If pricing comes up in sales calls:
- \"Project Management Tool Pricing Comparison\"
- \"How to Choose the Right Plan\"
- \"[Product] Reviews\"

### Implementation Stage
Modifiers: \"templates,\" \"examples,\" \"tutorial,\" \"how to use,\" \"setup\"

Example: If support tickets show implementation struggles:
- \"Project Template Library\"
- \"Step-by-Step Setup Tutorial\"
- \"How to Use [Feature]\"

---

## Content Ideation Sources

### 1. Keyword Data

If user provides keyword exports (Ahrefs, SEMrush, GSC), analyze for:
- Topic clusters (group related keywords)
- Buyer stage (awareness/consideration/decision/implementation)
- Search intent (informational, commercial, transactional)
- Quick wins (low competition + decent volume + high relevance)
- Content gaps (keywords competitors rank for that you don't)

Output as prioritized table:
| Keyword | Volume | Difficulty | Buyer Stage | Content Type | Priority |

### 2. Call Transcripts

If user provides sales or customer call transcripts, extract:
- Questions asked → FAQ content or blog posts
- Pain points → problems in their own words
- Objections → content to address proactively
- Language patterns → exact phrases to use (voice of customer)
- Competitor mentions → what they compared you to

Output content ideas with supporting quotes.

### 3. Survey Responses

If user provides survey data, mine for:
- Open-ended responses (topics and language)
- Common themes (30%+ mention = high priority)
- Resource requests (what they wish existed)
- Content preferences (formats they want)

### 4. Forum Research

Use web search to find content ideas:

**Reddit:** `site:reddit.com [topic]`
- Top posts in relevant subreddits
- Questions and frustrations in comments
- Upvoted answers (validates what resonates)

**Quora:** `site:quora.com [topic]`
- Most-followed questions
- Highly upvoted answers

**Other:** Indie Hackers, Hacker News, Product Hunt, industry Slack/Discord

Extract: FAQs, misconceptions, debates, problems being solved, terminology used.

### 5. Competitor Analysis

Use web search to analyze competitor content:

**Find their content:** `site:competitor.com/blog`

**Analyze:**
- Top-performing posts (comments, shares)
- Topics covered repeatedly
- Gaps they haven't covered
- Case studies (customer problems, use cases, results)
- Content structure (pillars, categories, formats)

**Identify opportunities:**
- Topics you can cover better
- Angles they're missing
- Outdated content to improve on

### 6. Sales and Support Input

Extract from customer-facing teams:
- Common objections
- Repeated questions
- Support ticket patterns
- Success stories
- Feature requests and underlying problems

---

## Prioritizing Content Ideas

Score each idea on four factors:

### 1. Customer Impact (40%)
- How frequently did this topic come up in research?
- What percentage of customers face this challenge?
- How emotionally charged was this pain point?
- What's the potential LTV of customers with this need?

### 2. Content-Market Fit (30%)
- Does this align with problems your product solves?
- Can you offer unique insights from customer research?
- Do you have customer stories to support this?
- Will this naturally lead to product interest?

### 3. Search Potential (20%)
- What's the monthly search volume?
- How competitive is this topic?
- Are there related long-tail opportunities?
- Is search interest growing or declining?

### 4. Resource Requirements (10%)
- Do you have expertise to create authoritative content?
- What additional research is needed?
- What assets (graphics, data, examples) will you need?

### Scoring Template

| Idea | Customer Impact (40%) | Content-Market Fit (30%) | Search Potential (20%) | Resources (10%) | Total |
|------|----------------------|-------------------------|----------------------|-----------------|-------|
| Topic A | 8 | 9 | 7 | 6 | 8.0 |
| Topic B | 6 | 7 | 9 | 8 | 7.1 |

---

## Output Format

When creating a content strategy, provide:

### 1. Content Pillars
- 3-5 pillars with rationale
- Subtopic clusters for each pillar
- How pillars connect to product

### 2. Priority Topics
For each recommended piece:
- Topic/title
- Searchable, shareable, or both
- Content type (use-case, hub/spoke, thought leadership, etc.)
- Target keyword and buyer stage
- Why this topic (customer research backing)

### 3. Topic Cluster Map
Visual or structured representation of how content interconnects.

---

## Task-Specific Questions

1. What patterns emerge from your last 10 customer conversations?
2. What questions keep coming up in sales calls?
3. Where are competitors' content efforts falling short?
4. What unique insights from customer research aren't being shared elsewhere?
5. Which existing content drives the most conversions, and why?

---

## Related Skills

- **copywriting**: For writing individual content pieces
- **seo-audit**: For technical SEO and on-page optimization
- **programmatic-seo**: For scaled content generation
- **email-sequence**: For email-based content
- **social-content**: For social media content""",
    ),

  ],
),

AppCourse(
  id: "copy_5",
  title: "Content Repurposing",
  description: "Content Repurposing",
  instructor: "Hustle Academy",
  category: "Copywriting",
  difficulty: "Intermediate",
  icon: Icons.edit,
  color: Colors.deepPurple,
  duration: "1 Lessons",
  lessons: [
    AppLesson(
      title: "Skill",
      body: r"""---
name: content-repurposing
description: Repurpose and atomize content across platforms and formats. Use when the user says \"repurpose this\", \"turn this into\", \"convert blog to\", \"make a thread from\", \"content atomization\", \"repurpose content\", \"turn this article into social posts\", or asks about adapting content from one format to another.
---

# Content Repurposing Skill

You are a content repurposing expert. Take one piece of content and transform it into multiple formats optimized for different platforms. Follow the content pyramid methodology.

## The Content Pyramid

```
            ┌─────────────┐
            │  PILLAR      │  Long-form: Blog, podcast, video, webinar
            │  CONTENT     │  (1 piece, high effort)
            └──────┬───────┘
                   │
         ┌─────────┴─────────┐
         │  DERIVATIVE        │  Medium-form: Newsletter, LinkedIn article,
         │  CONTENT           │  YouTube short, email sequence
         │                    │  (3-5 pieces, medium effort)
         └─────────┬──────────┘
                   │
    ┌──────────────┴──────────────┐
    │  MICRO CONTENT               │  Short-form: Social posts, quotes,
    │                              │  carousels, stories, clips
    │                              │  (10-20 pieces, low effort)
    └──────────────────────────────┘
```

**Goal:** 1 pillar piece → 15-25 content assets across platforms.

## Conversion Recipes

### Recipe 1: Blog Post → Twitter/X Thread

**Process:**
1. Extract the core thesis (this becomes the hook tweet)
2. Pull 5-10 key points (each becomes a tweet)
3. Add a personal take or story (for engagement)
4. End with a CTA tweet

**Format:**
```
🧵 {Hook: Bold claim or surprising insight from the article}

1/ {First key point, condensed to <280 chars}

2/ {Second key point with a specific example}

...

{N}/ {Summary + CTA: \"Follow for more {topic}\" or \"RT if this was useful\"}
```

**Rules:**
- Each tweet must stand alone (people see individual tweets in feeds)
- Use numbers or bullet points for scannability
- Add 1-2 relevant images or data visualizations
- Max 10-12 tweets for optimal engagement

### Recipe 2: Blog Post → LinkedIn Carousel

**Process:**
1. Extract 7-10 actionable takeaways
2. Write a hook slide (title + subtitle)
3. One takeaway per slide with minimal text
4. Add a CTA final slide

**Format:**
```
SLIDE 1 (Cover): {Compelling title}
{Subtitle: \"X lessons from...\" or \"How to...\"}

SLIDE 2: {Takeaway 1 - headline}
{1-2 supporting sentences}

SLIDE 3-9: {Repeat pattern}

SLIDE 10 (CTA): {Follow / Save / Visit link}
{Author name and handle}
```

**Rules:**
- Large, readable text (imagine reading on a phone)
- Max 3 lines of text per slide
- Use contrasting colors for key words
- 8-12 slides optimal

### Recipe 3: Blog Post → Newsletter Section

**Process:**
1. Write a 2-sentence personal intro connecting to the topic
2. Summarize the 3 most actionable insights
3. Add your unique take or commentary
4. Link to the full post

**Format:**
```markdown
## {Section title}

{Personal intro — why this matters to you/your audience}

Here are the 3 biggest takeaways:

**1. {Insight}** — {1-2 sentence expansion}

**2. {Insight}** — {1-2 sentence expansion}

**3. {Insight}** — {1-2 sentence expansion}

{Your unique commentary or additional insight}

👉 [Read the full post]({url})
```

### Recipe 4: Blog Post → Video Script (60-90 seconds)

**Process:**
1. Open with the most surprising/useful point (hook: 5 seconds)
2. Quick context on why it matters (10 seconds)
3. 3 key points, rapid-fire (45 seconds)
4. CTA (10 seconds)

**Format:**
```
HOOK (0-5s): \"{Surprising statement or question from the article}\"

CONTEXT (5-15s): \"I just {wrote about/discovered/tested} {topic} and here's what you need to know...\"

POINT 1 (15-30s): \"{Key insight} — here's why that matters: {brief explanation}\"

POINT 2 (30-45s): \"{Key insight} — {example or proof point}\"

POINT 3 (45-60s): \"{Key insight} — {actionable takeaway}\"

CTA (60-70s): \"Follow for more {topic} content. Link to the full breakdown in my bio.\"
```

### Recipe 5: Podcast Episode → Blog Post

**Process:**
1. Extract the main topic and thesis
2. Identify 5-8 distinct segments/talking points
3. Pull specific quotes and stories
4. Structure as a how-to or listicle blog post
5. Add introduction, transitions, and conclusion

### Recipe 6: Podcast Episode → Quote Cards

**Process:**
1. Find 5-10 quotable moments (surprising, insightful, or contrarian)
2. Keep quotes under 30 words each
3. Format with speaker attribution

**Output per quote:**
```
\"{Quote text}\" — {Speaker Name}

Context: {1 sentence explaining the context}
Best for: {Platform — Instagram, LinkedIn, Twitter}
```

### Recipe 7: Video → GIF Clips + Social Posts

**Process:**
1. Identify 3-5 key moments (reactions, demonstrations, key statements)
2. Note timestamps for each clip (3-10 seconds each)
3. Write a social caption for each clip

## Platform-Specific Adaptation

When repurposing, adjust for each platform:

| Platform | Max Length | Tone | Format | Hashtags |
|----------|-----------|------|--------|----------|
| Twitter/X | 280 chars/tweet | Casual, punchy | Threads, quote tweets | 1-2 max |
| LinkedIn | 3,000 chars | Professional, story-driven | Long text, carousels, polls | 3-5 in first comment |
| Instagram | 2,200 chars caption | Visual, lifestyle | Carousels, Reels, Stories | 5-15 |
| TikTok | 60-90s video | Raw, energetic | Short video, text overlay | 3-5 |
| Newsletter | No limit | Personal, conversational | Sections, links | None |
| YouTube Shorts | <60s | Educational, hook-driven | Vertical video | In description |
| Reddit | No limit | Authentic, no self-promo | Text post, discussion | None |
| Bluesky | 300 chars | Casual, early-adopter | Text, threads | None |

## Repurposing Workflow

### Step 1: Identify Source Content
Ask or infer: What is the pillar content? (URL, text, transcript, etc.)

### Step 2: Extract Core Elements
- **Thesis:** The one big idea
- **Key points:** 5-10 supporting arguments or insights
- **Stories/examples:** Specific anecdotes that illustrate points
- **Data:** Statistics, results, numbers
- **Quotes:** Memorable or quotable lines
- **Action items:** Concrete steps the reader can take

### Step 3: Map to Target Platforms
Based on the user's channels, create a repurposing plan:

```markdown
# Content Repurposing Plan

**Source:** {title/description of pillar content}
**Platforms:** {target platforms}

| # | Platform | Format | Content Angle | Status |
|---|----------|--------|---------------|--------|
| 1 | Twitter/X | Thread (8 tweets) | Key takeaways | Draft |
| 2 | LinkedIn | Carousel (10 slides) | Framework overview | Draft |
| 3 | LinkedIn | Text post | Personal story angle | Draft |
| 4 | Newsletter | Section (300 words) | Commentary + link | Draft |
| 5 | Instagram | Carousel (7 slides) | Visual tips | Draft |
| 6 | TikTok/Reels | 60s script | Hook + 3 points | Draft |
| ... | ... | ... | ... | ... |
```

### Step 4: Create Each Piece
Write each content piece following the platform-specific rules above.

### Step 5: Scheduling Recommendation
Stagger content across days/weeks for maximum reach:
- Day 1: Publish pillar content
- Day 1-2: Twitter thread + LinkedIn post
- Day 3-4: Carousel + newsletter mention
- Day 5-7: Short-form video + Instagram
- Week 2: Quote cards + follow-up discussion post

## Important Notes

- Each repurposed piece should feel native to its platform, not like a copy-paste.
- Add unique value to each version — a personal take, additional insight, or different framing.
- The hook/opening matters most. Rewrite it specifically for each platform's audience.
- Never cross-post identical content across platforms. Audiences overlap and it looks lazy.
- Track which repurposed formats drive the most engagement back to the pillar content.""",
    ),

  ],
),

];
