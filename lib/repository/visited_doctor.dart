import 'dart:async';
import 'package:medapp/api/visited_doctor_api.dart';
import 'package:medapp/model/visited_doctor.dart';

class VisitedDoctorRepository {
  final visitedDoctorAPIClient = VisitedDoctorAPIClient();
  Future<ListVisitedDoctor> getVisitedDoctor() async {
    return await visitedDoctorAPIClient.getVisitedDoctor();
  }
}
