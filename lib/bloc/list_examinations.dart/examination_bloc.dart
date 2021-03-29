import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medapp/model/examination/examination.dart';
import 'package:medapp/model/examination/list_examinations.dart';
import 'package:medapp/repository/list_examinations.dart';
import 'package:meta/meta.dart';

// bloc state
class ExaminationsState extends Equatable {
  const ExaminationsState();

  @override
  List<Object> get props => [];
}

class ListExaminationsInitial extends ExaminationsState {}

class ListExaminationEmpty extends ExaminationsState {}

class ListExaminationLoading extends ExaminationsState {}

class ListExaminationLoaded extends ExaminationsState {
  final ListExaminationsBody listExaminationsBody;

  ListExaminationLoaded({@required this.listExaminationsBody});

  @override
  List<Object> get props => [listExaminationsBody];
}

class ListExaminationError extends ExaminationsState {}

class SingleExaminationInitial extends ExaminationsState {}

class SingleExaminationLoading extends ExaminationsState {}

class SingleExaminationEmpty extends ExaminationsState {}

class SingleExaminationLoaded extends ExaminationsState {
  final ExaminationBody examinationBody;

  SingleExaminationLoaded({@required this.examinationBody});
}

class SingleExaminationError extends ExaminationsState {}

// bloc event
abstract class ExaminationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetListExaminations extends ExaminationEvent {}

class GetExamination extends ExaminationEvent {
  final String idChuoiKham;

  GetExamination({this.idChuoiKham});
}

// bloc

class ListExaminationBloc extends Bloc<ExaminationEvent, ExaminationsState> {
  ListExaminationBloc() : super(null);

  final ExaminationsRepository examinationsRepository = ExaminationsRepository();

  @override
  ExaminationsState get initialState => ListExaminationsInitial();

  @override
  void onTransition(Transition<ExaminationEvent, ExaminationsState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  Stream<ExaminationsState> mapEventToState(ExaminationEvent event) async* {
    if (event is GetListExaminations) {
      yield ListExaminationLoading();
      try {
        final ListExaminationsBody listExaminationsBody = await examinationsRepository.getListExaminations();
        if (listExaminationsBody != null) {
          yield ListExaminationLoaded(listExaminationsBody: listExaminationsBody);
        } else {
          yield ListExaminationEmpty();
        }
      } catch (e) {
        print(e.toString());
        yield ListExaminationError();
      }
    }
  }
}

class SingleExaminationBloc extends Bloc<ExaminationEvent, ExaminationsState> {
  SingleExaminationBloc() : super(null);

  final ExaminationsRepository examinationsRepository = ExaminationsRepository();

  @override
  ExaminationsState get initialState => SingleExaminationInitial();

  @override
  void onTransition(Transition<ExaminationEvent, ExaminationsState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  Stream<ExaminationsState> mapEventToState(ExaminationEvent event) async* {
    if (event is GetExamination) {
      yield SingleExaminationLoading();
      try {
        final ExaminationBody examinationBody = await examinationsRepository.getExaminationDetail(event.idChuoiKham);

        // if (examinationBody.data.isEmpty) {
        //   yield SingleExaminationEmpty();
        // } else {
        //   yield SingleExaminationLoaded(examinationBody: examinationBody);
        // }
        if (examinationBody != null) {
          yield SingleExaminationLoaded(examinationBody: examinationBody);
        } else {
          yield SingleExaminationEmpty();
        }
      } catch (e) {
        print(e.toString());
        yield SingleExaminationError();
      }
    }
  }
}
