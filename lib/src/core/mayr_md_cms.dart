import 'package:dio/dio.dart';
import 'package:mayr_md_cms/src/core/mayr_md_cms_config.dart';
import 'package:mayr_md_cms/src/tools/extensions.dart';
import 'package:mayr_md_cms/src/tools/loaders.dart';
import 'package:mayr_md_cms/src/widgets/mayr_md_cms_renderer.dart';

/// Main entry point for the Mayr Markdown CMS package.
///
/// Provides static factory methods to create markdown renderers from different sources:
/// - [local]: Load markdown from local asset files
/// - [network]: Load markdown from network URLs
/// - [custom]: Load markdown from custom async functions
///
/// Example:
/// ```dart
/// // From local asset
/// MayrMdCms.local('assets/content.md');
///
/// // From network
/// MayrMdCms.network('https://example.com/content.md');
///
/// // From custom source
/// MayrMdCms.custom(() async => 'Custom markdown content');
/// ```
final class MayrMdCms {
  /// Creates a renderer that loads markdown content from a local asset file.
  ///
  /// The [path] should be the asset path as defined in pubspec.yaml.
  /// Optional [config] can be provided to customize the rendering behavior.
  ///
  /// Example:
  /// ```dart
  /// MayrMdCms.local('assets/content.md', config: MayrMdCmsConfig(...));
  /// ```
  static MayrMdCmsRenderer local(String path, {MayrMdCmsConfig? config}) {
    return MayrMdCmsRenderer(
      future: () => Loaders.fromLocal(path),
      config: config.orDefault,
    );
  }

  /// Creates a renderer that loads markdown content from a network URL.
  ///
  /// The [href] should be a valid URL to the markdown content.
  /// Optional [config] can be provided to customize the rendering behavior.
  /// Optional [dioClient] can be provided for custom network configurations (e.g., authentication).
  ///
  /// Example:
  /// ```dart
  /// MayrMdCms.network(
  ///   'https://example.com/content.md',
  ///   config: MayrMdCmsConfig(...),
  ///   dioClient: customDio,
  /// );
  /// ```
  static MayrMdCmsRenderer network(
    String href, {
    MayrMdCmsConfig? config,
    Dio? dioClient,
  }) {
    return MayrMdCmsRenderer(
      future: () async => Loaders.fromNetwork(href, dioClient: dioClient),
      config: config.orDefault,
    );
  }

  /// Creates a renderer that loads markdown content from a custom async function.
  ///
  /// The [callback] function should return a Future that resolves to markdown content.
  /// Optional [config] can be provided to customize the rendering behavior.
  ///
  /// Example:
  /// ```dart
  /// MayrMdCms.custom(
  ///   () async => fetchMarkdownFromDatabase(),
  ///   config: MayrMdCmsConfig(...),
  /// );
  /// ```
  static MayrMdCmsRenderer custom(
    Future<String> Function() callback, {
    MayrMdCmsConfig? config,
  }) => MayrMdCmsRenderer(future: callback, config: config.orDefault);
}
