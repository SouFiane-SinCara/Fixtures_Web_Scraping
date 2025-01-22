import 'package:fixtures_web_scraping/core/constants/my_colors.dart';
import 'package:fixtures_web_scraping/core/constants/my_text_style.dart';
import 'package:fixtures_web_scraping/core/constants/routes_name.dart';
import 'package:fixtures_web_scraping/core/helpers/spaces.dart';
import 'package:fixtures_web_scraping/features/fixtures/domain/entities/fixture_details.dart';
import 'package:fixtures_web_scraping/features/fixtures/presentation/blocs/fixture_details_cubit/fixture_details_cubit.dart';
import 'package:fixtures_web_scraping/features/fixtures/presentation/blocs/fixture_details_cubit/fixture_details_state.dart';
import 'package:fixtures_web_scraping/features/fixtures/presentation/widgets/fixture_card.dart';
import 'package:fixtures_web_scraping/features/fixtures/presentation/widgets/knockout_fixture_card.dart';
import 'package:fixtures_web_scraping/features/fixtures/presentation/widgets/statistics_card.dart';
import 'package:fixtures_web_scraping/features/fixtures/presentation/widgets/team_logo_name_card.dart';
import 'package:fixtures_web_scraping/features/fixtures/presentation/widgets/team_position_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

enum SelectionInfo {
  defaultInfo,
  standings,
  knockout,
}

class FixtureDetailsPage extends StatefulWidget {
  final String fixtureDetailsUrl;
  const FixtureDetailsPage({super.key, required this.fixtureDetailsUrl});

  @override
  State<FixtureDetailsPage> createState() => _FixtureDetailsPageState();
}

class _FixtureDetailsPageState extends State<FixtureDetailsPage> {
  late FixtureDetailsCubit fixtureDetailsCubit;
  void getFixtureDetails(BuildContext context) async {
    await fixtureDetailsCubit.getFixtureDetails(
        fixtureDetailsUrl: widget.fixtureDetailsUrl);
  }

  SelectionInfo selectionInfo = SelectionInfo.defaultInfo;

