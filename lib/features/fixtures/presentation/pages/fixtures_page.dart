import 'package:fixtures_web_scraping/core/constants/my_colors.dart';
import 'package:fixtures_web_scraping/core/constants/my_text_style.dart';
import 'package:fixtures_web_scraping/core/constants/routes_name.dart';
import 'package:fixtures_web_scraping/core/helpers/spaces.dart';
import 'package:fixtures_web_scraping/features/fixtures/domain/entities/fixture.dart';
import 'package:fixtures_web_scraping/features/fixtures/presentation/blocs/date_selection_cubit/date_selection_cubit.dart';
import 'package:fixtures_web_scraping/features/fixtures/presentation/blocs/fixtures_cubit/fixtures_cubit.dart';
import 'package:fixtures_web_scraping/features/fixtures/presentation/blocs/fixtures_cubit/fixtures_state.dart';
import 'package:fixtures_web_scraping/features/fixtures/presentation/widgets/fixture_card.dart';
import 'package:fixtures_web_scraping/features/fixtures/presentation/widgets/league_card.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FixturesPage extends StatefulWidget {
  const FixturesPage({super.key});

  @override
  State<FixturesPage> createState() => _FixturesPageState();
}

class _FixturesPageState extends State<FixturesPage> {
  late FixturesCubit fixturesCubit;
  @override
  void initState() {
    super.initState();
    fixturesCubit = BlocProvider.of<FixturesCubit>(context);
    fixturesCubit.getFixtures(date: formatDateTime(DateTime.now()));
  }

