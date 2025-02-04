import 'package:flutter/material.dart';

class Appcolors {
  static Color primaryColor = const Color(0xFFC628BC);

  static LinearGradient primaryGradient = const LinearGradient(
    begin: Alignment(1.00, 0.00),
    end: Alignment(-1, 0),
    colors: [Color(0xFF644DDA), Color(0xFFC428BB)],
  );
  static LinearGradient backbuttonGradient = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF644DDA), Color(0xFFC428BB)],
  );
}
