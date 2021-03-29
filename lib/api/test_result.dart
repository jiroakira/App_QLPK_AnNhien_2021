import 'package:medapp/injector/injector.dart';
import 'package:medapp/model/test_result_body.dart';
import 'package:medapp/storage/sharedpreferences/shared_preferences_manager.dart';
import 'package:medapp/utils/constants.dart';
import 'package:medapp/utils/http_interceptor/dio_logging_interceptor.dart';
import 'package:dio/dio.dart';

class TestResultProvider {
  final Dio _dio = new Dio();
  final _baseUrl = HOST_URL;
  final SharedPreferencesManager sharedPreferencesManager = locator<SharedPreferencesManager>();

  TestResultProvider() {
    _dio.options.baseUrl = _baseUrl;
    _dio.interceptors.add(DioLoggingInterceptors(_dio));
  }

  Future<TestResultBody> getTestResult(id) async {
    try {
      final response = await _dio.get('api/benh_nhan/ket_qua_xet_nghiem/?id=$id');
      final json = response.data;
      return TestResultBody.fromJson(json);
    } catch (error, stacktrace) {
      print("Error: $error");
      print("Stacktrace: $stacktrace");
    }
  }
}
