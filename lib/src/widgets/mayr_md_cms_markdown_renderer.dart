import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:mayr_md_cms/mayr_md_cms.dart';
import 'package:mayr_md_cms/src/tools/extensions.dart';
import 'package:url_launcher/url_launcher.dart';

/// Prefix used to identify internal action links in markdown.
const String _internalActionPrefix = 'internal:';

/// Message displayed when a link is copied to clipboard.
const String _linkCopiedMessage = 'Link copied to clipboard';

/// Widget that renders markdown content and handles link interactions.
///
/// This widget uses the flutter_markdown package to render markdown content
/// and provides automatic link handling:
/// - Internal links (starting with 'internal:') trigger custom actions
/// - Valid URLs are opened in an external browser
/// - Invalid URLs are copied to the clipboard with a notification
class MayrMdCmsMarkdownRenderer extends StatelessWidget {
  /// Creates a markdown renderer widget.
  ///
  /// The [content] should be valid markdown text.
  /// The [config] defines the styling and behavior of the renderer.
  const MayrMdCmsMarkdownRenderer({
    super.key,
    required this.content,
    required this.config,
  });

  /// The markdown content to render.
  final String content;

  /// Configuration for customizing the renderer.
  final MayrMdCmsConfig config;

  @override
  Widget build(BuildContext context) {
    return Markdown(
      data: content,
      shrinkWrap: config.shrinkWrap,
      physics: config.scrollPhysics,
      styleSheet: config.markdownStyleSheetToUse(context),
      onTapLink: (text, href, title) => _onTapLink(text, href, title, context),
    );
  }

  /// Handles link taps in the markdown content.
  ///
  /// Link handling logic:
  /// 1. If href is null or empty, do nothing
  /// 2. If href starts with 'internal:', execute the corresponding internal action
  /// 3. If href is a valid URL, open it in an external browser
  /// 4. Otherwise, copy the href to clipboard and show a notification
  Future _onTapLink(
    String text,
    String? href,
    String title,
    BuildContext context,
  ) async {
    if (href == null || href.isEmpty) return;

    // Handle internal actions
    if (_isInternalAction(href)) {
      _handleInternalAction(href, context);
      return;
    }

    // Handle external URLs
    await _handleExternalUrl(href, context);
  }

  /// Checks if the href is an internal action link.
  bool _isInternalAction(String href) {
    return href.startsWith(_internalActionPrefix);
  }

  /// Executes the internal action associated with the href.
  void _handleInternalAction(String href, BuildContext context) {
    if (!config.internalActions.containsKey(href)) return;
    config.internalActions[href]!(context);
  }

  /// Handles external URL links.
  ///
  /// Attempts to open the URL in an external browser.
  /// If the URL cannot be launched, copies it to clipboard instead.
  Future<void> _handleExternalUrl(String href, BuildContext context) async {
    Uri url = href.toUri;
    bool canLaunch = await canLaunchUrl(url);

    if (canLaunch) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
      return;
    }

    // URL cannot be launched, copy to clipboard
    if (!context.mounted) return;
    href.copyToClipboard();
    context.snackText(_linkCopiedMessage);
  }
}
