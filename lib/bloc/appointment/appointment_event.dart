import 'package:equatable/equatable.dart';
import 'package:medapp/model/appointment/appointment_response.dart';
import 'package:meta/meta.dart';

abstract class AppointmentEvent extends Equatable {
  const AppointmentEvent();

  @override
  List<Object> get props => [];
}

class GetUpcomingAppointment extends AppointmentEvent {
  @override
  List<Object> get props => [];
}

class GetAllAppointments extends AppointmentEvent {
  @override
  List<Object> get props => [];
}

class ButtonSendAppointmentRequest extends AppointmentEvent {
  final int benhNhan;
  final String thoiGianBatDau;

  ButtonSendAppointmentRequest({@required this.benhNhan, @required this.thoiGianBatDau});

  @override
  List<Object> get props => [benhNhan, thoiGianBatDau];
}

class GetAppointmentResponse extends AppointmentEvent {
  final AppointmentResponseModel appointmentResponseModel;

  GetAppointmentResponse({@required this.appointmentResponseModel});

  @override
  List<Object> get props => [appointmentResponseModel];
}

class GetAllVisit extends AppointmentEvent {}
