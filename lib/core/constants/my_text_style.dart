import 'package:fixtures_app/core/constants/my_colors.dart';
import 'package:flutter/material.dart';

class MyTextStyle {
  static const TextStyle whiteSemiBold = TextStyle(
      fontFamily: 'sourceSansPro',
      fontStyle: FontStyle.normal,
      color: MyColors.white,
      fontWeight: FontWeight.w600);

  static const TextStyle grey1SemiBold = TextStyle(
      fontFamily: 'sourceSansPro',
      fontStyle: FontStyle.normal,
      color: MyColors.grey1,
      fontWeight: FontWeight.w500);

  static const TextStyle whiteRegular = TextStyle(
      fontFamily: 'sourceSansPro',
      fontStyle: FontStyle.normal,
      color: MyColors.white,
      fontWeight: FontWeight.w400);
}
