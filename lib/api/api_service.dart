import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:medapp/model/login.dart';
import 'package:medapp/model/register.dart';
import 'package:medapp/model/token/auth_token.dart';
import 'package:medapp/utils/http_interceptor/dio_logging_interceptor.dart';
import 'package:medapp/model/token/token.dart';
import 'package:medapp/utils/constants.dart';

class APIService {
  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    String url = "https://reqres.in/api/login";
    final response = await http.post(url, body: requestModel.toJson());
    if (response.statusCode == 200 || response.statusCode == 400) {
      return LoginResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }
}

class LoginApiClient {
  final _baseUrl = "https://reqres.in/api";

  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    final url = '$_baseUrl/login';

    final response = await http.post(
      url,
      body: requestModel.toJson(),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 200) {
      throw new Exception('Đăng Nhập Thất Bại');
    }

    final json = jsonDecode(response.body);
    return LoginResponseModel.fromJson(json);
  }
}

class RegisterApiClient {
  final _baseUrl = "https://reqres.in/api";

  Future<RegisterResponseModel> register(RegisterRequestModel registerRequestModel) async {
    final url = '$_baseUrl/register';
  }
}

class ApiAuthProvider {
  final Dio _dio = new Dio();
  final String _baseUrl = HOST_URL;

  ApiAuthProvider() {
    _dio.options.baseUrl = _baseUrl;
    _dio.interceptors.add(DioLoggingInterceptors(_dio));
  }

  Future<RegisterResponse> registerUser(RegisterBody registerBody) async {
    try {
      final response = await _dio.post(
        'api/dang_ki/',
        data: registerBody.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      return RegisterResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Error: $error");
      print("Stacktrace: $stacktrace");
    }
  }

  Future<ResponseTokenBody> loginUser(LoginBody loginBody) async {
    try {
      final response = await _dio.post(
        'api/dang_nhap/',
        data: FormData.fromMap(loginBody.toJson()),
      );
      return ResponseTokenBody.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Error: $error");
      print("Stacktrace: $stacktrace");
    }
  }

  Future<ResponseTokenBody> refreshAuth(RefreshTokenBody refreshTokenBody) async {
    try {
      final response = await _dio.post(
        'api/token/refresh/',
        data: FormData.fromMap(
          refreshTokenBody.toJson(),
        ),
      );
      return ResponseTokenBody.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Error: " + error.toString());
      print("Stacktrace: " + stacktrace.toString());
    }
  }
}
