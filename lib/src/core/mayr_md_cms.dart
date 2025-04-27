import 'package:mayr_md_cms/src/core/mayr_md_cms_config.dart';
import 'package:mayr_md_cms/src/core/tools/loaders.dart';
import 'package:mayr_md_cms/src/widgets/mayr_md_cms_renderer.dart';

class MayrMdCms {
  static MayrMdCmsRenderer local(String path, {MayrMdCmsConfig? config}) {
    return MayrMdCmsRenderer(
      future: () => Loaders.fromLocal(path),
      config: config ?? MayrMdCmsConfig(),
    );
  }

  static MayrMdCmsRenderer newtwork(String href, {MayrMdCmsConfig? config}) {
    return MayrMdCmsRenderer(
      future: () async => Loaders.fromNetwork(href),
      config: config ?? MayrMdCmsConfig(),
    );
  }

  static MayrMdCmsRenderer custom(
    Future<String> Function() callback, {
    MayrMdCmsConfig? config,
  }) {
    return MayrMdCmsRenderer(
      future: callback,
      config: config ?? MayrMdCmsConfig(),
    );
  }
}
