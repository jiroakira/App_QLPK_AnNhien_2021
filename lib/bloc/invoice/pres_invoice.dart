import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medapp/model/examination/prescription_invoice.dart';
import 'package:medapp/repository/invoice.dart';

// bloc state
abstract class PresInvoiceState extends Equatable {
  @override
  List<Object> get props => [];
}

class PresInvoiceInitial extends PresInvoiceState {}

class PresInvoiceEmpty extends PresInvoiceState {}

class PresInvoiceLoading extends PresInvoiceState {}

class PresInvoiceLoaded extends PresInvoiceState {
  final PrescriptionInvoice prescriptionInvoice;

  PresInvoiceLoaded({this.prescriptionInvoice});
}

class PresInvoiceError extends PresInvoiceState {}

// bloc event
abstract class PresInvoiceEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetPresInvoice extends PresInvoiceEvent {
  final String chuoiKhamId;

  GetPresInvoice({this.chuoiKhamId});
}

class PresInvoiceBloc extends Bloc<PresInvoiceEvent, PresInvoiceState> {
  PresInvoiceBloc() : super(PresInvoiceInitial());

  final InvoiceRepository invoiceRepository = InvoiceRepository();

  @override
  PresInvoiceState get initialState => PresInvoiceInitial();

  @override
  void onTransition(Transition<PresInvoiceEvent, PresInvoiceState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  Stream<PresInvoiceState> mapEventToState(PresInvoiceEvent event) async* {
    if (event is GetPresInvoice) {
      yield PresInvoiceLoading();
      final PrescriptionInvoice prescriptionInvoice = await invoiceRepository.getPresInvoice(event.chuoiKhamId);
      if (prescriptionInvoice != null) {
        yield PresInvoiceLoaded(prescriptionInvoice: prescriptionInvoice);
      } else {
        yield PresInvoiceEmpty();
      }
      try {} catch (e) {
        print(e.toString());
        yield PresInvoiceError();
      }
    }
  }
}
