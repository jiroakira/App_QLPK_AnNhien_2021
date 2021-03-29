import 'package:bloc/bloc.dart';
import 'login_event.dart';
import 'login_state.dart';
import '../authentication/authentication_bloc.dart';

import 'package:medapp/bloc/authentication/authentication_event.dart';
import 'package:medapp/repository/login.dart';
import 'package:meta/meta.dart';

// class LoginBloc extends Bloc<LoginEvent, LoginState> {
//   final AuthenticationBloc _authenticationBloc;
//   // final AuthenticationService _authenticatio
//   final LoginRepository _loginRepository;

//   LoginBloc(
//     AuthenticationBloc authenticationBloc,
//     LoginRepository loginRepository,
//   )   : assert(authenticationBloc != null),
//         assert(loginRepository != null),
//         _authenticationBloc = authenticationBloc,
//         _loginRepository = loginRepository,
//         super(LoginInitial());

//   @override
//   Stream<LoginState> mapEventToState(LoginEvent event) async* {
//     if (event is LoginInWithEmailButtonPressed) {
//       yield* _mapLoginWithEmailToState(event);
//     }
//   }

//   Stream<LoginState> _mapLoginWithEmailToState(
//       LoginInWithEmailButtonPressed event) async* {
//     yield LoginLoading();
//     try {
//       final user = await _loginRepository.authenticate(
//           email: event.email, password: event.password);
//       if (user != null) {
//         _authenticationBloc.add(UserLoggedIn(user: user));
//         yield LoginSuccess();
//         yield LoginInitial();
//       } else {
//         yield LoginFailure(error: 'Something very weird just happened');
//       }
//     } catch (err) {
//       yield LoginFailure(error: 'An unknown error occured');
//     }
//   }
// }

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required this.loginRepository,
    @required this.authenticationBloc,
  })  : assert(loginRepository != null),
        assert(authenticationBloc != null),
        super(null);

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginInWithEmailButtonPressed) {
      yield LoginInitial();
      yield LoginLoading();
      try {
        final user = await loginRepository.authenticate(
          email: event.email,
          password: event.password,
        );

        authenticationBloc.add(UserLoggedIn(user: user));
        yield LoginInitial();
      } catch (error) {
        print(error);
        yield LoginFailure(error: error.message);
      }
    }
  }
}
