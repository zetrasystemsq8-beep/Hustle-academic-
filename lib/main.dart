import 'package:flutter/material.dart';

void main() {
  runApp(const HustleAcademyApp());
}

// ============================================================
// APP ROOT
// ============================================================
class HustleAcademyApp extends StatelessWidget {
  const HustleAcademyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hustle Academy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFFFF6B00),
        scaffoldBackgroundColor: const Color(0xFFF7F7FA),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.black,
        ),
        fontFamily: 'Roboto',
      ),
      home: const SplashScreen(),
    );
  }
}

// ============================================================
// MODELS
// ============================================================
class AppLesson {
  final String title;
  final String body;
  final String? codeSnippet;
  final bool hasImage;

  AppLesson({
    required this.title,
    required this.body,
    this.codeSnippet,
    this.hasImage = false,
  });
}

class AppCourse {
  final String id;
  final String title;
  final String description;
  final String instructor;
  final String category;
  final String difficulty;
  final IconData icon;
  final Color color;
  final List<AppLesson> lessons;
  final String duration;

  AppCourse({
    required this.id,
    required this.title,
    required this.description,
    required this.instructor,
    required this.category,
    required this.difficulty,
    required this.icon,
    required this.color,
    required this.lessons,
    required this.duration,
  });
}

class AppCategory {
  final String name;
  final IconData icon;
  final Color color;
  AppCategory(this.name, this.icon, this.color);
}

// ============================================================
// DUMMY DATA
// ============================================================
final List<AppCategory> kCategories = [
  AppCategory('Programming', Icons.code, Colors.indigo),
  AppCategory('Web Development', Icons.language, Colors.blue),
  AppCategory('Mobile Development', Icons.phone_android, Colors.teal),
  AppCategory('Artificial Intelligence', Icons.smart_toy, Colors.deepPurple),
  AppCategory('Graphic Design', Icons.brush, Colors.pink),
  AppCategory('Video Editing', Icons.movie, Colors.red),
  AppCategory('Photography', Icons.camera_alt, Colors.brown),
  AppCategory('Story Writing', Icons.edit_note, Colors.orange),
  AppCategory('Copywriting', Icons.menu_book, Colors.amber),
  AppCategory('Digital Marketing', Icons.trending_up, Colors.green),
  AppCategory('Freelancing', Icons.work, Colors.cyan),
  AppCategory('Data Analysis', Icons.bar_chart, Colors.blueGrey),
  AppCategory('Cybersecurity', Icons.security, Colors.deepOrange),
  AppCategory('Public Speaking', Icons.mic, Colors.purple),
  AppCategory('Personal Finance', Icons.attach_money, Colors.lightGreen),
  AppCategory('Entrepreneurship', Icons.rocket_launch, Colors.redAccent),
];

