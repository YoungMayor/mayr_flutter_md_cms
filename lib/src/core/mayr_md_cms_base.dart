import 'package:mayr_md_cms/mayr_md_cms.dart';
import 'package:mayr_md_cms/src/core/tools/loaders.dart';
import 'package:mayr_md_cms/src/widgets/mayr_md_cms_renderer.dart';

abstract class MayrMdCmsBase {
  MayrMdCmsConfig get config;

  MayrMdCmsRenderer local(String path) {
    return MayrMdCmsRenderer(
      future: () async => Loaders.fromLocal(path),
      config: config,
    );
  }

  MayrMdCmsRenderer newtwork(String href) {
    return MayrMdCmsRenderer(
      future: () async => Loaders.fromNetwork(href),
      config: config,
    );
  }

  MayrMdCmsRenderer custom(Future<String> Function() callback) {
    return MayrMdCmsRenderer(future: callback, config: config);
  }
}
