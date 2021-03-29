import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medapp/repository/invoice.dart';
import 'package:medapp/model/examination/examination_invoice.dart';

// bloc state
abstract class ExaminationsInvoiceState extends Equatable {
  @override
  List<Object> get props => [];
}

class ExaminationInvoiceInitial extends ExaminationsInvoiceState {}

class ExaminationInvoiceEmpty extends ExaminationsInvoiceState {}

class ExaminationInvoiceLoading extends ExaminationsInvoiceState {}

class ExaminationInvoiceLoaded extends ExaminationsInvoiceState {
  final ExaminationsInvoice examinationsInvoice;

  ExaminationInvoiceLoaded({this.examinationsInvoice});
}

class ExaminationInvoiceError extends ExaminationsInvoiceState {}

// bloc event

abstract class ExaminationsInvoiceEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetExaminationInvoice extends ExaminationsInvoiceEvent {}

// bloc

class ExaminationsInvoiceBloc extends Bloc<ExaminationsInvoiceEvent, ExaminationsInvoiceState> {
  ExaminationsInvoiceBloc() : super(ExaminationInvoiceInitial());

  final InvoiceRepository invoiceRepository = InvoiceRepository();

  @override
  ExaminationsInvoiceState get initialState => ExaminationInvoiceInitial();

  @override
  void onTransition(Transition<ExaminationsInvoiceEvent, ExaminationsInvoiceState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  Stream<ExaminationsInvoiceState> mapEventToState(ExaminationsInvoiceEvent event) async* {
    if (event is GetExaminationInvoice) {
      yield ExaminationInvoiceLoading();
      try {
        final ExaminationsInvoice examinationsInvoice = await invoiceRepository.getExaminationsInvoice();

        if (examinationsInvoice != null) {
          yield ExaminationInvoiceLoaded(examinationsInvoice: examinationsInvoice);
        } else {
          yield ExaminationInvoiceEmpty();
        }
      } catch (e) {
        print(e.toString());
        yield ExaminationInvoiceError();
      }
    }
  }
}
