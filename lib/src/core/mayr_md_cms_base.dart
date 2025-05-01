import 'package:dio/dio.dart';
import 'package:mayr_md_cms/mayr_md_cms.dart';
import 'package:mayr_md_cms/src/core/tools/loaders.dart';
import 'package:mayr_md_cms/src/widgets/mayr_md_cms_renderer.dart';

abstract class MayrMdCmsBase {
  MayrMdCmsConfig get config;

  MayrMdCmsRenderer local(String path) => MayrMdCmsRenderer(
    future: () async => Loaders.fromLocal(path),
    config: config,
  );

  MayrMdCmsRenderer newtwork(String href, {Dio? dioClient}) {
    return MayrMdCmsRenderer(
      future: () async => Loaders.fromNetwork(href, dioClient: dioClient),
      config: config,
    );
  }

  MayrMdCmsRenderer custom(Future<String> Function() callback) =>
      MayrMdCmsRenderer(future: callback, config: config);
}
