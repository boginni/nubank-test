import 'package:error_handler_with_result/error_handler_with_result.dart';
import 'package:vector_math/vector_math.dart';

abstract interface class LauncherRepository {
  const LauncherRepository();

  Future<Result> openBrowser(String url);

  Future<Result> openMapApp(Vector2 position);

  Future<Result> openSettings();

  Future<Result> openMailApp(String email);
}
