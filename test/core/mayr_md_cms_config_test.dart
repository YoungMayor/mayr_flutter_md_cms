import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mayr_md_cms/mayr_md_cms.dart';

void main() {
  group('MayrMdCmsConfig', () {
    test('creates config with default values', () {
      const config = MayrMdCmsConfig();

      expect(config.loadingWidget, isNull);
      expect(config.errorWidget, isNull);
      expect(config.emptyWidget, isNull);
      expect(config.shrinkWrap, false);
      expect(config.scrollPhysics, isA<NeverScrollableScrollPhysics>());
      expect(config.markdownStyleSheet, isNull);
      expect(config.internalActions, isEmpty);
    });

    test('creates config with custom values', () {
      const loadingWidget = CircularProgressIndicator();
      const errorWidget = Text('Error');
      const emptyWidget = Text('Empty');
      const shrinkWrap = true;
      const scrollPhysics = AlwaysScrollableScrollPhysics();
      final internalActions = {
        'internal:test': (BuildContext context) {},
      };

      final config = MayrMdCmsConfig(
        loadingWidget: loadingWidget,
        errorWidget: errorWidget,
        emptyWidget: emptyWidget,
        shrinkWrap: shrinkWrap,
        scrollPhysics: scrollPhysics,
        internalActions: internalActions,
      );

      expect(config.loadingWidget, loadingWidget);
      expect(config.errorWidget, errorWidget);
      expect(config.emptyWidget, emptyWidget);
      expect(config.shrinkWrap, shrinkWrap);
      expect(config.scrollPhysics, scrollPhysics);
      expect(config.internalActions, internalActions);
    });

    testWidgets('markdownStyleSheetToUse returns custom stylesheet when provided',
        (WidgetTester tester) async {
      final customStyleSheet = MarkdownStyleSheet(
        h1: const TextStyle(fontSize: 32),
      );

      final config = MayrMdCmsConfig(
        markdownStyleSheet: customStyleSheet,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final stylesheet = config.markdownStyleSheetToUse(context);
              expect(stylesheet, customStyleSheet);
              return const SizedBox();
            },
          ),
        ),
      );
    });

    testWidgets('markdownStyleSheetToUse returns default stylesheet when not provided',
        (WidgetTester tester) async {
      const config = MayrMdCmsConfig();

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final stylesheet = config.markdownStyleSheetToUse(context);
              expect(stylesheet, isNotNull);
              expect(stylesheet, isA<MarkdownStyleSheet>());
              return const SizedBox();
            },
          ),
        ),
      );
    });
  });

  group('MdCmsConfigExtension', () {
    test('orDefault returns config when not null', () {
      const MayrMdCmsConfig? config = MayrMdCmsConfig(shrinkWrap: true);
      final result = config.orDefault;

      expect(result, config);
      expect(result.shrinkWrap, true);
    });

    test('orDefault returns default config when null', () {
      const MayrMdCmsConfig? config = null;
      final result = config.orDefault;

      expect(result, isNotNull);
      expect(result.shrinkWrap, false);
    });
  });
}
