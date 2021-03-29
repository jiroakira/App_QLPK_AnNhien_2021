import 'package:equatable/equatable.dart';
import 'package:medapp/repository/user_info.dart';
import 'package:medapp/model/user/user_info.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

// bloc event
abstract class UserInfoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetUserInfo extends UserInfoEvent {}

// bloc state
abstract class UserInfoState extends Equatable {
  @override
  List<Object> get props => [];
}

class UserInfoInitial extends UserInfoState {}

class UserInfoLoading extends UserInfoState {}

class UserInfoLoaded extends UserInfoState {
  final UserInforBody userInforBody;

  UserInfoLoaded({@required this.userInforBody});
}

class UserInfoError extends UserInfoState {}

class UserInfoEmpty extends UserInfoState {}

// bloc
class UserInfoBloc extends Bloc<UserInfoEvent, UserInfoState> {
  final UserInfoRepository userInfoRepository = UserInfoRepository();

  UserInfoBloc() : super(UserInfoInitial());

  @override
  UserInfoState get initialState => UserInfoInitial();

  @override
  Stream<UserInfoState> mapEventToState(UserInfoEvent event) async* {
    if (event is GetUserInfo) {
      yield UserInfoLoading();
      try {
        final UserInforBody userInforBody = await userInfoRepository.getUserInfo();
        if (userInforBody != null) {
          yield UserInfoLoaded(userInforBody: userInforBody);
        } else {
          yield UserInfoEmpty();
        }
      } catch (e) {
        print(e.toString());
        yield UserInfoError();
      }
    }
  }
}
