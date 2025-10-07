import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mayr_md_cms/mayr_md_cms.dart';

/// Extension methods for String to provide common operations.
extension MdCmsStringExtension on String {
  /// Copies the string to the system clipboard.
  ///
  /// Example:
  /// ```dart
  /// 'Hello World'.copyToClipboard();
  /// ```
  void copyToClipboard() async =>
      await Clipboard.setData(ClipboardData(text: this));

  /// Converts the string to a Uri object.
  ///
  /// Example:
  /// ```dart
  /// Uri url = 'https://example.com'.toUri;
  /// ```
  Uri get toUri => Uri.parse(this);

  /// Converts the string to a SnackBar widget.
  ///
  /// Example:
  /// ```dart
  /// SnackBar snackBar = 'Message'.toSnackBar();
  /// ```
  SnackBar toSnackBar() => SnackBar(content: Text(this));
}

/// Extension methods for BuildContext to provide common operations.
extension MdCmsContextExtension on BuildContext {
  /// Returns the current ThemeData.
  ThemeData get theme => Theme.of(this);

  /// Returns the NavigatorState for this context.
  NavigatorState get navigator => Navigator.of(this);

  /// Returns the ScaffoldMessengerState for this context.
  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);

  /// Displays a snackbar with the given text content.
  ///
  /// Only shows the snackbar if the context is still mounted.
  ///
  /// Example:
  /// ```dart
  /// context.snackText('Operation completed');
  /// ```
  snackText(String content) {
    if (mounted) scaffoldMessenger.showSnackBar(content.toSnackBar());
  }
}

/// Extension methods for MayrMdCmsConfig to provide default values.
extension MdCmsConfigExtension on MayrMdCmsConfig? {
  /// Returns this config if not null, otherwise returns a default config.
  ///
  /// Example:
  /// ```dart
  /// MayrMdCmsConfig config = nullableConfig.orDefault;
  /// ```
  MayrMdCmsConfig get orDefault => this ?? MayrMdCmsConfig();
}
