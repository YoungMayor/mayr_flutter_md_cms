import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mayr_md_cms/mayr_md_cms.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('MayrMdCmsMarkdownRenderer', () {
    testWidgets('renders markdown content correctly', (
      WidgetTester tester,
    ) async {
      const markdownContent = '''
# Heading 1
## Heading 2

This is a paragraph with **bold** and *italic* text.

- List item 1
- List item 2
''';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: MayrMdCms.custom(() async => markdownContent)),
        ),
      );

      await tester.pumpAndSettle();

      // Verify headings are rendered
      expect(find.text('Heading 1'), findsOneWidget);
      expect(find.text('Heading 2'), findsOneWidget);
    });

    testWidgets('respects shrinkWrap configuration', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MayrMdCms.custom(
              () async => '# Test',
              config: const MayrMdCmsConfig(shrinkWrap: true),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Test'), findsOneWidget);
    });

    testWidgets('handles internal actions on link tap', (
      WidgetTester tester,
    ) async {
      bool actionCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MayrMdCms.custom(
              () async => '[Click me](internal:test_action)',
              config: MayrMdCmsConfig(
                internalActions: {
                  'internal:test_action': (context) {
                    actionCalled = true;
                  },
                },
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Tap the link
      await tester.tap(find.text('Click me'));
      await tester.pumpAndSettle();

      // Verify action was called
      expect(actionCalled, true);
    });

    testWidgets('ignores internal action if not defined', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MayrMdCms.custom(
              () async => '[Click me](internal:undefined_action)',
              config: const MayrMdCmsConfig(internalActions: {}),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Tap the link (should not throw)
      await tester.tap(find.text('Click me'));
      await tester.pumpAndSettle();

      // Test passes if no exception is thrown
    });

    testWidgets('handles multiple internal actions', (
      WidgetTester tester,
    ) async {
      int action1Count = 0;
      int action2Count = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MayrMdCms.custom(
              () async =>
                  '[Action 1](internal:action1)\n\n[Action 2](internal:action2)',
              config: MayrMdCmsConfig(
                internalActions: {
                  'internal:action1': (context) {
                    action1Count++;
                  },
                  'internal:action2': (context) {
                    action2Count++;
                  },
                },
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Tap first link
      await tester.tap(find.text('Action 1'));
      await tester.pumpAndSettle();

      // Tap second link
      await tester.tap(find.text('Action 2'));
      await tester.pumpAndSettle();

      // Verify both actions were called
      expect(action1Count, 1);
      expect(action2Count, 1);
    });

    testWidgets('applies custom markdown stylesheet', (
      WidgetTester tester,
    ) async {
      final customStyleSheet = MarkdownStyleSheet(
        h1: const TextStyle(fontSize: 48, color: Colors.red),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MayrMdCms.custom(
              () async => '# Custom Styled',
              config: MayrMdCmsConfig(markdownStyleSheet: customStyleSheet),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Custom Styled'), findsOneWidget);
    });

    testWidgets('handles empty links gracefully', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: MayrMdCms.custom(() async => '[Empty Link]()')),
        ),
      );

      await tester.pumpAndSettle();

      // Tap the link (should not throw)
      await tester.tap(find.text('Empty Link'));
      await tester.pumpAndSettle();

      // Test passes if no exception is thrown
    });
  });
}
