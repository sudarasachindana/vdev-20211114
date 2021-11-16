import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:vdev_test_project/constants/strings.dart';
import 'package:vdev_test_project/data/repository.dart';
import 'package:vdev_test_project/di/components/service_locator.dart';
import 'package:vdev_test_project/stores/category/category_store.dart';
import 'package:vdev_test_project/stores/form/form_store.dart';
import 'package:vdev_test_project/stores/user/user_store.dart';
import 'package:vdev_test_project/utils/locale/app_localization.dart';
import 'package:vdev_test_project/utils/routes/routes.dart';

import 'dashboard/dashboard.dart';
import 'login/login.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  // Create your store as a final variable in a base Widget. This works better
  // with Hot Reload than creating it directly in the `build` function.

  final CategoryStore _categoryStore = CategoryStore(getIt<Repository>());
  final UserStore _userStore = UserStore(getIt<Repository>());


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<CategoryStore>(create: (_) => _categoryStore),
        Provider<UserStore>(create: (_) => _userStore),
      ],
      child: Observer(
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: Strings.appName,
            routes: Routes.routes,

            localizationsDelegates: [
              // A class which loads the translations from JSON files
              AppLocalizations.delegate,
              // Built-in localization of basic text for Material widgets
              GlobalMaterialLocalizations.delegate,
              // Built-in localization for text direction LTR/RTL
              GlobalWidgetsLocalizations.delegate,
              // Built-in localization of basic text for Cupertino widgets
              GlobalCupertinoLocalizations.delegate,
            ],
            home: _userStore.isLoggedIn ? Dashboard() : LoginScreen(),
          );
        },
      ),
    );
  }
}