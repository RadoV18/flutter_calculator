import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'calculator_event.dart';
part 'calculator_state.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  CalculatorBloc() : super(const CalculatorValue()) {
    on<ButtonPress>((ButtonPress event, emit) {
      print("call calculator bl ${event.button}");
      emit(CalculatorValue(input: event.button));
    });
  }
}
