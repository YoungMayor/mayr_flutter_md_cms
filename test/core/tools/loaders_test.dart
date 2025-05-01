import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mayr_md_cms/src/tools/loaders.dart';
import 'package:mockito/mockito.dart';

import '../../mocks/mock_dio.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test("Test local loader", () async {
    String response = await Loaders.fromLocal("assets/demo_md.md");

    expect(response, isNotEmpty);
  });

  test("Test network with mock", () async {
    final mockDio = MockDio();

    final testUrl = 'https://example.com/markdown.md';

    final expectedMarkdown = '# Hello World';

    // Arrange: set up the mock behaviour
    when(mockDio.get(testUrl)).thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(path: testUrl),
        data: expectedMarkdown,
        statusCode: 200,
      ),
    );

    final result = await Loaders.fromNetwork(testUrl, dioClient: mockDio);

    // Assert: check if the result matches
    expect(result, expectedMarkdown);
  });
}
