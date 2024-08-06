import 'package:fixtures_app/core/constants/my_colors.dart';
import 'package:fixtures_app/core/constants/my_text_style.dart';
import 'package:fixtures_app/core/constants/routes_name.dart';
import 'package:fixtures_app/core/helpers/spaces.dart';
import 'package:fixtures_app/core/widgets/error_card.dart';
import 'package:fixtures_app/core/widgets/loading.dart';
import 'package:fixtures_app/features/fixtures/domain/entities/fixture.dart';
import 'package:fixtures_app/features/fixtures/presentation/blocs/date_selection_cubit/date_selection_cubit.dart';
import 'package:fixtures_app/features/fixtures/presentation/blocs/fixture_search_cubit/fixture_search_cubit.dart';
import 'package:fixtures_app/features/fixtures/presentation/blocs/fixtures_cubit/fixtures_cubit.dart';
import 'package:fixtures_app/features/fixtures/presentation/widgets/fixture_card.dart';
import 'package:fixtures_app/features/fixtures/presentation/widgets/league_card.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class FixturesPage extends StatelessWidget {
  FixturesPage({super.key});

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
    fixturesCubit.stopUpdating();
    fixturesCubit.getFixtures(date: formatDateTime(selectedDate));
    dateSelectionCubit.changeDate(selectedDate);
  }

  late FixturesCubit fixturesCubit;

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

  bool searchInShow = false;
  @override
  Widget build(BuildContext context) {
    fixturesCubit = BlocProvider.of<FixturesCubit>(context);
    fixturesCubit.getFixtures(date: '');
    return SafeArea(
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
                                  BlocProvider.of<FixtureSearchCubit>(context)
                                      .search(value);
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
                                BlocProvider.of<FixtureSearchCubit>(context)
                                    .search('');
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 20.w),
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
                child: BlocBuilder<DateSelectionCubit, DateSelectionState>(
                  builder: (context, dateState) {
                    return BlocBuilder<FixtureSearchCubit, FixtureSearchState>(
                      builder: (context, searchState) {
                        return BlocBuilder<FixturesCubit, FixturesState>(
                          builder: (context, state) {
                            if (state is FixturesErrorState) {
                              return ErrorCard(message: state.errorMessage);
                            } else if (state is FixturesLoadingState) {
                              return const Loading();
                            } else {
                              List<Fixture>? result =
                                  state is FixturesLoadedState
                                      ? state.fixtures
                                      : state is FixtureUpdateState
                                          ? state.fixtures
                                          : [];
                              List<Fixture> filteredFixtures = [];
                              if (searchState is UpdateFixtureSearchState) {
                                filteredFixtures = filterFixtures(
                                    fixtures: result,
                                    searching: searchState.searchInput);
                              } else {
                                filteredFixtures = result;
                              }
                              if (filteredFixtures.isNotEmpty) {
                                String currentLeague =
                                    filteredFixtures.first.league;

                                return ListView.builder(
                                  itemCount: filteredFixtures.length,
                                  itemBuilder: (context, index) {
                                    Fixture fixture = filteredFixtures[index];
                                    bool showLeagueCard = false;

                                    if (currentLeague != fixture.league ||
                                        index == 0) {
                                      currentLeague = fixture.league;
                                      showLeagueCard = true;
                                    }

                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.w),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          if (showLeagueCard)
                                            LeagueCard(
                                              leagueImg: fixture.leagueLogo,
                                              leagueName: fixture.league,
                                            ),
                                          GestureDetector(
                                            onTap: () async {
                                              String date = dateState
                                                      is DateSelectionUpdate
                                                  ? formatDateTime(
                                                      dateState.dateTime)
                                                  : '';
                                              fixturesCubit.stopUpdating();
                                              await Navigator.pushNamed(
                                                context,
                                                RoutesName
                                                    .fixtureDetailsPageName,
                                                arguments: fixture.moreInfoLink,
                                              );

                                              fixturesCubit.getFixtures(
                                                  date: date);
                                            },
                                            child:
                                                FixtureCard(fixture: fixture),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              } else {
                                return const ErrorCard(
                                    message: "no fixture found");
                              }
                            }
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
