import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medapp/injector/injector.dart';
import 'package:medapp/model/appointment/appointment.dart';
import 'package:medapp/model/appointment/response_appointment.dart';
import 'package:medapp/repository/appointment.dart';
import 'package:medapp/model/appointment/update_appt_info.dart';
import 'package:medapp/storage/sharedpreferences/shared_preferences_manager.dart';
import 'package:meta/meta.dart';

// bloc event
abstract class UpdateAppointmentInfoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetUpdateAppointmentInfo extends UpdateAppointmentInfoEvent {
  final String appointmentId;

  GetUpdateAppointmentInfo({@required this.appointmentId});

  @override
  List<Object> get props => [appointmentId];
}

class PostAppointmentRequestUpdate extends UpdateAppointmentInfoEvent {
  final String appointmentId;
  final String thoiGianBatDau;
  final String diaDiem;
  final String loaiDichVu;
  final String lyDo;

  PostAppointmentRequestUpdate({this.appointmentId, this.loaiDichVu, this.lyDo, this.diaDiem, this.thoiGianBatDau});

  @override
  List<Object> get props => [
        appointmentId,
        thoiGianBatDau,
        diaDiem,
        loaiDichVu,
        lyDo,
      ];
}

// bloc state
abstract class UpdateAppointmentInfoState extends Equatable {
  @override
  List<Object> get props => [];
}

class UpdateAppointmentInfoInitial extends UpdateAppointmentInfoState {}

class UpdateAppointmentInfoLoading extends UpdateAppointmentInfoState {}

class UpdateAppointmentInfoEmpty extends UpdateAppointmentInfoState {}

class UpdateAppointmentInfoLoaded extends UpdateAppointmentInfoState {
  final UpdateAppointmentInfo updateAppointmentInfo;

  UpdateAppointmentInfoLoaded({this.updateAppointmentInfo});
}

class UpdateAppointmentInfoError extends UpdateAppointmentInfoState {}

class UpdateRequestAppointmentInitial extends UpdateAppointmentInfoState {}

class UpdateRequestAppointmentSuccess extends UpdateAppointmentInfoState {
  final UpdateAppointmentResponse updateAppointmentResponse;

  UpdateRequestAppointmentSuccess({this.updateAppointmentResponse});
}

class UpdateRequestAppointmentError extends UpdateAppointmentInfoState {}

class UpdateRequestAppointmentLoading extends UpdateAppointmentInfoState {}

// bloc

class UpdateAppointmentInfoBloc extends Bloc<UpdateAppointmentInfoEvent, UpdateAppointmentInfoState> {
  UpdateAppointmentInfoBloc() : super(null);
  final UpdateAppointmentRepository updateAppointmentRepository = UpdateAppointmentRepository();

  final RequestAppointmentRepository requestAppointmentRepository = RequestAppointmentRepository();

  final SharedPreferencesManager sharedPreferencesManager = locator<SharedPreferencesManager>();

  @override
  UpdateAppointmentInfoState get initialState => UpdateAppointmentInfoInitial();

  @override
  void onTransition(Transition<UpdateAppointmentInfoEvent, UpdateAppointmentInfoState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  Stream<UpdateAppointmentInfoState> mapEventToState(UpdateAppointmentInfoEvent event) async* {
    if (event is GetUpdateAppointmentInfo) {
      try {
        yield UpdateAppointmentInfoLoading();
        final UpdateAppointmentInfo updateAppointmentInfo = await updateAppointmentRepository.getUpdateAppointmentInfo(event.appointmentId);
        if (updateAppointmentInfo != null) {
          yield UpdateAppointmentInfoLoaded(updateAppointmentInfo: updateAppointmentInfo);
        } else {
          yield UpdateAppointmentInfoEmpty();
        }
      } catch (e) {
        print(e.toString());
        yield UpdateAppointmentInfoError();
      }
    } else if (event is PostAppointmentRequestUpdate) {
      yield UpdateRequestAppointmentLoading();
      try {
        Future.delayed(Duration(milliseconds: 2500));
        // final String userId = sharedPreferencesManager.getString(SharedPreferencesManager.keyUserID);
        final UpdateAppointmentResponse updateAppointmentResponse = await updateAppointmentRepository.postUpdateAppointmentRequest(
          event.appointmentId,
          event.thoiGianBatDau,
          event.diaDiem,
          event.lyDo,
          event.loaiDichVu,
        );
        yield UpdateRequestAppointmentSuccess(updateAppointmentResponse: updateAppointmentResponse);
      } catch (e) {
        print(e.toString());
        yield UpdateRequestAppointmentError();
      }
    }
  }
}
