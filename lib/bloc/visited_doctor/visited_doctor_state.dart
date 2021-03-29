import 'package:equatable/equatable.dart';
import 'package:medapp/model/visited_doctor.dart';

abstract class VisitedDoctorState extends Equatable {
  const VisitedDoctorState();

  @override
  List<Object> get props => [];
}

class VisitedDoctorEmpty extends VisitedDoctorState {}

class VisitedDoctorLoading extends VisitedDoctorState {}

class VisitedDoctorLoaded extends VisitedDoctorState {
  final ListVisitedDoctor listVisitedDoctor;

  VisitedDoctorLoaded(this.listVisitedDoctor);

  @override
  List<Object> get props => [listVisitedDoctor];
}

class VisitedDoctorError extends VisitedDoctorState {}
