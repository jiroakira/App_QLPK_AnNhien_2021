import 'package:medapp/api/doctor.dart';
import 'package:medapp/model/user/doctor.dart';

class DoctorRepository {
  final DoctorsProvider doctorsProvider = DoctorsProvider();
  Future<ListDoctorBody> getAllDoctor() async {
    return await doctorsProvider.getListDoctor();
  }
}
