import 'package:equatable/equatable.dart';
import 'package:medapp/model/appointment/response_appointment.dart';
import 'package:medapp/repository/appointment.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medapp/storage/sharedpreferences/shared_preferences_manager.dart';
import 'package:medapp/injector/injector.dart';

// bloc event

abstract class RequestAppointmentEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PostAppointmentRequest extends RequestAppointmentEvent {
  final String thoiGianBatDau;
  final String diaDiem;
  final String loaiDichVu;
  final String lyDo;

  PostAppointmentRequest({this.loaiDichVu, this.lyDo, this.diaDiem, this.thoiGianBatDau});

  @override
  List<Object> get props => [
        thoiGianBatDau,
        diaDiem,
        loaiDichVu,
        lyDo,
      ];
}

// bloc state

abstract class RequestAppointmentState extends Equatable {
  @override
  List<Object> get props => [];
}

class RequestAppointmentInitial extends RequestAppointmentState {}

class RequestAppointmentSuccess extends RequestAppointmentState {
  final ResponseAppointment responseAppointment;

  RequestAppointmentSuccess({this.responseAppointment});
}

class RequestAppointmentError extends RequestAppointmentState {}

class RequestAppointmentLoading extends RequestAppointmentState {}

// bloc

class RequestAppointmentBloc extends Bloc<RequestAppointmentEvent, RequestAppointmentState> {
  RequestAppointmentBloc() : super(null);

  final RequestAppointmentRepository requestAppointmentRepository = RequestAppointmentRepository();

  final SharedPreferencesManager sharedPreferencesManager = locator<SharedPreferencesManager>();

  @override
  RequestAppointmentState get initialState => RequestAppointmentInitial();

  @override
  void onTransition(Transition<RequestAppointmentEvent, RequestAppointmentState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  Stream<RequestAppointmentState> mapEventToState(RequestAppointmentEvent event) async* {
    if (event is PostAppointmentRequest) {
      try {
        yield RequestAppointmentLoading();
        final String userId = sharedPreferencesManager.getString(SharedPreferencesManager.keyUserID);
        final ResponseAppointment responseAppointment = await requestAppointmentRepository.postAppointmentRequest(
          userId,
          event.thoiGianBatDau,
          event.diaDiem,
          event.loaiDichVu,
          event.lyDo,
        );
        yield RequestAppointmentSuccess(responseAppointment: responseAppointment);
      } catch (e) {
        print(e.toString());
        yield RequestAppointmentError();
      }
    }
  }
}
