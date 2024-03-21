import 'package:flutter/material.dart';

class ProfileTextField extends StatelessWidget {
  final String labelText;
  final String? placeholder;
  final String? initialValue;
  final TextEditingController? controller;
  final bool obscureText;
  final String? Function(String?)? validator;
  final IconData? icon;
  final TextInputType? keyboardType; // Added keyboardType parameter
  final int? maxLines; // Added maxLines parameter
  final Function(String)? onChanged;

  const ProfileTextField(
      {Key? key,
      required this.labelText,
      this.placeholder,
      this.controller,
      this.obscureText = false,
      this.validator,
      this.initialValue,
      this.icon,
      this.keyboardType, // Added keyboardType parameter
      this.maxLines, // Added maxLines parameter
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      initialValue: initialValue,
      validator: validator,
      onChanged: onChanged,
      keyboardType: keyboardType, // Utilizing the keyboardType parameter
      maxLines: maxLines, // Utilizing the maxLines parameter
      decoration: InputDecoration(
        // border: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(20),
        // ),
        labelText: labelText,
        hintText: placeholder,
        prefixIcon: icon != null ? Icon(icon) : null,
      ),
    );
  }
}
