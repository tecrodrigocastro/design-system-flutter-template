/// Semantic tone of a `DsBanner`, controlling its color and default icon.
enum DsBannerVariant {
  /// Neutral, informational message.
  info,

  /// Positive confirmation, e.g. "Changes saved".
  success,

  /// Cautionary message that does not block the user.
  warning,

  /// Error message describing something that went wrong.
  danger,
}
