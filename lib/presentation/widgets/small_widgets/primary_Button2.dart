import 'package:flutter/material.dart';

class PrimaryButton2 extends StatelessWidget {
  final String text;
  final Function()? onPressed;

  const PrimaryButton2({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(color: Colors.purple, fontSize: 15),
      ),
    );
  }
}
