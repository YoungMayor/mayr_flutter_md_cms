![License](https://img.shields.io/badge/license-MIT-blue.svg?label=Licence)
![Platform](https://img.shields.io/badge/Platform-Flutter-blue.svg)

![Pub Version](https://img.shields.io/pub/v/mayr_md_cms?style=plastic&label=Version)
![Pub.dev Score](https://img.shields.io/pub/points/mayr_md_cms?label=Score&style=plastic)
![Pub Likes](https://img.shields.io/pub/likes/mayr_md_cms?label=Likes&style=plastic)
![Pub.dev Publisher](https://img.shields.io/pub/publisher/mayr_md_cms?label=Publisher&style=plastic)
![Downloads](https://img.shields.io/pub/dm/mayr_md_cms.svg?label=Downloads&style=plastic)

![Build Status](https://img.shields.io/github/actions/workflow/status/YoungMayor/mayr_flutter_md_cms/ci.yaml?label=Build)
![Issues](https://img.shields.io/github/issues/YoungMayor/mayr_flutter_md_cms.svg?label=Issues)
![Last Commit](https://img.shields.io/github/last-commit/YoungMayor/mayr_flutter_md_cms.svg?label=Latest%20Commit)
![Contributors](https://img.shields.io/github/contributors/YoungMayor/mayr_flutter_md_cms.svg?label=Contributors)

- [📜 Mayr Markdown CMS](#-mayr-markdown-cms)
  - [🌟 Features](#-features)
  - [🚀 Getting started](#-getting-started)
  - [🚀 Usage](#-usage)
    - [1. Import the Package](#1-import-the-package)
    - [2. Fetch and Display Content](#2-fetch-and-display-content)
      - [From Local Asset:](#from-local-asset)
      - [From Network URL:](#from-network-url)
      - [Using a Custom Future:](#using-a-custom-future)
    - [3. Custom Link Handling](#3-custom-link-handling)
    - [4. Internal Page Navigation](#4-internal-page-navigation)
    - [5. Customisation](#5-customisation)
    - [6. Extend the Package](#6-extend-the-package)
  - [📢 Additional Information](#-additional-information)
    - [🤝 Contributing](#-contributing)
    - [🐛 Reporting Issues](#-reporting-issues)
    - [📜 Licence](#-licence)
  - [🌟 Support](#-support)



# 📜 Mayr Markdown CMS

*Fetch, Load, and Render Markdown — the Smart Way.*

`mayr_md_cms` is a powerful yet lightweight Flutter widget for fetching and displaying Markdown content from multiple sources:
- Local asset files 📂
- Network URLs 🌐
- Custom-defined futures ⚡

With built-in loading indicators, error handling, and smooth Markdown rendering, **mayr_md_cms** saves you from boilerplate and keeps your UI clean.

Whether you are building a blog, documentation app, or a CMS-driven mobile app, `mayr_md_cms` makes working with Markdown effortless!


## 🌟 Features
- Fetch and Render Markdown: Seamlessly fetch and display Markdown content from various sources like local assets, network URLs, or custom futures.

- Automatic Link Handling: Automatically handle link clicks within the Markdown:

  - Open valid URLs in the browser 🌐

  - Copy to clipboard for invalid links 📋

  - Option to let users define their custom link handling 🛠️

- Internal Pages Navigation: Add custom internal links in your Markdown (e.g., [About Us](internal:about_us)), and map them to custom pages (e.g., {'internal:about_us': AboutUsPage()}). Clicking such links will navigate to the respective page within your app.

- Fully Customisable:

  - Modify the loading widget 🌀

  - Customise the error widget ⚠️

  - Change the Markdown stylesheet (colors, fonts, etc.) 🎨

- Extendable: Create your own custom Markdown CMS by extending the base class:
    ```dart
    class CustomMdCms extends MayrMdCms {}
    ```
    Define your own custom behavior, UI components, and logic.

- Built-in Loading and Error Handling: Graceful fallbacks for loading content and error states 🛠️

- Flexible Content Source: Fetch content from various sources like:

  - Local assets using fromLocal()

  - Network URLs using fromNetwork()

  - Custom async functions using custom()

## 🚀 Getting started

1. Add `mayr_md_cms` to your `pubspec.yaml`:

    ```yaml
    dependencies:
        mayr_md_cms: # check for the latest version on pub.dev
    ```

2. Instal the package:
    ```bash
    flutter pub get
    ```

3. Import it into your Dart file:
    ```dart
    import 'package:mayr_md_cms/mayr_md_cms.dart';
    ```

> Alternatively, you could install it using the command
> ```bash
> flutter pub add mayr_md_cms
> ```


## 🚀 Usage

Here’s how to use MayrMdCms and display Markdown content in your Flutter app:

### 1. Import the Package
Import the package into your Dart file:

```dart
import 'package:mayr_md_cms/mayr_md_cms.dart';
```

### 2. Fetch and Display Content

#### From Local Asset:

If you have a Markdown file in your assets:

```dart
MayrMdCms.fromLocal('assets/content.md');
```

#### From Network URL:

If you want to fetch the Markdown content from a URL:

```dart
MayrMdCms.fromNetwork('https://example.com/content.md');
```

#### Using a Custom Future:

You can also pass a custom Future to fetch content, giving you full control over the data source:

```dart
MayrMdCms.custom(() async {
  // Custom async fetch logic
  return 'Your custom markdown content goes here';
});
```

### 3. Custom Link Handling

You can customize how links are handled. By default, valid URLs will open in a browser and invalid ones will copy to clipboard.

To handle the links manually, pass a custom link handler:

```dart
MayrMdCms.fromNetwork(
  'https://example.com/content.md',
  onLinkTap: (String url) {
    // Custom link handling
    print('Link tapped: $url');
  },
);
```

### 4. Internal Page Navigation

To create internal navigation in your app, define internal links in your Markdown (e.g., `[About Us](internal:about_us)`), and map them to your custom widgets:

```dart
MayrMdCms.fromNetwork(
  'https://example.com/content.md',
  internalLinks: {
    'internal:about_us': AboutUsPage(),
  },
);
```
Now, clicking on the About Us link will navigate to the `AboutUsPage` in your app!

### 5. Customisation

You can customise various parts of the widget such as:

- The loading widget

- The error widget

- The Markdown styling (CSS-like styling)

```dart
MayrMdCms.fromNetwork(
  'https://example.com/content.md',
  loadingWidget: CircularProgressIndicator(),
  errorWidget: Text('Failed to load content'),
  markdownStyles: {
    'h1': TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    'p': TextStyle(fontSize: 16),
  },
);
```

### 6. Extend the Package

For more control, you can create a custom class that extends MayrMdCms and override methods or add new logic:

```dart
class CustomMdCms extends MayrMdCms {
  // Custom logic here
}
```
Now you have full flexibility over the widget's behavior!


## 📢 Additional Information

### 🤝 Contributing
Contributions are highly welcome!
If you have ideas for new extensions, improvements, or fixes, feel free to fork the repository and submit a pull request.

Please make sure to:
- Follow the existing coding style.
- Write tests for new features.
- Update documentation if necessary.

> Let's build something amazing together!

---

### 🐛 Reporting Issues
If you encounter a bug, unexpected behaviour, or have feature requests:
- Open an issue on the repository.
- Provide a clear description and steps to reproduce (if it's a bug).
- Suggest improvements if you have any ideas.

> Your feedback helps make the package better for everyone!

---

### 📜 Licence
This package is licensed under the MIT License — which means you are free to use it for commercial and non-commercial projects, with proper attribution.

> See the [LICENSE](LICENSE) file for more details.

---

## 🌟 Support

If you find this package helpful, please consider giving it a ⭐️ on GitHub — it motivates and helps the project grow!

You can also support by:
- Sharing the package with your friends, colleagues, and tech communities.
- Using it in your projects and giving feedback.
- Contributing new ideas, features, or improvements.

> Every little bit of support counts! 🚀💙
