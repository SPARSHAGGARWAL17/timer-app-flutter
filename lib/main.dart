import 'package:flutter/material.dart';
import 'package:timer_app/navigator/routes.dart';
import 'package:timer_app/view/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timer App',
      theme: ThemeData(
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color(0xffB6EAFF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Color(0xffE1DFFF),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xff006782),
          centerTitle: false,
          elevation: 5,
          shadowColor: Colors.grey,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
          foregroundColor: Colors.white,
          toolbarHeight: 120,
          // backgroundColor: Color(0xff216C2E),
        ),
        cardColor: const Color(0xff0067820D),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff006782),
        ),
        useMaterial3: true,
      ),
      onGenerateRoute: AppNamedRoutes.onGenerateRoute,
      initialRoute: HomePage.route,
    );
  }
}
