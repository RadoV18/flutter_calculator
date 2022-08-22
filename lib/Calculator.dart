import 'package:flutter/material.dart';
import 'Screen.dart';
import 'Buttons.dart';

class Calculator extends StatelessWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: const [
        Screen(),
        Buttons()
      ],
    );
  }
}
