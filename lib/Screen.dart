import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/calculator_provider.dart';

class Screen extends StatefulWidget {
  const Screen({Key? key}) : super(key: key);

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    var calculatorProvider = Provider.of<CalculatorProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        height: 100.0,
        width: screenWidth,
        child: Align(
          alignment: Alignment.bottomRight,
          child: Text(
              context.watch<CalculatorProvider>().input,
              textAlign: TextAlign.right,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 90,
                  fontWeight: FontWeight.w500
              )
          ),
        )
      ),
    );
  }
}
