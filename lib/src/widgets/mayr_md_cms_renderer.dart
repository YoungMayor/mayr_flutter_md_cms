import 'package:flutter/material.dart';
import 'package:mayr_md_cms/mayr_md_cms.dart';
import 'package:mayr_md_cms/src/widgets/mayr_md_cms_markdown_renderer.dart';

class MayrMdCmsRenderer extends StatelessWidget {
  const MayrMdCmsRenderer({
    super.key,
    required this.future,
    required this.config,
  });

  final Future<String> Function() future;
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

  Widget _defaultLoadingWidget() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _defaultErrorWidget() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          Text("Failed to load content"),
        ],
      ),
    );
  }

  Widget _defaultEmptyWidget() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          Text("Empty Content"),
        ],
      ),
    );
  }
}
