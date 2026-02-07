import 'package:flutter/material.dart';
import 'package:dice_switcher/gradient_container.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: GradientContainer(Color(0xFF2D285A), Color(0xFF0C0A22)),
      ),
    ),
  );
}

