// ============================================================
// MOBILE DEVELOPMENT COURSES
// lib/courses/mobile_development_courses.dart
// ============================================================
// Add this import to main.dart:
// import 'courses/mobile_development_courses.dart';
// Then spread it inside kCourses:
// ...[mobileDevelopmentCourses],
// ============================================================

import 'package:flutter/material.dart';
import '../main.dart';

final List<AppCourse> mobileDevelopmentCourses = [
  // Course 1: Flutter - Beginner
  AppCourse(
    id: 'mobile_development_flutter_101',
    title: 'Flutter: Build Cross-Platform Apps',
    description: 'Master Flutter and Dart to build iOS and Android apps from a single codebase. Covers widgets, state management, navigation, networking, and a complete weather app project.',
    instructor: 'Chidi Okonkwo',
    category: 'mobile development',
    difficulty: 'Beginner',
    icon: Icons.flutter_dash,
    color: Colors.blue,
    duration: '12 hours',
    lessons: [
      AppLesson(
        title: 'Introduction to Flutter and Dart',
        body: 'Flutter is Google\'s UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase. It uses Dart, a language optimised for fast performance and hot reload. In this lesson, you\'ll set up your environment and write your first "Hello World" app.\n\nDart is object-oriented with C-style syntax and supports both JIT and AOT compilation. Flutter leverages Dart\'s reactive framework. You\'ll learn about variables, functions, and control flow. We\'ll also cover the project structure and pubspec.yaml.\n\nRun \'flutter create my_app\' to generate a new project. Open lib/main.dart and modify the default counter app. Use \'flutter run\' to see your changes live. This hands-on start builds confidence from day one.',
        codeSnippet: '''void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Hello Flutter')),
        body: Center(child: Text('Welcome to Hustle Academy!')),
      ),
    );
  }
}''',
        hasImage: true,
      ),
      AppLesson(
        title: 'Widgets: The Building Blocks',
        body: 'Everything in Flutter is a widget. Widgets are immutable descriptions of part of the UI. There are stateless widgets (no internal state) and stateful widgets (can change state). The UI is a tree of widgets; you compose them to build layouts.\n\nLearn common widgets: Container, Row, Column, Stack, ListView, and Card. Understand padding, margin, alignment, and decoration. The widget lifecycle: StatelessWidget builds once; StatefulWidget has a State object that can call setState() to rebuild.\n\nPractice by building a profile card using Column, CircleAvatar, and Card. Experiment with properties like EdgeInsets and BoxDecoration. This exercise solidifies layout principles and prepares you for more complex UIs.',
        codeSnippet: '''class ProfileCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://example.com/avatar.png'),
            ),
            SizedBox(height: 10),
            Text('John Doe', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text('Flutter Developer', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}''',
        hasImage: false,
      ),
      AppLesson(
        title: 'State Management with setState and Provider',
        body: 'State management is how you manage data that changes over time and update the UI accordingly. The simplest approach is setState() in a StatefulWidget, which triggers a rebuild of the widget subtree. For larger apps, you need a more scalable solution.\n\nProvider is the recommended package for state management. It uses InheritedWidget to efficiently propagate data down the widget tree. You\'ll create a ChangeNotifier class and expose it using ChangeNotifierProvider. Then use Consumer or Provider.of to access and listen to changes.\n\nImplement a simple counter app with both setState and Provider to compare. Notice how Provider decouples business logic from UI, making testing and maintenance easier. This foundation is critical for professional Flutter development.',
        codeSnippet: '''// Using Provider
class CounterModel extends ChangeNotifier {
  int _count = 0;
  int get count => _count;
  void increment() {
    _count++;
    notifyListeners();
  }
}

// In main.dart
void main() => runApp(
  ChangeNotifierProvider(
    create: (context) => CounterModel(),
    child: MyApp(),
  ),
);

// In a Consumer widget
Consumer<CounterModel>(
  builder: (context, counter, child) => Text('Count: \${counter.count}'),
)''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Navigation and Routing',
        body: 'Navigation allows users to move between screens. Flutter provides Navigator and Routes. The simplest is Navigator.push and Navigator.pop. You can define named routes in MaterialApp for more structured navigation.\n\nLearn to pass arguments between screens using ModalRoute.of(context).settings.arguments or using a custom Route. Also explore onGenerateRoute for dynamic routing.\n\nBuild a two-screen app: a list of items and a detail screen. Clicking an item navigates to the detail screen with the item\'s data. This pattern is ubiquitous in mobile apps and is a must-know.',
        codeSnippet: '''// Named routes
MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context) => HomeScreen(),
    '/details': (context) => DetailsScreen(),
  },
);

// Navigate and pass arguments
Navigator.pushNamed(
  context,
  '/details',
  arguments: {'id': 42, 'title': 'Item 42'},
);

// In DetailsScreen
final args = ModalRoute.of(context)!.settings.arguments as Map;
String title = args['title'];''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Handling User Input and Forms',
        body: 'Mobile apps heavily rely on user input. Flutter provides Form, TextFormField, and validation. You\'ll use a GlobalKey<FormState> to validate the form and save data. Learn to use TextEditingController to access and modify text fields.\n\nImplement validation for common fields like email, password, and phone number. Show error messages using validator. Also learn to handle focus and keyboard actions.\n\nBuild a login/sign-up screen with email and password fields, including validation and a submit button. This practical skill is used in almost every app you\'ll build.',
        codeSnippet: '''final _formKey = GlobalKey<FormState>();
String email = '', password = '';

Form(
  key: _formKey,
  child: Column(
    children: [
      TextFormField(
        decoration: InputDecoration(labelText: 'Email'),
        validator: (value) {
          if (value == null || value.isEmpty) return 'Enter email';
          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) return 'Invalid email';
          return null;
        },
        onSaved: (value) => email = value!,
      ),
      TextFormField(
        obscureText: true,
        decoration: InputDecoration(labelText: 'Password'),
        validator: (value) => value!.length < 6 ? 'Too short' : null,
        onSaved: (value) => password = value!,
      ),
      ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            // Submit login
          }
        },
        child: Text('Login'),
      ),
    ],
  ),
);''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Networking and JSON Parsing',
        body: 'Most apps communicate with APIs to fetch and send data. Flutter uses the http package for HTTP requests. You\'ll perform GET and POST requests and parse JSON responses using dart:convert.\n\nLearn to model data as Dart classes with fromJson and toJson methods. Use async/await for asynchronous operations. Handle loading and error states gracefully.\n\nFetch a list of posts from a public API (e.g., JSONPlaceholder) and display them in a ListView. This lesson bridges frontend and backend, a critical skill for any mobile developer.',
        codeSnippet: '''import 'package:http/http.dart' as http;
import 'dart:convert';

class Post {
  final int id;
  final String title;
  final String body;
  Post({required this.id, required this.title, required this.body});
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(id: json['id'], title: json['title'], body: json['body']);
  }
}

Future<List<Post>> fetchPosts() async {
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((post) => Post.fromJson(post)).toList();
  } else {
    throw Exception('Failed to load posts');
  }
}''',
        hasImage: true,
      ),
      AppLesson(
        title: 'Local Storage: SharedPreferences and SQLite',
        body: 'Persisting data locally is essential for offline support and user preferences. SharedPreferences stores key-value pairs (like settings or tokens). SQLite, accessed via sqflite package, handles relational data with full CRUD operations.\n\nYou\'ll implement a simple to-do list using SQLite: create a database, define a table, and perform insert, query, update, and delete. For lightweight data, use SharedPreferences to save a user\'s theme preference.\n\nBuild a notes app that saves notes locally using SQLite. This teaches you how to manage local data and handle database migrations, a skill required in most production apps.',
        codeSnippet: '''// SharedPreferences
final prefs = await SharedPreferences.getInstance();
prefs.setString('token', 'abc123');
String token = prefs.getString('token') ?? '';

// SQLite with sqflite
class DatabaseHelper {
  static final _databaseName = 'notes.db';
  static final _databaseVersion = 1;
  static final table = 'notes';

