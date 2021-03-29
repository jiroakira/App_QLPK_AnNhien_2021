import 'package:dio/dio.dart';
import 'package:medapp/model/all_doctor.dart';
import 'package:medapp/utils/constants.dart';
import 'package:medapp/utils/http_interceptor/dio_logging_interceptor.dart';

class AllDoctorProvider {
  final String _baseUrl = HOST_URL;
  final Dio _dio = new Dio();

  AllDoctorProvider() {
    _dio.options.baseUrl = _baseUrl;
    _dio.interceptors.add(DioLoggingInterceptors(_dio));
  }

  Future<DoctorBody> getAllDoctor() async {
    try {
      final response = await _dio.get('api/danh_sach_bac_si_api/');
      final json = response.data;
      return DoctorBody.fromJson(json);
    } catch (e) {
      print(e.toString());
    }
  }
}
