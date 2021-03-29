import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medapp/model/list_promotions.dart';
import 'package:medapp/repository/list_promotions_repository.dart';

abstract class PromotionsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetListPromotions extends PromotionsEvent {}

abstract class PromotionsState extends Equatable {
  @override
  List<Object> get props => [];
}

class PromotionsInitial extends PromotionsState {}

class PromotionsLoading extends PromotionsState {}

class PromotionsLoaded extends PromotionsState {
  final ListPromotions listPromotions;

  PromotionsLoaded({this.listPromotions});

  @override
  List<Object> get props => [listPromotions];
}

class PromotionsEmpty extends PromotionsState {}

class PromotionsError extends PromotionsState {}

class PromotionsBloc extends Bloc<PromotionsEvent, PromotionsState> {
  final ListPromotionsRepository listPromotionsRepository = ListPromotionsRepository();
  PromotionsBloc() : super(null);

  @override
  PromotionsState get initialState => PromotionsInitial();

  @override
  void onTransition(Transition<PromotionsEvent, PromotionsState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  Stream<PromotionsState> mapEventToState(PromotionsEvent event) async* {
    if (event is GetListPromotions) {
      yield PromotionsLoading();

      try {
        final ListPromotions listPromotions = await listPromotionsRepository.getListPromotions();
        if (listPromotions.data != null) {
          if (listPromotions.data.length != 0) {
            yield PromotionsLoaded(listPromotions: listPromotions);
          } else {
            yield PromotionsEmpty();
          }
        } else {}
      } catch (e) {
        yield PromotionsError();
      }
    }
  }
}
