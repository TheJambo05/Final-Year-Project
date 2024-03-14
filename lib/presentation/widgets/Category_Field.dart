import 'package:flutter/material.dart';

class CategoryField extends StatelessWidget {
  final String labelText;
  final String? placeholder; // Added placeholder parameter
  final TextEditingController? controller;
  final bool obscureText;
  final String? Function(String?)? validator;
  final IconData? icon; // Added icon parameter

  const CategoryField({
    Key? key,
    required this.labelText,
    this.placeholder, // Added placeholder parameter
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
        hintText: placeholder, // Utilizing the placeholder parameter
        prefixIcon: icon != null ? Icon(icon) : null,
      ),
    );
  }
}
