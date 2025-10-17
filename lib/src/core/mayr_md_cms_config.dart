import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:mayr_md_cms/src/core/mayr_md_cms_types.dart';
import 'package:mayr_md_cms/src/tools/extensions.dart';

/// Configuration class for customizing the Mayr Markdown CMS behavior.
///
/// This class allows you to customize various aspects of the markdown rendering:
/// - Custom widgets for different states (loading, error, empty)
/// - Markdown styling
/// - Scroll behavior
/// - Internal action handlers
///
/// Example:
/// ```dart
/// MayrMdCmsConfig(
///   loadingWidget: CircularProgressIndicator(),
///   errorWidget: Text('Failed to load'),
///   emptyWidget: Text('No content'),
///   shrinkWrap: true,
///   scrollPhysics: NeverScrollableScrollPhysics(),
///   markdownStyleSheet: MarkdownStyleSheet(...),
///   internalActions: {
///     'internal:action': (context) => print('Action triggered'),
///   },
/// )
/// ```
final class MayrMdCmsConfig {
  /// Widget to display when content is empty.
  final Widget? emptyWidget;

  /// Widget to display when an error occurs while loading content.
  final Widget? errorWidget;

  /// Widget to display while content is being loaded.
  final Widget? loadingWidget;

  /// Whether the markdown view should shrink-wrap its contents.
  final bool shrinkWrap;

  /// The physics for the scrollable markdown view.
  final ScrollPhysics? scrollPhysics;

  /// Custom stylesheet for markdown rendering.
  final MarkdownStyleSheet? markdownStyleSheet;

  /// Map of internal action handlers.
  ///
  /// Keys should match the format used in markdown links (e.g., 'internal:action_name').
  /// Values are callback functions that receive the BuildContext.
  final InternalActions internalActions;

  /// Creates a configuration for the Mayr Markdown CMS.
  const MayrMdCmsConfig({
    this.errorWidget,
    this.loadingWidget,
    this.emptyWidget,
    this.shrinkWrap = false,
    this.scrollPhysics = const NeverScrollableScrollPhysics(),
    this.markdownStyleSheet,
    this.internalActions = const {},
  });

  /// Returns the markdown stylesheet to use for rendering.
  ///
  /// If a custom [markdownStyleSheet] is provided, it will be used.
  /// Otherwise, a default stylesheet based on the current theme will be created.
  MarkdownStyleSheet markdownStyleSheetToUse(BuildContext context) =>
      markdownStyleSheet ?? _defaultMarkdownStyleSheet(context);

  /// Creates a default markdown stylesheet from the current theme.
  MarkdownStyleSheet _defaultMarkdownStyleSheet(BuildContext context) =>
      MarkdownStyleSheet.fromTheme(context.theme);
}
