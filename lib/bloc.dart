import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Application Event ========================================================= START
class AppEvent extends Equatable{
  const AppEvent();

  @override
  List<Object> get props => [];
}

class CalculatePrimeNumber extends AppEvent {
  final int start;
  final int end;
  
  const CalculatePrimeNumber({
    required this.start,
    required this.end
  });
}
// Application Event ========================================================= END

// Application State ========================================================= START
abstract class AppState extends Equatable {
  @override
  List<Object> get props => [];
}

class ApplicationInitial extends AppState {
  final List<int> result;

  ApplicationInitial({
    required this.result
  });
}

class ApplicationLoading extends AppState {}

class ApplicationError extends AppState {
  final String? errorMessage;

  ApplicationError({
    required this.errorMessage,
  });
}
// Application State ========================================================= END


// Application Bloc ========================================================= START
class ApplicationBloc extends Bloc<AppEvent, AppState> {
  ApplicationBloc(AppState initialState) : super(initialState);

  @override
  Stream<AppState> mapEventToState(AppEvent event,) async* {
    if(event is CalculatePrimeNumber) {
      yield* _mapCalculatePrimeNumberToState(event.start, event.end);
    }
  }

  Stream<AppState> _mapCalculatePrimeNumberToState(int start, int end) async* {
    yield ApplicationLoading();

    List<int> output = [];

    // function to check if the number is prime or not
    isPrime(int num) {
      // negate 1
      if(num < 2) return false;

      for (var k = 2; k < num; k++){
        if(num % k == 0){
          return false;
        }
      }
      return true;
    }

    try{
      for (var i = start; i <= end; i++) {
        bool number = isPrime(i);
        if (number) {
          output.add(i);
        }
      }
      yield ApplicationInitial(
        result: output
      );
    } catch(error){
      yield ApplicationError(
        errorMessage: error.toString()
      );
    }
  }
}
// Application Bloc ========================================================= END
