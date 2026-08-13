// ============================================================
// MOBILE DEVELOPMENT COURSES (Integrated)
// lib/courses/mobile_development_courses.dart
// Author: generated to match Hustle Academy course schema
// Instructor: Connect Baba
// ============================================================

import 'package:flutter/material.dart';
import '../models/app_course.dart';

// Mobile Development courses (knowledge-only). Labs live in the Mobile Lab.
final List<AppCourse> mobileDevelopmentCourses = [
  // Course 1
  AppCourse(
    id: 'mobile_dev_fundamentals',
    title: 'Mobile Development Fundamentals',
    description:
        'Foundations of mobile software: platforms, architecture, lifecycles, UI/UX basics and how mobile systems fit together. This course focuses on concepts and professional practices.',
    instructor: 'Connect Baba',
    category: 'mobile development',
    difficulty: 'Beginner',
    icon: Icons.smartphone,
    color: Colors.teal,
    duration: '3h',
    lessons: [
      AppLesson(
        title: 'Introduction to Mobile Development',
        body:
            'What mobile development is, historical context, and the role of mobile apps in modern software ecosystems. We discuss the goals of mobile experiences and high-level tradeoffs developers face.',
        hasImage: false,
      ),
      AppLesson(
        title: 'How Mobile Applications Work',
        body:
            'An overview of the platform stack: kernel, runtime (ART/Dart VM), platform SDKs, and app process lifecycle. Explain app startup, foreground/background, and lifecycle callbacks in general terms.',
        hasImage: false,
      ),
      AppLesson(
        title: 'Mobile Platforms and Operating Systems',
        body:
            'Compare Android and iOS: market differences, OS services, release cadence, and platform constraints. Mention alternative platforms and where cross-platform tooling fits.',
        hasImage: false,
      ),
      AppLesson(
        title: 'Native vs Cross-Platform Development',
        body:
            'Explain native toolchains (Kotlin/Swift) vs cross-platform frameworks (Flutter, React Native). Discuss benefits, limitations, integration points, and real-world criteria for choosing an approach.',
        hasImage: false,
      ),
      AppLesson(
        title: 'Mobile Application Architecture',
        body:
            'Introduce layers (UI, domain, data), common architectural patterns (MVC, MVVM, Clean), and how to reason about separation of concerns and testability.',
        hasImage: false,
      ),
      AppLesson(
        title: 'Development Tools and Environments',
        body:
            'Editors, IDEs (Android Studio, Xcode, VS Code), emulators, device farms, and debugging tools. Explain when to use which tool and how they fit into a professional workflow.',
        hasImage: false,
      ),
      AppLesson(
        title: 'Mobile UI and UX Fundamentals',
        body:
            'Principles of mobile UI design: affordances, touch targets, feedback, accessibility, and responsive layouts. Introduce platform UI conventions and when to follow them.',
        hasImage: false,
      ),
      AppLesson(
        title: 'Mobile Development Lifecycle',
        body:
            'From idea to app store: planning, prototyping, development, testing, release, monitoring, and maintenance. Briefly cover app store review and telemetry needs.',
        hasImage: false,
      ),
      AppLesson(
        title: 'Common Mistakes & Best Practices',
        body:
            'A practical list of frequent pitfalls (main thread work, battery misuse, ignoring permissions) and pragmatic best practices for reliable apps.',
        hasImage: false,
      ),
      AppLesson(
        title: 'Summary and Where to Go Next',
        body:
            'Recap key concepts and point learners to the Dart and Flutter fundamentals courses for next steps. Example: "Toluwani can now decide whether to learn Dart or native SDKs."',
        hasImage: false,
      ),
    ],
  ),

  // Course 2
  AppCourse(
    id: 'dart_programming_for_mobile',
    title: 'Dart Programming for Mobile Development',
    description:
        'A focused introduction to Dart language concepts most relevant to mobile developers using Flutter: types, async, OOP, and error handling.',
    instructor: 'Connect Baba',
    category: 'mobile development',
    difficulty: 'Beginner',
    icon: Icons.code,
    color: Colors.indigo,
    duration: '8h',
    lessons: [
      AppLesson(
        title: 'Introduction to Dart',
        body:
            'Language goals, tooling, the Dart VM vs AOT, and how Dart maps to Flutter. Explain strong typing and null safety at a conceptual level.',
        hasImage: false,
      ),
      AppLesson(
        title: 'Variables and Data Types',
        body:
            'Primitive types, type inference, final vs const, collections (List, Map, Set) and when to use each in mobile apps.',
        hasImage: false,
      ),
      AppLesson(
        title: 'Operators and Expressions',
        body:
            'Operators, expressions, and common idioms used in UI code and state updates. Short-circuiting, cascades, and collection if/for.',
        hasImage: false,
      ),
      AppLesson(
        title: 'Conditions and Control Flow',
        body:
            'Control structures, pattern-matching (when available), and writing readable branching for UI state and business logic.',
        hasImage: false,
      ),
      AppLesson(
        title: 'Loops',
        body:
            'For/while loops and collection iteration. Emphasise functional alternatives (map, where, fold) for clarity and immutability.',
        hasImage: false,
      ),
      AppLesson(
        title: 'Functions',
        body:
            'Top-level, nested, arrow functions, optional/named parameters, and function types used for callbacks in widget trees.',
        hasImage: false,
      ),
      AppLesson(
        title: 'Collections',
        body:
            'Working with Lists, Maps and Sets. Efficient updates, immutability patterns, and serialization concerns when talking to APIs.',
        hasImage: false,
      ),
      AppLesson(
        title: 'Object-Oriented Programming',
        body:
            'Classes, constructors, mixins, interfaces (abstract classes), and common OOP design patterns used in Flutter apps.',
        hasImage: false,
      ),
      AppLesson(
        title: 'Error Handling',
        body:
            'Exceptions, try/catch, safe error propagation, and designing error types for network or persistence layers.',
        hasImage: false,
      ),
      AppLesson(
        title: 'Asynchronous Programming',
        body:
            'Futures, async/await, Streams, and how to reason about concurrency in UI apps to keep interfaces responsive.',
        hasImage: false,
      ),
    ],
  ),

  // Course 3
  AppCourse(
    id: 'flutter_fundamentals',
    title: 'Flutter Fundamentals',
    description:
        'Core Flutter concepts: widgets, rendering model, layout and theming. Geared for learners who will use Flutter as their primary mobile framework.',
    instructor: 'Connect Baba',
    category: 'mobile development',
    difficulty: 'Beginner',
    icon: Icons.flutter_dash,
    color: Colors.blue,
    duration: '10h',
    lessons: [
      AppLesson(
        title: 'Introduction to Flutter',
        body:
            'Philosophy of Flutter, reactive UI model, widget tree vs render tree, hot reload and developer workflow.',
        hasImage: false,
      ),
      AppLesson(
        title: 'Flutter Architecture',
        body:
            'Layers of Flutter: widgets, elements, render objects. How state and rebuilds flow through the tree.',
        hasImage: false,
      ),
      AppLesson(
        title: 'Widgets',
        body:
            'Stateless vs Stateful widgets, composing widgets, and when to extract widgets for clarity and reuse.',
        hasImage: false,
      ),
      AppLesson(
        title: 'Stateless and Stateful Widgets',
        body:
            'Detailed comparison, lifecycle methods, and practical rules for choosing stateful boundaries.',
        hasImage: false,
      ),
      AppLesson(
        title: 'Layout and Constraints',
        body:
            'Constraint-based layout in Flutter: BoxConstraints, Row/Column, Flex, Expanded and common layout patterns.',
        hasImage: false,
      ),
      AppLesson(
        title: 'Text, Images and Icons',
        body:
            'Efficient image usage, vector assets, text styling and localization considerations for production apps.',
        hasImage: false,
      ),
      AppLesson(
        title: 'Buttons, Forms and Input',
        body:
            'Form handling patterns, validation strategies and accessibility considerations for input widgets.',
        hasImage: false,
      ),
      AppLesson(
        title: 'Themes and Styling',
        body:
            'Design tokens, ThemeData, dark/light modes and scaling typography for different screen sizes.',
        hasImage: false,
      ),
      AppLesson(
        title: 'Widget Composition',
        body:
            'Techniques for composing widgets, creating reusable components and avoiding deep inheritance trees.',
        hasImage: false,
      ),
      AppLesson(
        title: 'Flutter Application Structure',
        body:
            'Project layout conventions, organizing features, assets, and tests in a maintainable way for teams.',
        hasImage: false,
      ),
    ],
  ),

  // Course 4
  AppCourse(
    id: 'flutter_ui_development',
    title: 'Flutter UI Development',
    description:
        'Design and implement polished mobile interfaces with Flutter. Focuses on layout systems, accessibility, responsiveness and modern UI patterns.',
    instructor: 'Connect Baba',
    category: 'mobile development',
    difficulty: 'Intermediate',
    icon: Icons.palette,
    color: Colors.purple,
    duration: '9h',
    lessons: [
      AppLesson(
        title: 'Mobile Interface Design Principles',
        body:
            'Principles such as hierarchy, affordance, consistency and feedback. When to follow platform conventions and when to innovate.',
        hasImage: false,
      ),
      AppLesson(
        title: 'Layout Systems in Depth',
        body:
            'In-depth look at layout widgets, composing responsive UIs and strategies for cross-screen consistency.',
        hasImage: false,
      ),
      AppLesson(
        title: 'Rows, Columns and Containers',
        body:
            'Practical rules for using Row/Column, spacing systems, and container composition to build robust layouts.',
        hasImage: false,
      ),
      AppLesson(
        title: 'Lists and Grids',
        body:
            'Efficient scrolling, lazy loading, and when to use ListView, GridView or custom Slivers for performance.',
        hasImage: false,
      ),
      AppLesson(
        title: 'Forms and User Input',
        body:
            'Advanced form patterns: validation strategies, user-friendly error messaging, and progressive disclosure.',
        hasImage: false,
      ),
      AppLesson(
        title: 'Navigation Interfaces',
        body:
            'Designing navigation: bottom tabs, drawers, nested stacks, and patterns for discoverability.',
        hasImage: false,
      ),
      AppLesson(
        title: 'Dialogs, Sheets and Overlays',
        body:
            'Appropriate uses for modal UI, bottom sheets and overlays, and accessibility considerations for focus and navigation.',
        hasImage: false,
      ),
      AppLesson(
        title: 'Responsive Mobile Interfaces',
        body:
            'Techniques for adaptive UIs across phones, tablets and web targets. Breakpoints, fluid layouts and testing strategies.',
        hasImage: false,
      ),
      AppLesson(
        title: 'Accessibility',
        body:
            'Making apps usable for all: semantics, screen reader support, contrast, focus order and test practices.',
        hasImage: false,
      ),
      AppLesson(
        title: 'Modern Flutter UI Patterns',
        body:
            'Pattern library: cards, skeleton loading, shimmer, progressive lists and component libraries for consistent UIs.',
        hasImage: false,
      ),
    ],
  ),

  // Course 5
  AppCourse(
    id: 'mobile_navigation_architecture',
    title: 'Mobile Navigation & Application Architecture',
    description:
        'How to design app navigation and larger architectural concerns for scalable mobile apps: routing, nested navigation and auth flows.',
    instructor: 'Connect Baba',
    category: 'mobile development',
    difficulty: 'Intermediate',
    icon: Icons.swap_horiz,
    color: Colors.orange,
    duration: '7h',
    lessons: [
      AppLesson(title: 'Navigation Fundamentals', body: 'Routing concepts and UX expectations.', hasImage: false),
      AppLesson(title: 'Routes and Navigation Stacks', body: 'Stack-based navigation and back behaviour.', hasImage: false),
      AppLesson(title: 'Passing Data Between Screens', body: 'Best practices for arguments and state propagation.', hasImage: false),
      AppLesson(title: 'Nested Navigation', body: 'When to use nested navigators and how to manage state.', hasImage: false),
      AppLesson(title: 'Deep Linking', body: 'App links, URI schemes and handling incoming intents.', hasImage: false),
      AppLesson(title: 'Authentication-Based Navigation', body: 'Protecting routes and auth gates.', hasImage: false),
      AppLesson(title: 'Application Architecture', body: 'Feature/module boundaries and dependency flows.', hasImage: false),
      AppLesson(title: 'Separation of Concerns', body: 'Keep UI thin: move logic to controllers/services.', hasImage: false),
      AppLesson(title: 'State and UI Architecture', body: 'Aligning state shape to UI needs for predictable updates.', hasImage: false),
      AppLesson(title: 'Scalable Flutter Architecture', body: 'Folder structure, modularization and release-time considerations.', hasImage: false),
    ],
  ),

  // Course 6
  AppCourse(
    id: 'state_management_in_mobile',
    title: 'State Management in Mobile Applications',
    description:
        'Understand state in mobile apps and the tradeoffs between local and shared state plus patterns and tools like Provider, Riverpod and Bloc.',
    instructor: 'Connect Baba',
    category: 'mobile development',
    difficulty: 'Intermediate',
    icon: Icons.layers,
    color: Colors.deepPurple,
    duration: '6h',
    lessons: [
      AppLesson(title: 'Understanding Application State', body: 'What state is and why it matters.', hasImage: false),
      AppLesson(title: 'Local State', body: 'Managing ephemeral widget state effectively.', hasImage: false),
      AppLesson(title: 'Shared State', body: 'Patterns for sharing state across the app.', hasImage: false),
      AppLesson(title: 'Reactive Programming', body: 'Streams, publishers and reactive updates.', hasImage: false),
      AppLesson(title: 'State Management Patterns', body: 'Unidirectional data flow, observable patterns, and event sourcing basics.', hasImage: false),
      AppLesson(title: 'Provider-Based Architecture', body: 'Provider basics and when it fits.', hasImage: false),
      AppLesson(title: 'Riverpod', body: 'Why Riverpod exists and its strengths for testability.', hasImage: false),
      AppLesson(title: 'Managing Async State', body: 'Loading/error states and cancellation.', hasImage: false),
      AppLesson(title: 'Application State Architecture', body: 'Organising state for large apps.', hasImage: false),
      AppLesson(title: 'Scalable State Management', body: 'Tradeoffs when choosing patterns in teams.', hasImage: false),
    ],
  ),

  // Course 7
  AppCourse(
    id: 'mobile_data_storage_databases',
    title: 'Mobile Data, Storage & Databases',
    description:
        'Designing mobile storage: key-value, SQL, object stores, caching and offline-first strategies for mobile applications.',
    instructor: 'Connect Baba',
    category: 'mobile development',
    difficulty: 'Intermediate',
    icon: Icons.storage,
    color: Colors.brown,
    duration: '6h',
    lessons: [
      AppLesson(title: 'Data in Mobile Applications', body: 'Data shapes and constraints for mobile UIs.', hasImage: false),
      AppLesson(title: 'Local Storage', body: 'Key-value stores and secure storage for small data.', hasImage: false),
      AppLesson(title: 'Preferences and Persistent Data', body: 'Preferences vs structured storage and migration patterns.', hasImage: false),
      AppLesson(title: 'Local Databases', body: 'SQL vs document stores and choosing the right tooling.', hasImage: false),
      AppLesson(title: 'Structured Data', body: 'Models, versioning and schema migrations.', hasImage: false),
      AppLesson(title: 'CRUD Operations', body: 'Designing robust create/read/update/delete flows.', hasImage: false),
      AppLesson(title: 'Caching', body: 'Cache strategies to reduce network and improve perceived performance.', hasImage: false),
      AppLesson(title: 'Offline-First Applications', body: 'Conflict resolution and sync strategies.', hasImage: false),
      AppLesson(title: 'Data Synchronization', body: 'Background sync and queueing strategies.', hasImage: false),
      AppLesson(title: 'Mobile Data Architecture', body: 'How to structure repositories, mappers and persistence layers.', hasImage: false),
    ],
  ),

  // Course 8
  AppCourse(
    id: 'apis_backends_for_mobile',
    title: 'APIs & Backend Integration',
    description:
        'How mobile apps communicate with servers: REST, JSON, authentication, pagination, error handling and network resiliency.',
    instructor: 'Connect Baba',
    category: 'mobile development',
    difficulty: 'Intermediate',
    icon: Icons.cloud,
    color: Colors.blueGrey,
    duration: '7h',
    lessons: [
      AppLesson(title: 'Understanding APIs', body: 'API types, contracts and versioning.', hasImage: false),
      AppLesson(title: 'HTTP and HTTPS', body: 'Transport basics, TLS and certificates in mobile context.', hasImage: false),
      AppLesson(title: 'REST APIs', body: 'Principles of REST and practical API design for mobile clients.', hasImage: false),
      AppLesson(title: 'JSON and Data Serialization', body: 'Serializers, codecs and safe parsing.', hasImage: false),
      AppLesson(title: 'GET/POST/PUT/PATCH/DELETE', body: 'When to use each method and idempotency concerns.', hasImage: false),
      AppLesson(title: 'Authentication and Tokens', body: 'Token types, refresh flows and secure storage.', hasImage: false),
      AppLesson(title: 'API Error Handling', body: 'Designing robust client-side error handling and retries.', hasImage: false),
      AppLesson(title: 'Loading and Network States', body: 'UX patterns for loading, placeholders and progressive data.', hasImage: false),
      AppLesson(title: 'Pagination and Remote Data', body: 'Cursor vs offset pagination and caching strategies.', hasImage: false),
      AppLesson(title: 'Mobile-to-Backend Architecture', body: 'Backend considerations for mobile clients and contract testing.', hasImage: false),
    ],
  ),

  // Course 9
  AppCourse(
    id: 'mobile_authentication_security',
    title: 'Mobile Authentication & Security',
    description:
        'Security fundamentals for mobile apps: secure storage, network security, authentication flows and common threats.',
    instructor: 'Connect Baba',
    category: 'mobile development',
    difficulty: 'Advanced',
    icon: Icons.lock,
    color: Colors.deepOrange,
    duration: '6h',
    lessons: [
      AppLesson(title: 'Authentication Fundamentals', body: 'Auth concepts and threat models.', hasImage: false),
      AppLesson(title: 'Registration and Login Systems', body: 'Designing secure sign-up and sign-in flows.', hasImage: false),
      AppLesson(title: 'Sessions and Tokens', body: 'JWT, opaque tokens and refresh strategies.', hasImage: false),
      AppLesson(title: 'Secure Credential Storage', body: 'Keychains, Keystore and secure enclaves.', hasImage: false),
      AppLesson(title: 'Authorization', body: 'Role-based access and scopes.', hasImage: false),
      AppLesson(title: 'Protected Application Areas', body: 'Gatekeeping screens and session expiry handling.', hasImage: false),
      AppLesson(title: 'Mobile Application Security', body: 'Common vulnerabilities and platform-specific mitigations.', hasImage: false),
      AppLesson(title: 'Data Protection', body: 'Encryption at rest, transport and memory handling.', hasImage: false),
      AppLesson(title: 'Secure API Communication', body: 'Certificate pinning, TLS config and mitigations.', hasImage: false),
      AppLesson(title: 'Common Mobile Security Threats', body: 'Reverse engineering, tampering and mitigation techniques.', hasImage: false),
    ],
  ),

  // Course 10
  AppCourse(
    id: 'advanced_mobile_development',
    title: 'Advanced Mobile Development',
    description:
        'Advanced concepts: performance, background tasks, notifications, media and platform integrations that production apps need.',
    instructor: 'Connect Baba',
    category: 'mobile development',
    difficulty: 'Advanced',
    icon: Icons.build,
    color: Colors.red,
    duration: '8h',
    lessons: [
      AppLesson(title: 'Application Performance', body: 'Profiling, jank analysis and rendering budgets.', hasImage: false),
      AppLesson(title: 'Memory Management', body: 'Leaks, retained cycles and object lifetimes.', hasImage: false),
      AppLesson(title: 'Background Processing', body: 'Background fetch, tasks and battery considerations.', hasImage: false),
      AppLesson(title: 'Notifications', body: 'Push vs local notifications and best practices.', hasImage: false),
      AppLesson(title: 'Permissions', body: 'Principles of permission requests and UX.', hasImage: false),
      AppLesson(title: 'Camera and Media', body: 'Working with camera APIs and media pipelines.', hasImage: false),
      AppLesson(title: 'Files and Storage', body: 'Large file handling and streaming approaches.', hasImage: false),
      AppLesson(title: 'Location Services', body: 'Location accuracy, battery and privacy concerns.', hasImage: false),
      AppLesson(title: 'Deep Links and System Integration', body: 'Universal links, intents and platform bridges.', hasImage: false),
      AppLesson(title: 'Advanced Flutter Development', body: 'Custom render objects, platform channels and performance tuning.', hasImage: false),
    ],
  ),

  // Course 11
  AppCourse(
    id: 'mobile_testing_deployment',
    title: 'Mobile Application Testing & Deployment',
    description:
        'Testing strategies and the packaging/release process for Android and iOS including CI/CD, signing and distribution.',
    instructor: 'Connect Baba',
    category: 'mobile development',
    difficulty: 'Advanced',
    icon: Icons.verified,
    color: Colors.green,
    duration: '6h',
    lessons: [
      AppLesson(title: 'Testing Mobile Applications', body: 'Testing strategy and testing pyramid for mobile.', hasImage: false),
      AppLesson(title: 'Unit Testing', body: 'Small fast tests for business logic.', hasImage: false),
      AppLesson(title: 'Widget / UI Testing', body: 'Testing UI contracts and interactions.', hasImage: false),
      AppLesson(title: 'Integration Testing', body: 'End-to-end and smoke tests.', hasImage: false),
      AppLesson(title: 'Debugging', body: 'Remote debugging, logs and symbolication.', hasImage: false),
      AppLesson(title: 'Performance Analysis', body: 'Interpreting traces and optimizing hotspots.', hasImage: false),
      AppLesson(title: 'Build Configurations', body: 'Flavours, build-time flags and environment configs.', hasImage: false),
      AppLesson(title: 'Android Application Packaging', body: 'Signing, ABI splits and Play Store requirements.', hasImage: false),
      AppLesson(title: 'iOS Application Packaging', body: 'Certificates, provisioning and App Store Connect.', hasImage: false),
      AppLesson(title: 'Application Distribution', body: 'Beta distribution, store rollout strategies and monitoring.', hasImage: false),
    ],
  ),

  // Course 12
  AppCourse(
    id: 'professional_mobile_app_development',
    title: 'Professional Mobile App Development',
    description:
        'Skills for working in production teams: architecture at scale, CI/CD, monitoring, and professional practices to ship reliable mobile products.',
    instructor: 'Connect Baba',
    category: 'mobile development',
    difficulty: 'Professional',
    icon: Icons.workspace_premium,
    color: Colors.blueAccent,
    duration: '8h',
    lessons: [
      AppLesson(title: 'Production Mobile Architecture', body: 'Design patterns for reliability and scale.', hasImage: false),
      AppLesson(title: 'Scalable Application Design', body: 'Modularisation, feature flags and progressive delivery.', hasImage: false),
      AppLesson(title: 'Code Quality and Maintainability', body: 'Code reviews, linters and API contracts.', hasImage: false),
      AppLesson(title: 'Dependency Management', body: 'Managing package versions and transitive updates.', hasImage: false),
      AppLesson(title: 'Version Control', body: 'Branching models and release tagging.', hasImage: false),
      AppLesson(title: 'CI/CD for Mobile Applications', body: 'Automating builds, tests and releases.', hasImage: false),
      AppLesson(title: 'Monitoring and Crash Reporting', body: 'Crashlytics, logs and user metrics.', hasImage: false),
      AppLesson(title: 'Application Updates', body: 'In-app updates, feature rollouts and update policies.', hasImage: false),
      AppLesson(title: 'Mobile Development Team Practices', body: 'Working in cross-functional teams and release cadences.', hasImage: false),
      AppLesson(title: 'Becoming a Professional Mobile Developer', body: 'Career advice, portfolio projects (use NaijaLearn/NigerGram examples) and next steps.', hasImage: false),
    ],
  ),
];
