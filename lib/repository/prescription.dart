import 'package:medapp/model/prescription/list_prescription.dart';
import 'package:medapp/model/prescription/prescription.dart';
import 'package:medapp/api/prescription_api.dart';
import 'package:medapp/model/prescription/latest_prescription.dart';

class PrescriptionApiRepository {
  final PrescriptionApiProvider prescriptionApiProvider = PrescriptionApiProvider();

  Future<ListPrescriptionBody> getListPrescription() async {
    return await prescriptionApiProvider.getListPrescription();
  }

  Future<PrescriptionBody> getPrescription(String donThuocId) async {
    return await prescriptionApiProvider.getPrescription(donThuocId);
  }

  Future<LatestPrescription> getLatestPrescription() async {
    return await prescriptionApiProvider.getLatestPrescription();
  }

  Future<PrescriptionBody> getExaminationPrescription(String chuoiKhamId) async {
    return await prescriptionApiProvider.getExaminationPrescription(chuoiKhamId);
  }
}
