import 'package:medapp/api/all_doctor.dart';
import 'package:medapp/model/all_doctor.dart';

class AllDoctorRepository {
  final AllDoctorProvider allDoctorProvider = AllDoctorProvider();

  Future<DoctorBody> getAllDoctor() async {
    return await allDoctorProvider.getAllDoctor();
  }
}
