import 'dart:async';
import 'package:medapp/api/appointment_api.dart';
import 'package:medapp/model/appointment/appointment.dart';
import 'package:medapp/model/appointment/appointment_response.dart';
import 'package:medapp/model/appointment/update_appt_info.dart';
import 'package:meta/meta.dart';
import 'package:medapp/model/appointment/all_visit.dart';
import 'package:medapp/model/appointment/response_appointment.dart';

class AppointmentRepository {
  final appointmentAPIClient = AppointmentAPIClient();

  Future<AppointmentModel> getAppointment() async {
    print(appointmentAPIClient.getAppointment());
    return await appointmentAPIClient.getAppointment();
  }

  Future<AppointmentResponseModel> sendAppointment(
    @required String benhNhan,
    @required String thoiGianBatDau,
  ) async {
    AppointmentRequestModel appointmentRequestModel = AppointmentRequestModel(
      benhNhan: benhNhan,
      thoiGianBatDau: thoiGianBatDau,
    );

    AppointmentResponseModel response = await appointmentAPIClient.sendAppointment(appointmentRequestModel);
    AppointmentResponseModel appointmentResponseModel = AppointmentResponseModel(
      error: response.error,
      message: response.message,
      status: response.status,
      data: response.data,
    );

    return appointmentResponseModel;
  }
}

class AllVisitRepository {
  final AllVisitProvider _allVisitProvider = AllVisitProvider();

  Future<AllVisitModel> getAllVisit() async {
    return await _allVisitProvider.getAllVisit();
  }
}

class RequestAppointmentRepository {
  final AppointmentRequestProvider _appointmentRequestProvider = AppointmentRequestProvider();
  Future<ResponseAppointment> postAppointmentRequest(
    @required String benhNhan,
    @required String thoiGianBatDau,
    @required String diaDiem,
    @required String lyDo,
    @required String loaiDichVu,
  ) async {
    AppointmentRequestModel appointmentRequestModel = AppointmentRequestModel(
      benhNhan: benhNhan,
      thoiGianBatDau: thoiGianBatDau,
      diaDiem: diaDiem,
      lyDo: lyDo,
      loaiDichVu: loaiDichVu,
    );

    ResponseAppointment responseAppointment = await _appointmentRequestProvider.postAppointmentRequest(appointmentRequestModel);
    return ResponseAppointment(benhNhan: responseAppointment.benhNhan, lichHen: responseAppointment.lichHen);
  }
}

class UpdateAppointmentRepository {
  final UpdateAppointmentProvider updateAppointmentProvider = UpdateAppointmentProvider();

  Future<UpdateAppointmentInfo> getUpdateAppointmentInfo(
    String appointment_id,
  ) async {
    final UpdateAppointmentProvider updateAppointmentProvider = UpdateAppointmentProvider();
    return await updateAppointmentProvider.getUpdateAppointmentInfo(appointment_id);
  }

  Future<UpdateAppointmentResponse> postUpdateAppointmentRequest(
    String appointmentId,
    String thoiGianBatDau,
    String diaDiem,
    String lyDo,
    String loaiDichVu,
  ) async {
    UpdateAppointmentRequestModel updateAppointmentRequestModel = UpdateAppointmentRequestModel(
      appointmentId: appointmentId,
      thoiGianBatDau: thoiGianBatDau,
      diaDiem: diaDiem,
      lyDo: lyDo,
      loaiDichVu: loaiDichVu,
    );

    UpdateAppointmentResponse updateAppointmentResponse = await updateAppointmentProvider.postUpdateAppointmentRequest(updateAppointmentRequestModel);
    return UpdateAppointmentResponse(status: updateAppointmentResponse.status, message: updateAppointmentResponse.message);
  }
}
