import 'package:flutter/material.dart';

class CalculatorText extends StatelessWidget {
  final String value;
  final double fontSize;
  final Color color;

  const CalculatorText({
    super.key,
    required this.value,
    required this.fontSize,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
      ),
    );
  }
}
