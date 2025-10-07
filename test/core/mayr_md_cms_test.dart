import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mayr_md_cms/mayr_md_cms.dart';
import 'package:mayr_md_cms/src/widgets/mayr_md_cms_renderer.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('MayrMdCms', () {
    group('local', () {
      test('creates renderer with local loader', () {
        final renderer = MayrMdCms.local('assets/demo_md.md');

        expect(renderer, isA<MayrMdCmsRenderer>());
      });

      test('creates renderer with custom config', () {
        const customConfig = MayrMdCmsConfig(shrinkWrap: true);
        final renderer = MayrMdCms.local(
          'assets/demo_md.md',
          config: customConfig,
        );

        expect(renderer, isA<MayrMdCmsRenderer>());
        expect(renderer.config.shrinkWrap, true);
      });

      test('uses default config when not provided', () {
        final renderer = MayrMdCms.local('assets/demo_md.md');

        expect(renderer.config, isNotNull);
        expect(renderer.config.shrinkWrap, false);
      });
    });

    group('network', () {
      test('creates renderer with network loader', () {
        final renderer = MayrMdCms.network('https://example.com/content.md');

        expect(renderer, isA<MayrMdCmsRenderer>());
      });

      test('creates renderer with custom config', () {
        const customConfig = MayrMdCmsConfig(shrinkWrap: true);
        final renderer = MayrMdCms.network(
          'https://example.com/content.md',
          config: customConfig,
        );

        expect(renderer, isA<MayrMdCmsRenderer>());
        expect(renderer.config.shrinkWrap, true);
      });

      test('uses default config when not provided', () {
        final renderer = MayrMdCms.network('https://example.com/content.md');

        expect(renderer.config, isNotNull);
        expect(renderer.config.shrinkWrap, false);
      });
    });

    group('custom', () {
      test('creates renderer with custom callback', () {
        final renderer = MayrMdCms.custom(() async => '# Custom Content');

        expect(renderer, isA<MayrMdCmsRenderer>());
      });

      test('creates renderer with custom config', () {
        const customConfig = MayrMdCmsConfig(shrinkWrap: true);
        final renderer = MayrMdCms.custom(
          () async => '# Custom Content',
          config: customConfig,
        );

        expect(renderer, isA<MayrMdCmsRenderer>());
        expect(renderer.config.shrinkWrap, true);
      });

      test('uses default config when not provided', () {
        final renderer = MayrMdCms.custom(() async => '# Custom Content');

        expect(renderer.config, isNotNull);
        expect(renderer.config.shrinkWrap, false);
      });
    });
  });
}