final List<AppCourse> kCourses = [
  AppCourse(
    id: 'c1',
    title: 'Flutter for Beginners',
    description:
        'Learn how to build beautiful cross-platform apps using Flutter and Dart from scratch.',
    instructor: 'Chidi Okafor',
    category: 'Mobile Development',
    difficulty: 'Beginner',
    icon: Icons.phone_android,
    color: Colors.teal,
    duration: '3h 20m',
    lessons: [
      AppLesson(
        title: 'Introduction to Flutter',
        body:
            'Flutter is Google\'s UI toolkit for building natively compiled apps for mobile, web, and desktop from a single codebase.',
        hasImage: true,
      ),
      AppLesson(
        title: 'Widgets 101',
        body:
            'Everything in Flutter is a widget. Widgets describe what their view should look like given their current configuration and state.',
        codeSnippet:
            'Widget build(BuildContext context) {\n  return Text("Hello Hustle Academy");\n}',
      ),
      AppLesson(
        title: 'State Management Basics',
        body:
            'StatefulWidgets allow your UI to rebuild when data changes. We will explore setState and beyond.',
        codeSnippet:
            'setState(() {\n  count++;\n});',
      ),
    ],
  ),
  AppCourse(
    id: 'c2',
    title: 'Python Programming Fundamentals',
    description:
        'Master the basics of Python, one of the most in-demand programming languages in the world.',
    instructor: 'Ada Nwosu',
    category: 'Programming',
    difficulty: 'Beginner',
    icon: Icons.code,
    color: Colors.indigo,
    duration: '4h 10m',
    lessons: [
      AppLesson(
        title: 'Variables & Data Types',
        body:
            'Python variables are containers for storing data values. Python has no command for declaring a variable.',
        codeSnippet: 'name = "Hustler"\nage = 20\nprint(name, age)',
      ),
      AppLesson(
        title: 'Loops & Conditionals',
        body:
            'Loops let you execute a block of code repeatedly, while conditionals let your program make decisions.',
        codeSnippet: 'for i in range(5):\n    print(i)',
      ),
      AppLesson(
        title: 'Functions',
        body:
            'Functions are reusable blocks of code that perform a specific task and help keep your programs organized.',
        codeSnippet: 'def greet(name):\n    return f"Hello {name}"',
      ),
    ],
  ),
  AppCourse(
    id: 'c3',
    title: 'AI & Machine Learning Basics',
    description:
        'Understand the core concepts behind Artificial Intelligence and Machine Learning.',
    instructor: 'Tunde Bakare',
    category: 'Artificial Intelligence',
    difficulty: 'Intermediate',
    icon: Icons.smart_toy,
    color: Colors.deepPurple,
    duration: '5h 45m',
    lessons: [
      AppLesson(
        title: 'What is Machine Learning?',
        body:
            'Machine Learning is a subset of AI where systems learn patterns from data instead of being explicitly programmed.',
        hasImage: true,
      ),
      AppLesson(
        title: 'Types of ML',
        body:
            'Supervised, unsupervised, and reinforcement learning are the three broad categories of machine learning.',
      ),
      AppLesson(
        title: 'Your First Model',
        body:
            'We will conceptually walk through training a simple classifier on labeled data.',
        codeSnippet: 'model.fit(X_train, y_train)',
      ),
    ],
  ),
  AppCourse(
    id: 'c4',
    title: 'Graphic Design with Canva',
    description:
        'Create stunning visuals for social media, branding, and marketing using simple design tools.',
    instructor: 'Ngozi Eze',
    category: 'Graphic Design',
    difficulty: 'Beginner',
    icon: Icons.brush,
    color: Colors.pink,
    duration: '2h 30m',
    lessons: [
      AppLesson(
        title: 'Design Principles',
        body:
            'Contrast, alignment, repetition, and proximity are the four foundational principles of good design.',
        hasImage: true,
      ),
      AppLesson(
        title: 'Color Theory',
        body:
            'Colors evoke emotion. Understanding color harmony helps you design visuals that resonate with your audience.',
        hasImage: true,
      ),
    ],
  ),
  AppCourse(
    id: 'c5',
    title: 'Digital Marketing Mastery',
    description:
        'Learn SEO, social media marketing, and paid ads to grow any brand online.',
    instructor: 'Femi Adeyemi',
    category: 'Digital Marketing',
    difficulty: 'Intermediate',
    icon: Icons.trending_up,
    color: Colors.green,
    duration: '3h 50m',
    lessons: [
      AppLesson(
        title: 'Intro to SEO',
        body:
            'Search Engine Optimization helps your content rank higher on Google, driving organic traffic.',
      ),
      AppLesson(
        title: 'Social Media Strategy',
        body:
            'A good content calendar and consistent posting builds trust and audience loyalty over time.',
      ),
    ],
  ),
  AppCourse(
    id: 'c6',
    title: 'Freelancing 101',
    description:
        'Learn how to find clients, price your services, and build a sustainable freelance career.',
    instructor: 'Ijeoma Chukwu',
    category: 'Freelancing',
    difficulty: 'Beginner',
    icon: Icons.work,
    color: Colors.cyan,
    duration: '2h 15m',
    lessons: [
      AppLesson(
        title: 'Finding Your First Client',
        body:
            'Platforms like Upwork, Fiverr, and local networking are great starting points for new freelancers.',
      ),
      AppLesson(
        title: 'Pricing Your Work',
        body:
            'Price based on value delivered, not just hours spent — this is key to sustainable freelancing.',
      ),
    ],
  ),
];

// ============================================================
// LOCAL PROGRESS TRACKER (no backend, in-memory for v1)
// ============================================================
class UserProgress {
  static final UserProgress _instance = UserProgress._internal();
  factory UserProgress() => _instance;
  UserProgress._internal();

