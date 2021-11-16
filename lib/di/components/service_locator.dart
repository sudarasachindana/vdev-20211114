
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:sembast/sembast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vdev_test_project/data/network/apis/posts/category_api.dart';
import 'package:vdev_test_project/data/network/dio_client.dart';
import 'package:vdev_test_project/data/network/rest_client.dart';
import 'package:vdev_test_project/data/repository.dart';
import 'package:vdev_test_project/data/sharedpref/shared_preference_helper.dart';
import 'package:vdev_test_project/di/module/local_module.dart';
import 'package:vdev_test_project/di/module/network_module.dart';
import 'package:vdev_test_project/stores/category/category_store.dart';
import 'package:vdev_test_project/stores/error/error_store.dart';
import 'package:vdev_test_project/stores/form/form_store.dart';
import 'package:vdev_test_project/stores/user/user_store.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  // factories:-----------------------------------------------------------------
  getIt.registerFactory(() => ErrorStore());
  getIt.registerFactory(() => FormStore());

  // async singletons:----------------------------------------------------------
  getIt.registerSingletonAsync<Database>(() => LocalModule.provideDatabase());
  getIt.registerSingletonAsync<SharedPreferences>(() => LocalModule.provideSharedPreferences());

  // singletons:----------------------------------------------------------------
  getIt.registerSingleton(SharedPreferenceHelper(await getIt.getAsync<SharedPreferences>()));
  getIt.registerSingleton<Dio>(NetworkModule.provideDio(getIt<SharedPreferenceHelper>()));
  getIt.registerSingleton(DioClient(getIt<Dio>()));
  getIt.registerSingleton(RestClient());

  // api's:---------------------------------------------------------------------
  getIt.registerSingleton(CategoryApi(getIt<DioClient>(), getIt<RestClient>()));

  // repository:----------------------------------------------------------------
  getIt.registerSingleton(Repository(
    getIt<CategoryApi>(),
    getIt<SharedPreferenceHelper>(),
  ));

  // stores:--------------------------------------------------------------------
  getIt.registerSingleton(CategoryStore(getIt<Repository>()));
  getIt.registerSingleton(UserStore(getIt<Repository>()));
}
