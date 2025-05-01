import 'package:dio/dio.dart';
import 'package:mayr_md_cms/src/core/mayr_md_cms_config.dart';
import 'package:mayr_md_cms/src/core/tools/extensions.dart';
import 'package:mayr_md_cms/src/core/tools/loaders.dart';
import 'package:mayr_md_cms/src/widgets/mayr_md_cms_renderer.dart';

final class MayrMdCms {
  static MayrMdCmsRenderer local(String path, {MayrMdCmsConfig? config}) {
    return MayrMdCmsRenderer(
      future: () => Loaders.fromLocal(path),
      config: config.orDefault,
    );
  }

  static MayrMdCmsRenderer newtwork(
    String href, {
    MayrMdCmsConfig? config,
    Dio? dioClient,
  }) {
    return MayrMdCmsRenderer(
      future: () async => Loaders.fromNetwork(href, dioClient: dioClient),
      config: config.orDefault,
    );
  }

  static MayrMdCmsRenderer custom(
    Future<String> Function() callback, {
    MayrMdCmsConfig? config,
  }) => MayrMdCmsRenderer(future: callback, config: config.orDefault);
}
