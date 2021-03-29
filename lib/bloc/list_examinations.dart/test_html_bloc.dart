import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medapp/model/test_html.dart';
import 'package:medapp/repository/test_html.dart';

abstract class TestHtmlState extends Equatable {
  @override
  List<Object> get props => [];
}

abstract class TestHtmlEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetTestHtmlEvent extends TestHtmlEvent {
  final String id;
  GetTestHtmlEvent({this.id});
}

class TestHtmlInitial extends TestHtmlState {}

class TestHtmlEmpty extends TestHtmlState {}

class TestHtmlLoading extends TestHtmlState {}

class TestHtmlLoaded extends TestHtmlState {
  final TestHtmlBody testHtmlBody;

  TestHtmlLoaded({this.testHtmlBody});
}

class TestHtmlError extends TestHtmlState {}

class TestHtmlBloc extends Bloc<TestHtmlEvent, TestHtmlState> {
  TestHtmlBloc() : super(TestHtmlInitial());

  final TestHtmlRepository testHtmlRepository = TestHtmlRepository();

  @override
  TestHtmlInitial get initialState => TestHtmlInitial();

  @override
  void onTransition(Transition<TestHtmlEvent, TestHtmlState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  Stream<TestHtmlState> mapEventToState(TestHtmlEvent event) async* {
    // TODO: implement mapEventToState

    if (event is GetTestHtmlEvent) {
      yield TestHtmlLoading();
      try {
        final TestHtmlBody testHtmlBody = await testHtmlRepository.getTestHtml(event.id);
        if (testHtmlBody != null) {
          yield TestHtmlLoaded(testHtmlBody: testHtmlBody);
        } else {
          yield TestHtmlEmpty();
        }
      } catch (e) {
        print(e.toString());
        yield TestHtmlError();
      }
    }
  }
}
