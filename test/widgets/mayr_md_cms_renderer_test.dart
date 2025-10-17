import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mayr_md_cms/mayr_md_cms.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('MayrMdCmsRenderer', () {
    testWidgets('displays loading widget while fetching content', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MayrMdCms.custom(() async {
              await Future.delayed(const Duration(milliseconds: 100));
              return '# Test Content';
            }),
          ),
        ),
      );

      // Should show default loading widget
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Wait for future to complete to avoid pending timer warning
      await tester.pumpAndSettle();
    });

    testWidgets('displays custom loading widget while fetching content', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MayrMdCms.custom(
              () async {
                await Future.delayed(const Duration(milliseconds: 100));
                return '# Test Content';
              },
              config: const MayrMdCmsConfig(
                loadingWidget: Text('Custom Loading'),
              ),
            ),
          ),
        ),
      );

      // Should show custom loading widget
      expect(find.text('Custom Loading'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);

      // Wait for future to complete to avoid pending timer warning
      await tester.pumpAndSettle();
    });

    testWidgets('displays error widget when content loading fails', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MayrMdCms.custom(
              () async => throw Exception('Failed to load'),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Should show default error widget
      expect(find.text('Failed to load content'), findsOneWidget);
    });

    testWidgets('displays custom error widget when content loading fails', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MayrMdCms.custom(
              () async => throw Exception('Failed to load'),
              config: const MayrMdCmsConfig(errorWidget: Text('Custom Error')),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Should show custom error widget
      expect(find.text('Custom Error'), findsOneWidget);
      expect(find.text('Failed to load content'), findsNothing);
    });

    testWidgets('displays empty widget when content is null', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: MayrMdCms.custom(() async => ''))),
      );

      await tester.pumpAndSettle();

      // Should show default empty widget
      expect(find.text('Empty Content'), findsOneWidget);
    });

    testWidgets('displays custom empty widget when content is null', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MayrMdCms.custom(
              () async => '',
              config: const MayrMdCmsConfig(emptyWidget: Text('Custom Empty')),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Should show custom empty widget
      expect(find.text('Custom Empty'), findsOneWidget);
      expect(find.text('Empty Content'), findsNothing);
    });

    testWidgets('renders markdown content successfully', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MayrMdCms.custom(
              () async => '# Test Heading\n\nTest paragraph',
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Should render markdown content
      expect(find.text('Test Heading'), findsOneWidget);
      expect(find.text('Test paragraph'), findsOneWidget);
    });

    testWidgets('renders local markdown content', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: MayrMdCms.local('assets/demo_md.md'))),
      );

      await tester.pumpAndSettle();

      // Should render markdown content from assets
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.text('Failed to load content'), findsNothing);
    });
  });
}
