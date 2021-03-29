import 'package:bloc/bloc.dart';
import 'package:medapp/bloc/register/register_event.dart';
import 'package:medapp/bloc/register/register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc(RegisterState initialState) : super(initialState);

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }
}
