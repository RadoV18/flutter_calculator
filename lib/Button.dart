import 'package:flutter/material.dart';
import './ButtonColors.dart' as button_colors;

class Button extends StatelessWidget {
  final String value;
  final bool isOperator;
  final Color color;
  final int width;

  const Button({Key? key,
    this.value = "",
    this.isOperator = false,
    this.color = button_colors.grey,
    this.width = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: screenWidth * 0.25 * width,
      height: screenWidth * 0.25,
      child: ElevatedButton(
        onPressed: () {
          print(value);
        },
        style: ElevatedButton.styleFrom(
          primary: color,
          shape: const StadiumBorder(),
          padding: const EdgeInsets.all(24)
        ),
        child: Text(
          value,
          style: const TextStyle(
            fontSize: 35,
            fontFamily: 'SF Pro'
          ),
        )
      ),
    );
  }
}
