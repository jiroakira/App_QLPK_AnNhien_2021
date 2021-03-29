import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:medapp/repository/api_auth_repository.dart';
import 'package:medapp/model/token/register.dart';

// bloc state
abstract class SignupState {
  @override
  List<Object> get props => [];
}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupError extends SignupState {
  final String error;

  SignupError(this.error);
}

class SignupSuccess extends SignupState {}

// bloc event

abstract class SignupEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ButtonSignupPressed extends SignupEvent {
  final RegisterBody registerBody;

  ButtonSignupPressed({this.registerBody});
}

// bloc

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final ApiAuthRepository apiAuthRepository = ApiAuthRepository();

  SignupBloc() : super(SignupInitial());

  @override
  SignupState get initialState => SignupInitial();

  @override
  void onTransition(Transition<SignupEvent, SignupState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  Stream<SignupState> mapEventToState(SignupEvent event) async* {
    if (event is ButtonSignupPressed) {
      yield SignupLoading();
      try {
        RegisterBody registerBody = event.registerBody;
        if (registerBody.hoTen == null || registerBody.hoTen.isEmpty) {
          yield SignupError("Bạn Cần Cung Cấp Họ Tên");
        } else if (registerBody.soDienThoai == null || registerBody.soDienThoai.isEmpty) {
          yield SignupError("Số Điện Thoại Không Thể Thiếu");
        } else if (registerBody.password == null || registerBody.password.isEmpty) {
          yield SignupError("Mật Khẩu Không Được Để Trống");
        } else {
          yield SignupLoading();
          RegisterResponse registerResponse = await apiAuthRepository.postRegisterUser(registerBody);
          if (registerResponse != null) {
            yield SignupSuccess();
          } else {
            yield SignupError("Vui Lòng Kiểm Tra Lại Thông Tin");
          }
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
