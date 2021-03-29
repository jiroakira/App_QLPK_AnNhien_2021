import 'package:equatable/equatable.dart';
import 'package:medapp/model/examination/list_examinations.dart';
import 'package:meta/meta.dart';

class ListExaminationsEvent extends Equatable {
  const ListExaminationsEvent();

  @override
  List<Object> get props => [];
}

class GetListExaminations extends ListExaminationsEvent {
  final String id;

  GetListExaminations({@required this.id});

  @override
  List<Object> get props => [id];
}
