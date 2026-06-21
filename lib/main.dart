import 'package:flutter/material.dart';

import 'src/ui/app/app_dependencies.dart';
import 'src/ui/app/app_routes.dart';
import 'src/ui/app/app_widget.dart';
import 'src/ui/app/controllers/app_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp();
  //
  // FlutterError.onError = (errorDetails) {
  //   FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  // };
  //
  // PlatformDispatcher.instance.onError = (error, stack) {
  //   FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  //   return true;
  // };

  AppDependencies.init();

  runApp(
    AppWidget(
      controller: AppController(
        AppDependencies.get(),
        AppDependencies.get(),
        appRoutes: AppRoutes(),
      ),
    ),
  );
}
