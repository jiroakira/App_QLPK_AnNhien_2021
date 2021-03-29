import 'dart:convert';
import 'package:medapp/model/visited_doctor.dart';
import 'package:http/http.dart' as http;

class VisitedDoctorAPIClient {
  final _url = "https://run.mocky.io/v3/850dd066-92f5-483b-be36-85c3696d2d78";

  Future<ListVisitedDoctor> getVisitedDoctor() async {
    final response = await http.get(_url);
    final l = jsonDecode(response.body);
    print(l);
    return ListVisitedDoctor.fromJson(l);
  }
}
