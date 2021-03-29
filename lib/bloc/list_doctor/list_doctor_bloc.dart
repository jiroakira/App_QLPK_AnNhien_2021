import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medapp/model/user/doctor.dart';
import 'package:medapp/repository/doctor.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class ListDoctorEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetAllDoctor extends ListDoctorEvent {}

abstract class ListDoctorState extends Equatable {
  @override
  List<Object> get props => [];
}

class ListDoctorInitial extends ListDoctorState {}

class ListDoctorLoading extends ListDoctorState {}

class ListDoctorLoaded extends ListDoctorState {
  final ListDoctorBody doctorBody;

  ListDoctorLoaded({@required this.doctorBody});
}

class ListDoctorEmpty extends ListDoctorState {}

class ListDoctorError extends ListDoctorState {}

class ListDoctorBloc extends Bloc<ListDoctorEvent, ListDoctorState> {
  ListDoctorBloc() : super(null);

  final DoctorRepository doctorRepository = DoctorRepository();

  @override
  ListDoctorState get initialState => ListDoctorInitial();

  @override
  Stream<ListDoctorState> mapEventToState(ListDoctorEvent event) async* {
    if (event is GetAllDoctor) {
      yield ListDoctorLoading();
      try {
        final ListDoctorBody doctorBody = await doctorRepository.getAllDoctor();
        if (doctorBody != null) {
          yield ListDoctorLoaded(doctorBody: doctorBody);
        } else {
          yield ListDoctorEmpty();
        }
      } catch (e) {
        yield ListDoctorError();
      }
    }
  }
}
