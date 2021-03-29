// bloc state
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medapp/model/appointment/first_invoice.dart';
import 'package:medapp/repository/invoice.dart';

abstract class FirstInvoiceState extends Equatable {
  @override
  List<Object> get props => [];
}

class FirstInvoiceInitial extends FirstInvoiceState {}

class FirstInvoiceEmpty extends FirstInvoiceState {}

class FirstInvoiceLoading extends FirstInvoiceState {}

class FirstInvoiceLoaded extends FirstInvoiceState {
  final FirstInvoice firstInvoice;

  FirstInvoiceLoaded({this.firstInvoice});
}

class FirstInvoiceError extends FirstInvoiceState {}

class LatestFirstInvoiceInitial extends FirstInvoiceState {}

class LatestFirstInvoiceEmpty extends FirstInvoiceState {}

class LatestFirstInvoiceLoading extends FirstInvoiceState {}

class LatestFirstInvoiceLoaded extends FirstInvoiceState {
  final FirstInvoice firstInvoice;

  LatestFirstInvoiceLoaded({this.firstInvoice});
}

class LatestFirstInvoiceError extends FirstInvoiceState {}

// bloc event

abstract class FirstInvoiceEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetFirstInvoice extends FirstInvoiceEvent {
  final String lichHenId;

  GetFirstInvoice({this.lichHenId});
}

class GetLatestFirstInvoice extends FirstInvoiceEvent {}

// bloc

class FirstInvoiceBloc extends Bloc<FirstInvoiceEvent, FirstInvoiceState> {
  FirstInvoiceBloc() : super(FirstInvoiceInitial());

  final InvoiceRepository invoiceRepository = InvoiceRepository();

  @override
  FirstInvoiceState get initialState => FirstInvoiceInitial();

  @override
  void onTransition(Transition<FirstInvoiceEvent, FirstInvoiceState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  Stream<FirstInvoiceState> mapEventToState(FirstInvoiceEvent event) async* {
    if (event is GetFirstInvoice) {
      yield FirstInvoiceLoading();
      try {
        final FirstInvoice firstInvoice = await invoiceRepository.getFirstInvoice(event.lichHenId);

        if (firstInvoice != null) {
          yield FirstInvoiceLoaded(firstInvoice: firstInvoice);
        } else {
          yield FirstInvoiceEmpty();
        }
      } catch (e) {
        print(e.toString());
        yield FirstInvoiceError();
      }
    }
  }
}

class LatestFirstInvoiceBloc extends Bloc<FirstInvoiceEvent, FirstInvoiceState> {
  LatestFirstInvoiceBloc() : super(LatestFirstInvoiceInitial());

  final InvoiceRepository invoiceRepository = InvoiceRepository();

  @override
  FirstInvoiceState get initialState => LatestFirstInvoiceInitial();

  @override
  void onTransition(Transition<FirstInvoiceEvent, FirstInvoiceState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  Stream<FirstInvoiceState> mapEventToState(FirstInvoiceEvent event) async* {
    if (event is GetLatestFirstInvoice) {
      yield LatestFirstInvoiceLoading();
      try {
        final FirstInvoice firstInvoice = await invoiceRepository.getLatestFirstInvoice();
        if (firstInvoice != null) {
          yield LatestFirstInvoiceLoaded(firstInvoice: firstInvoice);
        } else {
          yield LatestFirstInvoiceEmpty();
        }
      } catch (e) {
        print(e.toString());
        yield LatestFirstInvoiceError();
      }
    }
  }
}
