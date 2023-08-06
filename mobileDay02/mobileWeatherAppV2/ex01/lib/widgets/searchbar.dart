import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) updateText;
  final Color color;

  const SearchField({
    super.key,
    required this.controller,
    required this.updateText,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: TextField(
          controller: controller,
          onSubmitted: (value) {
            updateText(value);
            controller.clear();
          },
          cursorColor: color,
          decoration: _buildTextFieldDecoration(color),
          style: TextStyle(fontSize: 16.0, color: color),
        ),
      ),
    );
  }

  InputDecoration _buildTextFieldDecoration(Color color) {
    return InputDecoration(
      hintText: "Search location...",
      hintStyle: TextStyle(fontSize: 16.0, color: color.withOpacity(0.5)),
      filled: false,
      enabledBorder: _outlineInputBorder(color.withOpacity(0.5)),
      focusedBorder: _outlineInputBorder(color),
      prefixIcon: Icon(Icons.search, color: color.withOpacity(0.5)),
    );
  }

  OutlineInputBorder _outlineInputBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        color: color,
      ),
    );
  }
}
