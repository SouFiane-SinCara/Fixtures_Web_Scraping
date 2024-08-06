import 'package:fixtures_app/core/constants/my_text_style.dart';
import 'package:fixtures_app/features/fixtures/domain/entities/statistic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatisticsCard extends StatelessWidget {
  final Statistic statistic;
  const StatisticsCard({super.key, required this.statistic});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.h,
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 100.w,
            child: FittedBox(
              child: Text(
                statistic.homeStatistic,
                style: MyTextStyle.whiteRegular,
              ),
            ),
          ),
          SizedBox(
            width: 100.w,
            child: FittedBox(
              child: Text(
                statistic.statisticName,
                style: MyTextStyle.whiteSemiBold,
              ),
            ),
          ),
          SizedBox(
            width: 100.w,
            child: FittedBox(
              child: Text(
                statistic.awayStatistic,
                style: MyTextStyle.whiteRegular,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
