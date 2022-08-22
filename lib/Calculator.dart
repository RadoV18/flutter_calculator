import 'package:flutter/material.dart';
import 'Screen.dart';
import 'Buttons.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Screen(),
        Buttons()
      ],
    );
  }
}
