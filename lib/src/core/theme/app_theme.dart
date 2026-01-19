import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sopaki_app/src/core/theme/color_schemes.dart';
import 'package:sopaki_app/src/core/theme/dimens.dart';
import 'package:sopaki_app/src/shared/extensions/context_extensions.dart';

class AppTheme {
  static const _fontFamily = 'Nevo';

  static ThemeData _buildTheme({required Brightness brightness}) {
    final ColorScheme colors = brightness == Brightness.light ? lightColorScheme : darkColorScheme;

    return ThemeData(
      textTheme: _buildTextTheme(colors: colors),
      fontFamily: _fontFamily,
      appBarTheme: AppBarTheme(
        surfaceTintColor: Colors.transparent,
        backgroundColor: colors.surface,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: switch (brightness) {
            Brightness.light => Brightness.dark,
            Brightness.dark => Brightness.light,
          },
        ),
      ),
      bottomAppBarTheme: BottomAppBarThemeData(
        elevation: 3.0,
        height: Dimens.bottomNavBarHeight,
        color: colors.surface,
        shadowColor: colors.shadow.withOpacity(0.3),
        padding: const EdgeInsets.symmetric(vertical: Dimens.minSpacing),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: colors.primary,
        unselectedItemColor: colors.surfaceContainer,
        selectedIconTheme: const IconThemeData(color: Colors.white),
        unselectedIconTheme: IconThemeData(color: colors.onSurface),
      ),
      cardTheme: CardThemeData(color: colors.surface),
      colorScheme: colors,
    );
  }

  static TextTheme _buildTextTheme({required ColorScheme colors}) {
    return TextTheme(
      displayLarge: TextStyle(
        fontSize: 36.0,
        fontWeight: FontWeight.w700,
        color: colors.onSurface,
      ),
      displayMedium: TextStyle(
        fontSize: 28.0,
        color: colors.onSurface,
      ),
      displaySmall: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: colors.onSurface,
      ),
      headlineLarge: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: colors.onSurface,
      ),
      headlineMedium: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: colors.onSurface,
      ),
      titleLarge: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: colors.onSurface,
      ),
      bodyLarge: const TextStyle(
        fontSize: 16.0,
        overflow: TextOverflow.ellipsis,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.0,
        height: 1.7,
        color: colors.onSurface.withOpacity(.7),
      ),
      bodySmall: TextStyle(
        fontSize: 12.0,
        color: colors.secondary,
        fontWeight: FontWeight.w500,
      ),
      labelMedium: TextStyle(
        fontSize: 10.0,
        color: colors.onSurface,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  static final ThemeData lightTheme = _buildTheme(brightness: Brightness.light);

  static final ThemeData darkTheme = _buildTheme(brightness: Brightness.dark);
}

extension AppThemeExt on BuildContext {
  TextTheme get primaryTextTheme => Theme.of(this).textTheme.copyWith(
        displayLarge: Theme.of(this).textTheme.displayLarge?.copyWith(color: theme.colorScheme.onPrimary),
        displayMedium: Theme.of(this).textTheme.displayMedium?.copyWith(color: theme.colorScheme.onPrimary),
        displaySmall: Theme.of(this).textTheme.displaySmall?.copyWith(color: theme.colorScheme.onPrimary),
        headlineLarge: Theme.of(this).textTheme.headlineLarge?.copyWith(color: theme.colorScheme.onPrimary),
        headlineMedium: Theme.of(this).textTheme.headlineMedium?.copyWith(color: theme.colorScheme.onPrimary),
        titleLarge: Theme.of(this).textTheme.titleLarge?.copyWith(color: theme.colorScheme.onPrimary),
        bodyLarge: Theme.of(this).textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onPrimary),
        bodyMedium: Theme.of(this).textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onPrimary),
        bodySmall: Theme.of(this).textTheme.bodySmall?.copyWith(color: theme.colorScheme.onPrimary),
        labelMedium: Theme.of(this).textTheme.labelMedium?.copyWith(color: theme.colorScheme.onPrimary),
      );
}
