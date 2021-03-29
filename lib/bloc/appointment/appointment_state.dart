import 'package:equatable/equatable.dart';
import 'package:medapp/model/appointment/appointment_response.dart';
import 'package:medapp/model/appointment/upcoming_visit.dart';
import 'package:medapp/repository/appointment.dart';
import 'package:meta/meta.dart';
import 'package:medapp/model/appointment/all_visit.dart';

abstract class AppointmentState extends Equatable {
  const AppointmentState();

  @override
  List<Object> get props => [];
}

class AppointmentEmpty extends AppointmentState {}

class AppointmentLoading extends AppointmentState {}

class AppointmentLoaded extends AppointmentState {
  final UpcomingVisit upcomingVisit;

  AppointmentLoaded({@required this.upcomingVisit}) : assert(upcomingVisit != null);

  @override
  List<Object> get props => [upcomingVisit];
}

class AppointmentError extends AppointmentState {}

class SendAppointmentRequestInitial extends AppointmentState {}

class SendAppointmentRequestLoading extends AppointmentState {}

class SendAppointmentRequestSuccess extends AppointmentState {
  final AppointmentResponseModel appointmentResponseModel;

  SendAppointmentRequestSuccess({@required this.appointmentResponseModel});

  @override
  List<Object> get props => [appointmentResponseModel];
}

class SendAppointmentRequestError extends AppointmentState {}

class AllVisitInitial extends AppointmentState {}

class AllVisitEmpty extends AppointmentState {}

class AllVisitLoading extends AppointmentState {}

class AllVisitLoaded extends AppointmentState {
  final AllVisitModel allVisitModel;

  AllVisitLoaded({@required this.allVisitModel});

  @override
  List<Object> get props => [allVisitModel];
}

class AllVisitError extends AppointmentState {}
