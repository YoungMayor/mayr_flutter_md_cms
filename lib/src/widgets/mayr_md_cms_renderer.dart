import 'package:flutter/material.dart';
import 'package:mayr_md_cms/mayr_md_cms.dart';
import 'package:mayr_md_cms/src/widgets/mayr_md_cms_markdown_renderer.dart';

/// Widget that handles the lifecycle of loading and rendering markdown content.
///
/// This widget manages three states:
/// 1. Loading: Displays a loading indicator while content is being fetched
/// 2. Error: Displays an error message if content loading fails
/// 3. Empty: Displays an empty state if no content is available
/// 4. Success: Renders the markdown content
///
/// The appearance of each state can be customized through [MayrMdCmsConfig].
class MayrMdCmsRenderer extends StatelessWidget {
  /// Creates a markdown renderer widget.
  ///
  /// The [future] function should return markdown content as a string.
  /// The [config] defines the behavior and appearance of the renderer.
  const MayrMdCmsRenderer({
    super.key,
    required this.future,
    required this.config,
  });

  /// Function that returns a Future resolving to markdown content.
  final Future<String> Function() future;

  /// Configuration for customizing the renderer behavior and appearance.
  final MayrMdCmsConfig config;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: future(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return config.loadingWidget ?? _defaultLoadingWidget();
        } else if (snapshot.hasError) {
          return config.errorWidget ?? _defaultErrorWidget();
        } else if (!snapshot.hasData || snapshot.data == null) {
          return config.emptyWidget ?? _defaultEmptyWidget();
        } else {
          return MayrMdCmsMarkdownRenderer(
            content: snapshot.data!,
            config: config,
          );
        }
      },
    );
  }

  /// Default loading widget displayed while content is being fetched.
  Widget _defaultLoadingWidget() {
    return const Center(child: CircularProgressIndicator());
  }

  /// Default error widget displayed when content loading fails.
  Widget _defaultErrorWidget() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Failed to load content"),
        ],
      ),
    );
  }

  /// Default empty widget displayed when no content is available.
  Widget _defaultEmptyWidget() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Empty Content"),
        ],
      ),
    );
  }
}
