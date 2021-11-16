import 'package:vdev_test_project/models/post/category.dart';

class CategoryList {
  final List<Category>? categoryList;

  CategoryList({
    this.categoryList,
  });

  factory CategoryList.fromJson(List<dynamic> json) {
    List<Category> categoryList = <Category>[];
    categoryList = json.map((category) => Category.fromMap(category)).toList();

    return CategoryList(
      categoryList: categoryList,
    );
  }
}
