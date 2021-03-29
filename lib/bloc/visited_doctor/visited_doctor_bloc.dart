import 'package:bloc/bloc.dart';
import 'package:medapp/bloc/visited_doctor/visited_doctor.dart';
import 'package:medapp/model/visited_doctor.dart';
import 'package:medapp/repository/visited_doctor.dart';

class VisitedDoctorBloc extends Bloc<VisitedDoctorEvent, VisitedDoctorState> {
  final VisitedDoctorRepository visitedDoctorRepository =
      VisitedDoctorRepository();

  VisitedDoctorBloc() : super(null);

  @override
  void onTransition(
      Transition<VisitedDoctorEvent, VisitedDoctorState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  VisitedDoctorState get initialState => VisitedDoctorEmpty();

  @override
  Stream<VisitedDoctorState> mapEventToState(VisitedDoctorEvent event) async* {
    if (event is GetVisitedDoctor) {
      yield VisitedDoctorLoading();
      print("hit this state");
      try {
        final ListVisitedDoctor listVisitedDoctor =
            await visitedDoctorRepository.getVisitedDoctor();
        print("hit this state 2");
        print(listVisitedDoctor.visitedDoctor);
        if (listVisitedDoctor != null) {
          print("hit this state 3");
          yield VisitedDoctorLoaded(listVisitedDoctor);
        } else {
          yield VisitedDoctorEmpty();
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }
}
