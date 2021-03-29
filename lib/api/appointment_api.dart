import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:medapp/model/appointment/appointment.dart';
import 'package:medapp/model/appointment/appointment_response.dart';
import 'package:medapp/model/appointment/update_appt_info.dart';
import 'package:medapp/utils/http_interceptor/dio_logging_interceptor.dart';
import 'package:medapp/storage/sharedpreferences/shared_preferences_manager.dart';
import 'package:medapp/injector/injector.dart';
import 'package:medapp/model/appointment/all_visit.dart';
import 'package:medapp/model/appointment/response_appointment.dart';
import 'package:medapp/utils/constants.dart';

class AppointmentAPIClient {
  final baseUrl = "http://niovietnam.com/api/lich_kham/";
  final _url = "https://run.mocky.io/v3/f2b4bda8-8111-4729-984c-edc9c522f7a6";

  Future<AppointmentModel> getAppointment() async {
    final response = await http.get(_url);
    final json = jsonDecode(response.body);
    print(json);
    return AppointmentModel.fromJson(json);
  }

  Future<AllAppointmentModel> getAllAppointments() async {
    final response = await http.get(_url);
    final json = jsonDecode(response.body);
    return AllAppointmentModel.fromJson(json);
  }

  Future<AppointmentResponseModel> sendAppointment(AppointmentRequestModel requestModel) async {
    print(requestModel.toJson());
    final Dio dio = new Dio();

    final response = await dio.post(
      baseUrl,
      data: requestModel.toJson(),
    );
    print(response.data);
    if (response.statusCode != 200) {
      print(response.data);
      throw new Exception('Đăng Kí Lịch Hẹn Thất Bại');
    }
    final json = response.data;
    print(json);
    return AppointmentResponseModel.fromJson(json);
  }
}

class AllVisitProvider {
  final Dio _dio = new Dio();
  final String _baseUrl = HOST_URL;
  final SharedPreferencesManager sharedPreferencesManager = locator<SharedPreferencesManager>();

  AllVisitProvider() {
    _dio.options.baseUrl = _baseUrl;
    _dio.interceptors.add(DioLoggingInterceptors(_dio));
  }

  Future<AllVisitModel> getAllVisit() async {
    try {
      final String userId = sharedPreferencesManager.getString(SharedPreferencesManager.keyUserID);
      final response = await _dio.get('api/benh_nhan/tat_ca_lich_hen/?user_id=$userId');
      final json = response.data;
      return AllVisitModel.fromJson(json);
    } catch (e) {
      print(e.toString());
    }
  }
}

class AppointmentRequestProvider {
  final Dio _dio = new Dio();
  final String _baseUrl = HOST_URL;
  final SharedPreferencesManager sharedPreferencesManager = locator<SharedPreferencesManager>();

  AppointmentRequestProvider() {
    _dio.options.baseUrl = _baseUrl;
    _dio.interceptors.add(DioLoggingInterceptors(_dio));
  }

  Future<ResponseAppointment> postAppointmentRequest(AppointmentRequestModel requestModel) async {
    try {
      final response = await _dio.post(
        'api/banh_nhan/dang_ki_lich_hen/',
        data: requestModel.toJson(),
      );
      if (response.statusCode != 200) {
        print(response.data);
        throw new Exception('Đăng Kí Lịch Hẹn Thất Bại');
      }

      final json = response.data;
      return ResponseAppointment.fromJson(json);
    } catch (e) {
      print(e.toString());
    }
  }
}

class UpdateAppointmentProvider {
  final Dio _dio = new Dio();
  final String _baseUrl = HOST_URL;

  UpdateAppointmentProvider() {
    _dio.options.baseUrl = _baseUrl;
    _dio.interceptors.add(DioLoggingInterceptors(_dio));
  }

  Future<UpdateAppointmentInfo> getUpdateAppointmentInfo(String appointment_id) async {
    try {
      final response = await _dio.get('api/thong_tin_lich_hen/?appointment_id=$appointment_id');
      final json = response.data;
      return UpdateAppointmentInfo.fromJson(json);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<UpdateAppointmentResponse> postUpdateAppointmentRequest(UpdateAppointmentRequestModel updateAppointmentRequestModel) async {
    try {
      final response = await _dio.post(
        'api/chinh_sua_lich_hen/',
        data: updateAppointmentRequestModel.toJson(),
      );
      final json = response.data;
      return UpdateAppointmentResponse.fromJson(json);
    } catch (e) {
      print(e.toString());
    }
  }
}
