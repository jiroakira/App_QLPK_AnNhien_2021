import 'package:medapp/api/process.dart';
import 'package:medapp/model/checkup_process/process.dart';
import 'package:medapp/model/checkup_process/latest_process.dart';

class CheckupProcessRepository {
  final CheckupProcessProvider _checkupProcessProvider = CheckupProcessProvider();

  Future<CheckupProcessBody> getCheckupProcess() async {
    return await _checkupProcessProvider.getCheckupProcess();
  }

  Future<LatestCheckupProcessBody> getLatestCheckupProcess() async {
    return await _checkupProcessProvider.getLatestCheckupProcess();
  }
}
