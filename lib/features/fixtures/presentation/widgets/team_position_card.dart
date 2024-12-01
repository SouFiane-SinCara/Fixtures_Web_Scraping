import 'package:fixtures_web_scraping/core/constants/my_colors.dart';
import 'package:fixtures_web_scraping/core/constants/my_text_style.dart';
import 'package:fixtures_web_scraping/core/helpers/spaces.dart';
import 'package:fixtures_web_scraping/features/fixtures/domain/entities/team_position.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TeamPositionCard extends StatelessWidget {
  final TeamPosition teamPosition;
  const TeamPositionCard({super.key, required this.teamPosition});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25.h,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 6,
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 5.w),
                  child: Row(
                    children: [
                      Container(
                        width: 30.w,
                        height: 20.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: MyColors.white,
                          border: Border.all(color: MyColors.black3, width: 2),
                        ),
                        child: Image.network(
                          teamPosition.team.imageUrl,
                        ),
                      ),
                      widthBox(10),
                      Container(
                        width: 110.w,
                        height: 20.h,
                        alignment: Alignment.centerLeft,
                        child: FittedBox(
                            child: Text(
                          teamPosition.team.name,
                          style: MyTextStyle.whiteRegular,
                        )),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  height: 20.h,
                  child: FittedBox(
                    child: Text(
                      teamPosition.gamesPlayed.toString(),
                      style: MyTextStyle.whiteRegular.copyWith(fontSize: 20.sp),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  height: 20.h,
                  margin: EdgeInsets.only(left: 4.w),
                  child: FittedBox(
                    child: Text(
                      teamPosition.wins.toString(),
                      style: MyTextStyle.whiteRegular.copyWith(fontSize: 20.sp),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  height: 20.h,
                  margin: EdgeInsets.only(left: 4.w),
                  child: FittedBox(
                    child: Text(
                      teamPosition.draws.toString(),
                      style: MyTextStyle.whiteRegular.copyWith(fontSize: 20.sp),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  height: 20.h,
                  margin: EdgeInsets.only(left: 4.w),
                  child: FittedBox(
                    child: Text(
                      teamPosition.lose.toString(),
                      style: MyTextStyle.whiteRegular.copyWith(fontSize: 20.sp),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  height: 20.h,
                  margin: EdgeInsets.only(left: 4.w),
                  child: FittedBox(
                    child: Text(
                      teamPosition.goalsDifference.toString(),
                      style: MyTextStyle.whiteRegular.copyWith(fontSize: 20.sp),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  height: 20.h,
                  margin: EdgeInsets.only(left: 4.w),
                  child: FittedBox(
                    child: Text(
                      teamPosition.points.toString(),
                      style: MyTextStyle.whiteRegular.copyWith(fontSize: 20.sp),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              Expanded(
                flex: 1,
                child: Divider(
                  color: MyColors.black2,
                  height: 1.h,
                  thickness: 0.5.h,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