  final Set<String> startedCourseIds = {};
  final Set<String> completedCourseIds = {};
  final Set<String> certificatesUnlocked = {};
  final Map<String, Set<int>> completedLessons = {};
  int streak = 1;

  void startCourse(String courseId) {
    startedCourseIds.add(courseId);
  }

  void completeLesson(String courseId, int lessonIndex, int totalLessons) {
    completedLessons.putIfAbsent(courseId, () => {});
    completedLessons[courseId]!.add(lessonIndex);
    if (completedLessons[courseId]!.length >= totalLessons) {
      completedCourseIds.add(courseId);
      certificatesUnlocked.add(courseId);
    }
  }

  bool isCourseCompleted(String courseId) =>
      completedCourseIds.contains(courseId);

  int lessonsDoneFor(String courseId) =>
      completedLessons[courseId]?.length ?? 0;
}

final progress = UserProgress();

// ============================================================
// SPLASH SCREEN
// ============================================================
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const MainScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFF6B00),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
              ),
              child: const Icon(Icons.rocket_launch,
                  size: 60, color: Color(0xFFFF6B00)),
            ),
            const SizedBox(height: 20),
            const Text(
              'Hustle Academy',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Learn. Create. Succeed.',
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// MAIN SCREEN WITH BOTTOM NAVIGATION
// ============================================================
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _index = 0;

  final List<Widget> _tabs = const [
    HomeTab(),
    CoursesTab(),
    SearchTab(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _tabs[_index]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.menu_book_outlined), selectedIcon: Icon(Icons.menu_book), label: 'Courses'),
          NavigationDestination(icon: Icon(Icons.search), selectedIcon: Icon(Icons.search), label: 'Search'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

// ============================================================
// HOME TAB
// ============================================================
class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final featured = kCourses.take(4).toList();
    final popular = kCourses.reversed.take(4).toList();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFFF6B00), Color(0xFFFF9248)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Welcome to Hustle Academy 👋',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 6),
              Text('Learn. Create. Succeed.',
                  style: TextStyle(color: Colors.white70, fontSize: 14)),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _SearchBarStatic(),
        const SizedBox(height: 24),
        _SectionTitle('Categories'),
        const SizedBox(height: 12),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: kCategories.length,
            itemBuilder: (context, i) => _CategoryCard(category: kCategories[i]),
          ),
        ),
        const SizedBox(height: 24),
        _SectionTitle('🔥 Featured Courses'),
        const SizedBox(height: 12),
        SizedBox(
          height: 210,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: featured.length,
            itemBuilder: (context, i) => _CourseCard(course: featured[i]),
          ),
        ),
        const SizedBox(height: 24),
        _SectionTitle('⭐ Popular This Week'),
        const SizedBox(height: 12),
        ...popular.map((c) => _CourseListTile(course: c)),
      ],
    );
  }
}

class _SearchBarStatic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final state = context.findAncestorStateOfType<_MainScreenState>();
        state?.setState(() => state._index = 2);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8)
          ],
        ),
        child: const Row(
          children: [
            Icon(Icons.search, color: Colors.grey),
            SizedBox(width: 10),
            Text('What do you want to learn today?',
                style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);
  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
  }
}

class _CategoryCard extends StatelessWidget {
  final AppCategory category;
  const _CategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CategoryCoursesScreen(category: category),
          ),
        );
      },
      child: Container(
        width: 90,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: category.color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(category.icon, color: category.color, size: 28),
            const SizedBox(height: 8),
            Text(
              category.name,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: category.color),
            ),
          ],
        ),
      ),
    );
  }
}

class _CourseCard extends StatelessWidget {
  final AppCourse course;
  const _CourseCard({required this.course});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => CourseScreen(course: course)));
      },
      child: Container(
        width: 170,
        margin: const EdgeInsets.only(right: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10)
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: course.color.withOpacity(0.15),
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Icon(course.icon, size: 40, color: course.color),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(course.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 13)),
                  const SizedBox(height: 6),
                  Text('${course.difficulty} · ${course.lessons.length} lessons',
                      style: const TextStyle(fontSize: 11, color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CourseListTile extends StatelessWidget {
  final AppCourse course;
  const _CourseListTile({required this.course});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        leading: CircleAvatar(
          backgroundColor: course.color.withOpacity(0.15),
          child: Icon(course.icon, color: course.color),
        ),
        title: Text(course.title,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('${course.category} · ${course.difficulty}'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => CourseScreen(course: course))),
      ),
    );
  }
}

