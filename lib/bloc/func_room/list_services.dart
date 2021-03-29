import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medapp/model/service/list_services.dart';
import 'package:medapp/repository/list_services.dart';

// bloc state
abstract class ListServicesState extends Equatable {
  @override
  List<Object> get props => [];
}

class ListServicesInitial extends ListServicesState {}

class ListServicesLoading extends ListServicesState {}

class ListServicesEmpty extends ListServicesState {}

class ListServicesLoaded extends ListServicesState {
  final ListServices listServices;

  ListServicesLoaded({this.listServices});
}

class ListServicesError extends ListServicesState {}

// bloc event
abstract class ListServicesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetListServices extends ListServicesEvent {
  final String funcRoomId;

  GetListServices({this.funcRoomId});
}

// bloc

class ListServicesBloc extends Bloc<ListServicesEvent, ListServicesState> {
  ListServicesBloc() : super(ListServicesInitial());
  final ListServicesRepository listServicesRepository = ListServicesRepository();

  @override
  ListServicesState get initialState => ListServicesInitial();

  @override
  void onTransition(Transition<ListServicesEvent, ListServicesState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  Stream<ListServicesState> mapEventToState(ListServicesEvent event) async* {
    if (event is GetListServices) {
      yield ListServicesLoading();
      try {
        final ListServices listServices = await listServicesRepository.getAllServices(event.funcRoomId);
        if (listServices != null) {
          yield ListServicesLoaded(listServices: listServices);
        } else {
          yield ListServicesEmpty();
        }
      } catch (e) {
        print(e.toString());
        yield ListServicesError();
      }
    }
  }
}
