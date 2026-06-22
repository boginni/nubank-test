import 'package:dio/dio.dart';
import 'package:error_handler_with_result/error_handler_with_result.dart';

class ServerFailure extends DioException implements UnknownFailure {
  ServerFailure({
    required super.requestOptions,
    required super.response,
    required super.stackTrace,
  });

  @override
  bool get isFatal => true;

  @override
  String toString() {
    return 'ServerFailure: ${requestOptions.uri} | ${response?.statusCode} | ${response?.data}';
  }

  @override
  Never throwError() {
    throw this;
  }
}

class DioTimeoutFailure extends DioException implements TimeoutFailure {
  DioTimeoutFailure({
    required super.requestOptions,
    required super.response,
    required super.stackTrace,
  });

  @override
  bool get isFatal => true;

  @override
  String toString() {
    return 'DioTimeoutFailure: ${requestOptions.uri} | ${response?.statusCode} | ${response?.data}';
  }

  @override
  Never throwError() {
    throw this;
  }
}
