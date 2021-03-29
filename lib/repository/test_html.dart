import 'package:medapp/api/test_html.dart';
import 'package:medapp/model/test_html.dart';

class TestHtmlRepository {
  final TestHtmlProvider testHtmlProvider = TestHtmlProvider();

  Future<TestHtmlBody> getTestHtml(id) async {
    return await testHtmlProvider.getTestHtml(id);
  }
}
