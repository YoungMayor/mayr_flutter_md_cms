import 'package:flutter/material.dart';
import 'package:mayr_md_cms/mayr_md_cms.dart';

/// Example demonstrating the usage of Mayr Markdown CMS package.
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mayr MD CMS Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mayr MD CMS Examples'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const LocalAssetExample(),
              ),
            ),
            child: const Text('Local Asset Example'),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const NetworkExample(),
              ),
            ),
            child: const Text('Network Example'),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const CustomSourceExample(),
              ),
            ),
            child: const Text('Custom Source Example'),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const InternalActionsExample(),
              ),
            ),
            child: const Text('Internal Actions Example'),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const CustomizedExample(),
              ),
            ),
            child: const Text('Customized Example'),
          ),
        ],
      ),
    );
  }
}

/// Example 1: Load markdown from local asset
class LocalAssetExample extends StatelessWidget {
  const LocalAssetExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Local Asset Example')),
      body: MayrMdCms.local('assets/demo_md.md'),
    );
  }
}

/// Example 2: Load markdown from network URL
class NetworkExample extends StatelessWidget {
  const NetworkExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Network Example')),
      body: MayrMdCms.network(
        'https://raw.githubusercontent.com/YoungMayor/mayr_flutter_md_cms/main/README.md',
      ),
    );
  }
}

/// Example 3: Load markdown from custom source
class CustomSourceExample extends StatelessWidget {
  const CustomSourceExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Custom Source Example')),
      body: MayrMdCms.custom(
        () async {
          // Simulate fetching from a database or custom source
          await Future.delayed(const Duration(seconds: 2));
          return '''
# Custom Markdown Content

This content was loaded from a **custom source**.

## Features
- ✅ Custom data fetching
- ✅ Async loading
- ✅ Full markdown support

### Code Example
```dart
MayrMdCms.custom(() async {
  return 'Your markdown content';
});
```

Visit [Flutter](https://flutter.dev) for more information.
''';
        },
      ),
    );
  }
}

/// Example 4: Using internal actions
class InternalActionsExample extends StatelessWidget {
  const InternalActionsExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Internal Actions Example')),
      body: MayrMdCms.custom(
        () async => '''
# Internal Actions Demo

Click on the links below to trigger actions:

- [Show Alert Dialog](internal:show_alert)
- [Navigate Back](internal:go_back)
- [Show Snackbar](internal:show_snackbar)

These links use the `internal:` prefix to trigger custom actions
instead of opening URLs.
''',
        config: MayrMdCmsConfig(
          internalActions: {
            'internal:show_alert': (context) {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Alert'),
                  content: const Text('Internal action triggered!'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
            'internal:go_back': (context) {
              Navigator.pop(context);
            },
            'internal:show_snackbar': (context) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Snackbar from internal action!'),
                ),
              );
            },
          },
        ),
      ),
    );
  }
}

/// Example 5: Fully customized appearance
class CustomizedExample extends StatelessWidget {
  const CustomizedExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Customized Example')),
      body: MayrMdCms.custom(
        () async {
          await Future.delayed(const Duration(seconds: 1));
          return '''
# Customized Styling

This example demonstrates custom styling options.

## Custom Features
- 🎨 Custom loading widget
- ⚠️ Custom error widget
- 📭 Custom empty widget
- 🖋️ Custom markdown stylesheet

Try changing the state to see different custom widgets!
''';
        },
        config: MayrMdCmsConfig(
          loadingWidget: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Loading markdown content...'),
              ],
            ),
          ),
          errorWidget: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 48, color: Colors.red),
                SizedBox(height: 16),
                Text('Oops! Something went wrong.'),
              ],
            ),
          ),
          emptyWidget: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.inbox_outlined, size: 48, color: Colors.grey),
                SizedBox(height: 16),
                Text('No content available.'),
              ],
            ),
          ),
          markdownStyleSheet: MarkdownStyleSheet(
            h1: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
            h2: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
            p: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}

/// Example 6: Extended custom class
class CustomMdCms extends MayrMdCmsBase {
  @override
  MayrMdCmsConfig get config => MayrMdCmsConfig(
        shrinkWrap: true,
        markdownStyleSheet: MarkdownStyleSheet(
          h1: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.purple,
          ),
        ),
        internalActions: {
          'internal:custom_action': (context) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Custom class action!'),
              ),
            );
          },
        },
      );
}

/// Example of using the custom class
class ExtendedClassExample extends StatelessWidget {
  const ExtendedClassExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Extended Class Example')),
      body: CustomMdCms().custom(
        () async => '''
# Extended Class Demo

This uses a custom class that extends `MayrMdCmsBase`.

All instances of this class will use the same configuration.

[Trigger Custom Action](internal:custom_action)
''',
      ),
    );
  }
}
