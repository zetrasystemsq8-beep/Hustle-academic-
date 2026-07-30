/// Metadata for a single advanced-user starter template. Templates are
/// locked by default — beginners always start from the three blank
/// files created by [ProjectController.createBlankProject].
class WebLabTemplate {
  final String id;
  final String title;
  final String description;
  final String category;
  final Map<String, String> files;

  const WebLabTemplate({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.files,
  });
}

/// Central registry of all templates available to advanced/unlocked
/// users. Each template supplies a minimal, valid starting point (never
/// a finished solution) that gives structure without replacing the
/// learning the student still has to do.
class TemplateRegistry {
  TemplateRegistry._();

  static final List<WebLabTemplate> all = [
    WebLabTemplate(
      id: 'portfolio',
      title: 'Portfolio',
      description: 'A personal portfolio starting point with sections for about, projects, and contact.',
      category: 'Personal',
      files: {
        'index.html': '''<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>My Portfolio</title>
  <link rel="stylesheet" href="style.css">
</head>
<body>
  <header>
    <h1>Your Name</h1>
    <nav>
      <a href="#about">About</a>
      <a href="#projects">Projects</a>
      <a href="#contact">Contact</a>
    </nav>
  </header>

  <section id="about">
    <!-- Write your introduction here -->
  </section>

  <section id="projects">
    <!-- List your projects here -->
  </section>

  <section id="contact">
    <!-- Add your contact details or a form here -->
  </section>

  <script src="script.js"></script>
</body>
</html>''',
        'style.css': '''/* Start styling your portfolio here */
body {
  font-family: sans-serif;
  margin: 0;
}

header {
  padding: 24px;
}
''',
        'script.js': '''// Add interactivity for your portfolio here
''',
      },
    ),
    WebLabTemplate(
      id: 'restaurant',
      title: 'Restaurant',
      description: 'A restaurant site starting point with a menu and hours section.',
      category: 'Business',
      files: {
        'index.html': '''<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Restaurant Name</title>
  <link rel="stylesheet" href="style.css">
</head>
<body>
  <header>
    <h1>Restaurant Name</h1>
  </header>

  <section id="menu">
    <h2>Menu</h2>
    <!-- Add your menu items here -->
  </section>

  <section id="hours">
    <h2>Hours</h2>
    <!-- Add opening hours here -->
  </section>

  <script src="script.js"></script>
</body>
</html>''',
        'style.css': '''body {
  font-family: serif;
  margin: 0;
}
''',
        'script.js': '''// Add menu filtering or interactivity here
''',
      },
    ),
    WebLabTemplate(
      id: 'landing_page',
      title: 'Landing Page',
      description: 'A single-page product landing page starting point.',
      category: 'Marketing',
      files: {
        'index.html': '''<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Product Landing Page</title>
  <link rel="stylesheet" href="style.css">
</head>
<body>
  <section id="hero">
    <h1>Your Product Name</h1>
    <p>Your tagline goes here.</p>
    <button id="cta-button">Get Started</button>
  </section>

  <section id="features">
    <!-- Add feature blocks here -->
  </section>

  <script src="script.js"></script>
</body>
</html>''',
        'style.css': '''body {
  font-family: sans-serif;
  margin: 0;
  text-align: center;
}
''',
        'script.js': '''// Wire up the CTA button here
''',
      },
    ),
    WebLabTemplate(
      id: 'dashboard',
      title: 'Dashboard',
      description: 'An admin-style dashboard starting point with a sidebar and content area.',
      category: 'Application',
      files: {
        'index.html': '''<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Dashboard</title>
  <link rel="stylesheet" href="style.css">
</head>
<body>
  <div class="layout">
    <aside id="sidebar">
      <!-- Add navigation links here -->
    </aside>
    <main id="content">
      <!-- Add dashboard widgets here -->
    </main>
  </div>

  <script src="script.js"></script>
</body>
</html>''',
        'style.css': '''.layout {
  display: flex;
}

#sidebar {
  width: 220px;
}

#content {
  flex: 1;
}
''',
        'script.js': '''// Add dashboard logic here
''',
      },
    ),
    WebLabTemplate(
      id: 'ecommerce',
      title: 'E-commerce',
      description: 'A product listing starting point with a cart placeholder.',
      category: 'Business',
      files: {
        'index.html': '''<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Shop</title>
  <link rel="stylesheet" href="style.css">
</head>
<body>
  <header>
    <h1>Shop</h1>
    <div id="cart-count">Cart (0)</div>
  </header>

  <section id="products">
    <!-- Add product cards here -->
  </section>

  <script src="script.js"></script>
</body>
</html>''',
        'style.css': '''#products {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(160px, 1fr));
  gap: 16px;
}
''',
        'script.js': '''// Add cart logic here
let cartCount = 0;
''',
      },
    ),
    WebLabTemplate(
      id: 'blog',
      title: 'Blog',
      description: 'A blog starting point with a post list and article layout.',
      category: 'Content',
      files: {
        'index.html': '''<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>My Blog</title>
  <link rel="stylesheet" href="style.css">
</head>
<body>
  <header>
    <h1>My Blog</h1>
  </header>

  <main id="posts">
    <!-- Add blog post previews here -->
  </main>

  <script src="script.js"></script>
</body>
</html>''',
        'style.css': '''body {
  font-family: Georgia, serif;
  max-width: 700px;
  margin: 0 auto;
}
''',
        'script.js': '''// Add post filtering or search here
''',
      },
    ),
    WebLabTemplate(
      id: 'business',
      title: 'Business Website',
      description: 'A general business website starting point with services and about sections.',
      category: 'Business',
      files: {
        'index.html': '''<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Business Name</title>
  <link rel="stylesheet" href="style.css">
</head>
<body>
  <header>
    <h1>Business Name</h1>
    <nav>
      <a href="#services">Services</a>
      <a href="#about">About</a>
      <a href="#contact">Contact</a>
    </nav>
  </header>

  <section id="services">
    <!-- List your services here -->
  </section>

  <section id="about">
    <!-- Describe your business here -->
  </section>

  <section id="contact">
    <!-- Add contact info here -->
  </section>

  <script src="script.js"></script>
</body>
</html>''',
        'style.css': '''body {
  font-family: sans-serif;
  margin: 0;
}
''',
        'script.js': '''// Add form validation or interactivity here
''',
      },
    ),
  ];

  static WebLabTemplate? findById(String id) {
    try {
      return all.firstWhere((t) => t.id == id);
    } catch (_) {
      return null;
    }
  }
}
