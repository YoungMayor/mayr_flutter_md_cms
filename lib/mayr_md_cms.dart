/// Mayr Markdown CMS - A flexible Flutter widget for fetching and rendering Markdown content.
///
/// This package provides an easy way to fetch and display Markdown content from various sources:
/// - Local asset files
/// - Network URLs
/// - Custom async functions
///
/// Features:
/// - Built-in loading, error, and empty state handling
/// - Customizable widgets for all states
/// - Internal link actions for navigation
/// - Automatic URL handling
/// - Extensible architecture
///
/// Example usage:
/// ```dart
/// import 'package:mayr_md_cms/mayr_md_cms.dart';
///
/// // From local asset
/// MayrMdCms.local('assets/content.md');
///
/// // From network
/// MayrMdCms.network('https://example.com/content.md');
///
/// // With custom configuration
/// MayrMdCms.local(
///   'assets/content.md',
///   config: MayrMdCmsConfig(
///     loadingWidget: MyLoadingWidget(),
///     errorWidget: MyErrorWidget(),
///     internalActions: {
///       'internal:action': (context) => print('Action triggered'),
///     },
///   ),
/// );
/// ```
library;

export 'package:flutter_markdown/flutter_markdown.dart' show MarkdownStyleSheet;

export 'src/core/mayr_md_cms.dart';
export 'src/core/mayr_md_cms_base.dart';
export 'src/core/mayr_md_cms_config.dart';
export 'src/core/mayr_md_cms_types.dart';
export 'src/tools/extensions.dart';
