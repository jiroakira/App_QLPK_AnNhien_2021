import 'package:dio/dio.dart';
import 'package:medapp/injector/injector.dart';
import 'package:medapp/storage/sharedpreferences/shared_preferences_manager.dart';
import 'package:medapp/model/prescription/list_prescription.dart';
import 'package:medapp/model/prescription/prescription.dart';
import 'package:medapp/model/prescription/latest_prescription.dart';
import 'package:medapp/utils/constants.dart';

class PrescriptionApiProvider {
  final Dio _dio = new Dio();
  final String _baseUrl = HOST_URL;
  final SharedPreferencesManager sharedPreferencesManager = locator<SharedPreferencesManager>();

  PrescriptionApiProvider() {
    _dio.options.baseUrl = _baseUrl;
  }

  Future<ListPrescriptionBody> getListPrescription() async {
    try {
      final String userId = sharedPreferencesManager.getString(SharedPreferencesManager.keyUserID);
      print(userId);
      final response = await _dio.get('api/benh_nhan/danh_sach_don_thuoc/?user_id=$userId');
      final json = response.data;
      return ListPrescriptionBody.fromJson(json);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<PrescriptionBody> getPrescription(String donThuocId) async {
    try {
      final response = await _dio.get('api/benh_nhan/don_thuoc/?don_thuoc_id=$donThuocId');
      final json = response.data;
      print(json);
      return PrescriptionBody.fromJson(json);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<LatestPrescription> getLatestPrescription() async {
    final String userId = sharedPreferencesManager.getString(SharedPreferencesManager.keyUserID);
    try {
      final response = await _dio.get('api/don_thuoc_gan_nhat/?user_id=$userId');
      final json = response.data;
      return LatestPrescription.fromJson(json);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<PrescriptionBody> getExaminationPrescription(String chuoiKhamId) async {
    try {
      final response = await _dio.get('api/don_thuoc/chuoi_kham/?id_chuoi_kham=$chuoiKhamId');
      final json = response.data;
      return PrescriptionBody.fromJson(json);
    } catch (e) {
      print(e.toString());
    }
  }
}
