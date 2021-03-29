import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medapp/model/examination/examination_invoice.dart';
import 'package:medapp/repository/invoice.dart';

// bloc state
abstract class ExamInvoiceState extends Equatable {
  @override
  List<Object> get props => [];
}

class ExamInvoiceInitial extends ExamInvoiceState {}

class ExamInvoiceEmpty extends ExamInvoiceState {}

class ExamInvoiceLoading extends ExamInvoiceState {}

class ExamInvoiceLoaded extends ExamInvoiceState {
  final ExaminationsInvoice examinationsInvoice;

  ExamInvoiceLoaded({this.examinationsInvoice});
}

class ExamInvoiceError extends ExamInvoiceState {}

// bloc event
abstract class ExamInvoiceEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetExamInvoice extends ExamInvoiceEvent {
  final String chuoiKhamId;

  GetExamInvoice({this.chuoiKhamId});
}

class ExamInvoiceBloc extends Bloc<ExamInvoiceEvent, ExamInvoiceState> {
  ExamInvoiceBloc() : super(ExamInvoiceInitial());

  final InvoiceRepository invoiceRepository = InvoiceRepository();

  @override
  ExamInvoiceState get initialState => ExamInvoiceInitial();

  @override
  void onTransition(Transition<ExamInvoiceEvent, ExamInvoiceState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  Stream<ExamInvoiceState> mapEventToState(ExamInvoiceEvent event) async* {
    if (event is GetExamInvoice) {
      yield ExamInvoiceLoading();

      try {
        final ExaminationsInvoice examinationsInvoice = await invoiceRepository.getExamInvoice(event.chuoiKhamId);
        if (examinationsInvoice != null) {
          yield ExamInvoiceLoaded(examinationsInvoice: examinationsInvoice);
        } else {
          yield ExamInvoiceEmpty();
        }
      } catch (e) {
        print(e.toString());
        yield ExamInvoiceError();
      }
    }
  }
}
