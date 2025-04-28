import 'package:flutter_test/flutter_test.dart';
import 'package:mayr_md_cms/src/core/tools/loaders.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test("Test from local loader", () async {
    String response = await Loaders.fromLocal("assets/demo_md.md");

    expect(response, isNotEmpty);
  });
}
