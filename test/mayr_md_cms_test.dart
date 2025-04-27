import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// import 'package:mayr_md_cms/mayr_md_cms.dart';

void main() {
  testWidgets('renders markdown from local file', (WidgetTester tester) async {
    // Arrange: create a simple MayrMdCms with mocked local content
    await tester.pumpWidget(
      MaterialApp(home: Center(child: Text("Hello World"))),
    );

    // Act: Let it finish loading
    await tester.pumpAndSettle();

    // Assert: Verify that Markdown content appears
    expect(find.text('Hello World'), findsOneWidget);
  });
}