  String formatDateTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(dateTime);
  }

  Future<void> showCalendar(BuildContext context) async {
    final ThemeData theme = Theme.of(context);
    DateSelectionCubit dateSelectionCubit =
        BlocProvider.of<DateSelectionCubit>(context);
    final ThemeData datePickerTheme = theme.copyWith(
      colorScheme: const ColorScheme.light(
        primary: Colors.white, // header background color
        onPrimary: MyColors.black3, // header text color
        onSurface: MyColors.white, // body text color
        surface: MyColors.black2, // The background color of the calendar
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white, // button text color
        ),
      ),
    );
    DateTime? selectedDate = await showDatePicker(
        context: context,
        firstDate: DateTime(2021),
        lastDate: DateTime(2100),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: datePickerTheme,
            child: child!,
          );
        },
        initialDate: dateSelectionCubit.dateTime);

    if (selectedDate == null) return;

    fixturesCubit.getFixtures(date: formatDateTime(selectedDate));
    dateSelectionCubit.changeDate(selectedDate);
  }

  List<Fixture> filterFixtures(
      {required List<Fixture> fixtures, required String searching}) {
    List<Fixture> filteredFixtures = [];
    for (var element in fixtures) {
      if (element.homeTeamName
              .toLowerCase()
              .contains(searching.toLowerCase()) ||
          element.awayTeamName
              .toLowerCase()
              .contains(searching.toLowerCase())) {
        filteredFixtures.add(element);
      }
    }
    return filteredFixtures;
  }

  List<List<Fixture>> fixturesToLeaguesWithFixtures(
      {required List<Fixture> fixtures}) {
    if (fixtures.isEmpty) return [];

    Map<String, List<Fixture>> leagueFixturesMap = {};

    for (var fixture in fixtures) {
      if (!leagueFixturesMap.containsKey(fixture.league)) {
        leagueFixturesMap[fixture.league] = [];
      }
      leagueFixturesMap[fixture.league]!.add(fixture);
    }

    return leagueFixturesMap.values.toList();
  }

  bool searchInShow = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<FixturesCubit, FixturesState>(
      listener: (context, fixturesState) {
        
        if (fixturesState.status.isError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: SizedBox(
                height: 50.h,
                width: double.infinity,
                child: Center(
                  child: Text(fixturesState.error),
                ),
              ),
            ),
          );
        }
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: MyColors.black2,
          body: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              children: [
                heightBox(30),
                //! --------------------bar------------------
                StatefulBuilder(
                  builder: (context, setState) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //?-------------logo-----------------
                        searchInShow
                            ? const SizedBox()
                            : Container(
                                width: 70.w,
                                height: 30.h,
                                margin: EdgeInsets.only(left: 20.w),
                                child: Image.asset(
                                  'lib/core/assets/icons/logo.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                        widthBox(searchInShow ? 20 : 200),
                        //?----------search field --------if searchInShow is true-----
                        searchInShow
                            ? Container(
                                width: 260.0.w,
                                decoration: BoxDecoration(
                                    color: MyColors.black1,
                                    borderRadius: BorderRadius.circular(14.r)),
                                child: TextField(
                                  style: MyTextStyle.whiteRegular
                                      .copyWith(fontSize: 15.sp),
                                  cursorColor: MyColors.white,
                                  textInputAction: TextInputAction.search,
                                  onChanged: (value) {
                                    BlocProvider.of<FixturesCubit>(context)
                                        .searchFixture(query: value);
                                  },
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.only(
                                      bottom: 20.0.h,
                                      top: 20.0.h,
                                    ),
                                    hintText: 'Search your team...',
                                    hintStyle: MyTextStyle.grey1SemiBold
                                        .copyWith(fontSize: 14.sp),
                                    border: InputBorder.none,
                                    prefixIcon: Image.asset(
                                      'lib/core/assets/icons/search.png',
                                      color: MyColors.grey2,
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        //?-------------calendar-----------------
                        searchInShow
                            ? const SizedBox()
                            : Container(
                                width: 30.w,
                                height: 30.h,
                                margin: EdgeInsets.only(right: 5.w),
                                child: GestureDetector(
                                  onTap: () {
                                    showCalendar(context);
                                  },
                                  child: SvgPicture.asset(
                                    'lib/core/assets/icons/calendar.svg',
                                    colorFilter: const ColorFilter.mode(
                                        Colors.white, BlendMode.srcIn),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                        //?-------------search-----------------
                        searchInShow
                            ? GestureDetector(
                                onTap: () {
                                  setState(
                                    () {
                                      searchInShow = false;
                                    },
                                  );
                                  BlocProvider.of<FixturesCubit>(context)
                                      .searchFixture(query: '');
                                },
                                child: Container(
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 20.w),
                                  child: FittedBox(
                                      child: Text('Cancel',
                                          style: MyTextStyle.whiteRegular
                                              .copyWith(fontSize: 12.sp))),
                                ),
                              )
                            : Container(
                                margin: EdgeInsets.only(right: 5.w),
                                width: 30.w,
                                height: 30.h,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(
                                      () {
                                        searchInShow = true;
                                      },
                                    );
                                  },
                                  child: Image.asset(
                                    'lib/core/assets/icons/search.png',
                                    color: MyColors.white,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                      ],
                    );
                  },
                ),

                heightBox(10),
                //!------------------selected date---------
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  alignment: Alignment.centerLeft,
                  child: FittedBox(
                    child: BlocBuilder<DateSelectionCubit, DateSelectionState>(
                      builder: (context, state) {
                        if (state is DateSelectionUpdate) {
                          return Text(
                            '${state.dateTime.day} / ${state.dateTime.month} / ${state.dateTime.year}',
                            style: MyTextStyle.grey1SemiBold
                                .copyWith(fontSize: 14.sp),
                          );
                        } else {
                          DateTime currentDateTime = DateTime.now();
                          return Text(
                            '${currentDateTime.day} / ${currentDateTime.month} / ${currentDateTime.year}',
                            style: MyTextStyle.grey1SemiBold
                                .copyWith(fontSize: 14.sp),
                          );
                        }
                      },
                    ),
                  ),
                ),
                //! -----------------fixtures--------------
                Expanded(
                  child: BlocBuilder<FixturesCubit, FixturesState>(
                    builder: (context, fixturesState) {
                      return SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Column(
                            children: (fixturesState.status.isLoading &&
                                        fixturesState.fixtures.isEmpty
                                    ? List.generate(
                                        2,
                                        (index) => List.generate(
                                          4,
                                          (index) => Fixture.empty(),
                                        ),
                                      )
                                    : fixturesToLeaguesWithFixtures(
                                        fixtures: (fixturesState
                                                .status.isSearching
                                            ? fixturesState.searchingFixtures
                                            : fixturesState.fixtures),
                                      ))
                                .map(
                              (fixtures) {
                                return Column(
                                  children: [
                                    Skeletonizer(
                                      effect: MyColors.loadingEffect,
                                      enabled: fixturesState.status.isLoading,
                                      child: LeagueCard(
                                          leagueImg: fixtures.first.leagueLogo,
                                          leagueName: fixtures.first.league),
                                    ),
                                    heightBox(10),
                                    ...fixtures.map(
                                      (fixture) {
                                        return Skeletonizer(
                                          effect: MyColors.loadingEffect,
                                          enabled:
                                              fixturesState.status.isLoading,
                                          child: GestureDetector(
                                              onTap: () {
                                                if (fixturesState
                                                    .status.isLoaded) {
                                                  Navigator.pushNamed(
                                                      context,
                                                      RoutesName
                                                          .fixtureDetailsPageName,
                                                      arguments:
                                                          fixture.moreInfoLink);
                                                }
                                              },
                                              child: FixtureCard(
                                                  fixture: fixture)),
                                        );
                                      },
                                    ),
                                  ],
                                );
                              },
                            ).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
