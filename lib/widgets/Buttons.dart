import 'package:flutter/material.dart';
import './Button.dart';
import './ButtonColors.dart' as button_colors;

class Buttons extends StatelessWidget {
  const Buttons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            Button(value: "AC", color: button_colors.lightGrey),
            Button(value: "(", color: button_colors.lightGrey),
            Button(value: ")", color: button_colors.lightGrey),
            Button(value: "÷", isOperator: true, color: button_colors.orange)
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            Button(value: "7"),
            Button(value: "8"),
            Button(value: "9"),
            Button(value: "×", isOperator: true, color: button_colors.orange)
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            Button(value: "4"),
            Button(value: "5"),
            Button(value: "6"),
            Button(value: "-", isOperator: true, color: button_colors.orange)
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            Button(value: "1"),
            Button(value: "2"),
            Button(value: "3"),
            Button(value: "+", isOperator: true, color: button_colors.orange)
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            Button(value: "0"),
            Button(value: "."),
            Button(icon: IconData(0xeeb5, fontFamily: 'MaterialIcons', matchTextDirection: true)),
            Button(value: "=", isOperator: true, color: button_colors.orange)
          ],
        ),
      ],
    );
  }
}