  Future<Database> get database async {
    return openDatabase(_databaseName, version: _databaseVersion,
        onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE $table (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT NOT NULL,
          content TEXT NOT NULL
        )
      ''');
    });
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database db = await database;
    return await db.query(table);
  }
}''',
        hasImage: true,
      ),
      AppLesson(
        title: 'Animations and Transitions',
        body: 'Animations make apps feel responsive and polished. Flutter provides implicit animations (AnimatedContainer, FadeTransition) and explicit animations using AnimationController. You\'ll learn to create smooth transitions between screens and state changes.\n\nMaster Tween, Curve, and AnimationBuilder. Implement a like button with a heart animation and a list that animates items on insertion or deletion.\n\nProfessional apps use animations to guide user attention. You\'ll add a hero animation to your profile card, making the transition to a detail page feel seamless. This skill differentiates amateur from professional apps.',
        codeSnippet: '''class FadeInWidget extends StatefulWidget {
  @override
  _FadeInWidgetState createState() => _FadeInWidgetState();
}

class _FadeInWidgetState extends State<FadeInWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Container(width: 100, height: 100, color: Colors.blue),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Professional Workflow: Git, CI/CD, and App Signing',
        body: 'In a real job, you\'ll work in teams using version control. Learn Git basics: clone, commit, push, branching, and pull requests. Set up a GitHub repo for your Flutter project.\n\nUnderstand continuous integration: use GitHub Actions to run tests and build the app on every push. Learn to sign your Android and iOS apps for release and distribute via Play Store and App Store.\n\nThis lesson covers the full professional pipeline from code to store. You\'ll create a release build and understand the keystore, provisioning profiles, and deployment checklists. Employers expect this, not just coding skills.',
        codeSnippet: '''# .github/workflows/flutter.yml
name: Flutter CI
on: [push]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - uses: subosito/flutter-action@v1
    - run: flutter pub get
    - run: flutter test
    - run: flutter build apk --release

# Keystore config (android/app/build.gradle)
signingConfigs {
    release {
        keyAlias 'key'
        keyPassword 'password'
        storeFile file('keystore.jks')
        storePassword 'password'
    }
}''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Common Mistakes and Debugging',
        body: 'Even experienced developers encounter bugs. Flutter\'s hot reload and DevTools help you inspect widgets, performance, and memory. Learn common errors: null safety issues, incorrect widget keys, async/await misuse, and context errors.\n\nMaster debugging techniques: print() statements, breakpoints, and the debug console. Understand the Flutter inspector to visualize widget trees. Learn to handle exceptions gracefully with try-catch and error widgets.\n\nWe\'ll walk through real bug scenarios from production apps. You\'ll practice debugging a broken app and fixing it. This builds resilience and problem-solving skills that employers value highly.',
        codeSnippet: '''// Common null safety issue
String? name;
print(name.length); // Error - use ! only if sure

// Async/Await mistake
void fetchData() async {
  // Missing await
  final data = http.get(url); // returns Future, not actual data
}

// Debugging with debugPrint
debugPrint('Button pressed: \$count');

// Using Flutter DevTools
// Run with: flutter pub global run devtools''',
        hasImage: true,
      ),
      AppLesson(
        title: 'Mini Project: Weather App with API and State Management',
        body: 'Now you\'ll build a fully functional weather app. It will fetch weather data from OpenWeatherMap API using the http package, parse JSON, and display current conditions and a 5-day forecast.\n\nUse Provider for state management to handle loading, error, and data states. Implement a search bar for city input, and save the last searched city with SharedPreferences. Add pull-to-refresh and a settings screen to toggle Celsius/Fahrenheit.\n\nThis project showcases everything you\'ve learned: networking, state management, navigation, forms, and local storage. It\'s a portfolio-worthy app that demonstrates real-world competence. Add a README and publish it on GitHub to show employers.',
        codeSnippet: '''// Weather model
class Weather {
  final String city;
  final double temp;
  final String description;
  Weather({required this.city, required this.temp, required this.description});
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      city: json['name'],
      temp: json['main']['temp'] - 273.15, // Kelvin to Celsius
      description: json['weather'][0]['description'],
    );
  }
}

// Provider state
class WeatherProvider extends ChangeNotifier {
  Weather? _weather;
  bool _loading = false;
  String _error = '';

  Weather? get weather => _weather;
  bool get loading => _loading;
  String get error => _error;

  Future<void> fetchWeather(String city) async {
    _loading = true;
    _error = '';
    notifyListeners();
    try {
      final response = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=\$city&appid=YOUR_KEY'));
      if (response.statusCode == 200) {
        _weather = Weather.fromJson(json.decode(response.body));
        _error = '';
      } else {
        _error = 'City not found';
        _weather = null;
      }
    } catch (e) {
      _error = 'Network error';
      _weather = null;
    }
    _loading = false;
    notifyListeners();
  }
}''',
        hasImage: false,
      ),
    ],
  ),

  // Course 2: Android Development with Kotlin - Intermediate
  AppCourse(
    id: 'mobile_development_android_kotlin',
    title: 'Android Native Development with Kotlin',
    description: 'Build production-ready Android apps using Kotlin, Android SDK, Jetpack Compose, and modern architecture patterns. Covers activities, fragments, ViewModel, Room, Retrofit, and a full e-commerce app project.',
    instructor: 'Adaobi Nnamdi',
    category: 'mobile development',
    difficulty: 'Intermediate',
    icon: Icons.android,
    color: Colors.green,
    duration: '14 hours',
    lessons: [
      AppLesson(
        title: 'Kotlin Fundamentals and Android Studio Setup',
        body: 'Kotlin is a modern, statically-typed language that runs on the JVM. It is concise, safe (null safety), and interoperable with Java. You\'ll set up Android Studio and create your first project.\n\nLearn Kotlin syntax: variables, functions, lambdas, and coroutines. Understand the project structure: manifests, resources, and Gradle build files.\n\nWrite a simple "Hello World" app and run it on an emulator. This lesson ensures your environment is ready for the rest of the course.',
        codeSnippet: '''// Kotlin basics
fun main() {
    val name = "Hustle Academy"
    println("Hello, \$name!")
}

// Data class
data class User(val id: Int, val name: String)

// Null safety
var nullable: String? = null
val length = nullable?.length ?: 0''',
        hasImage: true,
      ),
      AppLesson(
        title: 'Activities, Fragments, and the Lifecycle',
        body: 'An Activity is a single screen with a user interface. Fragments are reusable UI components that can be combined within an Activity. You\'ll learn the lifecycle callbacks: onCreate, onStart, onResume, onPause, onStop, and onDestroy.\n\nUnderstand how to handle configuration changes (like screen rotation) using ViewModel and saved instance state. We\'ll create a simple app with two Activities and navigate using Intents.\n\nThis foundation is crucial for building robust Android apps that respond correctly to system events.',
        codeSnippet: '''class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
    }

    fun navigateToDetails(view: View) {
        val intent = Intent(this, DetailsActivity::class.java)
        intent.putExtra("key", "value")
        startActivity(intent)
    }
}

// Fragment example
class MyFragment : Fragment() {
    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        return inflater.inflate(R.layout.fragment_my, container, false)
    }
}''',
        hasImage: false,
      ),
      AppLesson(
        title: 'UI Design with Jetpack Compose',
        body: 'Jetpack Compose is Android\'s modern UI toolkit for building native interfaces declaratively. Instead of XML layouts, you define UI in Kotlin code using composable functions.\n\nLearn the basic composables: Text, Button, Column, Row, Box, and LazyColumn. Manage state with remember and mutableStateOf. Understand recomposition and side effects.\n\nBuild a login screen with Compose and handle button clicks. Compose speeds up development and makes UI code more readable and maintainable.',
        codeSnippet: '''@Composable
fun Greeting(name: String) {
    Text(text = "Hello \$name!")
}

@Composable
fun LoginScreen() {
    var email by remember { mutableStateOf("") }
    var password by remember { mutableStateOf("") }
    Column(
        modifier = Modifier.padding(16.dp)
    ) {
        TextField(value = email, onValueChange = { email = it }, label = { Text("Email") })
        TextField(value = password, onValueChange = { password = it }, label = { Text("Password") })
        Button(onClick = { /* login logic */ }) {
            Text("Login")
        }
    }
}''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Architecture: ViewModel and LiveData/StateFlow',
        body: 'Android\'s recommended architecture is Model-View-ViewModel (MVVM). The ViewModel holds UI-related data and survives configuration changes. LiveData or StateFlow observe data changes and update the UI.\n\nYou\'ll create a ViewModel with LiveData, expose it to the UI, and observe changes. This pattern separates concerns and improves testability.\n\nImplement a simple counter with ViewModel and LiveData. Then refactor to use StateFlow for more reactive programming. These patterns are industry standards for Android development.',
        codeSnippet: '''class CounterViewModel : ViewModel() {
    private val _count = MutableLiveData<Int>(0)
    val count: LiveData<Int> = _count

    fun increment() {
        _count.value = (_count.value ?: 0) + 1
    }
}

// In Activity
class MainActivity : AppCompatActivity() {
    private lateinit var viewModel: CounterViewModel
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        viewModel = ViewModelProvider(this).get(CounterViewModel::class.java)
        viewModel.count.observe(this) { count ->
            textView.text = count.toString()
        }
        button.setOnClickListener { viewModel.increment() }
    }
}''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Networking with Retrofit and Moshi',
        body: 'Retrofit is a type-safe HTTP client for Android. It simplifies API calls and converts JSON to Kotlin objects using Moshi or Gson. You\'ll define an interface for your API endpoints, create a Retrofit instance, and make asynchronous calls with coroutines.\n\nLearn to handle network errors, timeouts, and response codes. Parse JSON to data classes. We\'ll fetch a list of posts from a REST API and display them in a LazyColumn.\n\nThis skill is essential for any app that consumes backend services. You\'ll also learn to add logging interceptors for debugging.',
        codeSnippet: '''// Build.gradle dependencies
implementation 'com.squareup.retrofit2:retrofit:2.9.0'
implementation 'com.squareup.retrofit2:converter-moshi:2.9.0'

// API interface
interface ApiService {
    @GET("posts")
    suspend fun getPosts(): List<Post>
}

// Retrofit instance
val retrofit = Retrofit.Builder()
    .baseUrl("https://jsonplaceholder.typicode.com/")
    .addConverterFactory(MoshiConverterFactory.create())
    .build()
val api = retrofit.create(ApiService::class.java)

// Usage in ViewModel
viewModelScope.launch {
    try {
        val posts = api.getPosts()
        _posts.value = posts
    } catch (e: Exception) {
        _error.value = "Network error"
    }
}''',
        hasImage: true,
      ),
      AppLesson(
        title: 'Local Database with Room',
        body: 'Room is an abstraction layer over SQLite that provides compile-time verification of SQL queries. You define entities, DAOs, and a database class. Room supports LiveData and Flow for reactive queries.\n\nCreate a User entity and a UserDao with insert, delete, and query methods. Use Room in your ViewModel to save user preferences and offline data.\n\nBuild a simple to-do app that stores tasks locally. This teaches you database design, migrations, and testing with Room, all crucial for production apps.',
        codeSnippet: '''@Entity(tableName = "users")
data class User(
    @PrimaryKey val id: Int,
    val name: String,
    val email: String
)

@Dao
interface UserDao {
    @Insert
    suspend fun insertUser(user: User)

    @Query("SELECT * FROM users")
    fun getAllUsers(): Flow<List<User>>
}

@Database(entities = [User::class], version = 1)
abstract class AppDatabase : RoomDatabase() {
    abstract fun userDao(): UserDao
}

// Instantiate
val db = Room.databaseBuilder(context, AppDatabase::class.java, "app.db").build()''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Dependency Injection with Dagger/Hilt',
        body: 'Dependency injection (DI) decouples object creation from usage, making code more testable and maintainable. Hilt is the recommended DI library for Android, built on top of Dagger.\n\nYou\'ll annotate your ViewModel and repository classes with @Inject and set up Hilt modules to provide dependencies. Hilt generates Dagger components at compile time.\n\nLearn to inject Retrofit, SharedPreferences, and other dependencies. This is a professional practice that large teams use to manage complexity. You\'ll refactor your app to use Hilt, improving its architecture.',
        codeSnippet: '''// AppModule
@Module
@InstallIn(SingletonComponent::class)
object AppModule {
    @Provides
    fun provideApiService(): ApiService = retrofit.create(ApiService::class.java)
}

// ViewModel with injection
@HiltViewModel
class MainViewModel @Inject constructor(
    private val api: ApiService
) : ViewModel() {
    // ...
}

// Activity
@AndroidEntryPoint
class MainActivity : AppCompatActivity() {
    private val viewModel: MainViewModel by viewModels()
    // ...
}''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Professional Workflow: Android Testing and Release',
        body: 'Professional Android development includes unit testing (JUnit), integration testing (Espresso), and instrumented tests. You\'ll write tests for your ViewModel and UI.\n\nLearn to set up test doubles (mocks) with MockK. Understand the test pyramid and how to achieve high coverage.\n\nAlso cover the release process: generate a signed APK/AAB, update version codes, and upload to Google Play Console. Understand app signing, proguard, and crash reporting with Firebase Crashlytics.',
        codeSnippet: '''// Unit test for ViewModel
@Test
fun testIncrement() = runTest {
    val viewModel = CounterViewModel()
    viewModel.increment()
    assertEquals(1, viewModel.count.value)
}

// Espresso UI test
@Test
fun testLoginButton() {
    onView(withId(R.id.login_button)).perform(click())
    onView(withId(R.id.success_text)).check(matches(isDisplayed()))
}''',
        hasImage: true,
      ),
      AppLesson(
        title: 'Common Pitfalls and Performance Tuning',
        body: 'Android apps face memory leaks, ANRs, and UI jank. Learn to use Android Profiler (CPU, Memory, Network) and LeakCanary to detect leaks. Understand the main thread vs background threads – never block the UI thread.\n\nCommon mistakes: not handling configuration changes, improper use of contexts, and overdraw. Use lint checks to catch issues early.\n\nWe\'ll analyze a poorly-performing app and optimize it: implement lazy loading, use view binding, and reduce layout complexity. These skills are what interviewers look for in senior roles.',
        codeSnippet: '''// Use View Binding to reduce findViewById
private lateinit var binding: ActivityMainBinding

override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    binding = ActivityMainBinding.inflate(layoutInflater)
    setContentView(binding.root)
    binding.button.setOnClickListener { ... }
}

// Avoid memory leaks with weak references
class MyHandler(weakActivity: WeakReference<MainActivity>) : Handler() {
    override fun handleMessage(msg: Message) {
        weakActivity.get()?.doSomething()
    }
}''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Mini Project: E-Commerce App with Cart and Checkout',
        body: 'Build a full e-commerce app that fetches products from an API, displays them in categories, allows adding to cart, and processes checkout. Use Room to persist cart items locally and Retrofit for network calls.\n\nImplement MVVM with Hilt, StateFlow for UI state, and navigation with Jetpack Navigation. Include a search filter and a wishlist feature. Write unit tests for the ViewModel and integration tests for the checkout flow.\n\nThis project mimics a real startup MVP. Add screenshots and a demo video to your portfolio. It demonstrates your ability to build a production-grade Android app from scratch.',
        codeSnippet: '''// CartViewModel
@HiltViewModel
class CartViewModel @Inject constructor(
    private val repository: CartRepository
) : ViewModel() {
    private val _cartItems = MutableStateFlow<List<CartItem>>(emptyList())
    val cartItems: StateFlow<List<CartItem>> = _cartItems

    fun addToCart(product: Product) {
        viewModelScope.launch {
            repository.insert(product)
            _cartItems.value = repository.getAll()
        }
    }

    fun checkout(): Boolean {
        // process payment, clear cart
        return true
    }
}''',
        hasImage: false,
      ),
    ],
  ),

  // Course 3: iOS Development with Swift - Intermediate
  AppCourse(
    id: 'mobile_development_ios_swift',
    title: 'iOS Native Development with SwiftUI',
    description: 'Build iOS apps using Swift and SwiftUI. Covers UIKit, SwiftUI, Combine, Core Data, networking, and a complete social media feed project.',
    instructor: 'Tunde Adebayo',
    category: 'mobile development',
    difficulty: 'Intermediate',
    icon: Icons.apple,
    color: Colors.grey,
    duration: '13 hours',
    lessons: [
      AppLesson(
        title: 'Swift Essentials and Xcode Setup',
        body: 'Swift is Apple\'s modern language for iOS, macOS, and watchOS. It\'s type-safe, fast, and uses ARC for memory management. You\'ll install Xcode and create your first iOS project.\n\nLearn Swift basics: variables, constants, optionals, guard, and closures. Understand the Xcode workspace, storyboards, and the Info.plist.\n\nWrite a simple "Hello" app and run it on the simulator. This sets the stage for the rest of the course.',
        codeSnippet: '''// Swift basics
let message = "Hello, Hustle Academy"
var count = 0
count += 1

// Optional handling
var name: String? = nil
if let unwrapped = name {
    print(unwrapped)
}

// Closure
let add = { (a: Int, b: Int) -> Int in a + b }
print(add(3, 5))''',
        hasImage: true,
      ),
      AppLesson(
        title: 'UIKit vs SwiftUI - The New Way',
        body: 'UIKit has been the standard framework for iOS UI, using storyboards and view controllers. SwiftUI is a modern declarative framework introduced in 2019. We\'ll focus on SwiftUI but cover UIKit for legacy support.\n\nIn SwiftUI, you build UI with View structs and modifiers. State management uses @State, @Binding, and @ObservedObject. Learn the lifecycle of SwiftUI views.\n\nBuild a simple profile view with SwiftUI and compare with UIKit to see the declarative advantage. SwiftUI is the future of iOS development.',
        codeSnippet: '''import SwiftUI

struct ContentView: View {
    @State private var name = "John"
    var body: some View {
        VStack {
            Text("Hello, \\(name)!")
            TextField("Enter name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
        }
    }
}

// UIKit equivalent
class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    @IBAction func buttonTapped(_ sender: Any) {
        label.text = "Tapped"
    }
}''',
        hasImage: false,
      ),
      AppLesson(
        title: 'State Management in SwiftUI',
        body: 'SwiftUI uses property wrappers for state: @State for local UI state, @Binding for two-way binding, @ObservedObject for external observable objects, and @EnvironmentObject for shared data across views.\n\nYou\'ll create a counter app using @State, then refactor to use @ObservedObject with a ViewModel conforming to ObservableObject. Use @Published to trigger UI updates.\n\nLearn to manage navigation with NavigationStack and pass data between views. These patterns are essential for building robust SwiftUI apps.',
        codeSnippet: '''class CounterViewModel: ObservableObject {
    @Published var count = 0
    func increment() { count += 1 }
}

struct CounterView: View {
    @StateObject private var vm = CounterViewModel()
    var body: some View {
        VStack {
            Text("Count: \\(vm.count)")
            Button("Increment") { vm.increment() }
        }
    }
}

// Environment object
struct DetailView: View {
    @EnvironmentObject var settings: UserSettings
    var body: some View {
        Text(settings.username)
    }
}''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Networking with URLSession and Codable',
        body: 'iOS apps fetch data using URLSession. You\'ll perform GET and POST requests and decode JSON using the Codable protocol. Use async/await (Swift Concurrency) for clean asynchronous code.\n\nModel your data as structs conforming to Decodable. Handle errors and loading states. We\'ll fetch a list of users from a REST API and display them in a List.\n\nThis lesson covers the core networking stack used in almost every iOS app.',
        codeSnippet: '''struct User: Decodable {
    let id: Int
    let name: String
    let email: String
}

class APIService {
    func fetchUsers() async throws -> [User] {
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let users = try JSONDecoder().decode([User].self, from: data)
        return users
    }
}

// Usage
Task {
    do {
        let users = try await api.fetchUsers()
        usersList = users
    } catch {
        print(error)
    }
}''',
        hasImage: true,
      ),
      AppLesson(
        title: 'Persistent Storage with Core Data and UserDefaults',
        body: 'Core Data is Apple\'s object graph and persistence framework. You\'ll define entities (like Person), generate NSManagedObject subclasses, and perform CRUD operations. Use NSFetchRequest and NSPredicate for queries.\n\nFor simple preferences, use UserDefaults. You\'ll save user settings and login state.\n\nBuild a notes app where notes are stored in Core Data. This gives you practical experience with Core Data stack: NSManagedObjectContext, NSPersistentContainer, and saving contexts.',
        codeSnippet: '''// Core Data entity Person
extension Person {
    @NSManaged var name: String?
    @NSManaged var age: Int16
}

// Save
let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
let person = Person(context: context)
person.name = "Alice"
person.age = 30
try? context.save()

// Fetch
let request: NSFetchRequest<Person> = Person.fetchRequest()
request.predicate = NSPredicate(format: "age > %d", 18)
let results = try? context.fetch(request)

// UserDefaults
UserDefaults.standard.set("dark", forKey: "theme")
let theme = UserDefaults.standard.string(forKey: "theme")''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Combine Framework for Reactive Programming',
        body: 'Combine is Apple\'s framework for reactive programming. It provides publishers and subscribers to handle asynchronous events. Combine integrates with SwiftUI and URLSession.\n\nYou\'ll learn to create publishers using Just, Future, and URLSession.DataTaskPublisher. Use operators like map, filter, and combineLatest. Subscribe using sink or assign.\n\nImplement a search bar that sends requests as the user types, debouncing and cancelling previous requests. This showcases Combine\'s power.',
        codeSnippet: '''import Combine

class SearchViewModel: ObservableObject {
    @Published var query = ""
    @Published var results: [String] = []
    private var cancellables = Set<AnyCancellable>()

    init() {
        $query
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] q in
                self?.performSearch(q)
            }
            .store(in: &cancellables)
    }

    func performSearch(_ term: String) {
        // simulate network
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.results = ["Result for \(term)"]
        }
    }
}''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Unit Testing and UI Testing in Xcode',
        body: 'iOS development requires testing. Use XCTest for unit tests and XCUITest for UI tests. Write tests for your ViewModel and network layer. Use mock objects to isolate dependencies.\n\nLearn to use expectations for asynchronous code and measure performance. Understand code coverage and test-driven development (TDD).\n\nYou\'ll write a suite of tests for your app, ensuring reliability. Testing is a non-negotiable skill in professional iOS teams.',
        codeSnippet: '''import XCTest
@testable import MyApp

class CounterTests: XCTestCase {
    func testIncrement() {
        let vm = CounterViewModel()
        vm.increment()
        XCTAssertEqual(vm.count, 1)
    }

    func testAsyncFetch() {
        let exp = expectation(description: "Fetch users")
        let api = APIService()
        Task {
            let users = try await api.fetchUsers()
            XCTAssertGreaterThan(users.count, 0)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5)
    }
}''',
        hasImage: true,
      ),
      AppLesson(
        title: 'App Store Submission and App Store Connect',
        body: 'To distribute your iOS app, you need to go through App Store Connect. Learn to create an app record, configure certificates and provisioning profiles, and upload a build using Xcode\'s Organizer.\n\nUnderstand the review guidelines, privacy policy requirements, and how to handle rejections. Set up app icons, screenshots, and app descriptions.\n\nYou\'ll submit a sample app to TestFlight for beta testing. This practical experience demystifies the submission process that every iOS developer must navigate.',
        codeSnippet: '''// Steps
// 1. Create App ID and certificates in Apple Developer portal
// 2. Configure Xcode project with team and bundle identifier
// 3. Archive product (Product > Archive)
// 4. Distribute App (via App Store Connect)
// 5. Fill in metadata in App Store Connect
// 6. Submit for review''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Common Bugs and Performance Optimizations',
        body: 'iOS apps can suffer from memory leaks, retain cycles, and UI lag. Use Xcode\'s Instruments (Leaks, Time Profiler, Allocations) to detect issues. Learn to use weak references to break cycles.\n\nCommon pitfalls: force-unwrapping optionals, main thread blocking, and overusing UIKit in SwiftUI. We\'ll profile a sample app and fix bottlenecks.\n\nOptimize image loading with caching, lazy load data, and use view reuse. These skills elevate you to a performance-conscious developer.',
        codeSnippet: '''// Avoid retain cycles with weak
class MyViewController: UIViewController {
    var closure: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        closure = { [weak self] in
            self?.doSomething()
        }
    }

    func doSomething() { }
}

