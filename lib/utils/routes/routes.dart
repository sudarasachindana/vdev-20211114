import 'package:flutter/material.dart';
import 'package:vdev_test_project/data/repository.dart';
import 'package:vdev_test_project/di/components/service_locator.dart';
import 'package:vdev_test_project/screens/dashboard/dashboard.dart';
import 'package:vdev_test_project/screens/login/login.dart';
import 'package:vdev_test_project/stores/form/form_store.dart';
import 'package:vdev_test_project/stores/user/user_store.dart';

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



