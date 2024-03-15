import 'package:flutter/material.dart';

class GapWidget extends StatefulWidget {
  const GapWidget({super.key});

  @override
  State<GapWidget> createState() => _GapWidgetState();
}

class _GapWidgetState extends State<GapWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.02,
    );
  }
}
