import 'package:flutter/material.dart';

import '../tokens/colors.dart';
import '../tokens/typography.dart';

/// Prebuilt [ThemeData] for light and dark mode, assembled entirely from
/// this library's design tokens.
///
/// Pass these directly to [MaterialApp.theme] / [MaterialApp.darkTheme]
/// so every Material widget — including this library's own components —
/// picks up the same brand colors and typography.
///
/// Example:
/// ```dart
/// MaterialApp(
///   theme: DsTheme.light,
///   darkTheme: DsTheme.dark,
/// )
/// ```
abstract final class DsTheme {
  /// The light variant of the theme.
  static ThemeData get light => _build(Brightness.light);

  /// The dark variant of the theme.
  static ThemeData get dark => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: DsPrimary.base,
      brightness: brightness,
    ).copyWith(
        primary: DsPrimary.base,
        secondary: DsSecondary.base,
        error: DsDanger.base);

    final textTheme = TextTheme(
      headlineLarge: DsTypography.h1,
      headlineMedium: DsTypography.h2,
      headlineSmall: DsTypography.h3,
      bodyLarge: DsTypography.bodyLarge,
      bodyMedium: DsTypography.bodyMedium,
      bodySmall: DsTypography.bodySmall,
      labelLarge: DsTypography.button,
      labelSmall: DsTypography.caption,
    ).apply(
        bodyColor: colorScheme.onSurface, displayColor: colorScheme.onSurface);

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      textTheme: textTheme,
    );
  }
}
