import 'package:cached_network_image/cached_network_image.dart';
import 'package:fixtures_web_scraping/core/constants/my_colors.dart';
import 'package:fixtures_web_scraping/core/constants/my_text_style.dart';
import 'package:fixtures_web_scraping/core/helpers/spaces.dart';
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
              shape: BoxShape.circle,
              color: MyColors.black1,
              border: Border.all(color: MyColors.black3, width: 2),
            ),
            child: leagueImg == ''
                ? null
                : CachedNetworkImage(
                    imageUrl: leagueImg,
                    placeholder: (context, url) => Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: MyColors.black1,
                        border: Border.all(color: MyColors.black3, width: 2),
                      ),
                    ),
                  ),
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
