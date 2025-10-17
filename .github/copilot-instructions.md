# GitHub Copilot Instructions for mayr_md_cms

## Project Overview

**mayr_md_cms** is a Flutter package that provides a flexible widget for fetching and rendering Markdown content from multiple sources (local assets, network URLs, or custom futures). It includes built-in loading and error handling, customizable styling, and support for internal link actions.

**Organization**: MayR Labs
- Website: https://mayrlabs.com
- GitHub: https://github.com/MayR-Labs

## Code Style and Conventions

### General Principles
- Follow **KISS** (Keep It Simple, Stupid)
- Follow **DRY** (Don't Repeat Yourself)
- Follow **SRP** (Single Responsibility Principle)
- Follow **SOC** (Separation of Concerns)
- Write clean, maintainable, and well-documented code

### Dart/Flutter Conventions
- Use `lowerCamelCase` for variable, method, and parameter names
- Use `UpperCamelCase` for class, enum, and typedef names
- Use `lowercase_with_underscores` for library and file names
- Prefer `final` over `var` when variables won't be reassigned
- Use trailing commas for better formatting
- Follow the official [Dart style guide](https://dart.dev/guides/language/effective-dart/style)

### Documentation
- **All public APIs MUST have documentation comments** using `///`
- Include examples in documentation where appropriate
- Document all parameters, return values, and exceptions
- Use proper markdown formatting in doc comments

Example:
```dart
/// Fetches and displays Markdown content from a network URL.
///
/// The [url] parameter specifies the network location of the Markdown file.
///
/// The optional [config] allows customization of loading widgets, error handling,
/// and markdown styling.
///
/// Example:
/// ```dart
/// MayrMdCms.network(
///   'https://example.com/content.md',
///   config: MayrMdCmsConfig(shrinkWrap: true),
/// )
/// ```
factory MayrMdCms.network(String url, {MayrMdCmsConfig? config}) { ... }
```

### Code Organization

#### File Structure
```
lib/
├── mayr_md_cms.dart              # Main export file
└── src/
    ├── core/                     # Core functionality
    │   ├── mayr_md_cms.dart
    │   ├── mayr_md_cms_base.dart
    │   ├── mayr_md_cms_config.dart
    │   └── mayr_md_cms_types.dart
    ├── tools/                    # Utilities
    │   ├── extensions.dart
    │   └── loaders.dart
    └── widgets/                  # UI components
        ├── mayr_md_cms_renderer.dart
        └── mayr_md_cms_markdown_renderer.dart
```

#### Constants
- Define magic strings as constants to improve maintainability
- Place constants near where they're used or in a dedicated constants file

Example:
```dart
static const String _internalPrefix = 'internal:';
static const String _httpPrefix = 'http://';
static const String _httpsPrefix = 'https://';
```

### Testing

#### Test Coverage Requirements
- All public APIs must have tests
- All core functionality must have tests
- Widget tests for all widgets
- Unit tests for utilities and extensions
- Integration tests for complex workflows

#### Test Structure
```
test/
├── mayr_md_cms_test.dart         # Main integration tests
├── core/                         # Core tests
│   ├── mayr_md_cms_test.dart
│   ├── mayr_md_cms_base_test.dart
│   └── mayr_md_cms_config_test.dart
├── mocks/                        # Mock implementations
│   ├── mock_dio.dart
│   └── mock_dio.mocks.dart
├── tools/                        # Utility tests
│   ├── extensions_test.dart
│   └── loaders_test.dart
└── widgets/                      # Widget tests
    ├── mayr_md_cms_renderer_test.dart
    └── mayr_md_cms_markdown_renderer_test.dart
```

#### Test Naming
- Use descriptive test names that explain what is being tested
- Format: `'should [expected behavior] when [condition]'`

Example:
```dart
test('should load markdown from local asset when valid path provided', () async {
  // Test implementation
});
```

### Dependencies

#### Current Dependencies
- `dio`: HTTP client for network requests
- `flutter_markdown`: Markdown rendering
- `url_launcher`: Opening URLs in browser

#### Adding New Dependencies
- Only add dependencies that are necessary
- Prefer well-maintained packages with good pub.dev scores
- Document why the dependency is needed
- Update the README if it affects public API

### Error Handling

- Provide meaningful error messages
- Use custom error widgets that can be configured
- Handle all async operations with proper try-catch blocks
- Log errors appropriately for debugging

Example:
```dart
try {
  final response = await dio.get(url);
  return response.data;
} catch (e) {
  throw Exception('Failed to load markdown from network: $e');
}
```

### Breaking Changes

- Document all breaking changes in CHANGELOG.md
- Follow semantic versioning (MAJOR.MINOR.PATCH)
- Provide migration guides for breaking changes
- Use `@Deprecated` annotations before removing APIs

### Widget Development

#### Widget Guidelines
- Keep widgets focused on single responsibility
- Make widgets configurable through constructors
- Provide sensible defaults
- Use const constructors where possible
- Extract complex logic into separate methods or classes

Example:
```dart
class MayrMdCmsRenderer extends StatelessWidget {
  const MayrMdCmsRenderer({
    super.key,
    required this.future,
    this.config,
  });

  final Future<String> future;
  final MayrMdCmsConfig? config;

  // Widget build method
}
```

### Extension Methods

- Place extension methods in `src/tools/extensions.dart`
- Document what the extension provides
- Name extensions clearly (e.g., `MdCmsStringExtension`)

### Performance Considerations

- Use `const` constructors and widgets where possible
- Avoid unnecessary rebuilds
- Cache data when appropriate
- Use `shrinkWrap: true` sparingly

### Package Publishing

- Update version in `pubspec.yaml` following semver
- Update CHANGELOG.md with all changes
- Run `flutter analyze` and fix all issues
- Run all tests and ensure they pass
- Update documentation if needed
- Create a git tag for the release

## Common Tasks

### Adding a New Feature
1. Design the API (public methods/classes)
2. Write documentation comments
3. Implement the feature
4. Write comprehensive tests
5. Update CHANGELOG.md
6. Update README.md if it affects public API

### Fixing a Bug
1. Write a failing test that reproduces the bug
2. Fix the bug
3. Ensure the test passes
4. Update CHANGELOG.md
5. Consider if documentation needs updates

### Code Review Checklist
- [ ] All public APIs have documentation
- [ ] Tests cover new/changed code
- [ ] Code follows style guidelines
- [ ] No magic strings (use constants)
- [ ] Error handling is appropriate
- [ ] Breaking changes are documented
- [ ] CHANGELOG.md is updated
- [ ] README.md is updated if needed

## Links and Resources

- Package Repository: https://github.com/MayR-Labs/mayr_flutter_md_cms
- Issue Tracker: https://github.com/MayR-Labs/mayr_flutter_md_cms/issues
- Documentation: https://github.com/MayR-Labs/mayr_flutter_md_cms/wiki
- MayR Labs Website: https://mayrlabs.com
- MayR Labs GitHub: https://github.com/MayR-Labs
