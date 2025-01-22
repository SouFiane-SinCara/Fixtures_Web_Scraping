import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MyColors {
  static const Color black1 = Color(0xFF222232);
  static const Color black2 = Color(0XFF181829);
  static const Color black3 = Color(0xFF2B2B3D);

  static const Color grey1 = Color(0xFFC4C4C4);
  static const Color grey2 = Color(0xFF65656B);
  static const LinearGradient gradient = LinearGradient(
    colors: [
      Color(0xFFED6B4E),
      Color(0xFFF4A58A),
    ],
    end: Alignment.topLeft,
    begin: Alignment.bottomRight,
  );
  static const Color white = Colors.white;
  static const Color blue = Color(0xFF246BFD);
  static const PaintingEffect loadingEffect = ShimmerEffect(
    baseColor: MyColors.black1,
    highlightColor: MyColors.white,
    duration: Duration(seconds: 2),
    begin: Alignment(-1.0, -1.0),
    end: Alignment(1.0, 1.0),
  );
}
