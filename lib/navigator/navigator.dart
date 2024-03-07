import 'package:flutter/material.dart';

class TimerAppNavigator {
  static final TimerAppNavigator _internal = TimerAppNavigator._();

  GlobalKey<NavigatorState>? _navigatorKey;

  TimerAppNavigator._();

  void setNavigatorKey(GlobalKey<NavigatorState> key) {
    _navigatorKey = key;
  }

  factory TimerAppNavigator() {
    return _internal;
  }

  Future<T?> pushNamed<T>(String routeName, {Object? args}) async {
    _throwErrorIfKeyIsNull();
    return _navigatorKey!.currentState
        ?.pushNamed<T>(routeName, arguments: args);
  }

  void pop([Object? arg]) {
    _throwErrorIfKeyIsNull();
    _navigatorKey!.currentState?.pop(arg);
  }

  void _throwErrorIfKeyIsNull() {
    if (_navigatorKey == null) {
      throw Exception("Navigator key is not initialised. Please call setNavigatorKey() before accessing any other method");
    }
  }
}
