import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Application Event ========================================================= START
class AppEvent extends Equatable{
  const AppEvent();

  @override
  List<Object> get props => [];
}

class EventOne extends AppEvent {
  final int input;
  
  const EventOne({
    required this.input
  });
}

class EventTwo extends AppEvent {
  final int input;
  
  const EventTwo({
    required this.input
  });
}

class EventThree extends AppEvent {
  final int input;

  const EventThree({
    required this.input
  });
}

class EventFour extends AppEvent {
  final int input;

  const EventFour({
    required this.input
  });
}
// Application Event ========================================================= END

// Application State ========================================================= START
abstract class AppState extends Equatable {
  @override
  List<Object> get props => [];
}

class ApplicationInitial extends AppState {
  final String result;

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
    if(event is EventOne) {
      yield* _mapEventOneToState(event.input);
    }
    else if(event is EventTwo) {
      yield* _mapEventTwoToState(event.input);
    }
    else if(event is EventThree) {
      yield* _mapEventThreeToState(event.input);
    }
    else if(event is EventFour) {
      yield* _mapEventFourToState(event.input);
    }
  }

  Stream<AppState> _mapEventOneToState(int input) async* {
    yield ApplicationLoading();
    String output = '';
    try{
      for (var i = 1; i <= input; i++) {
        output = output + " " + i.toString();
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

  Stream<AppState> _mapEventTwoToState(int input) async* {
    yield ApplicationLoading();
    print("input is : " + input.toString());
    String output = '';
    try{
      for (var i = 1; i <= input; i++) {
        output = output + " " + i.toString();
      }
      for (var i = input - 1; i > 0; i--) {
        output = output + " " + i.toString();
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

  Stream<AppState> _mapEventThreeToState(int input) async* {
    yield ApplicationLoading();
    String output = '10';
    int initialValue = 10;
    int currentValue = initialValue;
    try{
      for (var i = 0; i < input-1; i++) {
        currentValue = currentValue+11;
        output = output + " " + (currentValue).toString();
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

  Stream<AppState> _mapEventFourToState(int input) async* {
    yield ApplicationLoading();
    String output = '';
    try{
      for (var i = 1; i <= input; i++) {
        if (i % 7 == 0) {
          output = output + " TUJUH";
        }
        else if (i % 5 == 0) {
          output = output + " LIMA";
        } else {
          output = output + " " + i.toString();
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
