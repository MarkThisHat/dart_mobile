import 'package:flutter/material.dart';

class CalculatorText extends StatelessWidget {
  final String text;
  final double minorDimension;
  final bool isLandscape;
  final Color color;

  const CalculatorText({
    Key? key,
    required this.text,
    required this.minorDimension,
    required this.isLandscape,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: isLandscape ? minorDimension * 0.07 : minorDimension * 0.10,
        color: color,
      ),
    );
  }
}
