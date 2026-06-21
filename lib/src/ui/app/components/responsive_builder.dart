import 'package:flutter/material.dart';

enum ResponsiveDisplaySizeEnum {
  unsupported,
  phone,
  tablet,
  desktop,
  wide,
  ultraWide;

  const ResponsiveDisplaySizeEnum();

  static ResponsiveDisplaySizeEnum? fromString(String value) {
    return values.where((element) => element.name == value).firstOrNull;
  }
}

class ResponsiveBuilder extends StatelessWidget {
  final WidgetBuilder? unsupported;
  final WidgetBuilder? phone;
  final WidgetBuilder? tablet;
  final WidgetBuilder? desktop;
  final WidgetBuilder? wide;
  final WidgetBuilder? ultraWide;

  final ResponsiveDisplaySizeEnum? forceDisplaySize;

  static ResponsiveDisplaySizeEnum getDisplaySize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return switch (width) {
      >= 1920 => ResponsiveDisplaySizeEnum.ultraWide,
      >= 1440 => ResponsiveDisplaySizeEnum.wide,
      >= 1024 => ResponsiveDisplaySizeEnum.desktop,
      >= 720 => ResponsiveDisplaySizeEnum.tablet,
      >= 320 => ResponsiveDisplaySizeEnum.phone,
      _ => ResponsiveDisplaySizeEnum.unsupported,
    };
  }

  static T resolveSize<T>(
    BuildContext context, {
    T Function()? unsupported,
    T Function()? phone,
    T Function()? tablet,
    T Function()? desktop,
    T Function()? wide,
    T Function()? ultraWide,
  }) {
    final displaySize = getDisplaySize(context);

    final result = switch (displaySize) {
      ResponsiveDisplaySizeEnum.phone => phone,
      ResponsiveDisplaySizeEnum.tablet => tablet ?? phone,
      ResponsiveDisplaySizeEnum.desktop => desktop ?? tablet ?? phone,
      ResponsiveDisplaySizeEnum.wide => wide ?? desktop ?? tablet ?? phone,
      ResponsiveDisplaySizeEnum.ultraWide =>
        ultraWide ?? wide ?? desktop ?? tablet ?? phone,
      _ => unsupported,
    };

    if (result == null) {
      throw Exception('All resolutions are null');
    }

    return result();
  }

  const ResponsiveBuilder({
    super.key,
    this.phone,
    this.tablet,
    this.desktop,
    this.wide,
    this.ultraWide,
    this.forceDisplaySize,
    this.unsupported,
  });

  const ResponsiveBuilder.required({
    super.key,
    this.forceDisplaySize,
    required this.phone,
    required this.tablet,
    required this.desktop,
    required this.wide,
    required this.ultraWide,
    required this.unsupported,
  });

  @override
  Widget build(BuildContext context) {
    final builder = () {
      final displaySize = forceDisplaySize ?? getDisplaySize(context);

      return switch (displaySize) {
        ResponsiveDisplaySizeEnum.phone => phone,
        ResponsiveDisplaySizeEnum.tablet => tablet ?? phone,
        ResponsiveDisplaySizeEnum.desktop => desktop ?? tablet ?? phone,
        ResponsiveDisplaySizeEnum.wide => wide ?? desktop ?? tablet ?? phone,
        ResponsiveDisplaySizeEnum.ultraWide =>
          ultraWide ?? wide ?? desktop ?? tablet ?? phone,
        _ => unsupported,
      };
    }();

    return builder?.call(context) ?? const Offstage();
  }
}