  bool showLastFiveMatchesOfHomeTeam = true;
  @override
  void initState() {
    context
        .read<FixtureDetailsCubit>()
        .getFixtureDetails(fixtureDetailsUrl: widget.fixtureDetailsUrl);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    fixtureDetailsCubit = BlocProvider.of<FixtureDetailsCubit>(context);
    getFixtureDetails(context);
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: MyColors.black2,
          child: BlocBuilder<FixtureDetailsCubit, FixtureDetailsState>(
            builder: (context, fixtureDetailsState) {
              FixtureDetails fixtureDetails =
                  fixtureDetailsState.fixtureDetails ?? FixtureDetails.empty();
              
              return Column(
                children: [
                  //! -------------------------bar----------------------------
                  AppBar(
                    leadingWidth: 40.w,
                    centerTitle: true,
                    title: FittedBox(
                      child: Text(
                        fixtureDetails.leagueName,
                        style:
                            MyTextStyle.whiteSemiBold.copyWith(fontSize: 16.sp),
                      ),
                    ),
                    leading: Container(
                      margin: EdgeInsets.only(left: 15.w),
                      width: 15.w,
                      height: 15.h,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset(
                          'lib/core/assets/icons/arrow.png',
                          color: MyColors.white,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    backgroundColor: MyColors.black2,
                  ),
                  //!-------------- home team vs away team------------------------------
                  Skeletonizer(
                    enabled: fixtureDetailsState.status.isLoading,
                    effect: MyColors.loadingEffect,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //? ----------home Team logo with name-----------------------

                        TeamLogoNameCard(
                            teamLogo: fixtureDetails.homeTeam.imageUrl,
                            teamName: fixtureDetails.homeTeam.name),
                        //? -----------score---------------
                        Column(
                          children: [
                            fixtureDetails.homeScore == '' ||
                                    fixtureDetails.awayScore == ''
                                ? const SizedBox()
                                : SizedBox(
                                    width: 80.w,
                                    height: 50.h,
                                    child: FittedBox(
                                      child: Text(
                                        '${fixtureDetails.homeScore} - ${fixtureDetails.awayScore}',
                                        style: MyTextStyle.whiteSemiBold,
                                      ),
                                    ),
                                  ),
                            //?--------------- time-------------------
                            SizedBox(
                              width: 60.w,
                              height: 30.h,
                              child: FittedBox(
                                child: Text(
                                  fixtureDetails.matchTime,
                                  style: MyTextStyle.whiteSemiBold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        //? ----------away Team logo with name-----------------------

                        TeamLogoNameCard(
                            teamLogo: fixtureDetails.awayTeam.imageUrl,
                            teamName: fixtureDetails.awayTeam.name),
                      ],
                    ),
                  ),

                  //!------------selection bar-----------------------
                  Expanded(
                    child: StatefulBuilder(
                      builder: (context, setSelectionInfo) {
                        return Column(
                          children: [
                            if (fixtureDetails.knockout!.isNotEmpty ||
                                fixtureDetails.standings!.isNotEmpty)
                              Column(
                                children: [
                                  heightBox(30),
                                  Container(
                                    height: 40.h,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.w),
                                    child: Row(
                                      children: [
                                        //?----------------------button match details (default) -----------------------------

                                        Expanded(
                                          flex: 1,
                                          child: GestureDetector(
                                            onTap: () {
                                              setSelectionInfo(
                                                () {
                                                  selectionInfo =
                                                      SelectionInfo.defaultInfo;
                                                },
                                              );
                                            },
                                            child: Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 5.w),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          23.r),
                                                  gradient: selectionInfo ==
                                                          SelectionInfo
                                                              .defaultInfo
                                                      ? MyColors.gradient
                                                      : null),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5.w),
                                              alignment: Alignment.center,
                                              child: const FittedBox(
                                                child: Text(
                                                  'Match details',
                                                  style:
                                                      MyTextStyle.whiteRegular,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        //?---------------------- button Standings -------if not null -----------------------------
                                        if (fixtureDetails.standings != null &&
                                            fixtureDetails
                                                .standings!.isNotEmpty)
                                          Expanded(
                                            flex: 1,
                                            child: GestureDetector(
                                              onTap: () {
                                                setSelectionInfo(
                                                  () {
                                                    selectionInfo =
                                                        SelectionInfo.standings;
                                                  },
                                                );
                                              },
                                              child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 5.w),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            23.r),
                                                    gradient: selectionInfo ==
                                                            SelectionInfo
                                                                .standings
                                                        ? MyColors.gradient
                                                        : null),
                                                alignment: Alignment.center,
                                                child: const FittedBox(
                                                  child: Text(
                                                    'Standings',
                                                    style: MyTextStyle
                                                        .whiteRegular,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        //?----------------------button knockout--------if not null-----------------------------
                                        if (fixtureDetails.knockout != null &&
                                            fixtureDetails.knockout!.isNotEmpty)
                                          Expanded(
                                            flex: 1,
                                            child: GestureDetector(
                                              onTap: () {
                                                setSelectionInfo(
                                                  () {
                                                    selectionInfo =
                                                        SelectionInfo.knockout;
                                                  },
                                                );
                                              },
                                              child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 5.w),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            23.r),
                                                    gradient: selectionInfo ==
                                                            SelectionInfo
                                                                .knockout
                                                        ? MyColors.gradient
                                                        : null),
                                                alignment: Alignment.center,
                                                child: const FittedBox(
                                                  child: Text(
                                                    'Knockout',
                                                    style: MyTextStyle
                                                        .whiteRegular,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            heightBox(5),
                            //!-------------fixture Information----------------------
                            //?--------------match details content (default)-------------
                            if (selectionInfo == SelectionInfo.defaultInfo)
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      heightBox(30),
                                      Column(
                                        children: fixtureDetails.statistics
                                            .map((statistic) {
                                          return Skeletonizer(
                                            enabled: fixtureDetailsState
                                                .status.isLoading,
                                            effect: MyColors.loadingEffect,
                                            child: StatisticsCard(
                                                statistic: statistic),
                                          );
                                        }).toList(),
                                      ),
                                      //*--------------last five matches for these tow teams--------------
                                      if (fixtureDetails.statistics.isNotEmpty)
                                        heightBox(30),
                                      FittedBox(
                                        child: Text(
                                          'Last matches',
                                          style: MyTextStyle.whiteSemiBold
                                              .copyWith(fontSize: 16.sp),
                                        ),
                                      ),
                                      heightBox(20),
                                      //---------teams selection buttons---------------
                                      StatefulBuilder(
                                        builder: (context,
                                                setSelectionFiveLastMatchesStates) =>
                                            Column(
                                          children: [
                                            Skeletonizer(
                                              enabled: fixtureDetailsState
                                                  .status.isLoading,
                                              effect: MyColors.loadingEffect,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      setSelectionFiveLastMatchesStates(
                                                        () {
                                                          showLastFiveMatchesOfHomeTeam =
                                                              true;
                                                        },
                                                      );
                                                    },
                                                    child: Container(
                                                      height: 40.h,
                                                      width: 140.w,
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5.w),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      23.r),
                                                          gradient:
                                                              showLastFiveMatchesOfHomeTeam
                                                                  ? MyColors
                                                                      .gradient
                                                                  : null),
                                                      alignment:
                                                          Alignment.center,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5.w),
                                                      child: FittedBox(
                                                        child: Text(
                                                          fixtureDetails
                                                              .homeTeam.name,
                                                          style: MyTextStyle
                                                              .whiteRegular,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      setSelectionFiveLastMatchesStates(
                                                        () {
                                                          showLastFiveMatchesOfHomeTeam =
                                                              false;
                                                        },
                                                      );
                                                    },
                                                    child: Container(
                                                      height: 40.h,
                                                      width: 140.w,
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5.w),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      23.r),
                                                          gradient:
                                                              !showLastFiveMatchesOfHomeTeam
                                                                  ? MyColors
                                                                      .gradient
                                                                  : null),
                                                      alignment:
                                                          Alignment.center,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5.w),
                                                      child: FittedBox(
                                                        child: Text(
                                                          fixtureDetails
                                                              .awayTeam.name,
                                                          style: MyTextStyle
                                                              .whiteRegular,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            heightBox(20),
                                            //-----last five matches------------
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20.w),
                                              child: Column(
                                                  children: (showLastFiveMatchesOfHomeTeam
                                                          ? fixtureDetails
                                                              .homeTeamLastFixtures
                                                          : fixtureDetails
                                                              .awayTeamLastFixtures)
                                                      .map((fixtureElement) {
                                                return Skeletonizer(
                                                  effect:
                                                      MyColors.loadingEffect,
                                                  enabled: fixtureDetailsState
                                                      .status.isLoading,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Navigator
                                                          .pushNamedAndRemoveUntil(
                                                        context,
                                                        RoutesName
                                                            .fixtureDetailsPageName,
                                                        arguments:
                                                            fixtureElement
                                                                .moreInfoLink,
                                                        (route) =>
                                                            route.isFirst,
                                                      );
                                                    },
                                                    child: FixtureCard(
                                                      fixture: fixtureElement,
                                                      showDate: true,
                                                    ),
                                                  ),
                                                );
                                              }).toList()),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),

                            //?--------------standings content-------------
                            if (selectionInfo == SelectionInfo.standings)
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Container(
                                    margin: EdgeInsets.only(top: 20.h),
                                    child: Column(
                                      //*-------------groups--------------
                                      children: fixtureDetails.standings!.map(
                                        (standing) {
                                          return Column(
                                            children: [
                                              //---------group name-------------
                                              standing.nameStanding == ''
                                                  ? const SizedBox()
                                                  : Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      margin: EdgeInsets.only(
                                                          bottom: 10.h),
                                                      padding: EdgeInsets.only(
                                                          left: 20.w),
                                                      child: FittedBox(
                                                        child: Text(
                                                          standing.nameStanding,
                                                          style: MyTextStyle
                                                              .whiteSemiBold
                                                              .copyWith(
                                                                  fontSize:
                                                                      14.sp),
                                                        ),
                                                      ),
                                                    ),
                                              //------------group content--------------------
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10.h,
                                                    horizontal: 5.w),
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 20.w),
                                                decoration: BoxDecoration(
                                                  color: MyColors.black1,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    19.r,
                                                  ),
                                                ),
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 20.h,
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            flex: 6,
                                                            child: Container(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left:
                                                                          5.w),
                                                              child:
                                                                  const FittedBox(
                                                                      child:
                                                                          Text(
                                                                'Team',
                                                                style: MyTextStyle
                                                                    .whiteRegular,
                                                              )),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: FittedBox(
                                                                child: Text(
                                                                  'PL',
                                                                  style: MyTextStyle
                                                                      .whiteRegular
                                                                      .copyWith(
                                                                          fontSize:
                                                                              20.sp),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left:
                                                                          4.w),
                                                              child: FittedBox(
                                                                child: Text(
                                                                  'W',
                                                                  style: MyTextStyle
                                                                      .whiteRegular
                                                                      .copyWith(
                                                                          fontSize:
                                                                              20.sp),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left:
                                                                          4.w),
                                                              child: FittedBox(
                                                                child: Text(
                                                                  'D',
                                                                  style: MyTextStyle
                                                                      .whiteRegular
                                                                      .copyWith(
                                                                          fontSize:
                                                                              20.sp),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left:
                                                                          4.w),
                                                              child: FittedBox(
                                                                child: Text(
                                                                  'L',
                                                                  style: MyTextStyle
                                                                      .whiteRegular
                                                                      .copyWith(
                                                                          fontSize:
                                                                              20.sp),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left:
                                                                          4.w),
                                                              child: FittedBox(
                                                                child: Text(
                                                                  'GD',
                                                                  style: MyTextStyle
                                                                      .whiteRegular
                                                                      .copyWith(
                                                                          fontSize:
                                                                              20.sp),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left:
                                                                          4.w),
                                                              child: FittedBox(
                                                                child: Text(
                                                                  'PT',
                                                                  style: MyTextStyle
                                                                      .whiteRegular
                                                                      .copyWith(
                                                                          fontSize:
                                                                              20.sp),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
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
                                                            color:
                                                                MyColors.black2,
                                                            height: 1.h,
                                                            thickness: 0.5.h,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      children: standing
                                                          .teamPosition
                                                          .map(
                                                        (teamPosition) {
                                                          return TeamPositionCard(
                                                              teamPosition:
                                                                  teamPosition);
                                                        },
                                                      ).toList(),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              heightBox(20),
                                            ],
                                          );
                                        },
                                      ).toList(),
                                    ),
                                  ),
                                ),
                              ),
                            //?--------------knockout content-------------
                            if (selectionInfo == SelectionInfo.knockout)
                              Expanded(
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 5.w),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: fixtureDetails.knockout!.map(
                                          (step) {
                                            return Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 5.w),
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    FittedBox(
                                                        child: Text(
                                                      step.roundName,
                                                      style: MyTextStyle
                                                          .whiteRegular,
                                                    )),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children:
                                                          step.fixtures.map(
                                                        (fixture) {
                                                          return KnockoutFixtureCard(
                                                            fixtureKnockout:
                                                                fixture,
                                                          );
                                                        },
                                                      ).toList(),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ).toList()),
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
