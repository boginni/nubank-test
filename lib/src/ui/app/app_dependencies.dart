import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../../domain/environment.dart';
import '../../domain/repositories/shorten_url_repository.dart';
import '../../external/datasources/shorten_url_datasource.dart';
import '../../external/interceptors/dio_failure_handling_interceptor.dart';
import '../../external/provider/shorten_url_history_provider.dart';
import '../../external/repositories/shorten_url_repository_impl.dart';
import 'controllers/app_store.dart';

class AppDependencies {
  static final GetIt _app = GetIt.asNewInstance();

  static void init() {
    _init(_app);
  }

  static void _init(GetIt i) {
    final dio = Dio(
      BaseOptions(
        baseUrl: Environment.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 5),
      ),
    );

    dio.interceptors.add(DioFailureHandlingInterceptor());

    i.registerSingleton(dio);
    i.registerSingleton(AppStore());

    i.registerFactory(ShortenUrlHistoryProvider.new);

    i.registerFactory(
      () => ShortenUrlDatasource(
        dio,
        i.get(),
      ),
    );

    i.registerFactory<ShortenUrlRepository>(
      () => ShortenUrlRepositoryImpl(i.get()),
    );

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