// Use lazy loading
lazy var heavyObject: SomeClass = {
    return SomeClass()
}()''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Mini Project: Social Media Feed with Posts and Comments',
        body: 'Build a social feed app that displays posts from an API, supports pull-to-refresh, and shows comments when a post is tapped. Use SwiftUI for UI, Combine for reactive updates, and Core Data for caching posts.\n\nImplement a custom loading state, error handling, and a "like" button that persists locally. Write unit tests for the ViewModel and UI tests for the feed navigation.\n\nThis project mirrors a real-world social media feature. Add it to your portfolio with a video walkthrough. It demonstrates your ability to build a polished, data-driven iOS app.',
        codeSnippet: '''struct FeedView: View {
    @StateObject private var vm = FeedViewModel()
    var body: some View {
        List(vm.posts) { post in
            VStack(alignment: .leading) {
                Text(post.title).font(.headline)
                Text(post.body).font(.body)
                Button("Like") { vm.like(post) }
            }
        }
        .refreshable {
            await vm.refresh()
        }
        .overlay {
            if vm.isLoading { ProgressView() }
        }
        .alert("Error", isPresented: $vm.showError) {
            Button("Retry") { vm.fetch() }
        }
    }
}''',
        hasImage: false,
      ),
    ],
  ),

  // Course 4: React Native - Beginner
  AppCourse(
    id: 'mobile_development_react_native',
    title: 'React Native: Cross-Platform with JavaScript',
    description: 'Build mobile apps using React Native, JavaScript, and Expo. Covers components, state, navigation, native APIs, and a complete ride-sharing app project.',
    instructor: 'Zainab Bello',
    category: 'mobile development',
    difficulty: 'Beginner',
    icon: Icons.react,
    color: Colors.cyan,
    duration: '11 hours',
    lessons: [
      AppLesson(
        title: 'JavaScript/ES6 and React Native Setup',
        body: 'React Native uses JavaScript and React. You\'ll need a solid grasp of ES6: arrow functions, destructuring, spread operator, classes, and async/await. We\'ll set up the development environment with Node.js, npm, and Expo CLI.\n\nExpo simplifies development with a managed workflow. You\'ll create your first project using `expo init` and run it on an emulator or physical device with the Expo Go app.\n\nWrite a simple "Hello World" and understand the project structure. This foundation prepares you for the component-based architecture of React Native.',
        codeSnippet: '''// ES6 basics
const greet = (name) => `Hello ${name}`;
const { id, title } = { id: 1, title: "Post" };

// App.js
import React from 'react';
import { Text, View } from 'react-native';

export default function App() {
  return (
    <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}>
      <Text>Hello React Native!</Text>
    </View>
  );
}''',
        hasImage: true,
      ),
      AppLesson(
        title: 'Components and Styling in React Native',
        body: 'React Native provides core components: View, Text, ScrollView, Image, TextInput, and Button. Styling uses JavaScript objects similar to CSS but with camelCase properties.\n\nYou\'ll build a simple layout using Flexbox (a must-know for RN). Learn about StyleSheet.create for performance and reusability. Understand inline vs external styles.\n\nCreate a product card with an image, title, and price. This teaches you to compose components and style them effectively.',
        codeSnippet: '''import { StyleSheet, View, Text, Image } from 'react-native';

const ProductCard = ({ product }) => (
  <View style={styles.card}>
    <Image source={{ uri: product.image }} style={styles.image} />
    <Text style={styles.title}>{product.title}</Text>
    <Text style={styles.price}>${product.price}</Text>
  </View>
);

const styles = StyleSheet.create({
  card: { padding: 10, margin: 10, backgroundColor: '#fff', borderRadius: 8 },
  image: { width: 100, height: 100 },
  title: { fontSize: 16, fontWeight: 'bold' },
  price: { fontSize: 14, color: 'green' },
});''',
        hasImage: false,
      ),
      AppLesson(
        title: 'State Management with Hooks (useState, useEffect)',
        body: 'React hooks allow functional components to manage state and side effects. useState creates local state, and useEffect handles side effects like data fetching or subscriptions.\n\nYou\'ll build a counter app with useState. Then use useEffect to fetch data from an API and display it. Learn about dependency arrays and cleanup functions.\n\nManage loading and error states. This lesson is the core of React Native development and is applicable to any React project.',
        codeSnippet: '''import React, { useState, useEffect } from 'react';
import { View, Text, Button } from 'react-native';

const Counter = () => {
  const [count, setCount] = useState(0);
  useEffect(() => {
    document.title = `Count: ${count}`;
  }, [count]);

  return (
    <View>
      <Text>Count: {count}</Text>
      <Button title="Increment" onPress={() => setCount(count + 1)} />
    </View>
  );
};

// Data fetching
const fetchData = async () => {
  const response = await fetch('https://api.example.com/data');
  const json = await response.json();
  setData(json);
};

useEffect(() => {
  fetchData();
}, []);''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Navigation with React Navigation',
        body: 'React Navigation is the de facto library for navigation. You\'ll use Stack Navigator for screen transitions, Tab Navigator for bottom tabs, and Drawer Navigator for side menus.\n\nLearn to pass parameters between screens using navigation.navigate with params. Also handle deep linking.\n\nImplement a bottom-tab app with Home, Search, and Profile tabs. Then add a stack navigator inside the Home tab for detail screens. This is the standard pattern for RN apps.',
        codeSnippet: '''import { NavigationContainer } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';

const Stack = createStackNavigator();
const Tab = createBottomTabNavigator();

function HomeStack() {
  return (
    <Stack.Navigator>
      <Stack.Screen name="Home" component={HomeScreen} />
      <Stack.Screen name="Details" component={DetailsScreen} />
    </Stack.Navigator>
  );
}

function App() {
  return (
    <NavigationContainer>
      <Tab.Navigator>
        <Tab.Screen name="Home" component={HomeStack} />
        <Tab.Screen name="Search" component={SearchScreen} />
        <Tab.Screen name="Profile" component={ProfileScreen} />
      </Tab.Navigator>
    </NavigationContainer>
  );
}''',
        hasImage: true,
      ),
      AppLesson(
        title: 'Networking and Async Storage',
        body: 'React Native uses Fetch API (or Axios) for HTTP requests. You\'ll fetch data from REST APIs and handle responses. AsyncStorage provides simple key-value storage for small data.\n\nImplement a login screen that stores the user token in AsyncStorage. Use the token in subsequent requests by adding it to headers.\n\nBuild a posts list that fetches from JSONPlaceholder and caches the last fetched data in AsyncStorage for offline support. This covers both networking and persistence.',
        codeSnippet: '''// Fetch posts
const fetchPosts = async () => {
  const response = await fetch('https://jsonplaceholder.typicode.com/posts');
  const data = await response.json();
  setPosts(data);
};

// AsyncStorage
import AsyncStorage from '@react-native-async-storage/async-storage';

const storeData = async (key, value) => {
  try {
    await AsyncStorage.setItem(key, value);
  } catch (e) { console.error(e); }
};

const getData = async (key) => {
  try {
    const value = await AsyncStorage.getItem(key);
    return value;
  } catch (e) { console.error(e); }
};

// Save token after login
await storeData('token', 'abc123');
const token = await getData('token');''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Professional Tools: ESLint, Prettier, and Debugging',
        body: 'In a professional setting, code quality matters. Use ESLint for linting, Prettier for formatting, and React Native Debugger for debugging. Learn to use the Chrome DevTools for inspecting elements and debugging JavaScript.\n\nSet up Husky for pre-commit hooks to enforce standards. Understand the importance of consistent code style in teams.\n\nYou\'ll configure your project with these tools and practice debugging a broken app using breakpoints and console logs. Employers value developers who write clean, maintainable code.',
        codeSnippet: '''// .eslintrc.js
module.exports = {
  extends: '@react-native-community',
  rules: {
    'no-console': 'warn',
    'prettier/prettier': 'error',
  },
};

// .prettierrc
{
  "singleQuote": true,
  "trailingComma": "es5",
  "tabWidth": 2
}

// Debugging with console.log
console.log('User data:', userData);''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Handling Device Features (Camera, Location)',
        body: 'React Native apps often use native device features. Use Expo\'s libraries or community packages like react-native-camera and react-native-geolocation-service.\n\nLearn to request permissions and handle camera roll access. Implement a simple camera screen that takes a photo and uploads it.\n\nAlso use Geolocation to get the user\'s current location. Build a "Where Am I?" feature that displays latitude/longitude. These skills are essential for apps like Uber, Instagram, or food delivery.',
        codeSnippet: '''import * as ImagePicker from 'expo-image-picker';
import * as Location from 'expo-location';

// Camera
const takePhoto = async () => {
  const { status } = await ImagePicker.requestCameraPermissionsAsync();
  if (status !== 'granted') return;
  const result = await ImagePicker.launchCameraAsync();
  if (!result.cancelled) {
    setImage(result.uri);
  }
};

// Location
const getLocation = async () => {
  const { status } = await Location.requestForegroundPermissionsAsync();
  if (status !== 'granted') return;
  const location = await Location.getCurrentPositionAsync({});
  setCoords(location.coords);
};''',
        hasImage: true,
      ),
      AppLesson(
        title: 'Common Mistakes and Performance Tips',
        body: 'React Native has pitfalls: over-rendering, memory leaks, and slow navigation. Use React.memo and useMemo to prevent unnecessary re-renders. Use FlatList instead of ScrollView for long lists.\n\nAvoid using anonymous functions in render (they recreate on each render). Use keyExtractor in lists. Optimise images with caching.\n\nWe\'ll profile a sample app using React DevTools and identify performance bottlenecks. You\'ll learn to write efficient RN code that performs well on low-end devices.',
        codeSnippet: '''// Use FlatList for large lists
<FlatList
  data={data}
  renderItem={({ item }) => <PostItem post={item} />}
  keyExtractor={item => item.id.toString()}
  windowSize={5}
/>

// Memoize heavy computation
const expensive = useMemo(() => compute(data), [data]);

// Avoid inline functions in child components
<Button onPress={handlePress} /> // handlePress defined outside

// Use React.memo
const PostItem = React.memo(({ post }) => {
  return <Text>{post.title}</Text>;
});''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Mini Project: Ride-Sharing App (Uber-like)',
        body: 'Build a ride-sharing app with map integration (react-native-maps), location tracking, and a booking flow. Use a mock API to list available drivers and estimate fares.\n\nImplement a home screen with a map showing nearby drivers. A search bar to enter destination, and a "Request Ride" button. After booking, show driver arrival and a live map update (simulated). Use AsyncStorage to save ride history.\n\nThis project combines navigation, maps, networking, and state management. It\'s impressive for a portfolio and demonstrates end-to-end app development skills.',
        codeSnippet: '''// Map view
import MapView, { Marker } from 'react-native-maps';

const RideScreen = () => {
  const [region, setRegion] = useState({
    latitude: 37.78825,
    longitude: -122.4324,
    latitudeDelta: 0.0922,
    longitudeDelta: 0.0421,
  });

  return (
    <MapView region={region} style={{ flex: 1 }}>
      <Marker coordinate={region} title="You are here" />
    </MapView>
  );
};

// Booking function
const requestRide = async () => {
  const response = await fetch('https://api.example.com/ride/request', {
    method: 'POST',
    body: JSON.stringify({ pickup, dropoff }),
    headers: { 'Content-Type': 'application/json' },
  });
  const data = await response.json();
  setDriver(data.driver);
};''',
        hasImage: false,
      ),
    ],
  ),

  // Course 5: Flutter Advanced - Advanced
  AppCourse(
    id: 'mobile_development_flutter_advanced',
    title: 'Advanced Flutter: Architecture, Performance, and Production',
    description: 'Take Flutter to the next level with clean architecture, BLoC, Riverpod, custom painters, animations, and deployment. Includes a full banking app project.',
    instructor: 'Oluwaseun Ogunyemi',
    category: 'mobile development',
    difficulty: 'Advanced',
    icon: Icons.code,
    color: Colors.deepPurple,
    duration: '16 hours',
    lessons: [
      AppLesson(
        title: 'Clean Architecture in Flutter',
        body: 'Clean Architecture separates the app into layers: presentation, domain, and data. This makes the codebase scalable, testable, and maintainable. Use packages like get_it for dependency injection.\n\nYou\'ll structure your project into features, each with its own layers. Entities are plain Dart classes, use cases contain business logic, and repositories abstract data sources.\n\nThis lesson teaches you to think architecturally. We\'ll refactor a simple counter app into Clean Architecture, demonstrating how to add features without breaking existing code.',
        codeSnippet: '''// Domain/Entities
class User {
  final String id;
  final String name;
  User(this.id, this.name);
}

// Domain/Use Cases
class GetUserUseCase {
  final UserRepository repository;
  GetUserUseCase(this.repository);
  Future<User> call(String id) => repository.getUser(id);
}

// Data/Repositories
abstract class UserRepository {
  Future<User> getUser(String id);
}

// Data/DataSources
class RemoteUserDataSource {
  Future<Map<String, dynamic>> fetchUser(String id) async {
    // http call
  }
}

// Presentation/ViewModels
class UserViewModel extends ChangeNotifier {
  final GetUserUseCase getUserUseCase;
  UserViewModel(this.getUserUseCase);
  User? _user;
  User? get user => _user;
  Future<void> loadUser(String id) async {
    _user = await getUserUseCase(id);
    notifyListeners();
  }
}''',
        hasImage: true,
      ),
      AppLesson(
        title: 'Advanced State Management: Riverpod and BLoC',
        body: 'While Provider is good, Riverpod and BLoC offer more features for complex apps. Riverpod is compile-safe and supports auto-dispose, family, and state providers. BLoC uses streams and events.\n\nYou\'ll implement a todo app using Riverpod: create providers, override them, and use ref.watch. Then implement BLoC with cubit for a simple counter and with events for a more complex scenario.\n\nCompare both approaches and understand when to use each. These are the state management solutions used in enterprise Flutter projects.',
        codeSnippet: '''// Riverpod
final counterProvider = StateProvider<int>((ref) => 0);

class CounterWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider);
    return Row(
      children: [
        Text('$count'),
        ElevatedButton(
          onPressed: () => ref.read(counterProvider.notifier).state++,
          child: Text('+'),
        ),
      ],
    );
  }
}

// BLoC
class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);
  void increment() => emit(state + 1);
}

// Usage
BlocProvider(
  create: (context) => CounterCubit(),
  child: BlocConsumer<CounterCubit, int>(
    builder: (context, count) => Text('$count'),
    listener: (context, state) => print('Count: $state'),
  ),
)''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Custom Paint and Animations',
        body: 'Flutter allows custom drawing with CustomPainter and animations with AnimationController. You\'ll create custom shapes, charts, and loading spinners.\n\nLearn to use CustomPaint and Canvas to draw arcs, lines, and paths. Combine with animations to create dynamic effects.\n\nBuild a progress ring widget and a beautiful animated onboarding screen. These skills make your apps stand out visually.',
        codeSnippet: '''class ProgressPainter extends CustomPainter {
  final double progress;
  ProgressPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCircle(center: Offset(size.width/2, size.height/2), radius: 50),
      -pi/2,
      2*pi * progress,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant ProgressPainter oldDelegate) => oldDelegate.progress != progress;
}

// Animated progress
class AnimatedProgress extends StatefulWidget {
  @override
  _AnimatedProgressState createState() => _AnimatedProgressState();
}

class _AnimatedProgressState extends State<AnimatedProgress> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 2));
    _controller.forward();
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => CustomPaint(
        painter: ProgressPainter(_controller.value),
        size: Size(100, 100),
      ),
    );
  }
}''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Performance Profiling and Optimization',
        body: 'Advanced Flutter developers must optimize performance. Use the Performance overlay, timeline, and DevTools to identify jank and memory leaks. Understand frame rendering (UI vs GPU threads).\n\nLearn to use RepaintBoundary to isolate expensive widgets. Use const constructors to avoid rebuilds. Avoid large lists without ListView.builder.\n\nYou\'ll profile a sample app with heavy animations and optimize it using these techniques. Performance tuning is a key differentiator for senior engineers.',
        codeSnippet: '''// Use const to prevent rebuilds
const Text('Static text')

// ListView.builder for large lists
ListView.builder(
  itemCount: 1000,
  itemBuilder: (context, index) => ListTile(title: Text('Item $index')),
)

// RepaintBoundary
RepaintBoundary(
  child: MyComplexWidget(),
)

// Use keys for stateful widgets
Key key = ValueKey('unique')''',
        hasImage: true,
      ),
      AppLesson(
        title: 'Testing: Unit, Widget, and Integration Tests',
        body: 'Flutter\'s testing pyramid: unit tests for business logic, widget tests for UI interactions, and integration tests for full app flows. Use mockito for mocking.\n\nWrite unit tests for your ViewModel/Bloc. Widget tests using testWidgets and pumpWidget. Integration tests with flutter_driver or integration_test package.\n\nSet up a test environment with code coverage reporting. This is mandatory for production-grade apps. You\'ll test a sample shopping cart to ensure reliability.',
        codeSnippet: '''// Unit test
void main() {
  test('Counter increments', () {
    final counter = Counter();
    counter.increment();
    expect(counter.value, 1);
  });
}

// Widget test
testWidgets('Counter increments UI', (tester) async {
  await tester.pumpWidget(MyApp());
  expect(find.text('0'), findsOneWidget);
  await tester.tap(find.byIcon(Icons.add));
  await tester.pump();
  expect(find.text('1'), findsOneWidget);
});

// Integration test
import 'package:integration_test/integration_test.dart';
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('full app flow', (tester) async {
    await tester.pumpWidget(MyApp());
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();
    expect(find.text('Welcome'), findsOneWidget);
  });
}''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Internationalization and Accessibility',
        body: 'Professional apps serve global users. Implement i18n using the intl package and generate .arb files. Support RTL languages and locale-specific formatting.\n\nAccessibility is crucial: add semantic labels, use Semantics widget, and ensure contrast ratios. Test with screen readers (TalkBack, VoiceOver).\n\nYou\'ll localise a sample app into French and Spanish, and ensure all interactive elements are accessible. These are often overlooked but highly valued in enterprise.',
        codeSnippet: '''// pubspec.yaml
dependencies:
  flutter_localizations:
    sdk: flutter
  intl: any

// App with localizations
MaterialApp(
  localizationsDelegates: [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ],
  supportedLocales: [Locale('en'), Locale('es')],
  locale: Locale('es'),
  home: MyHomePage(),
)

// Accessibility
Semantics(
  label: 'Profile picture',
  child: CircleAvatar(
    backgroundImage: AssetImage('assets/avatar.png'),
  ),
)

// Text with semantics
Text('Hello', semanticsLabel: 'Greeting')''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Professional Context: Freelance and Employer Expectations',
        body: 'As a Flutter developer, you\'ll often work on freelance gigs or as part of a team. Understand common deliverables: design handoff (Figma), API integration, app store submissions, and maintenance.\n\nLearn to estimate tasks, communicate with stakeholders, and manage project timelines. Know how to use project management tools like Jira or Trello.\n\nWe\'ll discuss real-world case studies: building an MVP for a startup, fixing bugs in a legacy app, and adding new features under tight deadlines. This lesson prepares you for the business side of development.',
        codeSnippet: '''// Checklist for freelance delivery
// 1. Understand requirements and wireframes
// 2. Break down into tasks (estimates)
// 3. Set up CI/CD (GitHub Actions)
// 4. Implement and test each feature
// 5. Write documentation (README, API usage)
// 6. Submit to stores (Play/App Store)
// 7. Provide post-launch support for 2 weeks''',
        hasImage: true,
      ),
      AppLesson(
        title: 'Advanced Platform Channels and Native Code',
        body: 'Sometimes you need to call platform-specific code (Android/Kotlin, iOS/Swift). Use MethodChannel to communicate with native modules.\n\nImplement a native battery level plugin: call the platform code and return the result. Also learn to send events from native to Flutter using EventChannel.\n\nThis skill is essential when you need to integrate third-party SDKs that don\'t have Flutter plugins. It opens up the full power of the platform.',
        codeSnippet: '''// Flutter side
static const platform = MethodChannel('com.example/battery');
Future<String> getBatteryLevel() async {
  try {
    final result = await platform.invokeMethod('getBatteryLevel');
    return result;
  } catch (e) {
    return 'Failed: $e';
  }
}

// Android (Kotlin)
class MainActivity: FlutterActivity() {
  override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)
    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "com.example/battery")
      .setMethodCallHandler { call, result ->
        if (call.method == "getBatteryLevel") {
          // Get battery level
          result.success("75%")
        } else {
          result.notImplemented()
        }
      }
  }
}

// iOS (Swift)
let batteryChannel = FlutterMethodChannel(name: "com.example/battery", binaryMessenger: controller.binaryMessenger)
batteryChannel.setMethodCallHandler { (call, result) in
  if call.method == "getBatteryLevel" {
    let level = 75
    result(level)
  } else {
    result(FlutterMethodNotImplemented)
  }
}''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Common Anti-Patterns and Code Reviews',
        body: 'Avoid common Flutter anti-patterns: using BuildContext across async gaps, storing global singletons, neglecting error boundaries, and overusing setState.\n\nLearn to conduct code reviews: what to look for (naming, architecture, performance, tests). Understand the importance of linters and custom rules.\n\nWe\'ll review several code snippets from real projects and identify issues. This lesson trains you to be a valuable team player who writes clean, reviewable code.',
        codeSnippet: '''// Anti-pattern: using context in async
void fetchData(BuildContext context) async {
  final data = await api.get();
  Navigator.push(context, ...); // context might be stale
}

// Fix: check mounted
void fetchData(BuildContext context) async {
  final data = await api.get();
  if (mounted) {
    Navigator.push(context, ...);
  }
}

// Overuse of setState in large widgets - refactor to smaller widgets.
// Use const constructors where possible.'''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Mini Project: Banking App with Authentication and Transactions',
        body: 'Build a full-featured banking app: user login with biometrics (using local_auth), dashboard showing balance, transaction history, and a transfer screen. Use Clean Architecture, Riverpod for state, and Dio for networking.\n\nImplement offline support with SQLite (sqflite) to cache transactions. Include charts for spending breakdown using custom painters. Add push notifications for transaction alerts (using firebase_messaging).\n\nThis project is complex and portfolio-worthy. It demonstrates all advanced concepts: architecture, state, native features, and testing. You\'ll have a complete app that mimics a fintech MVP.',
        codeSnippet: '''// Auth use case
class LoginUseCase {
  final AuthRepository repository;
  LoginUseCase(this.repository);
  Future<User> execute(String email, String password) => repository.login(email, password);
}

// Transaction repository
class TransactionRepository {
  final LocalDataSource local;
  final RemoteDataSource remote;
  Future<List<Transaction>> getTransactions() async {
    // try remote, else local
  }
}

// UI with Riverpod
final transactionProvider = FutureProvider<List<Transaction>>((ref) async {
  final repo = ref.watch(transactionRepoProvider);
  return repo.getTransactions();
});

// Dashboard
class DashboardScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactions = ref.watch(transactionProvider);
    return Scaffold(
      body: transactions.when(
        data: (data) => TransactionList(data),
        loading: () => CircularProgressIndicator(),
        error: (err, stack) => ErrorWidget(err),
      ),
    );
  }
}''',
        hasImage: false,
      ),
    ],
  ),

  // Course 6: Kotlin Multiplatform - Advanced
  AppCourse(
    id: 'mobile_development_kmp',
    title: 'Kotlin Multiplatform Mobile (KMM)',
    description: 'Share business logic between Android and iOS using Kotlin Multiplatform. Covers KMM setup, expect/actual, networking, database, and a full fitness tracker app.',
    instructor: 'Chinwe Eze',
    category: 'mobile development',
    difficulty: 'Advanced',
    icon: Icons.g_mobiledata,
    color: Colors.purple,
    duration: '15 hours',
    lessons: [
      AppLesson(
        title: 'Introduction to KMM and Project Structure',
        body: 'Kotlin Multiplatform allows you to write common code that compiles to Android (JVM) and iOS (native). You\'ll set up a KMM project using the KMM plugin in Android Studio.\n\nUnderstand the project structure: shared module (commonMain, androidMain, iosMain), androidApp, and iosApp (Xcode project). Learn the expect/actual mechanism for platform-specific implementations.\n\nCreate a simple "Hello" common function and call it from both Android and iOS. This lesson establishes the KMM workflow.',
        codeSnippet: '''// shared/src/commonMain/kotlin/Greeting.kt
package com.example.shared

class Greeting {
  fun sayHello(): String = "Hello from KMM"
}

// Android usage (androidApp)
val greeting = Greeting()
textView.text = greeting.sayHello()

// iOS usage (iosApp)
let greeting = Greeting()
label.text = greeting.sayHello()''',
        hasImage: true,
      ),
      AppLesson(
        title: 'Expect/Actual for Platform-Specific Code',
        body: 'In KMM, you define expect declarations in commonMain and provide actual implementations in platform-specific source sets. This is used for networking, database, and UI.\n\nImplement a platform-specific logger: expect fun log(message: String) in common, actual for Android using Log.d, actual for iOS using NSLog.\n\nThis pattern is the core of KMM. You\'ll practice with a file system access example, which varies between platforms.',
        codeSnippet: '''// commonMain
expect fun getPlatformName(): String

// androidMain
actual fun getPlatformName(): String = "Android"

// iosMain
actual fun getPlatformName(): String = "iOS"

// common usage
println("Running on: ${getPlatformName()}")''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Networking with Ktor in KMM',
        body: 'Ktor is a multiplatform HTTP client. You\'ll set up a Ktor client in commonMain with platform-specific engines (OkHttp for Android, Darwin for iOS).\n\nDefine API endpoints, make GET/POST requests, and parse JSON using kotlinx.serialization. Handle errors and cancellations.\n\nFetch posts from a REST API and display them in both apps. This demonstrates sharing network logic across platforms.',
        codeSnippet: '''// commonMain
import io.ktor.client.*
import io.ktor.client.engine.*
import io.ktor.client.engine.okhttp.*
import io.ktor.client.engine.darwin.*

expect fun httpClientEngine(): HttpClientEngine

val client = HttpClient(httpClientEngine()) {
  install(JsonFeature) { serializer = KotlinxSerializer() }
}

data class Post(val id: Int, val title: String, val body: String)

suspend fun fetchPosts(): List<Post> {
  return client.get("https://jsonplaceholder.typicode.com/posts")
}

// androidMain
actual fun httpClientEngine() = OkHttpClientEngine()

// iosMain
actual fun httpClientEngine() = DarwinClientEngine()''',
        hasImage: true,
      ),
      AppLesson(
        title: 'Database with SQLDelight',
        body: 'SQLDelight is a multiplatform SQLite library. Define your schema in .sq files, and SQLDelight generates Kotlin code for type-safe queries. Support for coroutines and flows.\n\nCreate a Note table and implement CRUD operations in common. Platform-specific drivers: Android uses AndroidSQLiteDriver, iOS uses NativeSQLiteDriver.\n\nBuild a notes app that shares the entire data layer. This shows how to manage persistence across platforms with a single codebase.',
        codeSnippet: '''// shared/src/commonMain/sqldelight/com/example/shared/Note.sq
CREATE TABLE note (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL,
  content TEXT NOT NULL
);

insert:
INSERT INTO note(title, content) VALUES(?, ?);

selectAll:
SELECT * FROM note;

// commonMain Database
class Database(driver: SqlDriver) {
  private val queries = NoteQueries(driver)
  fun insertNote(title: String, content: String) {
    queries.insert(title, content)
  }
  fun getAllNotes(): List<Note> = queries.selectAll().executeAsList()
}

// androidMain driver
val driver = AndroidSqliteDriver(Database.Schema, context, "notes.db")
val db = Database(driver)

// iosMain driver
val driver = NativeSqliteDriver(Database.Schema, "notes.db")''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Coroutines and Flow in KMM',
        body: 'Kotlin coroutines and Flow are available in KMM. You\'ll use them for asynchronous operations, combining multiple APIs, and reactive streams.\n\nImplement a use case that fetches data from two endpoints and merges results using flow. Handle threading with Dispatchers (platform-specific).\n\nThis lesson ensures you can write non-blocking, reactive code that works on both platforms.',
        codeSnippet: '''// commonMain
suspend fun fetchCombinedData(): CombinedData {
  val posts = async { fetchPosts() }
  val users = async { fetchUsers() }
  return CombinedData(posts.await(), users.await())
}

fun observeNotes(): Flow<List<Note>> {
  return flow {
    while (true) {
      emit(db.getAllNotes())
      delay(5000)
    }
  }
}

// Dispatchers
expect val MainDispatcher: CoroutineDispatcher
actual val MainDispatcher = Dispatchers.Main // Android
actual val MainDispatcher = Dispatchers.Main // iOS (uses NSOperationQueue)''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Professional Context: KMM in Industry',
        body: 'KMM is adopted by companies like Netflix, Pinterest, and Philips to share business logic and reduce development time. It\'s not a silver bullet; decide when to use it.\n\nLearn about the trade-offs: increased build complexity, debugging, and learning curve. Understand the current state of KMM and its roadmap.\n\nWe\'ll discuss real-world case studies and the future of multiplatform development. This lesson prepares you to advocate for KMM in your organisation.',
        codeSnippet: '''// When to use KMM:
// - Complex business logic that benefits from sharing
// - Strong Kotlin expertise on the team
// - When you want to reduce code duplication > 60%
// - When you can afford the initial setup time

// When not:
// - UI-heavy with platform-specific interactions
// - Small apps with simple logic
// - Team unfamiliar with Kotlin''',
        hasImage: true,
      ),
      AppLesson(
        title: 'Testing in KMM (Common and Platform Tests)',
        body: 'Write unit tests in commonMain using kotlin.test. Platform-specific tests can run on JVM or iOS simulator. Use mocking (mockk) for dependencies.\n\nTest the networking layer with a mock engine. Test database operations with an in-memory driver.\n\nSet up a CI pipeline to run common and platform tests. This ensures your shared code works on both platforms.',
        codeSnippet: '''// commonTest
class GreetingTest {
  @Test
  fun testHello() {
    val greeting = Greeting()
    assertEquals("Hello from KMM", greeting.sayHello())
  }
}

// Mocking with mockk (common)
val mockApi = mockk<ApiService>()
every { mockApi.fetch() } returns listOf(Post(1, "title", "body"))

// Platform-specific test (Android)
@Test
fun androidSpecific() {
  // Use Android context
}''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Common Pitfalls and Debugging KMM',
        body: 'KMM debugging can be tricky: iOS debugging requires Xcode, Android uses Android Studio. Learn to use breakpoints in both. Common issues: serialization, concurrency, and memory management.\n\nAvoid using Java-specific classes in common. Watch out for iOS memory leaks due to strong references. Use expected/actual for platform-specific utilities.\n\nWe\'ll troubleshoot a broken KMM app, fixing serialization errors and threading issues. This gives you practical debugging skills.',
        codeSnippet: '''// Pitfall: using Java's UUID in common (not available)
// Use kotlin.uuid or expect/actual

// Pitfall: not handling cancellation in coroutines
try {
  val result = api.fetch()
} catch (e: CancellationException) {
  // handle cancellation
}

// Debugging tip: add logging in common
println("Debug: $data") // works on both platforms''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Mini Project: Fitness Tracker with KMM',
        body: 'Build a fitness tracker that shares the entire data and business logic across platforms. Features: user authentication (using Ktor), step counter (using sensors via expect/actual), workout history (SQLDelight), and weekly summary.\n\nImplement a common ViewModel (using MVI) and platform-specific UI (Compose for Android, SwiftUI for iOS). Use Koin for DI in common.\n\nThis project demonstrates the full power of KMM: sharing logic while maintaining native UI. It\'s a showcase of your multiplatform expertise.',
        codeSnippet: '''// Shared ViewModel
class FitnessViewModel(
  private val repository: FitnessRepository
) {
  private val _state = MutableStateFlow(FitnessState())
  val state = _state.asStateFlow()
  
  suspend fun loadSteps() {
    val steps = repository.getSteps()
    _state.update { it.copy(steps = steps) }
  }
}

// Android Compose UI
@Composable
fun FitnessScreen(viewModel: FitnessViewModel) {
  val state by viewModel.state.collectAsState()
  Text("Steps: ${state.steps}")
}

// iOS SwiftUI
struct FitnessView: View {
  @ObservedObject var viewModel: FitnessViewModel
  var body: some View {
    Text("Steps: \(viewModel.state.steps)")
  }
}''',
        hasImage: false,
      ),
    ],
  ),

  // Course 7: Cross-Platform with .NET MAUI - Intermediate
  AppCourse(
    id: 'mobile_development_maui',
    title: '.NET MAUI: Build Mobile & Desktop Apps with C#',
    description: 'Develop cross-platform applications using .NET MAUI (Multi-platform App UI) with C# and XAML. Covers MVVM, navigation, services, and a full e-commerce app.',
    instructor: 'Emeka Okafor',
    category: 'mobile development',
    difficulty: 'Intermediate',
    icon: Icons.network_wifi,
    color: Colors.teal,
    duration: '12 hours',
    lessons: [
      AppLesson(
        title: 'Introduction to .NET MAUI and C# Basics',
        body: '.NET MAUI is a framework for building mobile and desktop apps with a single project. It uses C# and XAML for UI. You\'ll install Visual Studio 2022 and create your first MAUI app.\n\nLearn C# essentials: classes, properties, events, async/await, LINQ, and dependency injection. Understand the MAUI lifecycle and the single project structure.\n\nRun the default template on Android and iOS. This lesson gets you started with the Microsoft ecosystem.',
        codeSnippet: '''// C# basics
public class Greeting {
  public string SayHello() => "Hello from MAUI";
}

// MainPage.xaml
<ContentPage xmlns="http://schemas.microsoft.com/dotnet/2021/maui"
             xmlns:x="http://schemas.microsoft.com/winfx/2009/xaml">
  <Label Text="Welcome to MAUI" />
</ContentPage>''',
        hasImage: true,
      ),
      AppLesson(
        title: 'XAML and Data Binding',
        body: 'XAML is a declarative UI language. You\'ll design layouts using Grid, StackLayout, and ScrollView. Data binding connects UI to ViewModels using Binding and INotifyPropertyChanged.\n\nImplement a simple login page with Entry and Button, bind to a ViewModel. Use commands for button actions.\n\nLearn to use converters for formatting. Data binding is the heart of MAUI development.',
        codeSnippet: '''// ViewModel
public class LoginViewModel : INotifyPropertyChanged {
  private string _email;
  public string Email { get => _email; set => SetProperty(ref _email, value); }
  public ICommand LoginCommand { get; }
  public LoginViewModel() {
    LoginCommand = new Command(OnLogin);
  }
  void OnLogin() { /* logic */ }
}

// XAML
<Entry Text="{Binding Email}" Placeholder="Email" />
<Button Text="Login" Command="{Binding LoginCommand}" />''',
        hasImage: false,
      ),
      AppLesson(
        title: 'MVVM and Dependency Injection',
        body: 'MVVM (Model-View-ViewModel) is the standard architecture for MAUI. You\'ll use a DI container (Microsoft.Extensions.DependencyInjection) to register services and ViewModels.\n\nRegister a service for data access, and inject it into your ViewModel. This promotes testability and decoupling.\n\nImplement a simple product list with a service fetching data from a mock API. This is similar to professional MAUI projects.',
        codeSnippet: '''// Service
public interface IProductService {
  Task<List<Product>> GetProductsAsync();
}
public class ProductService : IProductService { /* implementation */ }

// App.xaml.cs
public App() {
  Services.AddSingleton<IProductService, ProductService>();
  Services.AddTransient<ProductsViewModel>();
}

// ViewModel
public class ProductsViewModel {
  private readonly IProductService _productService;
  public ProductsViewModel(IProductService productService) {
    _productService = productService;
  }
}''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Navigation and Shell',
        body: 'MAUI provides Shell for app-level navigation. You define routes and use GoToAsync. Learn to pass parameters via query properties.\n\nCreate a tabbed app with Home, Search, and Profile. Use Shell hierarchy for nested pages.\n\nImplement a detail page that receives a product ID. This navigation pattern is used in all MAUI apps.',
        codeSnippet: '''// AppShell.xaml
<Shell>
  <TabBar>
    <Tab Title="Home" Icon="home.png">
      <ShellContent ContentTemplate="{DataTemplate local:HomePage}" />
    </Tab>
    <Tab Title="Profile" Icon="profile.png">
      <ShellContent ContentTemplate="{DataTemplate local:ProfilePage}" />
    </Tab>
  </TabBar>
</Shell>

// Navigation
await Shell.Current.GoToAsync($"productdetails?id={productId}");

// ProductDetails page
[QueryProperty(nameof(Id), "id")]
public partial class ProductDetailsPage : ContentPage {
  public string Id { get; set; }
}''',
        hasImage: true,
      ),
      AppLesson(
        title: 'Networking with HttpClient and JSON',
        body: 'Use HttpClient for API calls. Deserialize JSON with System.Text.Json. Handle errors and timeouts.\n\nFetch products from a REST API and display in a CollectionView. Implement pull-to-refresh and infinite scrolling.\n\nThis lesson covers the networking stack used in production MAUI apps.',
        codeSnippet: '''public class ProductService : IProductService {
  private readonly HttpClient _http;
  public ProductService() {
    _http = new HttpClient { BaseAddress = new Uri("https://api.example.com/") };
  }
  public async Task<List<Product>> GetProductsAsync() {
    var response = await _http.GetAsync("products");
    if (response.IsSuccessStatusCode) {
      var json = await response.Content.ReadAsStringAsync();
      return JsonSerializer.Deserialize<List<Product>>(json);
    }
    return new List<Product>();
  }
}''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Local Storage with SQLite and Preferences',
        body: 'MAUI uses SQLite for local storage. You\'ll use the SQLite-net package to define entities and perform CRUD. Preferences provides lightweight key-value storage.\n\nCreate a shopping cart table, save items, and retrieve. Use Preferences for user settings like theme.\n\nBuild a cart feature that persists across app restarts.',
        codeSnippet: '''// CartItem entity
[Table("Cart")]
public class CartItem {
  [PrimaryKey, AutoIncrement] public int Id { get; set; }
  public int ProductId { get; set; }
  public int Quantity { get; set; }
}

// Database
public class AppDatabase {
  private SQLiteAsyncConnection _db;
  public AppDatabase() {
    _db = new SQLiteAsyncConnection(Path.Combine(FileSystem.AppDataDirectory, "app.db"));
    _db.CreateTableAsync<CartItem>().Wait();
  }
  public Task<List<CartItem>> GetCart() => _db.Table<CartItem>().ToListAsync();
  public Task<int> SaveItem(CartItem item) => _db.InsertAsync(item);
}

// Preferences
Preferences.Set("theme", "dark");
var theme = Preferences.Get("theme", "light");''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Professional Context: MAUI in Enterprise',
        body: 'MAUI is often used in enterprise environments for line-of-business apps. Understand integration with Azure services, authentication (Azure AD), and offline sync.\n\nLearn about app lifecycle management: provisioning, code signing, and deployment to stores. Also know the community and support.\n\nWe\'ll discuss how MAUI fits in the .NET ecosystem, its strengths, and limitations. This prepares you for enterprise roles.',
        codeSnippet: '''// Azure AD authentication
public static MauiApp CreateMauiApp() {
  var builder = MauiApp.CreateBuilder();
  builder.Services.AddMsalAuthentication(options => {
    options.ClientId = "your-client-id";
    options.TenantId = "your-tenant-id";
  });
  return builder.Build();
}''',
        hasImage: true,
      ),
      AppLesson(
        title: 'Common Mistakes and Debugging',
        body: 'Common issues: binding errors, threading (UI thread), and memory leaks. Use the debugger, inspect visual tree, and use logging.\n\nLearn to use the Hot Reload and XAML preview. Avoid blocking the UI thread with async operations.\n\nWe\'ll debug a broken app: fix a ListView not updating, a command not firing, and a navigation crash. This hands-on debugging is invaluable.',
        codeSnippet: '''// Fix: binding path error - ensure property name matches
// Fix: use async/await with await, not .Result
private async void OnRefresh() {
  await LoadData(); // not .Result
}

// Memory leak: remove event handlers in OnDisappearing
protected override void OnDisappearing() {
  base.OnDisappearing();
  SomeEvent -= Handler;
}''',
        hasImage: false,
      ),
      AppLesson(
        title: 'Mini Project: E-Commerce App with Cart and Checkout',
        body: 'Build a full e-commerce app with product listing, details, cart, and checkout. Use MVVM, DI, HttpClient, SQLite, and Shell navigation.\n\nImplement a product search, add to cart, update quantities, and simulate checkout with a payment screen. Save order history in local DB.\n\nThis project is comprehensive and demonstrates all MAUI concepts. It\'s a strong portfolio piece showing cross-platform capability.',
        codeSnippet: '''// CartViewModel
public class CartViewModel : BaseViewModel {
  private readonly IProductService _productService;
  private readonly AppDatabase _database;
  public ObservableCollection<CartItem> Items { get; set; }
  public ICommand CheckoutCommand { get; }
  public CartViewModel(IProductService productService, AppDatabase database) {
    _productService = productService;
    _database = database;
    CheckoutCommand = new Command(OnCheckout);
    LoadItems();
  }
  async void LoadItems() {
    var items = await _database.GetCart();
    Items = new ObservableCollection<CartItem>(items);
  }
  async void OnCheckout() {
    // Process payment
    await Shell.Current.GoToAsync("checkout");
  }
}''',
        hasImage: false,
      ),
    ],
  ),
];
