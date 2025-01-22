
import 'package:fixtures_web_scraping/core/routes/my_routes.dart';
import 'package:fixtures_web_scraping/features/fixtures/presentation/blocs/date_selection_cubit/date_selection_cubit.dart';
import 'package:fixtures_web_scraping/features/fixtures/presentation/blocs/fixture_details_cubit/fixture_details_cubit.dart';
import 'package:fixtures_web_scraping/features/fixtures/presentation/blocs/fixtures_cubit/fixtures_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fixtures_web_scraping/core/helpers/dependency_injection.dart'
    as di;

void main() {
 
  di.init();
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
            create: (context) => di.sl<FixturesCubit>(),
          ),
          BlocProvider(
            create: (context) => di.sl<FixtureDetailsCubit>(),
          ),
          BlocProvider(
            create: (context) => di.sl<DateSelectionCubit>(),
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
