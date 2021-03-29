import 'dart:async';
import 'package:medapp/api/examination.dart';
import 'package:medapp/model/examination/examination.dart';
import 'package:medapp/model/examination/list_examinations.dart';

class ExaminationsRepository {
  final listExaminationAPIClient = ExaminationApiProvider();

  Future<ListExaminationsBody> getListExaminations() async {
    return await listExaminationAPIClient.getListExaminations();
  }

  Future<ExaminationBody> getExaminationDetail(String idChuoiKham) async {
    return await listExaminationAPIClient.getExaminationDetail(idChuoiKham);
  }
}
