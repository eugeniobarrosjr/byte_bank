import 'package:flutter/material.dart';

class FormEditor extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String labelText;
  final IconData icon;

  FormEditor({
    this.controller,
    this.labelText,
    this.hint,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.numberWithOptions(signed: true),
        style: TextStyle(
          fontSize: 16.0,
        ),
        decoration: InputDecoration(
          icon: icon != null ? Icon(icon) : null,
          labelText: labelText,
          hintText: hint,
        ),
      ),
    );
  }
}
