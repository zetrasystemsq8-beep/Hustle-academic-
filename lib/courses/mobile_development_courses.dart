// ============================================================
// MOBILE DEVELOPMENT COURSES (Full authored content)
// lib/courses/mobile_development_courses.dart
// Generated: complete 12-course Mobile Development curriculum
// Instructor: Connect Baba
// NOTE: This file is standalone. Do NOT modify main.dart here.
// Use the existing AppCourse and AppLesson schema from ../models/app_course.dart
// ============================================================

import 'package:flutter/material.dart';
import '../models/app_course.dart';

final List<AppCourse> mobileDevelopmentCourses = [
  // ---------------------------------------------------------------------------
  // Course 1 — Mobile Development Fundamentals
  // ---------------------------------------------------------------------------
  AppCourse(
    id: 'mobile_dev_fundamentals',
    title: 'Mobile Development Fundamentals',
    description:
        'Core conceptual foundation for mobile developers: platforms, lifecycles, constraints, UX fundamentals, release processes and the operational realities of shipping mobile products.',
    instructor: 'Connect Baba',
    category: 'mobile development',
    difficulty: 'Beginner',
    icon: Icons.smartphone,
    color: Colors.teal,
    duration: '6h',
    lessons: [
      AppLesson(
        title: '[Section 1: What & Why] What is Mobile Development?',
        body: '''
Introduction
Mobile development is the discipline of designing and building applications for devices such as smartphones and tablets. Unlike desktop or web applications, mobile apps run in a resource-constrained environment where network, battery, input methods, and platform expectations shape design and engineering choices.

What and Why
Mobile development targets device-specific capabilities (GPS, camera, sensors) and user contexts (on-the-go usage, intermittent connectivity). The primary goal is to deliver fast, context-aware experiences that respect limited RAM, battery and screen sizes while providing compelling, discoverable functionality via app stores or preloaded systems.

How it works (high level)
An app is packaged with assets and code, executed by the platform runtime (Dart VM/AOT for Flutter, ART for Android native, or native ABI for iOS). It interacts with OS-provided services (notifications, background tasks, storage) and often a backend for data and auth. The lifecycle of an app—launch, foreground/background, suspension and termination—determines how you manage state and resources.

Important terminology
- Runtime / VM: environment that executes app code.
- Lifecycle: stages an app goes through (launch, resume, pause, stop).
- AOT / JIT: ahead-of-time vs just-in-time compilation.
- App bundle / IPA / APK: platform packaging artifacts.

Why it matters
Mobile-specific constraints force tradeoffs. For example, a background-synced heavy process that’s fine on servers can cause battery drain on a phone. Understanding the platform differences helps you select the right tools and architecture.

Common mistakes
- Treating mobile like desktop: blocking the main thread, heavy memory use.
- Ignoring platform UX conventions: confusing navigation or permissions flows.
- Over-reliance on network: poor offline handling leads to bad UX.

Key takeaways
Mobile development balances device capabilities, UX expectation, and operational constraints. Understanding the environment will inform choices throughout the rest of the curriculum.''',
        hasImage: false,
      ),
      AppLesson(
        title: '[Section 2: Platforms] Android and iOS — contrasts and decisions',
        body: '''
Introduction
Android and iOS dominate mobile. While both support equivalent experiences, they differ in platform architecture, distribution models, UI conventions, and operational constraints. Knowing these differences is essential when designing cross-platform apps or choosing native vs cross-platform approaches.

Platform internals at a glance
- Android: Linux kernel, ART runtime, APK/AAB packaging, wide device variety, multiple OEM customizations. Fragmentation is significant (OS versions, hardware).
- iOS: Darwin kernel, Objective-C/Swift runtimes, IPA packaging via Xcode, tightly controlled hardware set and OS updates through Apple.

Design & UX expectations
iOS and Android have distinct UI patterns (navigation bars, back gestures, tab placement, action affordances). Users expect platform-consistent behaviour: iOS users expect swipe-to-go-back and tab bars, Android users expect system back behaviour and material design patterns.

Distribution and updates
- Play Store (Android) supports staged rollouts, multiple tracks and easier side-loading.
- App Store (iOS) enforces stricter signing, review process and provisioning profiles. App review adds quality gatekeeping but slows releases.

Decision criteria
Choose native when deep platform integration or maximal performance is required. Choose cross-platform (e.g., Flutter) when developer productivity and consistent experience across platforms matter and platform constraints are manageable.

Common pitfalls
- Porting a UI 1:1 between platforms without adjusting for platform idioms.
- Underestimating effort to support manufacturer-specific Android quirks.

Summary
Understand the platform strengths and constraints early: they drive architecture, UX, QA and release strategies.''',
        hasImage: false,
      ),
      AppLesson(
        title: '[Section 3: App Architecture] Layers, responsibilities and maintainability',
        body: '''
Introduction
Mobile apps are software systems that require clear separation of concerns. Good architecture reduces coupling, improves testability and scales as features and teams grow.

Common layers
- Presentation (UI): Widgets / Views, responsible only for rendering and user interaction.
- Domain (Business rules): Core logic, validation, algorithms, feature orchestration.
- Data (Persistence & APIs): Repositories handling local storage and remote APIs, transformation/mapping between DTOs and domain models.
- Platform / Services: Low-level services (push notifications, geolocation, camera, OS integrations).

Architectural styles
- Layered (classic): clear separation but can become rigid.
- MVVM (Model-View-ViewModel): encourages separation and testable view logic.
- Clean Architecture: use-cases / domain-centric, decouples frameworks from business logic.
- Feature-based modularization: group code by feature for large apps and teams.

How to apply in mobile
Keep UI thin: move complex logic to ViewModels / controllers. Treat repositories as single source of truth for data and policies like caching. Use dependency inversion (inject abstractions) to keep platform details out of domain logic.

Why it matters
Proper separation makes it easier to test, swap implementations (e.g., local storage engine), and onboard new developers.

Common mistakes
- Putting networking and parsing directly in widgets.
- Letting widgets own state beyond ephemeral UI concerns.

Key takeaways
Design for change: isolate side effects and treat the UI as a thin rendering layer backed by testable domain logic.''',
        hasImage: false,
      ),
      AppLesson(
        title: '[Section 4: Constraints & Performance] Memory, battery, CPU and network',
        body: '''
Introduction
Mobile devices are constrained. Designing for constrained environments is a core mobile skill: manage memory footprints, avoid CPU spikes, and respect battery life and network limitations.

Memory and resource management
Keep object graphs lean. Avoid large in-memory caches unless necessary; prefer streamed processing for large data (e.g., video frames). Reuse UI resources and avoid holding long-lived references to contexts or activities that can leak memory.

CPU and responsiveness
Work off the main/UI thread for expensive computation. Prefer async APIs, background isolates (Dart Isolates) or platform-native workers for heavy tasks. Keep UI rendering at 60fps (or 120fps on high-refresh displays); avoid synchronous work that causes frame drops (jank).

Battery and sensors
Sensors like GPS or camera drain battery; plan strategies (batching, adaptive sampling) to minimize impact. Request runtime permissions thoughtfully and inform users why the permission is needed to avoid unexpected battery usage surprises.

Network
Design for intermittent connectivity: cache data, expose offline experiences, queue writes for later sync. Use efficient payloads, compress when needed, and choose pagination strategies for lists to avoid overfetching.

Common mistakes
- Blocking the main thread, causing UI jank.
- Keeping unnecessary listeners or resources alive after a screen is disposed, leaking memory.
- Unbounded polling or wake locks that drain battery.

Key takeaways
Design mobile apps with resource constraints in mind — this affects architecture, UX, and testing strategies.''',
        hasImage: false,
      ),
      AppLesson(
        title: '[Section 5: UX & Interaction] Touch, input methods and accessibility',
        body: '''
Introduction
Mobile UX revolves around touch interaction, small screens, and context-aware experiences. Accessibility and inclusive design are fundamental: they expand your user base and are required by many markets.

Touch and affordances
Design large enough touch targets (Apple recommends 44x44pt), provide visible feedback for taps and long presses, and avoid crowded layouts that cause accidental taps. Use platform gestures idiomatically (swipe to dismiss, pull-to-refresh).

Input modalities
On-screen keyboards occupy space and change layout; design responsive views that adapt when keyboard appears. Use appropriate input types (email, number, tel) to bring up correct keyboard and reduce errors.

Accessibility
Use semantic labels for UI elements (screen reader text), ensure contrast ratios, support dynamic type (font scaling) and logical focus order. Test with VoiceOver (iOS) and TalkBack (Android).

Internationalization and localization
Plan for right-to-left languages, string length variability, and culture-specific content. Keep UI flexible for translated text and avoid image assets that contain embedded text.

Common mistakes
- Hard-coded font sizes without scaling.
- Non-semantic buttons that are invisible to screen readers.

Summary
Design with touch-first thinking and prioritize accessibility early — it’s easier and cheaper than retrofitting later.''',
        hasImage: false,
      ),
      AppLesson(
        title: '[Section 6: Release & Maintenance] App stores, telemetry and updates',
        body: '''
Introduction
Shipping an app involves more than building it — distribution, monitoring and updates are essential operational concerns.

App stores and distribution
Understand the packaging (APK/AAB for Android, IPA for iOS), signing, provisioning, and store metadata (privacy policy, screenshots, descriptions). Each store has review rules: design release workflows to recover from rejections quickly.

Telemetry and monitoring
Add production logging, crash reporting and user task metrics. Tools like Sentry, Crashlytics and custom telemetry enable fast triage of issues post-release. Respect user privacy and comply with regulations (GDPR) when capturing telemetry.

Update strategy
Implement staged rollouts and feature flags to mitigate risk. Consider in-app update prompts and mechanisms for critical security patches. Provide clear migration paths for data schema changes and use migration tooling for local databases.

Maintenance & team processes
Automate builds and tests via CI, maintain release notes, and use issue triage processes for prioritizing bugs vs features.

Key takeaways
An app released without telemetry and a safe update pipeline is at high risk; plan for operations as part of product design.''',
        hasImage: false,
      ),
    ],
  ),

  // ---------------------------------------------------------------------------
  // Course 2 — Dart Programming for Mobile Development
  // ---------------------------------------------------------------------------
  AppCourse(
    id: 'dart_for_mobile',
    title: 'Dart Programming for Mobile Development',
    description:
        'Comprehensive treatment of Dart language features and idioms used to build modern, robust Flutter apps: types, null safety, async, streams, isolates and package tooling.',
    instructor: 'Connect Baba',
    category: 'mobile development',
    difficulty: 'Beginner',
    icon: Icons.code,
    color: Colors.indigo,
    duration: '10h',
    lessons: [
      AppLesson(
        title: '[Section 1: Foundations] Dart language overview & tooling',
        body: '''
Introduction
Dart is a modern, optionally typed language designed for client apps. Its tight integration with Flutter makes understanding Dart crucial for writing maintainable, performant mobile code.

What Dart provides
- A concise syntax with strong, optionally sound typing (null-safety).
- Both AOT compilation for release and JIT for development (hot reload).
- First-class support for async programming (Futures, Streams), extension methods, mixins, and convenient collection literals.

Tooling
The Dart SDK includes the analyzer, formatter, pub package manager, and runtime tools. Use 'dart analyze' to catch potential issues early and 'dart format' to keep code style consistent. Packages are hosted on pub.dev and managed with pub or flutter pub.

Why it matters
Dart’s design favors developer ergonomics (hot reload, expressive syntax) and enables predictable performance when used with Flutter. Understanding its type system and concurrency model reduces runtime bugs and enables robust abstractions.

Common mistakes
- Ignoring analyzer warnings.
- Mixing dynamic types where stronger typing would improve maintainability.

Takeaway
Dart is the engine beneath Flutter: invest time in language fluency for cleaner, safer mobile apps.''',
        hasImage: false,
      ),
      AppLesson(
        title: '[Section 2: Types & Null Safety] Variables, types, and sound null-safety',
        body: '''
Introduction
Dart’s type system is central for building reliable apps. Since Dart 2.12, null safety is a key feature: non-nullable types are guaranteed by the compiler, preventing many runtime null errors.

Basics
- Types: int, double, bool, String, List<T>, Map<K,V>, Set<T>, dynamic, Object.
- Declaring variables: use 'var' for inferred types, or explicit types for clarity. Use 'final' for single-assignment and 'const' for compile-time constants.

Null safety
- A type by default is non-nullable (String cannot be null).
- To allow null, append '?': String? name.
- Use the null-aware operators: '?.', '??', '??=', and '!' (assert not null).
- Promotes safety by forcing a design decision: either handle possible nulls or assert presence.

Best practices
- Prefer non-nullable types; initialize late values with care using 'late' only when necessary.
- Avoid overuse of '!' — it bypasses safety and can cause runtime exceptions.
- Use typedefs and smaller abstractions to make complex types readable.

Examples and patterns
- Use factory constructors and named constructors for expressive APIs.
- Map/where/expand combinators for immutable collection transformations.

Common pitfalls
- Assuming migration to null-safety is trivial for large codebases; it requires auditing edge cases and dependencies.

Takeaway
Embrace Dart’s type system and null-safety to catch errors at compile-time and make APIs self-documenting.''',
        hasImage: false,
      ),
      AppLesson(
        title: '[Section 3: Functions & Closures] Parameters, scope and functional idioms',
        body: '''
Introduction
Functions in Dart are first-class citizens. Mastering parameter styles, closures, and higher-order functions improves code expressiveness and reduces boilerplate.

Function forms
- Top-level functions, instance methods, static methods.
- Arrow syntax for concise single-expression functions: int add(int a, int b) => a + b.
- Optional positional and named parameters: prefer named parameters for readability in APIs.

Closures and lexical scope
Functions can close over surrounding variables. Use closures for callbacks, event handlers and for creating small, testable units of behaviour.

Higher-order programming
- Pass functions as arguments, return functions from factories.
- Use collection higher-order methods (map, where, reduce) for declarative transformations.

Best practices
- Prefer named parameters with required keyword for clarity.
- Avoid large closures that capture heavy state — this can lead to memory leaks if not cleaned up.

Common mistakes
- Mutable capture inside loops causing surprising behaviour.
- Using many optional positional parameters that are hard to read.

Takeaway
Treat functions as expressive building blocks: combine clarity with small units of behavior for testability and reuse.''',
        hasImage: false,
      ),
      AppLesson(
        title: '[Section 4: Collections & Generics] Lists, Maps, Sets and generic types',
        body: '''
Introduction
Collections are ubiquitous. Dart’s collection APIs are powerful; generics help express constraints and ensure type safety for data structures used throughout an app.

Collections overview
- List<T>: ordered collections; support fixed-length or growable lists.
- Map<K,V>: key-value associations; LinkedHashMap preserves insertion order by default.
- Set<T>: unique unordered elements.

Generics
- Define type parameters to avoid casting and enable compile-time checks.
- Use bounded generics where appropriate: class Repo<T extends BaseModel> { ... }.

Performance tips
- Choose the right collection: prefer Set for membership checks, List for indexed access, Map for lookups.
- Avoid frequent reallocation in performance-sensitive paths — reuse existing buffers where possible.

Immutability and patterns
- Use 'final' to make references immutable and prefer returning unmodifiable views for public APIs.
- Use collection-if and collection-for for concise construction, such as a list that conditionally includes items or generates values from another collection.

Common mistakes
- Using dynamic maps and performing unchecked casts.
- Not validating incoming JSON shapes before mapping.

Takeaway
Dart collections and generics let you model data clearly and safely; prefer typed collections and immutable interfaces for robust code.''',
        hasImage: false,
      ),
      AppLesson(
        title: '[Section 5: Concurrency] Futures, async/await, Streams and Isolates',
        body: '''
Introduction
Concurrency in Dart is centered on event-based async (Futures) and streaming (Streams), plus Isolates for heavy parallel work. Understanding these primitives is essential to keep Flutter UIs responsive.

Futures and async/await
- A Future represents a value available at a later time.
- Use async/await for readable asynchronous code. Always handle exceptions with try/catch.
- Avoid fire-and-forget patterns unless you explicitly log failures.

Streams
- Streams represent sequences of asynchronous events (e.g., user input, socket messages).
- Use broadcast streams for multiple listeners and single-subscription streams when the sequence is consumed once.
- Transform streams with map, where, debounce and use stream controllers to bridge imperative APIs.

Isolates
- Dart isolates provide parallelism with separate memory; communication occurs via ports and messages.
- Use isolates for CPU-bound work (image processing, complex computations) to avoid UI jank.
- Flutter's compute() helper simplifies offloading functions to isolates for simple use-cases.

Best practices
- Cancel subscriptions when widgets dispose to avoid leaks.
- Consider backpressure and buffering strategies for high-frequency streams.

Common mistakes
- Performing CPU-bound operations on the main thread.
- Forgetting to cancel stream subscriptions and timers.

Takeaway
Use async/await for clarity, Streams for event sequences, and Isolates for CPU-bound work to keep UIs smooth.''',
        hasImage: false,
      ),
      AppLesson(
        title: '[Section 6: Error Handling & Testing] Exceptions, typing and robust code',
        body: '''
Introduction
Handling errors gracefully improves stability and user trust. Combine typed errors with robust test coverage to make your code resilient.

Exception handling
- Use try/catch for synchronous and asynchronous errors. Prefer typed exception classes to encapsulate error details.
- Use final fallback and error UI states to present recoverable problems to users.

Assertions and defensive programming
- Use assert() during development to catch programmer errors early.
- Use defensive checks on external inputs, such as network payloads and user-supplied data.

Testing and tools
- Unit test pure logic: functions, domain models, repositories.
- Use mocks (mocktail, Mockito) to simulate dependencies.
- Use the analyzer and linter rules to enforce patterns and avoid common mistakes.

Best practices
- Avoid using exceptions for control flow.
- Provide clear error messages and logs for developers; avoid exposing raw stack traces to users.

Takeaway
Combine strong typing, clear error models and automated tests to reduce runtime failures and simplify debugging.''',
        hasImage: false,
      ),
    ],
  ),

  // ---------------------------------------------------------------------------
  // Course 3 — Flutter Fundamentals
  // ---------------------------------------------------------------------------
  AppCourse(
    id: 'flutter_fundamentals',
    title: 'Flutter Fundamentals',
    description:
        'An in-depth exploration of how Flutter works: widgets, the rendering pipeline, layout, lifecycle, and practical idioms that support building well-structured Flutter apps.',
    instructor: 'Connect Baba',
    category: 'mobile development',
    difficulty: 'Beginner',
    icon: Icons.flutter_dash,
    color: Colors.blue,
    duration: '12h',
    lessons: [
      AppLesson(
        title: '[Section 1: Philosophy] Flutter\'s reactive model explained',
        body: '''
Introduction
Flutter is a UI toolkit built around the idea of describing a UI as a composition of widgets. Understanding the reactive model clarifies why rebuilds happen and how to structure incremental updates.

What is the reactive model?
In Flutter, the UI is declared by running a build function that returns a tree of widgets representing the desired UI at a moment in time. When state changes, Flutter calls build again for affected widgets. This approach encourages immutable widget descriptions and side-effect-free build methods.

Widget vs Element vs RenderObject
- Widget: immutable configuration.
- Element: an instantiation of a widget that holds state and links to the render tree.
- RenderObject: low-level object that handles layout, painting and hit testing.

How rebuilds work
Flutter efficiently diffs elements and reuses existing render objects when possible. Properly designed widgets minimize unnecessary rebuilds by placing state at the correct boundary and using const widgets where feasible.

Why it matters
Misunderstanding rebuilds leads to performance issues or overly complex component trees. Embrace immutability and move mutation to stateful holders and controllers.

Common mistakes
- Doing expensive work in build() methods.
- Storing mutable global UI state instead of localizing it.

Key takeaways
Think declaratively: the build method returns a description, and the framework updates the screen based on state changes.''',
        hasImage: false,
      ),
      AppLesson(
        title: '[Section 2: Widgets & Lifecycle] StatelessWidget vs StatefulWidget',
        body: '''
Introduction
Choosing between StatelessWidget and StatefulWidget is a fundamental design decision. This lesson explains lifecycle, update semantics, and common patterns.

StatelessWidget
Used when the UI depends only on immutable configuration and ambient inherited widgets. Build is pure and side-effect-free. Benefits include easy reasoning and potential compile-time optimizations (const).

StatefulWidget
Used when UI depends on mutable state held in a State object. Lifecycle methods include initState(), didChangeDependencies(), build(), didUpdateWidget(), deactivate(), dispose(). Use these hooks for initialization, responding to dependency changes and cleaning up resources.

Rules and patterns
- Keep state small and focused on what changes.
- Prefer composition over large monolithic stateful widgets.
- Use controllers (TextEditingController, AnimationController) with proper disposal in dispose().

Common mistakes
- Placing business logic in State and forgetting to unit test.
- Overusing StatefulWidget where Provider/Riverpod/Bloc would be more appropriate.

Best practices
- Prefer StatelessWidget when possible.
- Use Keys to preserve state across widget tree modifications only when necessary.

Takeaway
Correct state placement improves performance, testability and readability.''',
        hasImage: false,
      ),
      AppLesson(
        title: '[Section 3: Layout & Constraints] How Flutter lays out widgets',
        body: '''
Introduction
Layout in Flutter is driven by constraints flowing down the tree and sizes (intrinsic/explicit) flowing up. Internalizing this model helps you debug layout issues.

Constraint model
Parent provides BoxConstraints (min/max width/height) to children. A child must choose a size that fits those constraints and return it to the parent. This is different from many immediate-mode layouts and explains behaviors of Expanded, Flexible and Intrinsic widgets.

Common layout widgets
- Row/Column (flex layouts): use Expanded and Flexible for distribution.
- Stack: absolute positioning relative to parent bounds.
- ListView, GridView and Slivers for scrollable content.

Performance and best practices
- Prefer lazy builders for lists (ListView.builder).
- Avoid expensive child measurement (intrinsic widgets) in large lists.
- Use const where possible for static subtree widgets.

Debugging tips
- Use Flutter inspector to examine constraints and sizes.
- Add colored Containers temporarily to visualize bounds.

Takeaway
Think in constraints: parents impose limits and children choose sizes; use the right widgets for distribution and virtualization to build performant layouts.''',
        hasImage: false,
      ),
      AppLesson(
        title: '[Section 4: Rendering] Painting, compositing and performance',
        body: '''
Introduction
Rendering involves painting widgets to the screen and occasionally compositing layers for efficient GPU usage. Understanding this pipeline explains why some widgets cause repaints and others do not.

Render pipeline
- Layout: determines sizes and positions.
- Paint: issues canvas commands to draw shapes and images.
- Compositing: groups paint commands into layers to minimize re-paints and leverage GPU for transforms.

Performance signals
- Jank: frame rendering exceeds 16ms on 60fps devices.
- Excessive repaints: caused by frequently changing widgets or expensive paint operations (shadows, opacity over large regions).

Optimization patterns
- Avoid rebuilding the whole subtree when only a small portion changes. Extract subtrees into separate widgets.
- Use RepaintBoundary to isolate painting costs for complex widgets.
- Cache images and use lower-resolution placeholders when appropriate.

Common mistakes
- Using opacity on large subtrees frequently — prefer pre-composited layers.
- Doing heavy allocations during frame callbacks.

Takeaway
Be mindful of painting costs and use compositing and widget extraction to limit repaint scope and keep frame times low.''',
        hasImage: false,
      ),
      AppLesson(
        title: '[Section 5: Input & Forms] User input, validation and accessibility',
        body: '''
Introduction
Forms are the primary way users interact with data-driven apps. Good form design balances validation, user guidance and accessibility.

Text inputs
- Use TextFormField with validators to declaratively express validation rules.
- Provide appropriate keyboardType and textInputAction to optimize user flow.
- Manage focus with FocusNode to create logical tab/next navigation.

Validation strategies
- Synchronous validation for simple checks (non-empty, regex).
- Asynchronous checks (e.g., server-side username uniqueness) should provide progressive feedback with debouncing.
- Keep validation messages specific and actionable.

Accessibility
- Ensure form fields are labelled (semantics), controls can be navigated by screen readers, and error messages are announced.

Common mistakes
- Hiding validation errors or showing them only after submission — prefer inline, context-aware feedback.
- Blocking network calls directly in onChanged callbacks.

Takeaway
Design forms for clarity and accessibility; separate validation and submission concerns for a predictable UX.''',
        hasImage: false,
      ),
      AppLesson(
        title: '[Section 6: Assets, Themes & Internationalization] Managing app resources',
        body: '''
Introduction
Applications include images, fonts, translations, and theming. Managing these consistently is critical for a production app.

Assets
- Declare assets in pubspec.yaml. Prefer SVG/vector assets for scalable icons and multiple pixel densities for raster images.
- Consider using cached_network_image for remote assets to avoid repeated downloads.

Theming
- Use ThemeData and colorSchemeSeed to centralize look-and-feel.
- Support dark mode and dynamic text scaling. Keep design tokens (spacing, typography) centralized for consistency.

Internationalization (i18n)
- Use Flutter localization tools (ARB files) or packages (easy_localization). Avoid embedding text in widgets; use keys.
- Consider pluralization, date/number formatting and directionality (RTL).

Best practices
- Keep assets small and optimized.
- Use design tokens for predictable theming and easier brand changes.

Takeaway
Centralize resource management—assets, themes and localizations—for consistent cross-platform experiences.''',
        hasImage: false,
      ),
    ],
  ),

  // ---------------------------------------------------------------------------
  // Course 4 — Flutter UI Development
  // ---------------------------------------------------------------------------
  AppCourse(
    id: 'flutter_ui_development',
    title: 'Flutter UI Development',
    description:
        'Design patterns and practical techniques for building polished Flutter user interfaces: typography, spacing, responsive/adaptive layouts, states (loading/empty/error) and accessibility.',
    instructor: 'Connect Baba',
    category: 'mobile development',
    difficulty: 'Intermediate',
    icon: Icons.palette,
    color: Colors.purple,
    duration: '10h',
    lessons: [
      AppLesson(
        title: '[Section 1: Visual Design] Visual hierarchy, typography and color',
        body: '''
Introduction
A good interface communicates hierarchy and function immediately. Apply visual hierarchy through size, color and spacing, and use typography and color systems deliberately.

Typography
- Use a typographic scale for headings, body, captions and labels.
- Support dynamic type scaling and ensure layout adapts to larger fonts.
- Choose font families and weights carefully — consistent typography enhances perceived quality.

Color
- Use a limited palette: primary, secondary, surface, background, error.
- Ensure contrast ratios for accessibility; use WCAG guidelines.
- Use semantic colors (e.g., success, warning) rather than ad-hoc tints sprinkled through the code.

Spacing and layout rhythm
- Establish consistent spacing units (8dp baseline grid).
- Use spacing tokens for margins and paddings to maintain rhythm across the app.

Why it matters
Consistent visual systems speed development and improve usability — designers and developers speak the same language via tokens.

Common mistakes
- Using too many font styles and colors causing visual noise.
- Hardcoding spacings and colors across many widgets.

Takeaway
Create a small set of visual tokens for typography, color and spacing and apply them consistently.''',
        hasImage: false,
      ),
      AppLesson(
        title: '[Section 2: Responsive & Adaptive] Handling screens and orientations',
        body: '''
Introduction
Mobile apps run on diverse devices: phones, tablets, foldables and web. A responsive UI adapts layout and density; an adaptive UI varies structure to exploit platform affordances.

Responsive techniques
- MediaQuery to read screen size and orientation.
- LayoutBuilder to inspect parent constraints and switch to alternate layouts when thresholds are crossed.
- Use fractional sizes (Flexible, Expanded) and constraints rather than absolute pixel values.

Adaptive patterns
- On tablets, consider master-detail layout (two-pane) instead of stacked navigation.
- On web, make content scrollable horizontally and present denser information.

Testing
- Test with different device sizes, font scaling and on-device rotations.
- Consider accessibility settings (large fonts, high-contrast) when designing breakpoints.

Common mistakes
- Relying solely on screen width thresholds without considering content density and interaction model.

Takeaway
Design layouts that adapt gracefully to screen size, orientation and user settings to deliver consistent usability across devices.''',
        hasImage: false,
      ),
      AppLesson(
        title: '[Section 3: Lists, Grids & Virtualization] High-performance scrolling',
        body: '''
Introduction
Long lists are common on mobile. Use virtualization to render only visible items and reduce memory and CPU costs.

List techniques
- ListView.builder and GridView.builder create items lazily as needed.
- Use const subtrees and keyed widgets to preserve state during insertions or reorders.
- Implement item placeholders and skeletons to improve perceived speed during loading.

Pagination & infinite scrolling
- Fetch page-by-page based on position or cursor.
- Avoid naive infinite fetch on scroll end; use thresholds and ensure retries on failures.

Accessibility & UX
- Ensure items are reachable via accessibility services and that taps are large enough.
- Support keyboard navigation on desktop/web targets.

Common mistakes
- Building the whole list in memory (ListView(children: [...])) for large datasets.
- Blocking the UI while loading pages.

Takeaway
Use lazy builders and efficient pagination strategies to keep scrollable lists fast and smooth.''',
        hasImage: false,
      ),
      AppLesson(
        title: '[Section 4: Forms, Validation & UX] Designing reliable form flows',
        body: '''
Introduction
Forms are where users provide critical data. UX design for forms reduces friction, increases completion rates and reduces support load.

Field design
- Group related inputs and show inline hints and examples.
- Show real-time validation for simple checks, but avoid noisy validation on first keystroke.
- Use clear error messaging with recovery steps.

Progressive disclosure
- Split long forms into steps and persist partial progress.
- Use auto-save for multi-step flows to avoid data loss.

Security and privacy
- Mask sensitive fields (passwords), avoid logging input values, and use secure storage for credentials.

Accessibility
- Ensure labels are present and linked to fields; use appropriate input types to show correct keyboards.

Common mistakes
- Using ambiguous labels or relying on placeholder text as the only label.
- Performing network-bound validation synchronously blocking form submission.

Takeaway
Design forms for clarity, immediate feedback and accessibility; provide clear error states and recovery options.''',
        hasImage: false,
      ),
      AppLesson(
        title: '[Section 5: Loading, Empty & Error States] Making UX resilient',
        body: '''
Introduction
Robust apps gracefully handle network delays and errors with UI states that inform and guide users.

Loading patterns
- Use skeletons or shimmer to suggest content structure without blocking.
- Use progressive loading for lists (header first, then items) to reduce perceived latency.

Empty states
- Provide meaningful copy and affordances in empty lists (actions the user can take).
- Use contextual illustrations or microcopy that explains why content is empty.

Error states and retries
- Provide clear error messages and explicit retry affordances; avoid generic "Something went wrong."
- Differentiate between transient errors (network) and permanent errors (permission denied) and provide appropriate actions.

Design for offline
- Where possible, enable read-only offline usage and queue writes for later (sync patterns).

Takeaway
Anticipate network variability with clear loading, empty and error UI that reduces user confusion and supports recovery.''',
        hasImage: false,
      ),
      AppLesson(
        title: '[Section 6: Theming & Dark Mode] Modern theming and dynamic colors',
        body: '''
Introduction
Theming provides consistency across UI components. Supporting dark mode and dynamic color palettes is expected in modern apps.

Theming approach
- Centralize ThemeData and use colorScheme for semantic color definitions.
- Extract design tokens: spacing, radii, shadow sizes and component variants.
- Support runtime theme changes with provider/Riverpod or inherited theme objects.

Dark mode considerations
- Test color combinations to maintain contrast and avoid color inversion bugs.
- Use different asset variants or adaptive SVGs for clarity in dark mode.

Dynamic color and platform integration
- On Android 12+, leverage Material You dynamic colors when appropriate, but always provide fallback palettes.
- Respect user system theme preference and allow in-app overrides.

Takeaway
A robust theming strategy yields consistent visuals and eases brand updates; support dark mode and test thoroughly across components.''',
        hasImage: false,
      ),
    ],
  ),

  // ---------------------------------------------------------------------------
  // Course 5 — Mobile Navigation & Application Architecture
  // ---------------------------------------------------------------------------
  AppCourse(
    id: 'mobile_navigation_architecture',
    title: 'Mobile Navigation & Application Architecture',
    description:
        'Design navigation patterns and application architecture for maintainable, scalable mobile applications: routing models, nested navigation, auth guards, DI and feature modularization.',
    instructor: 'Connect Baba',
    category: 'mobile development',
    difficulty: 'Intermediate',
    icon: Icons.swap_horiz,
    color: Colors.orange,
    duration: '9h',
    lessons: [
      AppLesson(
        title: '[Section 1: Navigation Fundamentals] Declarative vs Imperative navigation',
        body: '''
Introduction
Navigation is how users move through an app. Two main paradigms exist: imperative (push/pop) and declarative (state-driven routes). Each has tradeoffs for complexity, testability and deep-linking.

Imperative navigation
- Navigator.push/pop: simple to reason about for linear flows.
- Easier for transient behaviors and one-off navigations.

Declarative navigation
- The app’s navigation stack is derived from state (router + route configuration).
- Better for complex flows, deep linking and synchronizing URL-like representations with app state.

Which to choose
- For simple apps, imperative navigation is pragmatic.
- For apps requiring nested shells, deep links and web parity, adopt a declarative router (e.g., go_router) to centralize route handling.

Best practices
- Keep navigation logic outside widgets where possible (navigation service or router delegate).
- Avoid tight coupling of business logic to navigation decisions.

Takeaway
Choose the navigation style that matches app complexity — prefer declarative routing for predictable, linkable user flows.''',
        hasImage: false,
      ),
      AppLesson(
        title: '[Section 2: Routing & Parameters] Named routes, arguments and typed routing',
        body: '''
Introduction
Routes often carry parameters: IDs, query parameters, or serialized filters. Managing these consistently avoids runtime surprises.

Typed parameters
- Use typed argument objects instead of raw Map<String, dynamic> to reduce casting and errors.
- Define route models that describe the expected parameters and default values.

Query & deep links
- Support query parameters for filterable or paginated screens.
- Normalize route parsing and validation to handle invalid parameters gracefully.

Security considerations
- Avoid embedding sensitive data in routes (URLs) that are logged or shared.
- Validate route inputs thoroughly on screen load.

Takeaway
Design routes with typed contracts and clear parameter validation to make navigation predictable and safe.''',
        hasImage: false,
      ),
      AppLesson(
        title: '[Section 3: Nested Navigation] Shells, tabs and nested stacks',
        body: '''
Introduction
Large apps commonly have nested navigation: bottom tabs each with their own navigation stack or master-detail patterns on tablets. Nested navigators retain state per tab and enable independent navigation flows.

Patterns
- Navigator per tab: preserves the tab’s history.
- Shell routers / navigation shells: central place for common scaffolding while each child manages its own stack.

State and restoration
- Persist navigation state across app restarts if user expectations demand it.
- Use restoration IDs and route serialization for deep linking and state restoration.

Common pitfalls
- Sharing a single Navigator across unrelated flows causing unwanted pop behavior.
- Not managing back button behavior consistently across nested stacks (Android system back).

Takeaway
Use nested navigators to model independent flows and carefully manage back/restore semantics for a natural user experience.''',
        hasImage: false,
      ),
      AppLesson(
        title: '[Section 4: Authenticated Flows] Guards, protected routes and session state',
        body: '''
Introduction
Most real apps have protected areas requiring authentication. Architecting auth-aware navigation ensures that unauthorized screens are unreachable and session changes propagate predictably.

Authentication guard strategies
- Router-level guard: prevents navigation to protected routes and redirects to login.
- Widget-level guard: shows different UI when session not present (useful for shared widgets).

Session state
- Keep the user session in a global provider or authentication service and notify listeners on login/logout.
- Carefully handle token refresh and session expiration to avoid inconsistent UI states (e.g., showing protected content while token is invalid).

Edge cases
- Deep links to protected routes should capture the original target, prompt login, then resume to the intended screen on success.
- Handle simultaneous session invalidation gracefully (show single global sign-out modal rather than multiple alerts).

Takeaway
Centralize auth state and route guards to protect navigation and provide smooth re-entry to intended flows after authentication.''',
        hasImage: false,
      ),
      AppLesson(
        title: '[Section 5: Modular Architecture] Features, packages and dependency inversion',
        body: '''
Introduction
As applications scale, modularization helps teams work independently and prevents a monolithic codebase from becoming brittle.

Feature modules
- Group code by feature (profile, feed, settings) rather than technical layer to align with product ownership.
- Expose minimal public APIs for each module so other modules interact via well-defined contracts.

Packages and plugin boundaries
- Use local packages within the repository (packages/) for shared components, models and utilities.
- Keep platform-specific code at clear boundaries (platform channels, plugin wrappers).

Dependency inversion
- Invert dependencies: higher-level modules define interfaces; lower-level modules provide implementations (DI).
- This enables mocking and independent testing of feature modules.

Best practices
- Keep modules small and cohesive.
- Avoid circular dependencies by establishing clear dependency direction (app -> features -> core).

Takeaway
Organize code into modular, feature-focused packages and adhere to inversion of control for maintainability and testability.''',
        hasImage: false,
      ),
      AppLesson(
        title: '[Section 6: Maintainability & Observability] Logging, metrics and runtime flags',
        body: '''
Introduction
Maintainability includes operational concerns: logs to debug issues, metrics to measure feature impact, and flags to roll out features gradually.

Logging and error reporting
- Use structured logs and attach context (user id, session id) for effective debugging.
- Integrate crash reporting (Sentry, Crashlytics) for root-cause analysis.

Feature flags
- Use remote-controlled flags for gradual rollouts and quick rollbacks.
- Keep flag evaluation cheap and deterministic.

Telemetry and metrics
- Track business KPIs (engagement, retention) and technical KPIs (startup time, error rates).
- Avoid excessive telemetry that affects privacy or performance.

Takeaway
Design architecture that includes runtime observability and safe rollout patterns to keep products healthy in production.''',
        hasImage: false,
      ),
    ],
  ),

  // ---------------------------------------------------------------------------
  // Course 6 — State Management in Mobile Applications
  // ---------------------------------------------------------------------------
  AppCourse(
    id: 'state_management_mobile',
    title: 'State Management in Mobile Applications',
    description:
        'Comprehensive coverage of state concepts: ephemeral vs application state, derived state, async flows, and modern libraries (Provider, Riverpod, Bloc). How to choose an approach and design testable state architectures.',
    instructor: 'Connect Baba',
    category: 'mobile development',
    difficulty: 'Intermediate',
    icon: Icons.layers,
    color: Colors.deepPurple,
    duration: '9h',
    lessons: [
      AppLesson(
        title: '[Section 1: What is State] Definitions, ownership and lifetime',
        body: '''
Introduction
State is any data that determines what the UI displays. Categorizing state clarifies ownership and lifecycle responsibilities which leads to consistent, testable apps.

Types of state
- Ephemeral (local) state: confined to a single widget (e.g., an animation controller).
- Shared state: used across multiple widgets (authentication, user preferences).
- Persistent state: saved on disk or database for restoration.
- Derived state: computed from other state (e.g., totals from a list of items).

Ownership & lifetime
- Define a single owner: only one place mutates important state to avoid race conditions.
- Use short-lived state for transient UI concerns and longer-lived providers/services for global state.

Why it matters
Unclear state ownership causes bugs like UI inconsistencies and data mismatches. Clear rules make debugging and testing straightforward.

Takeaway
Identify state types and clearly decide who owns and mutates each piece of state to avoid conflicts and improve predictability.''',
        hasImage: false,
      ),
      AppLesson(
        title: '[Section 2: Patterns] Unidirectional flow, event sourcing and immutable models',
        body: '''
Introduction
Unidirectional data flow reduces cycles of mutation and makes reasoning about changes simpler. This lesson examines patterns that implement this principle.

Unidirectional flow
- Changes are represented as events/actions.
- A single reducer or handler processes actions and produces a new state.
- UI reacts to state changes only; it does not directly mutate state.

Immutable models
- Prefer immutable models where possible. Immutable snapshots make debugging and time-travel debugging feasible.
- Use copyWith patterns to easily derive modified instances.

Event sourcing & logs
- Large applications benefit from event logs for auditing and debugging. Events can be replayed to reconstruct state.

Choosing a pattern
- For simple apps, simple ChangeNotifier or Provider might suffice.
- For complex flows with many interactions, consider Bloc or Redux-like approaches for predictability.

Takeaway
Prefer simple unidirectional flows; choose more heavy-weight patterns only when required by application complexity.''',
        hasImage: false,
      ),
      AppLesson(
        title: '[Section 3: Provider & InheritedWidget] Simple dependency injection',
        body: '''
Introduction
Provider is a lightweight way to expose objects to widget subtrees. It builds on top of InheritedWidget and offers patterns for DI and state propagation.

How Provider works
- Wrap the app or subtree with a provider that creates and exposes an object.
- Widgets down the tree use Provider.of<T>(context) or Consumer<T> to access the object and rebuild on changes.

Lifecycle and disposal
- Use Provider with create/dispose semantics so resources are cleaned when providers are removed.
- Avoid creating providers inside build methods that will recreate on every build.

When to use
- For localized, simple shared state such as theme or small view models.
- Pair with ChangeNotifier for simple observable models.

Common mistakes
- Over-providing many small providers causing overhead.
- Storing ephemeral UI state in high-level providers.

Takeaway
Provider is a pragmatic, low-friction tool for dependency injection and small shared state management; it shines for its simplicity.''',
        hasImage: false,
      ),
      AppLesson(
        title: '[Section 4: Riverpod] Scalable state with testability',
        body: '''
Introduction
Riverpod is a modern alternative to Provider with improved testability, compile-time safety, and better provider lifecycles.

Core concepts
- Providers are declared independently of the widget tree and can be overridden for tests.
- Providers come in different flavors: Provider (value), StateProvider, FutureProvider, StreamProvider, and more complex Notifier providers.

Benefits
- Easier testing: providers can be instantiated and read outside Flutter widgets.
- Removal of InheritedWidget dependency makes architecture clearer.

Best practices
- Use small focused providers and compose them.
- Keep computation in providers and keep widgets simple.

Common mistakes
- Treating providers as a dumping ground for unrelated utilities.
- Overfetching by not scoping providers appropriately.

Takeaway
Riverpod provides strong primitives for scalable, testable state management suitable for medium and large apps.''',
        hasImage: false,
      ),
      AppLesson(
        title: '[Section 5: Bloc / Cubit] Event-driven state management',
        body: '''
Introduction
Bloc (Business Logic Component) implements an event->state mapping that enforces separation and improves testability. Cubit is a simplified flavor focusing on direct state changes.

Architecture
- Events are dispatched to the Bloc.
- Bloc transforms events (possibly using repositories) into new states, emitted via a stream.
- UI subscribes to state changes and rebuilds accordingly.

When to use
- Complex state machines with clear event flows, multiple concurrent states, and complex side effects.
- Teams familiar with reactive streams and event-driven architectures.

Testing
- Bloc separates side effects and pure mapping logic making unit tests straightforward: dispatch an event and assert the emitted state sequence.

Common mistakes
- Overusing Bloc for trivial UI where ChangeNotifier or Riverpod would be simpler.
- Putting side effects in the UI layer instead of the bloc.

Takeaway
Use Bloc for complex event-driven scenarios where clear event/state separation brings clarity and testability.''',
        hasImage: false,
      ),
      AppLesson(
        title: '[Section 6: Async State & Patterns] Loading, error, caching and retries',
        body: '''
Introduction
Async state patterns are ubiquitous: fetch, show loading, present data or error, and handle refresh. Design consistent patterns for these states to avoid spaghetti logic.

Typical model
- Use a sealed state (loading, success<T>, failure) to represent possible states explicitly.
- Retry strategies: exponential backoff, idempotency considerations, and user-triggered manual retries.

Caching
- Cache at repository level with TTLs or LRU policies.
- Consider stale-while-revalidate for a fast perceived UI while ensuring freshness.

Best practices
- Keep retry policies centralized.
- Surface precise error messages for actionable user response (e.g., "Offline — Retry" vs "Server error — Try later").

Takeaway
Model async flows explicitly and centralize caching/retry semantics at repository boundaries for a consistent user experience.''',
        hasImage: false,
      ),
    ],
  ),

  // ---------------------------------------------------------------------------
  // Course 7 — Mobile Data, Storage & Databases
  // ---------------------------------------------------------------------------
  AppCourse(
    id: 'mobile_data_storage',
    title: 'Mobile Data, Storage & Databases',
    description:
        'How to design data layers for mobile apps: local storage options, database schemas, caching strategies, synchronization and conflict resolution for offline-first environments.',
    instructor: 'Connect Baba',
    category: 'mobile development',
    difficulty: 'Intermediate',
    icon: Icons.storage,
    color: Colors.brown,
    duration: '9h',
    lessons: [
      AppLesson(
        title: '[Section 1: Data Modeling] Designing mobile-friendly schemas',
        body: '''
Introduction
Data modeling on mobile balances local constraints and app semantics. Simplicity and robust migration strategies are primary goals.

Principles
- Model data for the UI: store normalized entities and design DTOs for transmission.
- Favor small, focused tables/collections that map to concrete features.
- Use surrogate keys and stable identifiers for synchronization with backends.

Migrations
- Plan versioned migrations for local databases; always provide upgrade and downgrade paths where possible.
- Store a schema version in the DB and write deterministic upgrade steps.

Why it matters
Poor modeling leads to migration nightmares and complicated sync logic. Model for the domain with an eye on offline sync needs.

Takeaway
Design pragmatic, evolvable models and invest in robust migration tooling early.''',
        hasImage: false,
      ),
      AppLesson(
        title: '[Section 2: Key-Value & Secure Storage] Preferences and secrets',
        body: '''
Introduction
Key-value stores are ideal for small preferences, tokens and feature toggles. Secure handling of secrets is a critical security concern.

SharedPreferences / platform equivalents
- Use for simple booleans, strings and lightweight values (theme, flags).
- Keep size small and avoid storing structured objects directly—serialize carefully.

Secure storage
- Use platform-specific secure stores (Android Keystore, iOS Keychain) to store tokens and secrets.
- Rotate keys and keep short token lifetimes for better security posture.

Best practices
- Never store unencrypted sensitive data in plaintext.
- Combine secure storage with server-side session invalidation for forced logouts.

Takeaway
Use key-value storage for small, non-sensitive preferences and platform secure stores for credentials or secrets.''',
        hasImage: false,
      ),
      AppLesson(
        title: '[Section 3: Relational Databases] SQLite, Room and object mapping',
        body: '''
Introduction
Relational databases like SQLite are common on mobile for structured, transactional data. Abstractions like Room (Android) or ORM-like helpers on Flutter simplify usage with compile-time checks.

Schema design
- Normalize where appropriate, but denormalize for read performance if necessary.
- Index columns that appear in WHERE clauses; avoid over-indexing.

Transactions
- Use transactions for atomic operations that touch multiple tables to maintain data integrity.

Mapping
- Map rows to domain models via DAOs/repositories; keep SQL in infrastructure layers and domain models pure.

Migrations & testing
- Use migration scripts and test migration paths from older versions to current.

Takeaway
Use relational databases for structured data requiring queries and transactions; abstract behind repositories for testability.''',
        hasImage: false,
      ),
      AppLesson(
        title: '[Section 4: NoSQL & Document Stores] When to choose document models',
        body: '''
Introduction
Document/NoSQL stores fit flexible schemas and hierarchical data patterns. They are useful for caches, offline-first sync stores and when the shape varies frequently.

Tradeoffs
- Favor NoSQL for denormalized, read-optimized access.
- Accept eventual consistency or implement conflict resolution strategies.

Querying and indices
- NoSQL queries may be limited; design documents with expected query patterns in mind.
- Use indices where supported to avoid full scans.

Takeaway
Choose document stores for flexible models but plan queries and sync semantics ahead of time.''',
        hasImage: false,
      ),
      AppLesson(
        title: '[Section 5: Caching & Offline] Cache policies and stale data management',
        body: '''
Introduction
Effective caching reduces network usage and yields a snappier UX. Offline-first apps must handle reconciling local edits with the server.

Caching policies
- TTL (time-to-live): simple expiration-based cache.
- Stale-while-revalidate: show cached data and refresh in background.
- Hybrid: combine memory caches and persistent caches for immediate access and cross-session persistence.

Offline writes & sync
- Use an append-only change log to queue writes.
- Implement deterministic conflict resolution (last-writer-wins, CRDTs or server-resolved merge policies).
- Provide user-facing conflict resolution for critical data where automatic resolution is unsafe.

Takeaway
Design caches according to data criticality and provide robust sync and conflict strategies for offline scenarios.''',
        hasImage: false,
      ),
      AppLesson(
        title: '[Section 6: Repositories & Persistence Layer] Clean separation',
        body: '''
Introduction
A repository mediates between domain logic and persistence/backends. It centralizes caching, mapping, validation and retry semantics.

Responsibilities of repositories
- Provide a single API for data access (get, list, save, delete).
- Hide storage details: whether data comes from the DB, cache or network is an internal implementation detail.
- Centralize error handling, caching and retries.

Testing & mocking
- Repositories are easy to mock in tests; keep them interface-driven for substitutability.

Takeaway
Use repositories to encapsulate data access logic and keep higher layers agnostic to storage details.''',
        hasImage: false,
      ),
    ],
  ),

  // ---------------------------------------------------------------------------
  // Course 8 — APIs & Backend Integration
  // ---------------------------------------------------------------------------
  AppCourse(
    id: 'apis_backend_integration',
    title: 'APIs & Backend Integration',
    description:
        'Designing robust API clients and backend contracts for mobile applications: REST/HTTP fundamentals, authentication flows, error handling, pagination, file uploads and offline synchronization.',
    instructor: 'Connect Baba',
    category: 'mobile development',
    difficulty: 'Intermediate',
    icon: Icons.cloud,
    color: Colors.blueGrey,
    duration: '10h',
    lessons: [
      AppLesson(
        title: '[Section 1: Network Fundamentals] HTTP, TLS and reliability',
        body: '''
Introduction
Mobile apps rely on remote services; understanding HTTP fundamentals and secure transport is vital for reliable, secure integration.

HTTP basics
- Methods: GET, POST, PUT/PATCH, DELETE — choose semantics carefully (idempotency matters).
- Status codes: 2xx success, 4xx client errors, 5xx server errors. Map them to user-friendly messages and retry strategies.

TLS & certificate handling
- Always use HTTPS in production. Ensure certificates are validated and consider certificate pinning for high-security contexts (carefully manage pin updates).
- Be aware of TLS handshakes cost; reuse connections when possible.

Resilience
- Implement timeouts, retries with exponential backoff and circuit breaker patterns for flaky services.
- Avoid silent infinite retries or aggressive polling that drains battery and network.

Takeaway
Treat network communication as an unreliable resource: design for timeouts, retries and secure channels.''',
        hasImage: false,
      ),
      AppLesson(
        title: '[Section 2: API Design & Contracts] Backend considerations for mobile clients',
        body: '''
Introduction
APIs designed for mobile clients should be efficient, predictable and versioned. Consider payload size, pagination, and backward compatibility.

API design tips
- Use compact payloads and avoid returning fields that clients don’t need.
- Provide endpoints that support pagination and partial resource fetches.
- Use clear versioning (URI versioning or Accept headers) and include deprecation windows.

Contracts and schemas
- Share JSON schemas or OpenAPI specs with mobile teams; generate clients where appropriate to reduce errors.
- Document error codes and authentication flows.

Data formats
- JSON is ubiquitous; consider binary formats (Protobuf) where bandwidth or CPU parsing matters.

Takeaway
Design APIs with mobile constraints in mind and codify contracts to reduce integration friction.''',
        hasImage: false,
      ),
      AppLesson(
        title: '[Section 3: Auth & Token Flows] Access/refresh tokens and secure storage',
        body: '''
Introduction
Authentication is central to many apps. Clients typically use short-lived access tokens and long-lived refresh tokens to minimize exposure if tokens leak.

Flow patterns
- OAuth2 Authorization Code with PKCE is recommended for mobile apps interacting with third-party providers.
- Use refresh tokens to obtain new access tokens without re-prompting users frequently.

Secure storage & rotation
- Store tokens in platform secure stores and rotate refresh tokens on sign-out or suspicious activity.
- Ensure token revocation logic exists server-side.

Handling token expiry
- Centralize token refresh logic in a network interceptor to transparently renew tokens and retry the original request.

Takeaway
Follow secure, standardized token flows and centralize token management to avoid leaks and inconsistent auth behaviour.''',
        hasImage: false,
      ),
      AppLesson(
        title: '[Section 4: Error Handling & Retries] Mapping network failures to UX',
        body: '''
Introduction
Network errors are inevitable. Translate technical errors into actionable UX while exposing enough context to troubleshoot.

Classification
- Client errors (4xx): show helpful messages; in some cases prompt user action.
- Server errors (5xx): present retry affordances and fallback UIs.
- Network connectivity: distinguish offline vs transient failures.

Retry strategies
- Use exponential backoff with jitter for transient errors.
- Limit retries to avoid battery drain; let the user control retry for important operations.

Visibility & logging
- Capture network failures in telemetry with request metadata for debugging.
- Avoid logging sensitive headers or tokens.

Takeaway
Design error handling that differentiates failure types, provides clear user paths and minimizes unnecessary retries.''',
        hasImage: false,
      ),
      AppLesson(
        title: '[Section 5: Pagination, Filtering & Efficiency] Scalable list loading',
        body: '''
Introduction
Large datasets require careful loading strategies. Good APIs and client patterns reduce data usage and improve perceived performance.

Pagination options
- Offset pagination: simple but can be inconsistent when underlying data changes.
- Cursor pagination: more robust for large or frequently-changing datasets and preferred for feed-like data.

Client-side patterns
- Use incremental loading (infinite scroll) with prefetching thresholds.
- Support pull-to-refresh semantics to allow users to request the latest data.

Filtering & search
- Implement server-side filtering for large datasets and apply client caching for common queries.

Takeaway
Pick pagination models that match your backend and implement client patterns to minimize bandwidth while offering responsive UIs.''',
        hasImage: false,
      ),
      AppLesson(
        title: '[Section 6: File Uploads & Media] Efficient uploads and large payload handling',
        body: '''
Introduction
Images and media are heavy; handle them efficiently to reduce bandwidth and improve UX.

Upload best practices
- Resize and compress images on device before upload where quality allows.
- Use multipart uploads for chunked/resumable uploads to handle flaky mobile networks.
- Provide progress indicators and allow background uploads when possible.

Streaming & downloads
- Stream media to avoid large memory allocations.
- Support pause/resume semantics where long downloads are likely.

Security
- Use signed URLs from the server (short-lived) for direct uploads to storage buckets to reduce server bandwidth.

Takeaway
Design media flows that minimize device and network costs while providing reliable progress and resumability.''',
        hasImage: false,
      ),
    ],
  ),

  // ---------------------------------------------------------------------------
  // Course 9 — Mobile Authentication & Security
  // ---------------------------------------------------------------------------
  AppCourse(
    id: 'mobile_auth_security',
    title: 'Mobile Authentication & Security',
    description:
        'Defensive mobile security: secure credential storage, TLS, certificate handling, secure coding practices, threat modelling and mobile-specific attack vectors such as tampering and reverse engineering.',
    instructor: 'Connect Baba',
    category: 'mobile development',
    difficulty: 'Advanced',
    icon: Icons.lock,
    color: Colors.deepOrange,
    duration: '10h',
    lessons: [
      AppLesson(
        title: '[Section 1: Auth Concepts] Authentication vs Authorization & threat models',
        body: '''
Introduction
Authentication proves identity; authorization enforces access. Establishing a threat model is the first step in securing mobile apps.

Threat modelling
- Identify assets (tokens, PII), actors (users, attackers), and attack surfaces (network, local storage, IPC).
- Prioritize mitigations for high-impact threats like token theft or data exfiltration.

Authentication patterns
- Local authentication (passwords, biometrics) vs federated (OAuth/OIDC).
- For mobile, Authorization Code with PKCE is best practice for interacting with third-party identity providers.

Principles
- Least privilege: request minimal permissions.
- Defense-in-depth: combine secure transport, token policies and secure storage.

Takeaway
Model threats early and choose authentication flows aligned with mobile security constraints.''',
        hasImage: false,
      ),
      AppLesson(
        title: '[Section 2: Secure Storage] Keystore, Keychain and best practices',
        body: '''
Introduction
Storing secrets requires platform-secure storage to reduce the attack surface if a device is compromised or lost.

Platform mechanisms
- Android Keystore: secures keys and can keep keys non-exportable when hardware-backed.
- iOS Keychain: secure storage for small secrets.
- For Flutter, wrap these mechanisms in a small, well-tested abstraction to allow mocking in tests.

Token lifecycle & rotation
- Use short-lived access tokens and refresh tokens stored securely.
- Implement silent rotation logic and handle refresh failures (force logout, re-auth).

Best practices
- Avoid storing long-lived static secrets in app resources or code.
- Use platform features (biometric gating) for critical operations and re-authentication on sensitive actions.

Takeaway
Use platform secure stores for secrets and design token lifecycles that minimize exposure and support rotation.''',
        hasImage: false,
      ),
      AppLesson(
        title: '[Section 3: Network Security] TLS, certificate pinning and secure APIs',
        body: '''
Introduction
Protecting transport is fundamental. TLS is necessary but not always sufficient; consider additional protections for high-risk applications.

Certificate validation
- Rely on standard TLS validation; consider certificate pinning only when threats justify the operational burden.
- Pinning requires clear update processes to avoid accidental lockouts when certificates rotate.

Mutual TLS & token comps
- Mutual TLS (mTLS) increases security but adds complexity; typically used in high-security enterprise scenarios.
- Combine TLS with tokenization and backend validation to reduce surface area.

Operational considerations
- Monitor TLS telemetry and expiry to avoid outages.
- Avoid storing TLS credentials in-app — rotate server-side where possible.

Takeaway
Use TLS correctly and adopt additional protections judiciously, balancing security and operational risk.''',
        hasImage: false,
      ),
      AppLesson(
        title: '[Section 4: App Hardening] Obfuscation, tamper detection and runtime checks',
        body: '''
Introduction
While obfuscation and tamper-detection do not replace secure design, they raise the bar for opportunistic attackers and are part of layered defenses.

Obfuscation
- Use code obfuscation tools to make static analysis harder (Dart obfuscation for Flutter release builds).
- Understand obfuscation is not foolproof — persistent attackers can reverse-engineer native binaries.

Tamper detection and integrity
- Detect if binaries are modified or if the app is running on a compromised device (jailbreak/root detection) and limit functionality accordingly.
- Be careful: false positives can degrade legitimate user experience. Use soft-fail approaches with telemetry.

Secrets and native code
- Avoid embedding secrets in app resources.
- When native libraries are necessary for secret handling, combine with secure hardware-backed keystore.

Takeaway
Use hardening as a deterrent within a defense-in-depth strategy; prioritize server-side validation and minimal client trust assumptions.''',
        hasImage: false,
      ),
      AppLesson(
        title: '[Section 5: Privacy & Compliance] Data minimization and user consent',
        body: '''
Introduction
Mobile apps often touch sensitive personal data. Respect privacy by design and comply with applicable laws and platform policies.

Principles
- Data minimization: collect only necessary data.
- Transparent consent: explain why data is collected and provide opt-outs where appropriate.
- Anonymize or pseudonymize data where possible before sending to telemetry backends.

Regulatory considerations
- Be aware of GDPR, CCPA and region-specific requirements — store data residency and deletion workflows accordingly.

Takeaway
Design for privacy: minimal collection, clear consent, and mechanisms for data deletion and portability.''',
        hasImage: false,
      ),
      AppLesson(
        title: '[Section 6: Incident Response] Monitoring, key rotation and forced logout',
        body: '''
Introduction
Security incidents happen; a prepared incident response plan mitigates impact and speeds recovery.

Operational playbook
- Maintain a security runbook including emergency key rotation, forced logout patterns, and user notification templates.
- Use telemetry to detect anomalous activity (sudden token misuse or mass errors) and trigger containment.

Key rotation & revocation
- Implement server-side token revocation and ephemeral keys.
- Plan coordinated key updates to avoid service disruption.

User communication
- Provide clear instructions and support channels if compromised accounts are detected.

Takeaway
Plan for incidents: telemetry, revocation and communication are essential parts of a secure mobile product lifecycle.''',
        hasImage: false,
      ),
    ],
  ),

  // ---------------------------------------------------------------------------
  // Course 10 — Advanced Mobile Development
  // ---------------------------------------------------------------------------
  AppCourse(
    id: 'advanced_mobile_development',
    title: 'Advanced Mobile Development',
    description:
        'Advanced topics for production apps: performance profiling, background processing, notifications, media, platform channels, and integrating native APIs responsibly.',
    instructor: 'Connect Baba',
    category: 'mobile development',
    difficulty: 'Advanced',
    icon: Icons.build,
    color: Colors.red,
    duration: '11h',
    lessons: [
      AppLesson(
        title: '[Section 1: Performance] Profiling, traces and reducing jank',
        body: '''
Introduction
Performance is a first-class concern on mobile. Users notice jank and slow startup times; both reduce retention. Learn to measure and optimize.

Tools and metrics
- Use Flutter DevTools for frame analysis, CPU and memory profiling.
- Measure startup time separately (cold start vs warm start) and optimize heavy initialization.

Optimization strategies
- Defer non-critical initialization (lazy load, initialize on demand).
- Avoid synchronous asset loading on startup; pre-warm caches in background tasks.
- Reduce rebuilds by scoping state and using const widgets.

Memory management
- Watch for large image allocations and use appropriate image caching and decoding strategies.
- Dispose controllers and subscriptions to avoid leaks.

Takeaway
Measure before optimizing; target high-impact slow paths like startup and critical interactions first.''',
        hasImage: false,
      ),
      AppLesson(
        title: '[Section 2: Background Work] Headless tasks, job scheduling and battery tradeoffs',
        body: '''
Introduction
Background processing needs to respect battery and platform policies. Use platform-provided job scheduling for regular or deferred work.

Patterns
- Use WorkManager/BackgroundFetch (Android) and BGAppRefreshTask/BackgroundTasks (iOS) for scheduled background work.
- For Flutter, delegate scheduling to platform code or use plugins that provide acceptable abstractions for background work.

Constraints
- Background windows are limited and subject to OS policies. Keep tasks short and idempotent.
- Use exponential retry and backoff when network is unavailable.

Security and privacy
- Only run background tasks for necessary operations and respect user settings for background data usage.

Takeaway
Design background tasks to be short, idempotent and respectful of battery and privacy constraints.''',
        hasImage: false,
      ),
      AppLesson(
        title: '[Section 3: Notifications] Push, local and in-app messages',
        body: '''
Introduction
Notifications re-engage users. Design messages that are relevant, actionable and respectful of frequency.

Push notifications
- Integrate with FCM (Android) and APNs (iOS) using a backend that controls message routing.
- Use data messages for silent background processing when appropriate; ensure payload sizes are reasonable.

Local notifications
- Use local scheduling for user-initiated reminders and contextual messages.

User experience
- Provide granular notification controls and clear opt-ins.
- Use deep links to take users into meaningful parts of the app when tapping notifications.

Security
- Avoid sending sensitive data in notification payloads since they might appear on lock screens.

Takeaway
Use notifications judiciously and provide tools to control frequency and personalization.''',
        hasImage: false,
      ),
      AppLesson(
        title: '[Section 4: Media & Camera] Handling photo, video and audio',
        body: '''
Introduction
Media handling introduces large data, device variability and performance concerns. Use the right APIs and formats for efficient storage and playback.

Camera and capture
- Use platform camera APIs for best performance; handle orientation and permissions carefully.
- Provide lower-resolution capture options when full resolution is unnecessary.

Encoding & streaming
- Use hardware acceleration for encoding where available.
- Stream large media via chunked/resumable uploads; avoid loading entire files into memory.

Playback
- Use optimized players and native codecs for smooth playback.
- Handle interruptions (incoming calls) gracefully with proper life-cycle handling.

Takeaway
Media features must be designed to conserve memory and network while delivering a dependable user experience.''',
        hasImage: false,
      ),
      AppLesson(
        title: '[Section 5: Location & Sensors] Privacy and power-aware usage',
        body: '''
Introduction
Location and sensors enable compelling experiences but have strong privacy and battery implications.

Accuracy vs battery
- Use the lowest-precision provider that fits the feature (coarse vs fine location).
- Batch location updates and use significant-change APIs when possible.

Permissions & consent
- Ask for permissions in context and explain the value to the user.
- Respect platform guidelines: access only while app is in use if background access is not required.

Security & data retention
- Avoid storing precise historical location unnecessarily; anonymize or aggregate where possible.

Takeaway
Use sensors responsibly: prioritize privacy, explain reasons and reduce battery usage through batching and low-power APIs.''',
        hasImage: false,
      ),
      AppLesson(
        title: '[Section 6: Platform Integration] Platform channels and native code boundaries',
        body: '''
Introduction
Sometimes you need platform APIs not available in Flutter. Platform channels allow invoking native code, but add complexity.

Channel design
- Keep platform channel APIs small and focused.
- Define clear message contracts (types, expected responses).
- Handle platform errors gracefully and translate them into meaningful client error types.

Testing and maintenance
- Test platform code on actual devices and across OS versions.
- Protect platform channels from breaking changes by versioning the channel contract.

When to write native code
- Only when necessary: performance-critical native SDKs, platform-specific features or integrations unavailable via plugins.

Takeaway
Use platform channels judiciously and encapsulate native code to limit surface area and maintenance burden.''',
        hasImage: false,
      ),
    ],
  ),

  // ---------------------------------------------------------------------------
  // Course 11 — Mobile Application Testing & Deployment
  // ---------------------------------------------------------------------------
  AppCourse(
    id: 'mobile_testing_deployment',
    title: 'Mobile Application Testing & Deployment',
    description:
        'Testing disciplines and release engineering for mobile: unit/widget/integration testing, CI/CD pipelines, signing, packaging, app store distribution and monitoring in production.',
    instructor: 'Connect Baba',
    category: 'mobile development',
    difficulty: 'Advanced',
    icon: Icons.verified,
    color: Colors.green,
    duration: '10h',
    lessons: [
      AppLesson(
        title: '[Section 1: Testing Philosophy] Pyramid, scope and tradeoffs',
        body: '''
Introduction
Testing ensures reliability and reduces regressions. The testing pyramid balances many fast unit tests at the base with fewer slower integration/end-to-end tests at the top.

Pyramid layers
- Unit tests: fast, isolated and cheap; test business logic.
- Widget tests: test widget composition and interactions with mocks.
- Integration/E2E tests: test actual app flows on devices/emulators.

Tradeoffs
- E2E tests are brittle and slow; reserve for critical flows.
- Use test doubles, dependency injection and abstractions to enable testing without complex environment setup.

Takeaway
Adopt a balanced testing strategy: many unit tests, thoughtful widget tests, and selective integration tests for critical flows.''',
        hasImage: false,
      ),
      AppLesson(
        title: '[Section 2: Unit & Widget Testing] Isolating logic and deterministic UIs',
        body: '''
Introduction
Unit tests verify logic correctness; widget tests validate rendering and specific UI behaviour without launching full apps.

Unit testing
- Test pure functions and view models with mocked repositories.
- Use parameterized tests for comprehensive coverage.

Widget testing
- Use WidgetTester to pump widgets and assert rendered output and interactions.
- Mock network/data layers to keep tests deterministic.

Best practices
- Keep tests fast: avoid real network or database calls.
- Use continuous integration to run tests on each commit.

Takeaway
Design code with testability in mind—dependency injection and small, pure units are test-friendly.''',
        hasImage: false,
      ),
      AppLesson(
        title: '[Section 3: Integration & E2E] Real-device and harness tests',
        body: '''
Introduction
Integration tests run the app end-to-end and validate flows across multiple components. They are valuable for confidence in releases but require careful maintenance.

Tools & patterns
- Use integration_test for Flutter or platform-specific tooling.
- Prepare deterministic test data and cleanup routines.
- Use device farms or cloud device providers for coverage across hardware.

Stability strategies
- Keep tests focused on high-impact flows (login, purchase, onboarding).
- Avoid fragile UI selectors; prefer semantic identifiers or accessibility labels.

Takeaway
Maintain a small suite of robust E2E tests to validate critical user journeys while relying on unit/widget tests for broader coverage.''',
        hasImage: false,
      ),
      AppLesson(
        title: '[Section 4: CI/CD] Build automation, distribution and release gating',
        body: '''
Introduction
Automating build, test and release pipelines reduces human error and speeds iteration. Build pipelines should be reproducible and auditable.

Pipeline components
- Build: compile and produce artifacts (APK, AAB, IPA).
- Test: run unit/widget/integration tests in pipeline.
- Sign: apply signing configs securely (use secrets management).
- Distribute: push to beta channels (internal testing, TestFlight) and promote to stores.

Gating and policies
- Enforce quality gates: linting results, test coverage thresholds and static analysis.
- Use staged rollouts for production deployment to mitigate risk.

Secrets and security
- Store signing keys and store credentials in secure vaults or CI provider secret stores.
- Rotate credentials periodically and audit access.

Takeaway
Automate builds and tests, gate releases with policy checks and use staged rollouts for safer production deployments.''',
        hasImage: false,
      ),
      AppLesson(
        title: '[Section 5: Signing & Packaging] Android & iOS release mechanics',
        body: '''
Introduction
Signing is necessary for platform integrity and update continuity. Packaging considerations differ between platforms.

Android
- Use app bundles (AAB) where possible; Play Store generates optimized APKs per device.
- Manage keystore securely and never commit it to source. Use signing configs in CI.

iOS
- Manage certificates, provisioning profiles and entitlements via Xcode or automated tooling.
- Understand App Store Connect metadata and required review screenshots.

Versioning
- Adopt semantic versioning and increment build numbers reliably from CI.

Takeaway
Plan signing & packaging workflows early and automate them within CI to avoid last-minute release blocking issues.''',
        hasImage: false,
      ),
      AppLesson(
        title: '[Section 6: Monitoring & Post-Release] Crash reporting and observability',
        body: '''
Introduction
Post-release monitoring is essential for stability and iteration. Crashes, ANR (Application Not Responding) and performance regressions must be detected quickly.

Telemetry and crash reporting
- Integrate crash reporting (Crashlytics, Sentry) to gather stack traces and user context.
- Capture breadcrumbs and logs that help triage issues without exposing sensitive data.

Performance monitoring
- Monitor startup times, frame rates and memory growth in production.
- Use feature flags and performance budgets to detect regressions early.

Feedback loops
- Create automated alerts for significant regressions and dashboards for tracking metrics over time.

Takeaway
Treat monitoring as part of the product; use telemetry to prioritize fixes and guide investments.''',
        hasImage: false,
      ),
    ],
  ),

  // ---------------------------------------------------------------------------
  // Course 12 — Professional Mobile App Development
  // ---------------------------------------------------------------------------
  AppCourse(
    id: 'professional_mobile_development',
    title: 'Professional Mobile App Development',
    description:
        'Practices and organization for production mobile teams: modular codebases, CI/CD, observability, versioning, security reviews, release management, and career patterns for mobile engineers.',
    instructor: 'Connect Baba',
    category: 'mobile development',
    difficulty: 'Professional',
    icon: Icons.workspace_premium,
    color: Colors.blueAccent,
    duration: '12h',
    lessons: [
      AppLesson(
        title: '[Section 1: Production Architecture] Scalability, modularization and multi-team development',
        body: '''
Introduction
Large-scale apps require deliberate structuring to enable multiple teams to work concurrently without stepping on each other’s code.

Modularization strategies
- Split the codebase into feature packages: each package encapsulates its models, UI and tests.
- Enforce boundaries through package-level APIs and avoid leakage of internal implementations.

Release boundaries
- Use semantic versioning for internal packages and publish them to an internal package registry if necessary.
- Implement compatibility contracts (deprecation windows) to avoid breaking dependents.

Organization and ownership
- Align feature modules with product teams to minimize cross-team dependencies.
- Use code owners and PR approvals to maintain quality on critical modules.

Takeaway
Partition the codebase by feature and establish clear ownership and release practices for scalability and team velocity.''',
        hasImage: false,
      ),
      AppLesson(
        title: '[Section 2: Code Quality] Reviews, linting and maintainability',
        body: '''
Introduction
Sustained code quality is essential for long-lived products. Processes and tooling enforce quality while enabling quick iteration.

Code reviews
- Standardize PR templates and required reviewers.
- Focus reviews on architecture, tests and user-impacting changes, not micro-style issues.

Static analysis and linting
- Use analyzer and linter rules to enforce style and catch common mistakes early.
- Automate lint checks in CI and provide clear remediation paths.

Testing culture
- Prioritize meaningful tests (core logic) and ensure new features include adequate coverage.

Takeaway
Establish processes and tooling to scale quality across teams and reduce regressions.''',
        hasImage: false,
      ),
      AppLesson(
        title: '[Section 3: Dependency Management] Packages, versioning and transitive updates',
        body: '''
Introduction
Dependencies must be managed to avoid surprising breakages. Use pinning, CI audits and update windows to keep ecosystems healthy.

Versioning policies
- Lock direct dependencies to a compatible range and frequently update within scheduled dependency maintenance windows.
- Use automated security scans to detect vulnerable packages.

Transitive dependency control
- Monitor transitive changes introduced by upgrades and use dependency overrides with caution.
- Test thoroughly after upgrades and consider dependency compatibility tests in CI.

Takeaway
Be proactive with dependency updates and use automation to surface issues early while keeping the app secure and up-to-date.''',
        hasImage: false,
      ),
      AppLesson(
        title: '[Section 4: CI/CD at Scale] Multi-track pipelines and release automation',
        body: '''
Introduction
At scale, CI/CD pipelines must support multiple release tracks, environment configurations and automated promotion processes.

Pipeline features
- Branch-based pipelines: PR checks, staging builds, and production promotion.
- Artifact promotion: build once, promote the artifact through stages to avoid rebuild drift.
- Canary & staged rollouts: controlled exposure for new releases.

Environment management
- Maintain environment-specific configuration securely using secret management services.
- Use consistent build environments to reduce "works-on-my-machine" problems.

Takeaway
Design CI/CD pipelines to be reproducible, auditable and safe for production promotions with staged rollouts and artifact promotion.''',
        hasImage: false,
      ),
      AppLesson(
        title: '[Section 5: Observability & Ops] Logs, metrics, SLOs and incident management',
        body: '''
Introduction
Operational excellence depends on structured observability and clear service-level objectives (SLOs).

Observability components
- Logs: structured and searchable with contextual metadata.
- Metrics: business and system metrics with dashboards for trend analysis.
- Traces: distributed tracing for cross-system performance analysis.

SLOs and alerting
- Define SLOs for latency and error rates and set alert thresholds tuned to reduce noise.
- Create playbooks and runbooks for common incidents.

Post-incident reviews
- Conduct blameless postmortems and drive action items with owners.

Takeaway
Practice observability as a culture: measure, alert and learn from incidents to improve reliability.''',
        hasImage: false,
      ),
      AppLesson(
        title: '[Section 6: Career & Teams] Growth, mentoring and professional practices',
        body: '''
Introduction
Mobile engineers progress through building technical depth and product judgment. Team practices and mentorship accelerate growth.

Career development
- Encourage rotations across features and ownership of end-to-end user flows.
- Invest in codebase orientation and technical onboarding docs.

Mentorship and review
- Pair programming and code reviews are excellent for tacit knowledge transfer.
- Use architectural reviews and tech radar documents to share platform strategy.

Community & ecosystem
- Contribute to Flutter community projects and internal libraries to grow expertise.
- Encourage representation in cross-functional planning to keep engineering aligned with product goals.

Takeaway
Develop both technical mastery and product thinking; foster mentoring and shared ownership to grow sustainable engineering teams.''',
        hasImage: false,
      ),
    ],
  ),
];
