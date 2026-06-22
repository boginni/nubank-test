import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nu_l10n/nu_l10n.dart';
import 'app_dependencies.dart';
import 'components/global_context_provider.dart';
import 'components/inverse_brightness_builder.dart';
import 'controllers/app_controller.dart';
import 'material_theme.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({
    super.key,
    required this.controller,
  });

  final AppController controller;

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final theme = const MaterialTheme();

  @override
  void initState() {
    super.initState();
    AppDependencies.registerSingleton(widget.controller);
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        init();
      },
    );
  }

  void init() {
    // widget.controller.init();
  }

  ThemeData get lightTheme => theme.getTheme(
    ThemeData.light(useMaterial3: true),
  );

  ThemeData get darkTheme => theme.getTheme(
    ThemeData.dark(useMaterial3: true),
  );

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.controller.store,
      builder: (context, value, child) {
        return MaterialApp.router(
          title: 'Brunno França',
          locale: value.locale,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: value.themeMode,
          supportedLocales: NuL10n.supportedLocales,
          localizationsDelegates: NuL10n.localizationsDelegates,
          routerConfig: widget.controller.appRoutes.routes,
          builder: (context, child) => GlobalContextProviderWidget(
            child: ThemeRegistry(
              lightTheme: lightTheme,
              darkTheme: darkTheme,
              child: child ?? const Offstage(),
            ),
          ),
        );
      },
    );
  }

  ThemeData getTheme(ThemeData base) {
    return base.copyWith(
      textTheme: GoogleFonts.poppinsTextTheme(base.textTheme),
    );
  }
}
