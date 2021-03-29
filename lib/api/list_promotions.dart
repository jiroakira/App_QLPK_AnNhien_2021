import 'package:dio/dio.dart';
import 'package:medapp/model/list_promotions.dart';
import 'package:medapp/utils/constants.dart';
import 'package:medapp/utils/http_interceptor/dio_logging_interceptor.dart';

class ListPromotionsProvider {
  final Dio _dio = new Dio();
  final String _baseUrl = HOST_URL;

  ListPromotionsProvider() {
    _dio.options.baseUrl = _baseUrl;
    _dio.interceptors.add(DioLoggingInterceptors(_dio));
  }

  Future<ListPromotions> getListPromotions() async {
    final response = await _dio.get('api/danh_sach_bai_dang/');
    final json = response.data;
    return ListPromotions.fromJson(json);
  }
}
