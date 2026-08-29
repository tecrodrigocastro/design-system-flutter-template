import 'package:flutter/painting.dart';

/// Text style scale for the design system.
///
/// Components never inline a [TextStyle] — they reference one of these
/// styles so that a single edit here (e.g. changing [fontFamily]) updates
/// every screen built with the library.
abstract final class DsTypography {
  /// Base font family. Leave `null` to fall back to the platform default,
  /// or point it at a font registered in your app's `pubspec.yaml`.
  static const String? fontFamily = null;

  /// Page-level heading. Use once per screen, e.g. a screen title.
  static const TextStyle h1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 1.2,
  );

  /// Section heading, one level below [h1].
  static const TextStyle h2 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 26,
    fontWeight: FontWeight.w700,
    height: 1.25,
  );

  /// Subsection heading, e.g. a card or dialog title.
  static const TextStyle h3 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );

  /// Emphasized body text, e.g. a lead paragraph.
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );

  /// Default body text. Use this for most paragraphs and labels.
  static const TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );

  /// Supporting body text, e.g. helper text below a field.
  static const TextStyle bodySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );

  /// Smallest text, e.g. timestamps or field error messages.
  static const TextStyle caption = TextStyle(
    fontFamily: fontFamily,
    fontSize: 11,
    fontWeight: FontWeight.w500,
    height: 1.3,
    letterSpacing: 0.2,
  );

  /// Style for text rendered inside interactive controls (buttons, tabs).
  static const TextStyle button = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1,
  );
}
