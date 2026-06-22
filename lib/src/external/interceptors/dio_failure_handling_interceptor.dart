import 'package:dio/dio.dart';

import '../architecture/data_failures.dart';

class DioFailureHandlingInterceptor extends Interceptor {
  DioFailureHandlingInterceptor();

  bool validateStatus(int? status) {
    return status != null && (status >= 200 && status < 300);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final timout = [
      DioExceptionType.connectionTimeout,
      DioExceptionType.sendTimeout,
      DioExceptionType.receiveTimeout,
    ];

    if (timout.contains(err.type)) {
      final timeoutFailure = DioTimeoutFailure(
        requestOptions: err.requestOptions,
        response: err.response,
        stackTrace: err.stackTrace,
      );

      return handler.next(timeoutFailure);
    }

    final failure = ServerFailure(
      requestOptions: err.requestOptions,
      response: err.response,
      stackTrace: err.stackTrace,
    );

    handler.next(
      failure,
    );
  }
}
