import 'package:medapp/api/api_service.dart';
import 'package:medapp/model/token/auth_token.dart';
import 'package:medapp/model/token/token.dart';

class ApiAuthRepository {
  final ApiAuthProvider _apiAuthProvider = ApiAuthProvider();

  Future<RegisterResponse> postRegisterUser(RegisterBody registerBody) async {
    return await _apiAuthProvider.registerUser(registerBody);
  }

  Future<ResponseTokenBody> postLoginUser(LoginBody loginBody) async {
    return await _apiAuthProvider.loginUser(loginBody);
  }

  Future<ResponseTokenBody> postRefreshAuth(RefreshTokenBody refreshTokenBody) => _apiAuthProvider.refreshAuth(refreshTokenBody);
}
