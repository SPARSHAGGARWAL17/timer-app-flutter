import 'package:flutter/material.dart';
import 'package:timer_app/view/home_page.dart';

class AppNamedRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    late Widget widget;

    var routeName = settings.name;

    switch (routeName) {
      case HomePage.route:
        widget = const HomePage();
        break;
      default:
        widget = const Scaffold();
    }
    return MaterialPageRoute(builder: (context) => widget, settings: settings);
  }
}
