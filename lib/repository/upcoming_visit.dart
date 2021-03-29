import 'package:medapp/api/upcoming_visit.dart';
import 'package:medapp/model/appointment/upcoming_visit.dart';

class UpcomingVisitRepository {
  final UpcomingVisitApiProvider _upcomingVisitApiProvider = UpcomingVisitApiProvider();

  Future<UpcomingVisit> getUpcomingVisit() async {
    return await _upcomingVisitApiProvider.getUpcomingVist();
  }
}
