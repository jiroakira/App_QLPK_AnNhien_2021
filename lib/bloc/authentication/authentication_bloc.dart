import 'package:bloc/bloc.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';
import 'package:medapp/repository/login.dart';
import 'package:meta/meta.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final LoginRepository loginRepository;

  AuthenticationBloc({@required this.loginRepository})
      : assert(LoginRepository != null),
        super(null);

  @override
  void onTransition(Transition<AuthenticationEvent, AuthenticationState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  AuthenticationState get initialState => AuthenticationInitial();

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    if (event is AppLoaded) {
      yield AuthenticationInitial();
    }

    if (event is UserLoggedIn) {
      yield* _mapUserLoggedInToState(event);
    }

    if (event is UserLoggedOut) {
      yield* _mapUserLoggedOutToState(event);
    }
  }

  Stream<AuthenticationState> _mapAppLoadedToState(AppLoaded event) async* {
    yield AuthenticationLoading();
    await Future.delayed(Duration(milliseconds: 1000));
    try {
      await Future.delayed(Duration(milliseconds: 500)); // a simulated delay
      final currentUser = await loginRepository.getCurrentUser();

      if (currentUser != null) {
        yield AuthenticationAuthenticated(user: currentUser);
      } else {
        yield AuthenticationNotAuthenticated();
      }
    } catch (e) {
      yield AuthenticationFailure(message: e.message ?? 'An unknown error occurred');
    }
  }

  Stream<AuthenticationState> _mapUserLoggedInToState(UserLoggedIn event) async* {
    yield AuthenticationAuthenticated(user: event.user);
  }

  Stream<AuthenticationState> _mapUserLoggedOutToState(UserLoggedOut event) async* {
    await loginRepository.signOut();
    yield AuthenticationNotAuthenticated();
  }
}
