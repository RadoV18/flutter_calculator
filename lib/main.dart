import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './Calculator.dart';
import './providers/calculator_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CalculatorProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
          fontFamily: 'SFPro'
        ),
        home: const Scaffold(
          body: Calculator()
        ),
      ),
    );
  }
}
