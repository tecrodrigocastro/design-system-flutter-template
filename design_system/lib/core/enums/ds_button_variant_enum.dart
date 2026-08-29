/// Visual style of a `DsButton`.
enum DsButtonVariant {
  /// Solid background filled with the primary brand color. Use for the
  /// single most important action on a screen.
  primary,

  /// Solid background filled with the secondary accent color. Use for a
  /// supporting action alongside a [primary] one.
  secondary,

  /// Transparent background with a colored border. Use for a
  /// medium-emphasis action.
  outline,

  /// Transparent background, no border. Use for a low-emphasis action,
  /// e.g. "Cancel" next to a primary "Confirm".
  ghost,
}
