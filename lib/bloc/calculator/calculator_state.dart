part of 'calculator_bloc.dart';

abstract class CalculatorState extends Equatable {
  const CalculatorState();

  @override
  List<Object> get props => [];
}

class CalculatorValue extends CalculatorState {
  final String input;

  const CalculatorValue({this.input = "0"});
}
