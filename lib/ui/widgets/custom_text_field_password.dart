import 'package:flutter/material.dart';

class CustomTextFieldPassword extends StatelessWidget {
  final String label;
  final TextEditingController textEditingController;
  const CustomTextFieldPassword({
    super.key,
    required this.label,
    required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      obscureText: true,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(Icons.password),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
