import 'package:flutter/material.dart';

class PrimaryTextField extends StatelessWidget {
  final String labelText;
  final String? placeholder;
  final TextEditingController? controller;
  final bool obscureText;
  final String? Function(String?)? validator;
  final IconData? icon;

  const PrimaryTextField({
    Key? key,
    required this.labelText,
    this.placeholder,
    this.controller,
    this.obscureText = false,
    this.validator,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
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
