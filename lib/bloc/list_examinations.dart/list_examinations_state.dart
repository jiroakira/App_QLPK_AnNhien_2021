import 'package:equatable/equatable.dart';
import 'package:medapp/model/examination/list_examinations.dart';
import 'package:meta/meta.dart';

class ListExaminationsState extends Equatable {
  const ListExaminationsState();

  @override
  List<Object> get props => [];
}

class ListExaminationsInitial extends ListExaminationsState {}

class ListExaminationEmpty extends ListExaminationsState {}

class ListExaminationLoading extends ListExaminationsState {}

class ListExaminationLoaded extends ListExaminationsState {
  final ListExaminationsBody listExaminationsModel;

  ListExaminationLoaded({@required this.listExaminationsModel});

  @override
  List<Object> get props => [listExaminationsModel];
}

class ListExaminationError extends ListExaminationsState {}
