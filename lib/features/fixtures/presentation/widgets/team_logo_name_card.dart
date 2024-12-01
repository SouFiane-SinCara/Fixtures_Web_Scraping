import 'package:auto_size_text/auto_size_text.dart';
import 'package:fixtures_web_scraping/core/constants/my_colors.dart';
import 'package:fixtures_web_scraping/core/constants/my_text_style.dart';
import 'package:fixtures_web_scraping/core/helpers/spaces.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TeamLogoNameCard extends StatelessWidget {
  final String teamLogo;
  final String teamName;

  const TeamLogoNameCard(
      {super.key, required this.teamLogo, required this.teamName});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100.w,
          height: 60.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: MyColors.black1,
            border: Border.all(color: MyColors.black3, width: 2),
          ),
          child: Image.network(
            teamLogo,
          ),
        ),
        heightBox(10),
        Container(
          width: 100.w,
          alignment: Alignment.center,
          child: AutoSizeText(
            teamName,
            style: MyTextStyle.whiteSemiBold,
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        )
      ],
    );
  }
}
