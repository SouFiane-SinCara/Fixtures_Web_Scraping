import 'package:fixtures_app/core/constants/routes_name.dart';
import 'package:fixtures_app/features/fixtures/presentation/pages/fixtures_page.dart';
import 'package:flutter/material.dart';

class MyRoutes {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RoutesName.fixturesPageName:
        return MaterialPageRoute(
          builder: (context) => FixturesPage(),
        );

      default:
    }
  }
}
