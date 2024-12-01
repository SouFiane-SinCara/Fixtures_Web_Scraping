import 'package:fixtures_web_scraping/core/constants/my_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ErrorCard extends StatelessWidget {
  final String message;
  const ErrorCard({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 200.w,
          height: 50.h,
          alignment: Alignment.center,
          child: FittedBox(
            child: Text(
              message,
              style: MyTextStyle.whiteSemiBold,
            ),
          ),
        ),
        SizedBox(
          width: 240.w,
          height: 200.h,
          child: Image.asset(
            'lib/core/assets/icons/error.png',
            fit: BoxFit.fitHeight,
          ),
        ),
      ],
    );
  }
}
