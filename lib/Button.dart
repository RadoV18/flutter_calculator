import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './ButtonColors.dart' as button_colors;
import './providers/calculator_provider.dart';

class Button extends StatelessWidget {
  final String value;
  final bool isOperator;
  final Color color;
  final int width;
  final IconData? icon;

  const Button({Key? key,
    this.value = "",
    this.icon,
    this.isOperator = false,
    this.color = button_colors.grey,
    this.width = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    Color textColor = color == button_colors.lightGrey ? Colors.black : Colors.white;
    Map<Color, FontWeight> weight = {
      button_colors.grey: FontWeight.w500,
      button_colors.orange: FontWeight.w700,
      button_colors.lightGrey: FontWeight.w500
    };
    return SizedBox(
      width: screenWidth * 0.2 * width + ( (width - 1) * 12 ),
      height: screenWidth * 0.2,
      child: ElevatedButton(
        onPressed: () {
          context.read<CalculatorProvider>().setInput(value);
        },
        style: ElevatedButton.styleFrom(
          primary: color,
          shape: const StadiumBorder()
        ),
        child: value.compareTo("") != 0 ?
          Align(
            alignment: Alignment.center,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 38,
                fontWeight: weight[color],
                color: textColor
              ),
            ),
          ) :
          Icon(icon, size: 30, color: Colors.white)
      ),
    );
  }
}
