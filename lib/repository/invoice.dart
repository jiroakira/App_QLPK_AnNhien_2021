import 'package:medapp/api/examination.dart';
import 'package:medapp/model/appointment/first_invoice.dart';
import 'package:medapp/model/examination/examination_invoice.dart';
import 'package:medapp/model/examination/prescription_invoice.dart';

class InvoiceRepository {
  final ExaminationApiProvider examinationApiProvider = ExaminationApiProvider();

  Future<ExaminationsInvoice> getExaminationsInvoice() async {
    return await examinationApiProvider.getExaminationsInvoice();
  }

  Future<PrescriptionInvoice> getPrescriptionInvoice() async {
    return await examinationApiProvider.getPrescriptionInvoice();
  }

  Future<ExaminationsInvoice> getExamInvoice(String chuoiKhamId) async {
    return await examinationApiProvider.getExamInvoice(chuoiKhamId);
  }

  Future<PrescriptionInvoice> getPresInvoice(String chuoiKhamId) async {
    return await examinationApiProvider.getPresInvoice(chuoiKhamId);
  }

  Future<FirstInvoice> getFirstInvoice(String lichHenId) async {
    return await examinationApiProvider.getFirstInvoice(lichHenId);
  }

  Future<FirstInvoice> getLatestFirstInvoice() async {
    return await examinationApiProvider.getLatestFirstInvoice();
  }
}