// ============================================================
// COURSES TAB (Categories grid + full list)
// ============================================================
class CoursesTab extends StatefulWidget {
  const CoursesTab({super.key});
  @override
  State<CoursesTab> createState() => _CoursesTabState();
}

class _CoursesTabState extends State<CoursesTab> {
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    final filtered = selectedCategory == null
        ? kCourses
        : kCourses.where((c) => c.category == selectedCategory).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            children: [
              const Text('All Categories',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const Spacer(),
              if (selectedCategory != null)
                TextButton(
                  onPressed: () => setState(() => selectedCategory = null),
                  child: const Text('Clear filter'),
                ),
            ],
          ),
        ),
        SizedBox(
          height: 100,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: kCategories.length,
            itemBuilder: (context, i) {
              final cat = kCategories[i];
              final isSelected = selectedCategory == cat.name;
              return GestureDetector(
                onTap: () => setState(() =>
                    selectedCategory = isSelected ? null : cat.name),
                child: Container(
                  width: 90,
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isSelected ? cat.color : cat.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(cat.icon,
                          color: isSelected ? Colors.white : cat.color,
                          size: 26),
                      const SizedBox(height: 6),
                      Text(cat.name,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: isSelected ? Colors.white : cat.color)),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: filtered.length,
            itemBuilder: (context, i) => _CourseListTile(course: filtered[i]),
          ),
        ),
      ],
    );
  }
}

class CategoryCoursesScreen extends StatelessWidget {
  final AppCategory category;
  const CategoryCoursesScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final courses =
        kCourses.where((c) => c.category == category.name).toList();
    return Scaffold(
      appBar: AppBar(title: Text(category.name)),
      body: courses.isEmpty
          ? const Center(child: Text('No courses yet in this category.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: courses.length,
              itemBuilder: (context, i) => _CourseListTile(course: courses[i]),
            ),
    );
  }
}

// ============================================================
// SEARCH TAB
// ============================================================
class SearchTab extends StatefulWidget {
  const SearchTab({super.key});
  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    final results = query.isEmpty
        ? <AppCourse>[]
        : kCourses.where((c) {
            final q = query.toLowerCase();
            return c.title.toLowerCase().contains(q) ||
                c.category.toLowerCase().contains(q) ||
                c.difficulty.toLowerCase().contains(q);
          }).toList();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Search', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          TextField(
            onChanged: (v) => setState(() => query = v),
            decoration: InputDecoration(
              hintText: 'Search by course, skill or category',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: query.isEmpty
                ? const Center(
                    child: Text('Start typing to search courses...',
                        style: TextStyle(color: Colors.grey)))
                : results.isEmpty
                    ? const Center(child: Text('No results found.'))
                    : ListView.builder(
                        itemCount: results.length,
                        itemBuilder: (context, i) =>
                            _CourseListTile(course: results[i]),
                      ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// PROFILE TAB (Offline / Local Stats)
// ============================================================
class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});
  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 32,
                backgroundColor: Color(0xFFFF6B00),
                child: Icon(Icons.person, color: Colors.white, size: 32),
              ),
              const SizedBox(width: 14),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hustler', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text('Local Profile · Offline', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              _StatBox(label: 'Started', value: '${progress.startedCourseIds.length}'),
              const SizedBox(width: 12),
              _StatBox(label: 'Completed', value: '${progress.completedCourseIds.length}'),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _StatBox(label: 'Streak (days)', value: '${progress.streak}'),
              const SizedBox(width: 12),
              _StatBox(label: 'Certificates', value: '${progress.certificatesUnlocked.length}'),
            ],
          ),
          const SizedBox(height: 24),
          const Text('Your Certificates', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Expanded(
            child: progress.certificatesUnlocked.isEmpty
                ? const Center(child: Text('No certificates unlocked yet.', style: TextStyle(color: Colors.grey)))
                : ListView(
                    children: progress.certificatesUnlocked.map((id) {
                      final course = kCourses.firstWhere((c) => c.id == id);
                      return ListTile(
                        leading: const Icon(Icons.workspace_premium, color: Colors.amber),
                        title: Text(course.title),
                        subtitle: const Text('Certificate unlocked'),
                      );
                    }).toList(),
                  ),
          ),
        ],
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String label;
  final String value;
  const _StatBox({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFFFF6B00))),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// COURSE SCREEN
