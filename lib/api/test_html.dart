import 'package:dio/dio.dart';
import 'package:medapp/injector/injector.dart';
import 'package:medapp/model/test_html.dart';
import 'package:medapp/storage/sharedpreferences/shared_preferences_manager.dart';
import 'package:medapp/utils/constants.dart';
import 'package:medapp/utils/http_interceptor/dio_logging_interceptor.dart';

class TestHtmlProvider {
  final Dio _dio = new Dio();
  final _baseUrl = HOST_URL;
  final SharedPreferencesManager sharedPreferencesManager = locator<SharedPreferencesManager>();

  TestHtmlProvider() {
    _dio.options.baseUrl = _baseUrl;
    _dio.interceptors.add(DioLoggingInterceptors(_dio));
  }

  Future<TestHtmlBody> getTestHtml(id) async {
    try {
      final response = await _dio.get('api/benh_nhan/phieu_ket_qua/?id=$id');
      final json = response.data;
      return TestHtmlBody.fromJson(json);
    } catch (error, stacktrace) {
      print("Error: $error");
      print("Stacktrace: $stacktrace");
    }
  }
}
