import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/calculator/calculator_bloc.dart';

class Screen extends StatefulWidget {
  const Screen({Key? key}) : super(key: key);

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<CalculatorBloc, CalculatorState>(
      builder: (context, state) {
        if (state is CalculatorValue) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
                height: 100.0,
                width: screenWidth,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    reverse: true,
                    child: Text(state.input,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 90,
                            fontWeight: FontWeight.w500)),
                  ),
                )),
          );
        } else {
          return const Text("An error occurred");
        }
      },
    );
  }
}
