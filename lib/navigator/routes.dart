import 'package:flutter/material.dart';

class AppNamedRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    late Widget widget;
    
    var routeName = settings.name;

    switch (routeName) {
      case "":
        break;
      default:
        widget = const Scaffold();
    }
    return MaterialPageRoute(builder: (context) => widget,settings: settings);
  }
}
