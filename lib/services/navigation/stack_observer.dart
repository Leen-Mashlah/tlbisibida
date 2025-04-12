import 'package:flutter/material.dart';

class StackObserver extends NavigatorObserver {
  final stack = <Route>[];
  List<String?> get history => stack.map((r) => r.settings.name).toList();

  String? get current => stack.last.settings.name;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    stack.add(route);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    stack.remove(route);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    stack.remove(route);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (oldRoute != null && newRoute != null) {
      final index = stack.indexOf(oldRoute);
      stack[index] = newRoute;
    }
  }
}
