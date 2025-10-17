import 'package:dio/dio.dart';
import 'package:mayr_md_cms/mayr_md_cms.dart';
import 'package:mayr_md_cms/src/tools/loaders.dart';
import 'package:mayr_md_cms/src/widgets/mayr_md_cms_renderer.dart';

/// Base class for creating custom markdown CMS implementations.
///
/// This abstract class provides a foundation for extending the MayrMdCms
/// functionality with custom configurations. Extend this class to create
/// your own specialized markdown CMS with predefined settings.
///
/// Example:
/// ```dart
/// class MyCustomMdCms extends MayrMdCmsBase {
///   @override
///   MayrMdCmsConfig get config => MayrMdCmsConfig(
///     loadingWidget: MyLoadingWidget(),
///     errorWidget: MyErrorWidget(),
///   );
/// }
///
/// // Usage
/// MyCustomMdCms().local('assets/content.md');
/// MyCustomMdCms().network('https://example.com/content.md');
/// ```
abstract class MayrMdCmsBase {
  /// Configuration for the markdown CMS.
  ///
  /// Override this getter to provide custom configuration for all
  /// markdown renderers created by this instance.
  MayrMdCmsConfig get config;

  /// Creates a renderer that loads markdown content from a local asset file.
  ///
  /// The [path] should be the asset path as defined in pubspec.yaml.
  MayrMdCmsRenderer local(String path) => MayrMdCmsRenderer(
    future: () async => Loaders.fromLocal(path),
    config: config,
  );

  /// Creates a renderer that loads markdown content from a network URL.
  ///
  /// The [href] should be a valid URL to the markdown content.
  /// Optional [dioClient] can be provided for custom network configurations.
  MayrMdCmsRenderer network(String href, {Dio? dioClient}) {
    return MayrMdCmsRenderer(
      future: () async => Loaders.fromNetwork(href, dioClient: dioClient),
      config: config,
    );
  }

  /// Creates a renderer that loads markdown content from a custom async function.
  ///
  /// The [callback] function should return a Future that resolves to markdown content.
  MayrMdCmsRenderer custom(Future<String> Function() callback) =>
      MayrMdCmsRenderer(future: callback, config: config);
}