// ============================================================
class CourseScreen extends StatefulWidget {
  final AppCourse course;
  const CourseScreen({super.key, required this.course});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  @override
  Widget build(BuildContext context) {
    final course = widget.course;
    final done = progress.lessonsDoneFor(course.id);

    return Scaffold(
      appBar: AppBar(title: Text(course.title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            height: 160,
            decoration: BoxDecoration(
              color: course.color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(course.icon, size: 60, color: course.color),
          ),
          const SizedBox(height: 16),
          Text(course.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(course.description, style: const TextStyle(color: Colors.black87, height: 1.4)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _InfoChip(icon: Icons.person, label: course.instructor),
              _InfoChip(icon: Icons.menu_book, label: '${course.lessons.length} lessons'),
              _InfoChip(icon: Icons.timer, label: course.duration),
              _InfoChip(icon: Icons.bar_chart, label: course.difficulty),
            ],
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: course.lessons.isEmpty ? 0 : done / course.lessons.length,
            backgroundColor: Colors.grey.shade200,
            color: course.color,
            minHeight: 8,
            borderRadius: BorderRadius.circular(10),
          ),
          const SizedBox(height: 6),
          Text('$done / ${course.lessons.length} lessons completed',
              style: const TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: const Color(0xFFFF6B00),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              onPressed: () {
                progress.startCourse(course.id);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => LessonScreen(course: course, lessonIndex: 0),
                  ),
                );
              },
              child: const Text('Start Learning', style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => CertificateScreen(course: course)),
                );
              },
              child: const Text('View Certificate'),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.grey.shade700),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

// ============================================================
// LESSON SCREEN
// ============================================================
class LessonScreen extends StatefulWidget {
  final AppCourse course;
  final int lessonIndex;
  const LessonScreen({super.key, required this.course, required this.lessonIndex});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  @override
  Widget build(BuildContext context) {
    final course = widget.course;
    final index = widget.lessonIndex;
    final lesson = course.lessons[index];
    final isLast = index == course.lessons.length - 1;

    return Scaffold(
      appBar: AppBar(title: Text('Lesson ${index + 1}/${course.lessons.length}')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(lesson.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          if (lesson.hasImage)
            Container(
              height: 160,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Center(
                child: Icon(Icons.image, size: 48, color: Colors.grey),
              ),
            ),
          Text(lesson.body, style: const TextStyle(fontSize: 15, height: 1.5)),
          if (lesson.codeSnippet != null) ...[
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E2C),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                lesson.codeSnippet!,
                style: const TextStyle(
                  color: Color(0xFF9CDCFE),
                  fontFamily: 'monospace',
                  fontSize: 13,
                ),
              ),
            ),
          ],
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: const Color(0xFFFF6B00),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              onPressed: () {
                progress.completeLesson(course.id, index, course.lessons.length);
                if (isLast) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => CertificateScreen(course: course)),
                  );
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => LessonScreen(course: course, lessonIndex: index + 1),
                    ),
                  );
                }
              },
              child: Text(isLast ? 'Finish Course' : 'Next Lesson',
                  style: const TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// CERTIFICATE SCREEN
// ============================================================
class CertificateScreen extends StatelessWidget {
  final AppCourse course;
  const CertificateScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final unlocked = progress.isCourseCompleted(course.id);

    return Scaffold(
      appBar: AppBar(title: const Text('Certificate')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                unlocked ? Icons.workspace_premium : Icons.lock_outline,
                size: 80,
                color: unlocked ? Colors.amber : Colors.grey,
              ),
              const SizedBox(height: 20),
              Text(
                unlocked ? 'Certificate Unlocked!' : 'Certificate Locked',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                unlocked
                    ? 'Congratulations on completing "${course.title}". Certificate generation is coming in a future version.'
                    : 'Complete all lessons and quizzes to unlock your certificate.',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
