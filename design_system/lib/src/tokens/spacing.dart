/// Spacing scale used for padding, margins, and gaps.
///
/// Values follow a 4px base unit so any two tokens compose cleanly
/// (e.g. [md] is exactly [sm] + [xs]).
abstract final class DsSpacing {
  /// 4px. Use for tight gaps, e.g. between an icon and its label.
  static const double xs = 4;

  /// 8px. Use for gaps between related inline elements.
  static const double sm = 8;

  /// 16px. The default spacing unit — reach for this first.
  static const double md = 16;

  /// 24px. Use for spacing between distinct sections within a screen.
  static const double lg = 24;

  /// 32px. Use for spacing around a screen's major regions.
  static const double xl = 32;

  /// 48px. Use for large vertical rhythm, e.g. between page sections.
  static const double xxl = 48;
}

/// Border radius scale used for surfaces and interactive controls.
abstract final class DsRadius {
  /// 6px. Use for small controls like chips and badges.
  static const double sm = 6;

  /// 10px. The default radius for inputs and buttons.
  static const double md = 10;

  /// 16px. Use for larger surfaces like cards and dialogs.
  static const double lg = 16;

  /// Fully rounded corners, e.g. for pill-shaped buttons or avatars.
  static const double full = 999;
}
