import 'dart:ui';

import 'package:flutter/material.dart';

class AppTheme {
  static const yellow = Color(0xFFFFE011);
  static final lightBlue = const Color(0xFF48cae7).withOpacity(0.1);
  static const blueMain = Color(0xFF3D58F8);
  static const blueIllustration = Color(0xFF2C4BA1);
  static const darkBlueIllustration = Color(0xFF1E3577);
  static const greyApp = Color(0xFFA2A2A3);
  static const brandBlue = Color(0xFF4789FA);
  static const white = Color(0xFFFFFFFF);
  static const lightBackgound = Color(0xFFFFFFFF);
  static const grey = Color(0xFFABADBD);
  static const darkGrey = Color(0xFF42476A);
  static const green = Color(0xFF4285F4);
  static const grey5 = Color(0xFFF5F5F5);
  static const color1 = Color(0xFFb158fe);
  static const color2 = Color(0xFFb158fe);
  static const color3 = Color(0xFF5b00a6);

  static const gradient1 = Color(0xFFf36ae3);
  static const gradient2 = Color(0xFF688ef3);
  static const gradient3 = Color(0xFFe5861c);
  static const gradient4 = Color(0xFFf283ec);

  static const analyse1 = Color(0xFFa07fff);
  static const analyse11 = Color.fromARGB(255, 128, 90, 241);

  static const analyse2 = Color(0xFFff6de9);
  static const analyse21 = Color.fromARGB(255, 230, 36, 200);

  static const analyse3 = Color(0xFF5bcdf1);
  static const analyse31 = Color.fromARGB(255, 13, 185, 237);

  static const analyse4 = Color(0xFFefb463);
  static const analyse41 = Color.fromARGB(255, 234, 160, 57);

  static const adminbgColor = Color(0xFFf5f5fa);

  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF89AEB2),
      Color(0xFF97F2F3),
      Color(0xFFF1E0B0),
      Color(0xFFF1CDB0),
    ],
  );

  static const LinearGradient gradient_analyse2 = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      analyse2,
      analyse21,
    ],
  );

  static const LinearGradient gradient_analyse1 = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      analyse1,
      analyse11,
    ],
  );

  static const LinearGradient gradient_analyse3 = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      analyse3,
      analyse31,
    ],
  );

  static const LinearGradient gradient_analyse4 = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      analyse4,
      analyse41,
    ],
  );
}
