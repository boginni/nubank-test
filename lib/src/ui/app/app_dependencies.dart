import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'controllers/app_store.dart';

class AppDependencies {
  static final GetIt _app = GetIt.asNewInstance();

  static void init() {
    _init(_app);
  }

  static void _init(GetIt i) {
    i.registerSingleton(Dio());
    i.registerSingleton(AppStore());
    // --
  }

  static void restart() {
    _app.reset();
  }

  static T get<T extends Object>({
    dynamic param1,
    dynamic param2,
    String? instanceName,
    Type? type,
  }) => _app.get();

  static void registerSingleton<T extends Object>(T instance) {
    _app.registerSingleton(instance);
  }
}
