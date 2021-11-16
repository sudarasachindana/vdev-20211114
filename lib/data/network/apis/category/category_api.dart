import 'dart:async';

import 'package:vdev_test_project/data/network/constants/endpoints.dart';
import 'package:vdev_test_project/data/network/dio_client.dart';
import 'package:vdev_test_project/data/network/rest_client.dart';
import 'package:vdev_test_project/models/category/category_list.dart';

class CategoryApi {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;

  // injecting dio instance
  CategoryApi(this._dioClient, this._restClient);

  /// Returns list of post in response
  Future<CategoryList> getCategories() async {
    try {
      final res = await _dioClient.get(Endpoints.getCategories);
      return CategoryList.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

/// sample api call with default rest client
//  Future<PostsList> getCategories() {
//
//    return _restClient
//        .get(Endpoints.getCategories)
//        .then((dynamic res) => CategoryList.fromJson(res))
//        .catchError((error) => throw NetworkException(message: error));
//  }

}
