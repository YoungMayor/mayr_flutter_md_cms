import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mayr_md_cms/mayr_md_cms.dart';

extension MdCmsStringExtension on String {
  /// Copies the string to clipboard
  void copyToClipboard() async =>
      await Clipboard.setData(ClipboardData(text: this));

  /// Covert the string (href) to Uri
  Uri get toUri => Uri.parse(this);

  /// To SnackBar
  SnackBar toSnackBar() => SnackBar(content: Text(this));
}

extension MdCmsContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  NavigatorState get navigator => Navigator.of(this);

  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);

  snackText(String content) {
    if (mounted) scaffoldMessenger.showSnackBar(content.toSnackBar());
  }
}

extension MdCmsConfigExtension on MayrMdCmsConfig? {
  MayrMdCmsConfig get orDefault => this ?? MayrMdCmsConfig();
}
