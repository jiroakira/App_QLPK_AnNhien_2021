import 'package:dio/dio.dart';
import 'package:medapp/model/service/list_services.dart';
import 'package:medapp/utils/constants.dart';
import 'package:medapp/utils/http_interceptor/dio_logging_interceptor.dart';

class ListServiceProvider {
  final Dio _dio = new Dio();
  final String _baseUrl = HOST_URL;

  ListServiceProvider() {
    _dio.options.baseUrl = _baseUrl;
    _dio.interceptors.add(DioLoggingInterceptors(_dio));
  }

  Future<ListServices> getAllServices(String funcRoomId) async {
    try {
      final response = await _dio.get('api/danh_sach_dich_vu/phong_chuc_nang/?id_phong=$funcRoomId');
      final json = response.data;
      return ListServices.fromJson(json);
    } catch (e) {
      print(e.toString());
    }
  }
}
