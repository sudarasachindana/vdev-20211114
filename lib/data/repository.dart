import 'dart:async';

import 'package:vdev_test_project/data/sharedpref/shared_preference_helper.dart';
import 'package:vdev_test_project/models/category/category_list.dart';

import 'network/apis/category/category_api.dart';

class Repository {

  // api objects
  final CategoryApi _categoryApi;

  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  Repository(this._categoryApi, this._sharedPrefsHelper);

  // Post: ---------------------------------------------------------------------
  Future<CategoryList> getCategories() async {
    // check to see if posts are present in database, then fetch from database
    // else make a network call to get all posts, store them into database for
    // later use
    return await _categoryApi.getCategories().then((categories) {
      categories.categoryList?.forEach((post) {
      });

      return categories;
    }).catchError((error) => throw error);
  }



  // Login:---------------------------------------------------------------------
  Future<bool> login(String email, String password) async {
    return await Future.delayed(Duration(seconds: 2), ()=> true);
  }

  Future<void> saveIsLoggedIn(bool value) =>
      _sharedPrefsHelper.saveIsLoggedIn(value);

  Future<bool> get isLoggedIn => _sharedPrefsHelper.isLoggedIn;



  // User: -----------------------------------------------------------------
  Future<void> setLoggedUser(String value) =>
      _sharedPrefsHelper.setLoggedUser(value);

  String? get currentUser => _sharedPrefsHelper.currentUser;


  Future<void> setLoggedTimeStamp(String value) =>
      _sharedPrefsHelper.setLoggedTimeStamp(value);

  String? get loggedTimeStamp => _sharedPrefsHelper.loggedTimeStamp;
}