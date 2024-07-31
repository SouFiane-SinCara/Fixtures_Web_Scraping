import 'package:fixtures_app/core/constants/my_text_style.dart';
import 'package:fixtures_app/core/helpers/spaces.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LeagueCard extends StatelessWidget {
  final String leagueName;
  final String leagueImg;
  const LeagueCard(
      {super.key, required this.leagueImg, required this.leagueName});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      width: double.infinity,
      child: Row(
        children: [
          Container(
            width: 35.w,
            height: 35.h,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: NetworkImage(leagueImg),
            )),
          ),
          widthBox(10),
          FittedBox(
            child: Text(
              leagueName,
              style: MyTextStyle.whiteSemiBold.copyWith(fontSize: 15.sp),
            ),
          )
        ],
      ),
    );
  }
}
