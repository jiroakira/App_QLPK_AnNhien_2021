import 'package:dio/dio.dart';
import 'package:medapp/model/token/token.dart';
import 'package:medapp/model/update_user_info/user_update_info.dart';
import 'package:medapp/utils/http_interceptor/dio_logging_interceptor.dart';
import 'package:medapp/storage/sharedpreferences/shared_preferences_manager.dart';
import 'package:medapp/injector/injector.dart';
import 'package:medapp/model/user/user_info.dart';
import 'package:medapp/utils/constants.dart';

class UserApiServices {
  final Dio _dio = new Dio();
  final String _baseUrl = HOST_URL;
  final SharedPreferencesManager sharedPreferencesManager = locator<SharedPreferencesManager>();

  UserApiServices() {
    _dio.options.baseUrl = _baseUrl;
    // _dio.interceptors.add(DioLoggingInterceptors(_dio));
  }

  Future<void> putUpdateUser(UpdateUserBody updateUserBoby) async {
    try {
      await _dio.put(
        "",
        data: FormData.fromMap(
          updateUserBoby.toJson(),
        ),
      );
    } catch (error, stacktrace) {
      print("Error: $error");
      print("Stacktrace: $stacktrace");
    }
  }

  Future<UserInforBody> getUserInfo() async {
    final String userId = sharedPreferencesManager.getString(SharedPreferencesManager.keyUserID);
    try {
      final response = await _dio.get("api/benh_nhan/thong_tin/?user_id=$userId");
      final json = response.data;
      return UserInforBody.fromJson(json);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<UserUpdateInfoBody> getUserUpdateInfo() async {
    final String userId = sharedPreferencesManager.getString(SharedPreferencesManager.keyUserID);
    try {
      final response = await _dio.get("api/thong_tin_chinh_sua/?user_id=$userId");
      final json = response.data;
      return UserUpdateInfoBody.fromJson(json);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<ResponseUserUpdateInfoBody> putUserUpdateInfoRequest(UserUpdateInfoRequestBody userUpdateInfoRequestBody) async {
    try {
      final response = await _dio.patch(
        'api/chinh_sua_thong_tin/',
        data: userUpdateInfoRequestBody.toJson(),
      );
      final json = response.data;
      return ResponseUserUpdateInfoBody.fromJson(json);
    } catch (e) {
      print(e.toString());
    }
  }
}
