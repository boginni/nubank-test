import 'package:error_handler_with_result/error_handler_with_result.dart';

abstract class DeviceRepository {
  Future<Result> copyToClipboard(String text);

  Future<Result<String?>> getClipboardData();
}
