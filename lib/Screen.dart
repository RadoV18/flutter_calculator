import 'package:flutter/material.dart';

class Screen extends StatefulWidget {
  const Screen({Key? key}) : super(key: key);

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        height: 100.0,
        width: screenWidth,
        child: const Align(
          alignment: Alignment.bottomRight,
          child: Text(
              "0",
              textAlign: TextAlign.right,
              style: TextStyle(
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
