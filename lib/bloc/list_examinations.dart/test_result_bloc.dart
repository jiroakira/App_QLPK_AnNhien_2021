import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medapp/model/test_result_body.dart';
import 'package:medapp/repository/test_result.dart';

abstract class TestResultState extends Equatable {
  @override
  List<Object> get props => [];
}

abstract class TestResultEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetTestResultEvent extends TestResultEvent {
  final String id;
  GetTestResultEvent({this.id});
}

class TestResultInitial extends TestResultState {}

class TestResultEmpty extends TestResultState {}

class TestResultLoading extends TestResultState {}

class TestResultLoaded extends TestResultState {
  final TestResultBody testResultBody;

  TestResultLoaded({this.testResultBody});
}

class TestResultError extends TestResultState {}

class TestResultBloc extends Bloc<TestResultEvent, TestResultState> {
  TestResultBloc() : super(TestResultInitial());

  final TestResultRepository testResultRepository = TestResultRepository();

  @override
  TestResultInitial get initialState => TestResultInitial();

  @override
  void onTransition(Transition<TestResultEvent, TestResultState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  Stream<TestResultState> mapEventToState(TestResultEvent event) async* {
    // TODO: implement mapEventToState

    if (event is GetTestResultEvent) {
      yield TestResultLoading();
      try {
        final TestResultBody testResultBody = await testResultRepository.getTestResult(event.id);
        if (testResultBody != null) {
          yield TestResultLoaded(testResultBody: testResultBody);
        } else {
          yield TestResultEmpty();
        }
      } catch (e) {
        print(e.toString());
        yield TestResultError();
      }
    }
  }
}
