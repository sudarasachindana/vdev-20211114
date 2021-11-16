import 'package:flutter/material.dart';
import 'package:vdev_test_project/screens/dashboard/dashboard.dart';
import 'package:vdev_test_project/screens/login/login.dart';

class Routes {
  Routes._();

  //static variables
  static const String login = '/login';
  static const String dashboard = '/home';

  static final routes = <String, WidgetBuilder>{
    login: (BuildContext context) => LoginScreen(),
    dashboard: (BuildContext context) => Dashboard(),
  };
}



