import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mayr_md_cms/mayr_md_cms.dart';
import 'package:mayr_md_cms/src/widgets/mayr_md_cms_renderer.dart';

/// Test implementation of MayrMdCmsBase
class TestMdCms extends MayrMdCmsBase {
  @override
  final MayrMdCmsConfig config;

  TestMdCms({MayrMdCmsConfig? config})
      : config = config ?? const MayrMdCmsConfig();
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('MayrMdCmsBase', () {
    late TestMdCms testCms;
    late MayrMdCmsConfig testConfig;

    setUp(() {
      testConfig = const MayrMdCmsConfig(shrinkWrap: true);
      testCms = TestMdCms(config: testConfig);
    });

    group('local', () {
      test('creates renderer with local loader', () {
        final renderer = testCms.local('assets/demo_md.md');

        expect(renderer, isA<MayrMdCmsRenderer>());
        expect(renderer.config, testConfig);
      });

      test('uses instance config', () {
        final renderer = testCms.local('assets/demo_md.md');

        expect(renderer.config.shrinkWrap, true);
      });
    });

    group('network', () {
      test('creates renderer with network loader', () {
        final renderer = testCms.network('https://example.com/content.md');

        expect(renderer, isA<MayrMdCmsRenderer>());
        expect(renderer.config, testConfig);
      });

      test('uses instance config', () {
        final renderer = testCms.network('https://example.com/content.md');

        expect(renderer.config.shrinkWrap, true);
      });
    });

    group('custom', () {
      test('creates renderer with custom callback', () {
        final renderer = testCms.custom(() async => '# Custom Content');

        expect(renderer, isA<MayrMdCmsRenderer>());
        expect(renderer.config, testConfig);
      });

      test('uses instance config', () {
        final renderer = testCms.custom(() async => '# Custom Content');

        expect(renderer.config.shrinkWrap, true);
      });
    });

    test('allows custom config per instance', () {
      final cms1 = TestMdCms(
        config: const MayrMdCmsConfig(shrinkWrap: true),
      );
      final cms2 = TestMdCms(
        config: const MayrMdCmsConfig(shrinkWrap: false),
      );

      expect(cms1.config.shrinkWrap, true);
      expect(cms2.config.shrinkWrap, false);
    });
  });
}
