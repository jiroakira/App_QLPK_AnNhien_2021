import 'package:medapp/bloc/list_examinations.dart/list_examinations.dart';
import 'package:bloc/bloc.dart';
import 'package:medapp/repository/list_examinations.dart';
import 'package:medapp/model/examination/list_examinations.dart';

class ListExaminationsBloc extends Bloc<ListExaminationsEvent, ListExaminationsState> {
  ListExaminationsBloc() : super(null);
  final ExaminationsRepository listExaminationsRepository = ExaminationsRepository();

  @override
  ListExaminationsState get initialState => ListExaminationsInitial();

  @override
  void onTransition(Transition<ListExaminationsEvent, ListExaminationsState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  Stream<ListExaminationsState> mapEventToState(ListExaminationsEvent event) async* {
    if (event is GetListExaminations) {
      yield ListExaminationLoading();
      try {
        final ListExaminationsBody listExaminationsModel = await listExaminationsRepository.getListExaminations();

        yield ListExaminationLoaded(listExaminationsModel: listExaminationsModel);
      } catch (e) {
        print(e.toString());
        yield ListExaminationError();
      }
    }
  }
}
