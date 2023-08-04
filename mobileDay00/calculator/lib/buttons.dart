import 'package:flutter/material.dart';

class ButtonRow extends StatelessWidget {
  final List<String> values;
  final double btnHeight;
  final bool isLastRow;
  final ValueChanged<String> onValueUpdate;

  const ButtonRow(
      {super.key,
      required this.values,
      required this.btnHeight,
      this.isLastRow = false,
      required this.onValueUpdate});

  @override
  Widget build(BuildContext context) {
    const Color customDarkGray = Color.fromARGB(255, 44, 58, 65);
    const Color customGray = Color.fromARGB(255, 96, 125, 139);
    const Color customRed = Color.fromARGB(255, 155, 59, 63);

    return Row(
      children: values.asMap().entries.map((entry) {
        int index = entry.key;
        String value = entry.value;
        Color buttonColor;

        if (int.tryParse(value) != null || value == '.') {
          buttonColor = customDarkGray;
        } else if (RegExp(r'[a-zA-Z]').hasMatch(value)) {
          buttonColor = customRed;
        } else {
          buttonColor = Colors.white;
        }

        return Expanded(
          flex: isLastRow && index == values.length - 1 ? 2 : 1,
          child: Padding(
            padding: const EdgeInsets.all(0.07),
            child: Material(
              child: InkWell(
                onTap: () {
                  onValueUpdate(value);
                },
                splashColor: Colors.black.withOpacity(0.3),
                child: Container(
                  height: btnHeight,
                  color: customGray,
                  alignment: Alignment.center,
                  child: Text(
                    value,
                    style: TextStyle(color: buttonColor, fontSize: 24.0),
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
