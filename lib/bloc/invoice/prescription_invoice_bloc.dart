import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medapp/repository/invoice.dart';
import 'package:medapp/model/examination/prescription_invoice.dart';
import 'package:equatable/equatable.dart';

// bloc state
abstract class PrescriptionInvoiceState extends Equatable {
  @override
  List<Object> get props => [];
}

class PrescriptionInvoiceInitial extends PrescriptionInvoiceState {}

class PrescriptionInvoiceEmpty extends PrescriptionInvoiceState {}

class PrescriptionInvoiceLoading extends PrescriptionInvoiceState {}

class PrescriptionInvoiceLoaded extends PrescriptionInvoiceState {
  final PrescriptionInvoice prescriptionInvoice;

  PrescriptionInvoiceLoaded({this.prescriptionInvoice});
}

class PrescriptionInvoiceError extends PrescriptionInvoiceState {}

// bloc event

abstract class PrescriptionInvoiceEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetPrescriptionInvoice extends PrescriptionInvoiceEvent {}

// bloc

class PrescriptionInvoiceBloc extends Bloc<PrescriptionInvoiceEvent, PrescriptionInvoiceState> {
  PrescriptionInvoiceBloc() : super(PrescriptionInvoiceInitial());
  final InvoiceRepository invoiceRepository = InvoiceRepository();

  @override
  PrescriptionInvoiceState get initialState => PrescriptionInvoiceInitial();

  @override
  Stream<PrescriptionInvoiceState> mapEventToState(PrescriptionInvoiceEvent event) async* {
    if (event is GetPrescriptionInvoice) {
      yield PrescriptionInvoiceLoading();
      try {
        final PrescriptionInvoice prescriptionInvoice = await invoiceRepository.getPrescriptionInvoice();
        if (prescriptionInvoice != null) {
          yield PrescriptionInvoiceLoaded(prescriptionInvoice: prescriptionInvoice);
        } else {
          yield PrescriptionInvoiceEmpty();
        }
      } catch (e) {
        print(e.toString());
        yield PrescriptionInvoiceError();
      }
    }
  }
}
