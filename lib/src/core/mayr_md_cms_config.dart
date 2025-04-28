import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:mayr_md_cms/src/core/mayr_md_cms_types.dart';
import 'package:mayr_md_cms/src/core/tools/extensions.dart';

final class MayrMdCmsConfig {
  final Widget? emptyWidget;
  final Widget? errorWidget;
  final Widget? loadingWidget;

  final bool shrinkWrap;

  final bool useDefaultStyleSheet;

  final ScrollPhysics? scrollPhysics;

  final MarkdownStyleSheet? markdownStyleSheet;

  final InternalPages internalPages;

  const MayrMdCmsConfig({
    this.errorWidget,
    this.loadingWidget,
    this.emptyWidget,
    this.shrinkWrap = false,
    this.useDefaultStyleSheet = false,
    this.scrollPhysics = const NeverScrollableScrollPhysics(),
    this.markdownStyleSheet,
    this.internalPages = const {},
  });

  MarkdownStyleSheet markdownStyleSheetToUse(BuildContext context) =>
      markdownStyleSheet ?? _defaultMarkdownStyleSheet(context);

  MarkdownStyleSheet _defaultMarkdownStyleSheet(BuildContext context) =>
      MarkdownStyleSheet.fromTheme(context.theme);
}
