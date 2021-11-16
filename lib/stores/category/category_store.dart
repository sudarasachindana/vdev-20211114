import 'package:mobx/mobx.dart';
import 'package:vdev_test_project/data/repository.dart';
import 'package:vdev_test_project/models/post/category_list.dart';
import 'package:vdev_test_project/stores/error/error_store.dart';
import 'package:vdev_test_project/utils/dio/dio_error_util.dart';

part 'category_store.g.dart';

class CategoryStore = _CategoryStore with _$CategoryStore;

abstract class _CategoryStore with Store {
  // repository instance
  late Repository _repository;

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();

  // constructor:---------------------------------------------------------------
  _CategoryStore(Repository repository) : this._repository = repository;

  // store variables:-----------------------------------------------------------
  static ObservableFuture<CategoryList?> emptyPostResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<CategoryList?> fetchPostsFuture =
      ObservableFuture<CategoryList?>(emptyPostResponse);

  @observable
  CategoryList? categoryModelList;

  @observable
  bool success = false;

  @computed
  bool get loading => fetchPostsFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  Future getCategories() async {
    final future = _repository.getCategories();
    fetchPostsFuture = ObservableFuture(future);

    future.then((categoryList) {
      this.categoryModelList = categoryList;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }
}
