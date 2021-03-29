import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medapp/model/functional_room/functional_room.dart';
import 'package:medapp/repository/func_room.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class FuncRoomEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetAllFuncRoom extends FuncRoomEvent {}

abstract class FuncRoomState extends Equatable {
  @override
  List<Object> get props => [];
}

class FuncRoomInitial extends FuncRoomState {}

class FuncRoomLoading extends FuncRoomState {}

class FuncRoomLoaded extends FuncRoomState {
  final FunctionalRoom functionalRoom;

  FuncRoomLoaded({@required this.functionalRoom});
}

class FuncRoomEmpty extends FuncRoomState {}

class FuncRoomError extends FuncRoomState {}

class FuncRoomBloc extends Bloc<FuncRoomEvent, FuncRoomState> {
  FuncRoomBloc() : super(null);

  final FuncRoomRepository funcRoomRepository = FuncRoomRepository();

  @override
  FuncRoomState get initialState => FuncRoomInitial();

  @override
  Stream<FuncRoomState> mapEventToState(FuncRoomEvent event) async* {
    if (event is GetAllFuncRoom) {
      yield FuncRoomLoading();
      try {
        final FunctionalRoom functionalRoom = await funcRoomRepository.getAllFuncRoom();
        if (functionalRoom != null) {
          yield FuncRoomLoaded(functionalRoom: functionalRoom);
        } else {
          yield FuncRoomEmpty();
        }
      } catch (e) {
        yield FuncRoomError();
      }
    }
  }
}
