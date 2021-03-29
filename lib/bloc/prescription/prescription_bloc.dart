import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medapp/model/prescription/list_prescription.dart';
import 'package:medapp/model/prescription/prescription.dart';
import 'package:medapp/repository/prescription.dart';
import 'package:meta/meta.dart';
import 'package:medapp/model/prescription/latest_prescription.dart';

// bloc event

abstract class PrescriptionEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetListPrescription extends PrescriptionEvent {}

class GetPrescription extends PrescriptionEvent {
  final String donThuocId;

  GetPrescription({@required this.donThuocId});

  @override
  List<Object> get props => [donThuocId];
}

class GetLatestPrescription extends PrescriptionEvent {}

class GetExaminationPrescription extends PrescriptionEvent {
  final String chuoiKhamId;

  GetExaminationPrescription({this.chuoiKhamId});

  @override
  List<Object> get props => [chuoiKhamId];
}

// bloc state
abstract class PrescriptionState extends Equatable {
  @override
  List<Object> get props => [];
}

class PrescriptionInitial extends PrescriptionState {}

class PrescriptionEmpty extends PrescriptionState {}

class PrescriptionLoading extends PrescriptionState {}

class PrescriptionLoaded extends PrescriptionState {
  final ListPrescriptionBody listPrescriptionBody;

  PrescriptionLoaded({@required this.listPrescriptionBody});
}

class PrescriptionError extends PrescriptionState {}

class SinglePrescriptionInitial extends PrescriptionState {}

class SinglePrescriptionLoading extends PrescriptionState {}

class SinglePrescriptionEmpty extends PrescriptionState {}

class SinglePrescriptionLoaded extends PrescriptionState {
  final PrescriptionBody prescriptionBody;

  SinglePrescriptionLoaded({@required this.prescriptionBody});
}

class SinglePrescriptionError extends PrescriptionState {}

class LatestPrescriptionInitial extends PrescriptionState {}

class LatestPrescriptionEmpty extends PrescriptionState {}

class LatestPrescriptionLoading extends PrescriptionState {}

class LatestPrescriptionLoaded extends PrescriptionState {
  final LatestPrescription latestPrescription;

  LatestPrescriptionLoaded({@required this.latestPrescription});

  @override
  List<Object> get props => [latestPrescription];
}

class LatestPrescriptionError extends PrescriptionState {}

class ExaminationPrescriptionInitial extends PrescriptionState {}

class ExaminationPrescriptionEmpty extends PrescriptionState {}

class ExaminationPrescriptionLoading extends PrescriptionState {}

class ExaminationPrescriptionLoaded extends PrescriptionState {
  final PrescriptionBody prescriptionBody;

  ExaminationPrescriptionLoaded({this.prescriptionBody});
}

class ExaminationPrescriptionError extends PrescriptionState {}

// bloc

class ListPrescriptionBloc extends Bloc<PrescriptionEvent, PrescriptionState> {
  ListPrescriptionBloc() : super(null);

  final PrescriptionApiRepository prescriptionApiRepository = PrescriptionApiRepository();

  @override
  PrescriptionState get initialState => PrescriptionInitial();

  @override
  void onTransition(Transition<PrescriptionEvent, PrescriptionState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  Stream<PrescriptionState> mapEventToState(PrescriptionEvent event) async* {
    if (event is GetListPrescription) {
      yield PrescriptionLoading();
      try {
        final ListPrescriptionBody listPrescriptionBody = await prescriptionApiRepository.getListPrescription();
        if (listPrescriptionBody.data != null) {
          yield PrescriptionLoaded(listPrescriptionBody: listPrescriptionBody);
        } else {
          yield PrescriptionEmpty();
        }
      } catch (e, stacktrace) {
        print(e.toString());
        print(stacktrace.toString());
        yield PrescriptionError();
      }
    }
  }
}

class SinglePrescriptionBloc extends Bloc<PrescriptionEvent, PrescriptionState> {
  SinglePrescriptionBloc() : super(null);

  final PrescriptionApiRepository prescriptionApiRepository = PrescriptionApiRepository();

  @override
  PrescriptionState get initialState => PrescriptionInitial();

  @override
  void onTransition(Transition<PrescriptionEvent, PrescriptionState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  Stream<PrescriptionState> mapEventToState(PrescriptionEvent event) async* {
    if (event is GetPrescription) {
      yield SinglePrescriptionLoading();
      try {
        final PrescriptionBody prescriptionBody = await prescriptionApiRepository.getPrescription(event.donThuocId);
        // if (prescriptionBody.data.isEmpty) {
        //   yield SinglePrescriptionEmpty();
        // }
        yield SinglePrescriptionLoaded(prescriptionBody: prescriptionBody);
      } catch (e, stacktrace) {
        print(e.toString());
        print(stacktrace.toString());
      }
    }
  }
}

class LatestPrescriptionBloc extends Bloc<PrescriptionEvent, PrescriptionState> {
  LatestPrescriptionBloc() : super(null);

  final PrescriptionApiRepository prescriptionApiRepository = PrescriptionApiRepository();

  @override
  PrescriptionState get initialState => LatestPrescriptionInitial();

  @override
  void onTransition(Transition<PrescriptionEvent, PrescriptionState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  Stream<PrescriptionState> mapEventToState(PrescriptionEvent event) async* {
    if (event is GetLatestPrescription) {
      yield LatestPrescriptionLoading();
      try {
        final LatestPrescription latestPrescription = await prescriptionApiRepository.getLatestPrescription();
        // if (prescriptionBody.data.isEmpty) {
        //   yield SinglePrescriptionEmpty();
        // }
        // if (latestPrescription)
        if (latestPrescription != null) {
          yield LatestPrescriptionLoaded(latestPrescription: latestPrescription);
        } else {
          yield LatestPrescriptionEmpty();
        }
      } catch (e, stacktrace) {
        print(e.toString());
        print(stacktrace.toString());
      }
    }
  }
}

class ExaminationPrescriptionBloc extends Bloc<PrescriptionEvent, PrescriptionState> {
  ExaminationPrescriptionBloc() : super(ExaminationPrescriptionInitial());

  final PrescriptionApiRepository prescriptionApiRepository = PrescriptionApiRepository();

  @override
  PrescriptionState get initialState => ExaminationPrescriptionInitial();

  @override
  Stream<PrescriptionState> mapEventToState(PrescriptionEvent event) async* {
    if (event is GetExaminationPrescription) {
      yield ExaminationPrescriptionLoading();
      try {
        final PrescriptionBody prescriptionBody = await prescriptionApiRepository.getExaminationPrescription(event.chuoiKhamId);
        if (prescriptionBody != null) {
          yield ExaminationPrescriptionLoaded(prescriptionBody: prescriptionBody);
        } else {
          yield ExaminationPrescriptionEmpty();
        }
      } catch (e) {
        print(e.toString());
        yield ExaminationPrescriptionError();
      }
    }
  }
}
