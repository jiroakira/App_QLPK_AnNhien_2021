import 'package:dio/dio.dart';
import 'package:medapp/model/user/doctor.dart';
import 'package:medapp/utils/constants.dart';

class DoctorsProvider {
  final String _baseUrl = HOST_URL;
  final Dio _dio = new Dio();

  DoctorsProvider() {
    _dio.options.baseUrl = _baseUrl;
  }

  Future<ListDoctorBody> getListDoctor() async {
    final response = await _dio.get('api/danh_sach_bac_si_api/');
    final json = response.data;
    return ListDoctorBody.fromJson(json);
  }
}
