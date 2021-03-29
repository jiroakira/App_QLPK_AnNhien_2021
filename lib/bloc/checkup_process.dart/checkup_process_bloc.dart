import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medapp/model/checkup_process/process.dart';
import 'package:medapp/repository/checkup_process.dart';
import 'package:meta/meta.dart';

// bloc event
abstract class CheckupProcessEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetCheckupProcesses extends CheckupProcessEvent {
  // final CheckupProcessBody checkupProcessModel;

  // GetCheckupProcesses({@required this.checkupProcessModel});
}

// bloc state
abstract class CheckupProcessState extends Equatable {
  @override
  List<Object> get props => [];
}

class CheckupProcessInitial extends CheckupProcessState {}

class CheckupProcessLoading extends CheckupProcessState {}

class CheckupProcessEmpty extends CheckupProcessState {}

class CheckupProcessLoaded extends CheckupProcessState {
  final CheckupProcessBody checkupProcessModel;

  CheckupProcessLoaded({@required this.checkupProcessModel});
}

class CheckupProcessError extends CheckupProcessState {}

// bloc
class CheckupProcessBloc extends Bloc<CheckupProcessEvent, CheckupProcessState> {
  final CheckupProcessRepository checkupProcessRepository = CheckupProcessRepository();

  CheckupProcessBloc() : super(null);

  @override
  CheckupProcessState get initialState => CheckupProcessInitial();

  @override
  Stream<CheckupProcessState> mapEventToState(CheckupProcessEvent event) async* {
    // TODO: implement mapEventToState
    if (event is GetCheckupProcesses) {
      yield CheckupProcessLoading();
      try {
        final CheckupProcessBody checkupProcessModel = await checkupProcessRepository.getCheckupProcess();

        if (checkupProcessModel != null) {
          yield CheckupProcessLoaded(checkupProcessModel: checkupProcessModel);
        } else {
          yield CheckupProcessEmpty();
        }
      } catch (e) {
        yield CheckupProcessError();
      }
    }
  }
}
