import 'package:medapp/api/test_result.dart';
import 'package:medapp/model/test_result_body.dart';

class TestResultRepository {
  final TestResultProvider testResultProvider = TestResultProvider();

  Future<TestResultBody> getTestResult(id) async {
    return await testResultProvider.getTestResult(id);
  }
}
