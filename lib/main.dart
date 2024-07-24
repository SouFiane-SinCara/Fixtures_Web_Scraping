import 'package:fixtures_app/core/routes/my_routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    MyRoutes myRoutes = MyRoutes();
    return MaterialApp(
      onGenerateRoute: myRoutes.onGenerateRoute,
    );
  }
} 
