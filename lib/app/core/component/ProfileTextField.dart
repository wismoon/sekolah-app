
import 'package:flutter/material.dart';

class ProfileTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final String initialValue; 

  const ProfileTextField({
    Key? key,
    required this.labelText,
    required this.controller,
    required this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.text = initialValue;
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
      ),
    );
  }
}