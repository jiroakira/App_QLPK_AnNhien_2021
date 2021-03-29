import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:medapp/model/token/token.dart';
import 'package:medapp/repository/api_auth_repository.dart';
import 'package:medapp/storage/sharedpreferences/shared_preferences_manager.dart';
import 'package:medapp/injector/injector.dart';

// bloc state
abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final ResponseTokenBody responseTokenBody;

  LoginSuccess({this.responseTokenBody});
}

class LoginError extends LoginState {
  final String error;

  LoginError(this.error);
}

// bloc event

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ButtonLoginPressed extends LoginEvent {
  final LoginBody loginBody;

  ButtonLoginPressed({this.loginBody});

  @override
  List<Object> get props => [loginBody];
}

// bloc

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ApiAuthRepository apiAuthRepository = ApiAuthRepository();
  final SharedPreferencesManager sharedPreferencesManager = locator<SharedPreferencesManager>();

  LoginBloc() : super(null);
  @override
  void onTransition(Transition<LoginEvent, LoginState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is ButtonLoginPressed) {
      // yield LoginLoading();
      try {
        LoginBody loginBody = event.loginBody;
        if (loginBody.soDienThoai == null || loginBody.soDienThoai.isEmpty) {
          yield LoginError("Số Điện Thoại Không Thể Thiếu");
        } else if (loginBody.password == null || loginBody.password.isEmpty) {
          yield LoginError("Bạn cần nhập mật khẩu");
        }
        yield LoginLoading();
        ResponseTokenBody tokenBody = await apiAuthRepository.postLoginUser(loginBody);

        if (tokenBody != null) {
          print(tokenBody.userId);
          await sharedPreferencesManager.putString(SharedPreferencesManager.keyAccessToken, tokenBody.access);
          await sharedPreferencesManager.putString(SharedPreferencesManager.keyRefreshToken, tokenBody.refresh);
          await sharedPreferencesManager.putBool(SharedPreferencesManager.keyIsLogin, true);
          await sharedPreferencesManager.putString(SharedPreferencesManager.keyPhone, loginBody.soDienThoai);
          await sharedPreferencesManager.putString(SharedPreferencesManager.keyUserID, tokenBody.userId.toString());

          final String user_id = await sharedPreferencesManager.getString(SharedPreferencesManager.keyUserID);
          print('user id: ');
          print(user_id);

          yield LoginSuccess(responseTokenBody: tokenBody);
        } else {
          yield LoginError("Số Điện Thoại Hoặc Mật Khẩu Không Đúng");
        }
      } catch (error, stacktrace) {
        _printError(error, stacktrace);
      }
    }
  }

  void _printError(error, StackTrace stacktrace) {
    debugPrint('error: $error & stacktrace: $stacktrace');
  }
}
