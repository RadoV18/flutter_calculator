part of 'calculator_bloc.dart';

abstract class CalculatorEvent extends Equatable {
  const CalculatorEvent();

  @override
  List<Object> get props => [];
}

class ButtonPress extends CalculatorEvent {
  final String button;
  const ButtonPress({required this.button});
}