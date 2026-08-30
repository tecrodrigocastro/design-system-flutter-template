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
/// The library is organized in four layers:
/// - **Tokens** ([DsPrimary], [DsTypography], [DsSpacing], [DsRadius]...):
///   the raw design decisions. Change these to re-skin the whole system.
/// - **Theme** ([DsTheme]): a `MaterialApp`-ready `ThemeData` built
///   entirely from the tokens above.
/// - **Enums** (`DsButtonVariant`, `DsButtonSize`...): type-safe variants
///   consumed by components, so there are no magic strings.
/// - **Components** ([DsButton], [DsInput], [DsCard], [DsBanner]):
///   ready-to-use widgets, grouped as atoms and molecules.
library;

// Tokens
export 'src/tokens/colors.dart';
export 'src/tokens/spacing.dart';
export 'src/tokens/typography.dart';

// Theme
export 'src/theme/ds_theme.dart';

// Enums
export 'core/enums/ds_banner_size_enum.dart';
export 'core/enums/ds_banner_variant_enum.dart';
export 'core/enums/ds_button_size_enum.dart';
export 'core/enums/ds_button_variant_enum.dart';
export 'core/enums/ds_input_variant_enum.dart';

// Atoms
export 'src/components/atoms/buttons/ds_button.dart';
export 'src/components/atoms/inputs/ds_input.dart';

// Molecules
export 'src/components/molecules/banners/ds_banner.dart';
export 'src/components/molecules/cards/ds_card.dart';

// Organisms
export 'src/components/organisms/app_bars/ds_app_bar.dart';
export 'src/components/organisms/empty_states/ds_empty_state.dart';
