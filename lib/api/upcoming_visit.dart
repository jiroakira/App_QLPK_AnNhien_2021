import 'package:dio/dio.dart';
import 'package:medapp/injector/injector.dart';
import 'package:medapp/storage/sharedpreferences/shared_preferences_manager.dart';
import 'package:medapp/utils/http_interceptor/dio_logging_interceptor.dart';
import 'package:medapp/model/appointment/upcoming_visit.dart';
import 'package:medapp/utils/constants.dart';

class UpcomingVisitApiProvider {
  final Dio _dio = new Dio();
  final String _baseUrl = HOST_URL;
  final SharedPreferencesManager sharedPreferencesManager = locator<SharedPreferencesManager>();

  UpcomingVisitApiProvider() {
    _dio.options.baseUrl = _baseUrl;
    _dio.interceptors.add(DioLoggingInterceptors(_dio));
  }

  Future<UpcomingVisit> getUpcomingVist() async {
    try {
      final String userId = sharedPreferencesManager.getString(SharedPreferencesManager.keyUserID);
      print(userId);
      final response = await _dio.get('api/lich_hen_sap_toi/?user_id=$userId');
      final json = response.data;
      return UpcomingVisit.fromJson(json);
    } catch (e) {
      print(e.toString());
    }
  }
}
