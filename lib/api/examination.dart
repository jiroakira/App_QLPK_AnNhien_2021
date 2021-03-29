import 'package:dio/dio.dart';
import 'package:medapp/model/appointment/first_invoice.dart';
import 'package:medapp/model/examination/examination_invoice.dart';
import 'package:medapp/model/examination/list_examinations.dart';
import 'package:medapp/model/examination/examination.dart';
import 'package:medapp/model/examination/prescription_invoice.dart';
import 'package:medapp/utils/http_interceptor/dio_logging_interceptor.dart';
import 'package:medapp/storage/sharedpreferences/shared_preferences_manager.dart';
import 'package:medapp/injector/injector.dart';
import 'package:medapp/utils/constants.dart';

class ExaminationApiProvider {
  final Dio _dio = new Dio();
  final String _baseUrl = HOST_URL;
  final SharedPreferencesManager sharedPreferencesManager = locator<SharedPreferencesManager>();

  ExaminationApiProvider() {
    _dio.options.baseUrl = _baseUrl;
    _dio.interceptors.add(DioLoggingInterceptors(_dio));
  }

  Future<ListExaminationsBody> getListExaminations() async {
    try {
      final String userId = sharedPreferencesManager.getString(SharedPreferencesManager.keyUserID);
      final response = await _dio.get('api/benh_nhan/danh_sach_chuoi_kham/?user_id=$userId');
      final json = response.data;
      return ListExaminationsBody.fromJson(json);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<ExaminationBody> getExaminationDetail(String idChuoiKham) async {
    try {
      final response = await _dio.get('api/benh_nhan/chuoi_kham/ket_qua/?id_chuoi_kham=$idChuoiKham');
      final json = response.data;
      return ExaminationBody.fromJson(json);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<ExaminationsInvoice> getExaminationsInvoice() async {
    try {
      final String userId = sharedPreferencesManager.getString(SharedPreferencesManager.keyUserID);
      final response = await _dio.get("api/hoa_don_chuoi_kham_can_thanh_toan/?user_id=$userId");
      final json = response.data;
      return ExaminationsInvoice.fromJson(json);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<PrescriptionInvoice> getPrescriptionInvoice() async {
    try {
      final String userId = sharedPreferencesManager.getString(SharedPreferencesManager.keyUserID);
      final response = await _dio.get("api/hoa_don_thuoc_can_thanh_toan/?user_id=$userId");
      final json = response.data;
      return PrescriptionInvoice.fromJson(json);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<ExaminationsInvoice> getExamInvoice(String chuoiKhamId) async {
    final response = await _dio.get('api/hoa_don_dich_vu/chuoi_kham/?id_chuoi_kham=$chuoiKhamId');
    final json = response.data;
    return ExaminationsInvoice.fromJson(json);
  }

  Future<PrescriptionInvoice> getPresInvoice(String chuoiKhamId) async {
    try {
      final response = await _dio.get('api/hoa_don_thuoc/chuoi_kham/?id_chuoi_kham=$chuoiKhamId');
      final json = response.data;
      return PrescriptionInvoice.fromJson(json);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<FirstInvoice> getFirstInvoice(String lichHenId) async {
    try {
      final response = await _dio.get('api/hoa_don_lam_sang/?id_lich_hen=$lichHenId');
      final json = response.data;
      return FirstInvoice.fromJson(json);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<FirstInvoice> getLatestFirstInvoice() async {
    try {
      final String userId = sharedPreferencesManager.getString(SharedPreferencesManager.keyUserID);
      final response = await _dio.get('api/hoa_don_lam_sang_gan_nhat/?user_id=$userId');
      final json = response.data;
      return FirstInvoice.fromJson(json);
    } catch (e) {
      print(e.toString());
    }
  }
}
