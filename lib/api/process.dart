import 'package:dio/dio.dart';
import 'package:medapp/model/checkup_process/process.dart';
import 'package:medapp/injector/injector.dart';
import 'package:medapp/storage/sharedpreferences/shared_preferences_manager.dart';
import 'package:medapp/utils/constants.dart';
import 'package:medapp/model/checkup_process/latest_process.dart';
import 'package:medapp/utils/http_interceptor/dio_logging_interceptor.dart';

class CheckupProcessProvider {
  final Dio _dio = new Dio();
  final _baseUrl = HOST_URL;
  final SharedPreferencesManager sharedPreferencesManager = locator<SharedPreferencesManager>();

  CheckupProcessProvider() {
    _dio.options.baseUrl = _baseUrl;
    _dio.interceptors.add(DioLoggingInterceptors(_dio));
  }

  Future<CheckupProcessBody> getCheckupProcess() async {
    try {
      final String userId = sharedPreferencesManager.getString(SharedPreferencesManager.keyUserID);
      final response = await _dio.get('api/danh_sach_phan_khoa/?user_id=$userId');
      final json = response.data;
      return CheckupProcessBody.fromJson(json);
    } catch (error, stacktrace) {
      print("Error: $error");
      print("Stacktrace: $stacktrace");
    }
  }

  Future<LatestCheckupProcessBody> getLatestCheckupProcess() async {
    try {
      final String userId = sharedPreferencesManager.getString(SharedPreferencesManager.keyUserID);
      final response = await _dio.get('api/benh_nhan/chuoi_kham_gan_nhat/?user_id=$userId');
      final json = response.data;
      return LatestCheckupProcessBody.fromJson(json);
    } catch (error, stacktrace) {
      print("Error: $error");
      print("Stacktrace: $stacktrace");
    }
  }
}
