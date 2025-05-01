import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:mayr_md_cms/mayr_md_cms.dart';
import 'package:mayr_md_cms/src/core/tools/extensions.dart';
import 'package:url_launcher/url_launcher.dart';

class MayrMdCmsMarkdownRenderer extends StatelessWidget {
  const MayrMdCmsMarkdownRenderer({
    super.key,
    required this.content,
    required this.config,
  });

  final String content;
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

  Future _onTapLink(
    String text,
    String? href,
    String title,
    BuildContext context,
  ) async {
    if (href == null || href.isEmpty) return;

    if (href.startsWith("internal:")) {
      if (!config.internalActions.containsKey(href)) return;

      config.internalActions[href]!(context);

      return;
    }

    Uri url = href.toUri;

    bool canLaunch = await canLaunchUrl(url);

    if (canLaunch) return launchUrl(url, mode: LaunchMode.externalApplication);

    if (!context.mounted) return;

    href.copyToClipboard();

    context.snackText("Link copied to clipboard");
  }
}
