import 'package:flutter/material.dart';

import 'app_color.dart';

class AppTextStyle {
  static const heading1 =
      TextStyle(fontWeight: FontWeight.w400, fontSize: 30, height: 1.2);
  static const heading1SemiBold = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 30,
  );
  static const heading1Medium = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 24,
    height: 1.5,
    color: Colors.black,
    decoration: TextDecoration.none,
  );

  //==========Heading 2=============
  static const heading2 = TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 24,
      height: 1.2,
      decoration: TextDecoration.none,
      color: AppTheme.white);

  //==========Heading 3=============

  static const heading2Medium = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 24,
      height: 1.4,
      decoration: TextDecoration.none,
      color: Colors.black);

  static const heading3Black = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 14,
      height: 1.4,
      decoration: TextDecoration.none,
      color: Colors.black);

  static const heading2CustomColor = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 19,
      height: 1.6,
      decoration: TextDecoration.none,
      color: AppTheme.color3);
  static const heading3CustomColor = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 17,
      height: 1.6,
      decoration: TextDecoration.none,
      color: AppTheme.color2);

  static const heading3Light = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 14,
      height: 1.4,
      decoration: TextDecoration.none,
      color: Colors.white);

  //==========Heading 4=============

  static const heading4Light = TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 13,
      height: 1.2,
      color: AppTheme.white,
      decoration: TextDecoration.none);

  static const heading4Black = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 14,
      height: 1.4,
      color: Colors.black,
      decoration: TextDecoration.none);

  static const heading4Grey = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
      height: 1.4,
      color: AppTheme.greyApp,
      decoration: TextDecoration.none);

  static const heading4Medium = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 14,
      height: 1.4,
      color: Colors.black,
      decoration: TextDecoration.none);

  static const h_grey = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 14,
      height: 1.4,
      fontFamily: 'Roboto',
      color: Colors.grey,
      decoration: TextDecoration.underline);

  static const h_grey_no_underline = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 1.4,
    fontFamily: 'Roboto',
    color: Colors.black54,
  );
  static const h_underline = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      height: 1.6,
      fontFamily: 'Roboto',
      color: Colors.black,
      decoration: TextDecoration.underline);
  static const h_underline_grey = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 15,
      height: 2.0,
      fontFamily: 'Roboto',
      color: Colors.grey,
      decoration: TextDecoration.underline);
}
