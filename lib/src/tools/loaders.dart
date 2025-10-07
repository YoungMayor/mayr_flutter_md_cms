import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

/// Utility class for loading markdown content from different sources.
class Loaders {
  /// Loads markdown content from a local asset file.
  ///
  /// The [path] should be the asset path as defined in pubspec.yaml.
  ///
  /// Example:
  /// ```dart
  /// String content = await Loaders.fromLocal('assets/content.md');
  /// ```
  static Future<String> fromLocal(String path) async =>
      rootBundle.loadString(path);

  /// Loads markdown content from a network URL.
  ///
  /// The [href] should be a valid URL to the markdown content.
  /// Optional [dioClient] can be provided for custom network configurations
  /// such as authentication, headers, or timeout settings.
  ///
  /// Example:
  /// ```dart
  /// String content = await Loaders.fromNetwork('https://example.com/content.md');
  /// ```
  static Future<String> fromNetwork(String href, {Dio? dioClient}) async =>
      (await (dioClient ?? Dio()).get(href)).data.toString();
}
