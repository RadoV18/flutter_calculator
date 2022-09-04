import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';

import '../../bl/calculator_bl.dart';

part 'calculator_event.dart';
part 'calculator_state.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  CalculatorBloc() : super(const CalculatorValue()) {
    on<ButtonPress>((ButtonPress event, emit) {
      CalculatorBl calc = CalculatorBl();
      calc.setInput(event.button);
      emit(CalculatorValue(input: calc.input));
    });
  }
}
