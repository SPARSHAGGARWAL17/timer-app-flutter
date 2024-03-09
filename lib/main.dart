import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timer_app/controller/timers_controller.dart';
import 'package:timer_app/database/db.dart';
import 'package:timer_app/navigator/routes.dart';
import 'package:timer_app/theme.dart';
import 'package:timer_app/view/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var timerDb = TimerDatabase();
  await timerDb.init();
  runApp(
    ChangeNotifierProvider(
      create: (context) => TimerController(
        database: timerDb,
      ),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timer App',
      theme: ThemeData(
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xffB6EAFF),
        ),
        elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStatePropertyAll(Colors.black),
            backgroundColor:
                MaterialStatePropertyAll(AppColors.buttonBackgroundColor),
            minimumSize: MaterialStatePropertyAll(
              Size(double.infinity, 50),
            ),
          ),
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: AppColors.buttonBackgroundColor,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primaryColor,
          centerTitle: false,
          elevation: 5,
          shadowColor: Colors.grey,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 32,
          ),
          foregroundColor: Colors.white,
          toolbarHeight: 120,
          // backgroundColor: Color(0xff216C2E),
        ),
        cardColor: AppColors.cardColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryColor,
        ),
        useMaterial3: true,
      ),
      onGenerateRoute: AppNamedRoutes.onGenerateRoute,
      initialRoute: HomePage.route,
    );
  }
}
