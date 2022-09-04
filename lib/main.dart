import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/calculator/calculator_bloc.dart';
import 'widgets/Calculator.dart';
import 'package:bloc/bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) =>
              CalculatorBloc()..add(const ButtonPress(button: "AC")),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.black, fontFamily: 'SFPro'),
        home: const Scaffold(body: Calculator()),
      ),
    );
  }
}
