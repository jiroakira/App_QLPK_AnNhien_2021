import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medapp/injector/injector.dart';
import 'package:medapp/model/update_user_info/user_update_info.dart';
import 'package:medapp/repository/update_user.dart';
import 'package:medapp/storage/sharedpreferences/shared_preferences_manager.dart';
import 'package:meta/meta.dart';

// bloc event
abstract class UpdateUserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ButtonUpdatePressed extends UpdateUserEvent {
  final String hoTen;
  final String soDienThoai;
  final String email;
  final String cmndCccd;
  final String ngaySinh;
  final String diaChi;
  final String danToc;
  final String maSoBaoHiem;
  final String gioiTinh;

  ButtonUpdatePressed({
    this.hoTen,
    this.soDienThoai,
    this.email,
    this.cmndCccd,
    this.ngaySinh,
    this.diaChi,
    this.danToc,
    this.maSoBaoHiem,
    this.gioiTinh,
  });

  @override
  List<Object> get props => [];
}

class GetUpdateUserInfo extends UpdateUserEvent {}

// bloc state
abstract class UpdateUserState extends Equatable {
  @override
  List<Object> get props => [];
}

class UpdateUserInitial extends UpdateUserState {}

class UpdateUserLoading extends UpdateUserState {}

class UpdateUserSuccess extends UpdateUserState {
  final ResponseUserUpdateInfoBody responseUserUpdateInfoBody;

  UpdateUserSuccess({@required this.responseUserUpdateInfoBody});
}

class UpdateUserError extends UpdateUserState {}

class GetUpdateUserInfoInitial extends UpdateUserState {}

class GetUpdateUserInfoEmpty extends UpdateUserState {}

class GetUpdateUserInfoLoading extends UpdateUserState {}

class GetUpdateUserInfoLoaded extends UpdateUserState {
  final UserUpdateInfoBody userUpdateInfoBody;

  GetUpdateUserInfoLoaded({this.userUpdateInfoBody});
}

class GetUpdateUserInfoError extends UpdateUserState {}

// bloc

class UpdateUserBloc extends Bloc<UpdateUserEvent, UpdateUserState> {
  UpdateUserBloc() : super(null);
  final UpdateUserRepository updateUserRepository = UpdateUserRepository();
  final SharedPreferencesManager sharedPreferencesManager = locator<SharedPreferencesManager>();

  @override
  void onTransition(Transition<UpdateUserEvent, UpdateUserState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  UpdateUserState get initialState => UpdateUserInitial();

  @override
  Stream<UpdateUserState> mapEventToState(UpdateUserEvent event) async* {
    if (event is ButtonUpdatePressed) {
      yield UpdateUserLoading();
      try {
        final String userId = sharedPreferencesManager.getString(SharedPreferencesManager.keyUserID);
        final ResponseUserUpdateInfoBody responseUserUpdateInfoBody = await updateUserRepository.putUserUpdateInfoRequest(
          UserUpdateInfoRequestBody(
            benhNhan: userId,
            hoTen: event.hoTen,
            soDienThoai: event.soDienThoai,
            email: event.email,
            cmndCccd: event.cmndCccd,
            ngaySinh: event.ngaySinh,
            gioiTinh: event.gioiTinh,
            diaChi: event.diaChi,
            danToc: event.danToc,
            maSoBaoHiem: event.maSoBaoHiem,
          ),
        );
        yield UpdateUserSuccess(responseUserUpdateInfoBody: responseUserUpdateInfoBody);
      } catch (e) {
        print(e);
        yield UpdateUserError();
      }
    }

    if (event is GetUpdateUserInfo) {
      yield GetUpdateUserInfoLoading();
      try {
        final String userId = sharedPreferencesManager.getString(SharedPreferencesManager.keyUserID);
        final UserUpdateInfoBody userUpdateInfoBody = await updateUserRepository.getUserUpdateInfo();
        if (userUpdateInfoBody.status == 200) {
          yield GetUpdateUserInfoLoaded(userUpdateInfoBody: userUpdateInfoBody);
        } else if (userUpdateInfoBody.status == 400) {
          yield GetUpdateUserInfoEmpty();
        }
      } catch (e) {
        yield GetUpdateUserInfoError();
      }
    }
  }
}
