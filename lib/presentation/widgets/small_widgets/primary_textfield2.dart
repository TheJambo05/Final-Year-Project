import 'package:flutter/material.dart';

class PrimaryTextField2 extends StatelessWidget {
  final String labelText;
  final String? placeholder;
  final TextEditingController? controller;
  final bool obscureText;
  final String? Function(String?)? validator;
  final IconData? icon;
  final TextInputType? keyboardType; // Added keyboardType parameter
  final int? maxLines; // Added maxLines parameter

  const PrimaryTextField2({
    Key? key,
    required this.labelText,
    this.placeholder,
    this.controller,
    this.obscureText = false,
    this.validator,
    this.icon,
    this.keyboardType, // Added keyboardType parameter
    this.maxLines, // Added maxLines parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      keyboardType: keyboardType, // Utilizing the keyboardType parameter
      maxLines: maxLines, // Utilizing the maxLines parameter
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        labelText: labelText,
        hintText: placeholder,
        prefixIcon: icon != null ? Icon(icon) : null,
      ),
    );
  }
}
