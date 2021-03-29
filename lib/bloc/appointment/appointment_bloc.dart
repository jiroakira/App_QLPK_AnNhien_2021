import 'package:medapp/model/appointment/appointment_response.dart';
import 'package:medapp/model/appointment/upcoming_visit.dart';
import 'package:medapp/repository/upcoming_visit.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:medapp/repository/appointment.dart';
import './appointment.dart';
import 'package:medapp/model/appointment/all_visit.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  // final AppointmentRepository appointmentRepository = AppointmentRepository();
  final UpcomingVisitRepository upcomingVisitRepository = UpcomingVisitRepository();

  AppointmentBloc() : super(null);

  @override
  void onTransition(Transition<AppointmentEvent, AppointmentState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  AppointmentState get initialState => AppointmentEmpty();

  @override
  Stream<AppointmentState> mapEventToState(AppointmentEvent event) async* {
    if (event is GetUpcomingAppointment) {
      yield AppointmentLoading();
      try {
        final UpcomingVisit upcomingVisit = await upcomingVisitRepository.getUpcomingVisit();
        if (upcomingVisit != null) {
          yield AppointmentLoaded(upcomingVisit: upcomingVisit);
        } else {
          yield AppointmentEmpty();
        }
      } catch (e) {
        print(e.toString());
        yield AppointmentError();
      }
    }
  }
}

class SendAppointmentRequestBloc extends Bloc<AppointmentEvent, AppointmentState> {
  final AppointmentRepository appointmentRepository = AppointmentRepository();
  SendAppointmentRequestBloc() : super(null);

  @override
  void onTransition(Transition<AppointmentEvent, AppointmentState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  AppointmentState get initialState => SendAppointmentRequestInitial();

  @override
  Stream<AppointmentState> mapEventToState(AppointmentEvent event) async* {
    if (event is ButtonSendAppointmentRequest) {
      yield SendAppointmentRequestLoading();
      try {
        final AppointmentResponseModel appointmentResponseModel = await appointmentRepository.sendAppointment("9", event.thoiGianBatDau);
        print(appointmentResponseModel);

        yield SendAppointmentRequestSuccess(appointmentResponseModel: appointmentResponseModel);
      } catch (e) {
        print(e.toString());
        yield SendAppointmentRequestError();
      }
    }
  }
}

class AllVisitBloc extends Bloc<AppointmentEvent, AppointmentState> {
  AllVisitBloc() : super(AllVisitInitial());

  final AllVisitRepository _allVisitRepository = AllVisitRepository();

  @override
  void onTransition(Transition<AppointmentEvent, AppointmentState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  AppointmentState get initialState => AllVisitInitial();

  @override
  Stream<AppointmentState> mapEventToState(AppointmentEvent event) async* {
    if (event is GetAllVisit) {
      yield AllVisitLoading();

      try {
        final AllVisitModel allVisitModel = await _allVisitRepository.getAllVisit();

        if (allVisitModel != null) {
          yield AllVisitLoaded(allVisitModel: allVisitModel);
        } else {
          yield AllVisitEmpty();
        }
      } catch (e, stacktrace) {
        print(stacktrace.toString());
        print(e.toString());
        yield AllVisitError();
      }
    }
  }
}
