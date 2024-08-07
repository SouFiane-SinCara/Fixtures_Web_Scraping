import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fixtures_app/core/routes/my_routes.dart';
import 'package:fixtures_app/features/fixtures/data/data_sources/fixtures_remote_data_src.dart';
import 'package:fixtures_app/features/fixtures/data/repositories_impl/fixtures_repository_impl.dart';
import 'package:fixtures_app/features/fixtures/domain/use_cases/get_fixture_details_use_case.dart';
import 'package:fixtures_app/features/fixtures/domain/use_cases/get_fixtures_use_case.dart';
import 'package:fixtures_app/features/fixtures/presentation/blocs/date_selection_cubit/date_selection_cubit.dart';
import 'package:fixtures_app/features/fixtures/presentation/blocs/fixture_details_cubit/fixture_details_cubit.dart';
import 'package:fixtures_app/features/fixtures/presentation/blocs/fixture_search_cubit/fixture_search_cubit.dart';
import 'package:fixtures_app/features/fixtures/presentation/blocs/fixtures_cubit/fixtures_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    MyRoutes myRoutes = MyRoutes();
    return ScreenUtilInit(
      
      designSize: const Size(360, 690),
      builder: (context, child) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => FixturesCubit(
                getFixturesUseCase: GetFixturesUseCase(
                    fixturesRepository: FixturesRepositoryImpl(
                        fixturesRemoteDataSource:
                            FixturesRemoteDataSourceWebScrapping(
                                httpClient: http.Client(),
                                connectivity: Connectivity())))),
          ),
          BlocProvider(
            create: (context) => FixtureDetailsCubit(
                getFixtureDetailsUseCase: GetFixtureDetailsUseCase(
                    fixturesRepository: FixturesRepositoryImpl(
                        fixturesRemoteDataSource:
                            FixturesRemoteDataSourceWebScrapping(
                                httpClient: http.Client(),
                                connectivity: Connectivity())))),
          ),
          BlocProvider(
            create: (context) => DateSelectionCubit(),
          ),
          BlocProvider(
            create: (context) => FixtureSearchCubit(),
          ),
        ],
        child: MaterialApp(
          onGenerateRoute: myRoutes.onGenerateRoute,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
