import 'package:cached_network_image/cached_network_image.dart';
import 'package:fixtures_web_scraping/core/constants/my_colors.dart';
import 'package:fixtures_web_scraping/core/constants/my_text_style.dart';
import 'package:fixtures_web_scraping/core/helpers/spaces.dart';
import 'package:fixtures_web_scraping/features/fixtures/domain/entities/fixture.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FixtureCard extends StatelessWidget {
  final Fixture fixture;
  final bool? showDate;
  const FixtureCard({super.key, required this.fixture, this.showDate});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: MyColors.black3,
        borderRadius: BorderRadius.all(Radius.circular(16.r)),
      ),
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: teamAndLogo(
                logo: fixture.homeTeamLogo, name: fixture.homeTeamName),
          ),
          widthBox(10),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                if (fixture.awayScore != '' && fixture.awayScore != '')
                  Expanded(
                    flex: 2,
                    child: FittedBox(
                      child: Text(
                        '${fixture.homeScore} - ${fixture.awayScore}',
                        style: MyTextStyle.whiteSemiBold,
                      ),
                    ),
                  ),
                if (!(fixture.date == '' && fixture.time == ''))
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.center,
                      child: FittedBox(
                        child: Text(
                          showDate != null ? fixture.date : fixture.time,
                          style: MyTextStyle.whiteRegular,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          widthBox(10),
          Expanded(
              flex: 2,
              child: teamAndLogo(
                  logo: fixture.awayTeamLogo, name: fixture.awayTeamName)),
        ],
      ),
    );
  }

  Column teamAndLogo({required String name, required String logo}) {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: MyColors.black1,
              border: Border.all(color: MyColors.black3, width: 2),
            ),
            child: logo == ''
                ? null
                : CachedNetworkImage(
                    imageUrl: logo,
                    placeholder: (context, url) => Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: MyColors.black1,
                        border: Border.all(color: MyColors.black3, width: 2),
                      ),
                    ),
                  ),
          ),
        ),
        heightBox(5),
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.center,
            child: FittedBox(
              child: Text(
                name,
                style: MyTextStyle.whiteSemiBold,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        )
      ],
    );
  }
}
