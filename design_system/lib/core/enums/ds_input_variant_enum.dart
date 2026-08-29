/// Visual style of a `DsInput`.
enum DsInputVariant {
  /// Transparent fill with a visible border. The default — works on any
  /// background.
  outline,

  /// Solid neutral fill with no visible border until focused. Use inside
  /// cards or panels that already have a border of their own.
  filled,
}
