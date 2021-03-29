import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medapp/model/checkup_process/latest_process.dart';
import 'package:medapp/repository/checkup_process.dart';
import 'package:meta/meta.dart';

// bloc event
abstract class LatestCheckupEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetLatestCheckupProcess extends LatestCheckupEvent {}

// bloc state

abstract class LatestCheckupState extends Equatable {
  @override
  List<Object> get props => [];
}

class LatestCheckupInitial extends LatestCheckupState {}

class LatestCheckupLoading extends LatestCheckupState {}

class LatestCheckupLoaded extends LatestCheckupState {
  final LatestCheckupProcessBody latestCheckupProcessBody;

  LatestCheckupLoaded({@required this.latestCheckupProcessBody});

  @override
  List<Object> get props => [latestCheckupProcessBody];
}

class LatestCheckupEmpty extends LatestCheckupState {}

class LatestCheckupError extends LatestCheckupState {}

// bloc

class LatestCheckupBloc extends Bloc<LatestCheckupEvent, LatestCheckupState> {
  LatestCheckupBloc() : super(null);

  final CheckupProcessRepository checkupProcessRepository = CheckupProcessRepository();

  @override
  LatestCheckupState get initialState => LatestCheckupInitial();

  @override
  void onTransition(Transition<LatestCheckupEvent, LatestCheckupState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  Stream<LatestCheckupState> mapEventToState(LatestCheckupEvent event) async* {
    if (event is GetLatestCheckupProcess) {
      yield LatestCheckupLoading();
      try {
        final LatestCheckupProcessBody latestCheckupProcessBody = await checkupProcessRepository.getLatestCheckupProcess();

        if (latestCheckupProcessBody != null) {
          yield LatestCheckupLoaded(latestCheckupProcessBody: latestCheckupProcessBody);
        } else {
          yield LatestCheckupEmpty();
        }
      } catch (e) {
        print(e.toString());
        yield LatestCheckupError();
      }
    }
  }
}
