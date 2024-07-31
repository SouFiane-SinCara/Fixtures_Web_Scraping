import 'package:auto_size_text/auto_size_text.dart';
import 'package:fixtures_app/core/constants/my_colors.dart';
import 'package:fixtures_app/core/constants/my_text_style.dart';
import 'package:fixtures_app/core/helpers/spaces.dart';
import 'package:fixtures_app/features/fixtures/domain/entities/fixture.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FixtureCard extends StatelessWidget {
  final Fixture fixture;
  const FixtureCard({super.key, required this.fixture});

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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          widthBox(10),
          SizedBox(
            width: 50.w,
            height: 40.h,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: 15.w,
                  width: 30.w,
                  height: 40.h,
                  child: Image.network(
                    fixture.awayTeamLogo,
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  left: 0.w,
                  width: 30.w,
                  height: 40.h,
                  child: Image.network(
                    fixture.homeTeamLogo,
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80.w,
                height: 30.h,
                margin: EdgeInsets.symmetric(horizontal: 5.w),
                child: FittedBox(
                  child: Text(
                    fixture.homeTeamName,
                    style: MyTextStyle.whiteSemiBold,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              fixture.awayScore == ''
                  ? const SizedBox()
                  : SizedBox(
                      width: 90.w,
                      height: 25.h,
                      child: AutoSizeText(
                        fixture.homeScore,
                        style:
                            MyTextStyle.whiteSemiBold.copyWith(fontSize: 25.sp),
                        textAlign: TextAlign.center,
                      ),
                    ),
            ],
          ),
          widthBox(5),
          FittedBox(
            child: Text(
              'VS',
              style: MyTextStyle.whiteSemiBold.copyWith(fontSize: 15.sp),
            ),
          ),
          widthBox(5),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80.w,
                height: 30.h,
                margin: EdgeInsets.symmetric(horizontal: 5.w),
                child: FittedBox(
                  child: Text(
                    fixture.awayTeamName,
                    style: MyTextStyle.whiteSemiBold,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              fixture.awayScore == ''
                  ? const SizedBox()
                  : SizedBox(
                      width: 90.w,
                      height: 25.h,
                      child: AutoSizeText(
                        fixture.awayScore,
                        style:
                            MyTextStyle.whiteSemiBold.copyWith(fontSize: 25.sp),
                        textAlign: TextAlign.center,
                      ),
                    ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
                color: MyColors.black1,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16.r),
                    bottomRight: Radius.circular(16.r))),
            width: 50.w,
            height: 60.h,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: FittedBox(
              child: Text(
                fixture.time,
                textAlign: TextAlign.center,
                style: MyTextStyle.whiteSemiBold.copyWith(fontSize: 14.sp),
                maxLines: 1,
              ),
            ),
          )
        ],
      ),
    );
  }
}
