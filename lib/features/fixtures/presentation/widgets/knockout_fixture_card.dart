import 'package:fixtures_app/core/constants/my_colors.dart';
import 'package:fixtures_app/core/constants/my_text_style.dart';
import 'package:fixtures_app/features/fixtures/domain/entities/fixture_knockout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class KnockoutFixtureCard extends StatelessWidget {
  final FixtureKnockout fixtureKnockout;
  const KnockoutFixtureCard({super.key, required this.fixtureKnockout});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      width: 80.w,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: MyColors.grey1),
        borderRadius: BorderRadius.circular(5.r),
        color: MyColors.black3,
      ),
      margin: EdgeInsets.symmetric(vertical: 20.h),
      padding: EdgeInsets.only(top: 5.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 30.w,
                height: 40.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: MyColors.black1,
                  border: Border.all(color: MyColors.black3, width: 2),
                ),
                child: Image.network(fixtureKnockout.teams.first.imageUrl),
              ),
              Container(
                width: 30.w,
                height: 40.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: MyColors.black1,
                  border: Border.all(color: MyColors.black3, width: 2),
                ),
                child: Image.network(fixtureKnockout.teams[1].imageUrl),
              ),
            ],
          ),
          Container(
            height: 20.h,
            margin: EdgeInsets.symmetric(horizontal: 5.w),
            child: FittedBox(
              child: Text(
                fixtureKnockout.score,
                style: MyTextStyle.whiteSemiBold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
