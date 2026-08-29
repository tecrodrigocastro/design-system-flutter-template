/// A Flutter design system: design tokens, type-safe components built
/// with Atomic Design, and living documentation via DartDoc + Widgetbook.
///
/// Import this single file to get every public token, enum, and
/// component in the library:
///
/// ```dart
/// import 'package:design_system/design_system.dart';
/// ```
///
/// The library is organized in three layers:
/// - **Tokens** ([DsPrimary], [DsTypography], [DsSpacing], [DsRadius]...):
///   the raw design decisions. Change these to re-skin the whole system.
/// - **Enums** (`DsButtonVariant`, `DsButtonSize`...): type-safe variants
///   consumed by components, so there are no magic strings.
/// - **Components** ([DsButton], [DsInput], [DsCard], [DsBanner]):
///   ready-to-use widgets, grouped as atoms and molecules.
library;

// Tokens
export 'src/tokens/colors.dart';
