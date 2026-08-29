import 'package:flutter/painting.dart';

/// Primary brand color scale.
///
/// Every component in this design system reads its primary color from
/// here — never from a hardcoded [Color]. Swap these five values to
/// re-skin the entire library with your own brand identity.
abstract final class DsPrimary {
  /// Lightest tint. Use for subtle backgrounds, e.g. an info banner fill.
  static const Color lighten2 = Color(0xFFE4D5F4);

  /// Light tint. Use for hover/pressed backgrounds on light surfaces.
  static const Color lighten1 = Color(0xFFC9ABE9);

  /// The brand color itself. Use for primary buttons, links, and active
  /// states.
  static const Color base = Color(0xFF782DC8);

  /// Darker shade. Use for text on top of [lighten2]/[lighten1]
  /// backgrounds to keep contrast accessible.
  static const Color darken1 = Color(0xFF5F23A0);

  /// Darkest shade. Use sparingly, e.g. for pressed states on dark
  /// surfaces.
  static const Color darken2 = Color(0xFF461978);
}

/// Secondary accent color scale, used for supporting actions and accents
/// that should not compete with [DsPrimary].
abstract final class DsSecondary {
  /// Lightest tint. Use for subtle secondary backgrounds.
  static const Color lighten2 = Color(0xFFD6E4F7);

  /// Light tint. Use for hover/pressed backgrounds on light surfaces.
  static const Color lighten1 = Color(0xFFA9C6ED);

  /// The accent color itself. Use for secondary buttons and highlights.
  static const Color base = Color(0xFF2D6FC8);

  /// Darker shade. Use for text on top of tinted secondary backgrounds.
  static const Color darken1 = Color(0xFF23579F);

  /// Darkest shade. Use sparingly, e.g. for pressed states on dark
  /// surfaces.
  static const Color darken2 = Color(0xFF193F76);
}

/// Neutral grayscale used for surfaces, borders, and text.
abstract final class DsNeutral {
  /// Pure white. Use for surfaces on top of colored backgrounds.
  static const Color white = Color(0xFFFFFFFF);

  /// Lightest gray. Use for page backgrounds and disabled fills.
  static const Color gray50 = Color(0xFFF7F7F8);

  /// Use for subtle dividers and input fills.
  static const Color gray100 = Color(0xFFEDEDF0);

  /// Use for default borders on inputs and cards.
  static const Color gray200 = Color(0xFFD7D7DE);

  /// Use for disabled text and icons.
  static const Color gray300 = Color(0xFFB4B4C0);

  /// Use for placeholder text and inactive icons.
  static const Color gray400 = Color(0xFF8B8B99);

  /// Use for secondary/supporting body text.
  static const Color gray500 = Color(0xFF64646F);

  /// Use for labels above form fields.
  static const Color gray600 = Color(0xFF46464F);

  /// Use for headings on light surfaces.
  static const Color gray700 = Color(0xFF2E2E35);

  /// Use for the darkest headings and primary body text.
  static const Color gray800 = Color(0xFF1C1C21);

  /// Pure black. Use rarely — prefer [gray800] for text.
  static const Color black = Color(0xFF0A0A0C);
}

/// Semantic color for positive/success feedback (confirmations, valid
/// states).
abstract final class DsSuccess {
  /// Tinted background for success banners and badges.
  static const Color lighten2 = Color(0xFFDCF3E2);

  /// The success color itself. Use for icons and accents.
  static const Color base = Color(0xFF2E9E5B);

  /// Darker shade. Use for text on top of [lighten2] backgrounds.
  static const Color darken1 = Color(0xFF1F7A44);
}

/// Semantic color for cautionary feedback (warnings, risky actions).
abstract final class DsWarning {
  /// Tinted background for warning banners and badges.
  static const Color lighten2 = Color(0xFFFCEFD0);

  /// The warning color itself. Use for icons and accents.
  static const Color base = Color(0xFFCB8A15);

  /// Darker shade. Use for text on top of [lighten2] backgrounds.
  static const Color darken1 = Color(0xFF9C6A0E);
}

/// Semantic color for negative feedback (errors, destructive actions).
abstract final class DsDanger {
  /// Tinted background for error banners and badges.
  static const Color lighten2 = Color(0xFFFAD9D9);

  /// The danger color itself. Use for error icons, borders, and
  /// destructive buttons.
  static const Color base = Color(0xFFD1373F);

  /// Darker shade. Use for text on top of [lighten2] backgrounds.
  static const Color darken1 = Color(0xFFA22730);
}
