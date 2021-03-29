import 'package:meta/meta.dart';
import 'package:medapp/api/api_service.dart';
import 'package:medapp/model/login.dart';
import 'package:medapp/bloc/authentication/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginRepository {
  final loginApiClient = LoginApiClient();

  Future<User> authenticate({
    @required String email,
    @required String password,
  }) async {
    LoginRequestModel loginRequestModel = LoginRequestModel(
      email: email,
      password: password,
    );

    LoginResponseModel response = await loginApiClient.login(loginRequestModel);
    User user = User(token: response.token);
    return user;
  }

  Future<User> getCurrentUser() async {
    return null;
  }

  Future<void> signOut() {
    return null;
  }
}
