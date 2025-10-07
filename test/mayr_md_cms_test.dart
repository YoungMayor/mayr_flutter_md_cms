import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mayr_md_cms/mayr_md_cms.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Integration Tests', () {
    testWidgets('renders markdown from custom source', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MayrMdCms.custom(
              () async => '# Hello World\n\nThis is a test.',
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Verify that Markdown content appears
      expect(find.text('Hello World'), findsOneWidget);
      expect(find.text('This is a test.'), findsOneWidget);
    });

    testWidgets('renders markdown with links', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MayrMdCms.custom(
              () async => '[Click here](https://example.com)',
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Click here'), findsOneWidget);
    });

    testWidgets('handles internal actions', (WidgetTester tester) async {
      bool actionTriggered = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MayrMdCms.custom(
              () async => '[Trigger Action](internal:test)',
              config: MayrMdCmsConfig(
                internalActions: {
                  'internal:test': (context) => actionTriggered = true,
                },
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Tap the link
      await tester.tap(find.text('Trigger Action'));
      await tester.pumpAndSettle();

      expect(actionTriggered, true);
    });

    testWidgets('uses custom widgets for states', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MayrMdCms.custom(
              () async {
                await Future.delayed(const Duration(milliseconds: 100));
                return '# Content';
              },
              config: const MayrMdCmsConfig(
                loadingWidget: Text('Custom Loading'),
              ),
            ),
          ),
        ),
      );

      // Verify custom loading widget is shown
      expect(find.text('Custom Loading'), findsOneWidget);

      await tester.pumpAndSettle();

      // Verify content is rendered after loading
      expect(find.text('Content'), findsOneWidget);
      expect(find.text('Custom Loading'), findsNothing);
    });
  });
}
