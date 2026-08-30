import 'package:flutter/material.dart';

import '../../../tokens/colors.dart';
import '../../../tokens/spacing.dart';
import '../../../tokens/typography.dart';

/// A top app bar for the design system.
///
/// An organism built on top of Flutter's [AppBar]: it composes a title,
/// an optional back button, and a row of trailing actions (typically
/// `DsButton` widgets in a compact/ghost variant) styled with this
/// library's tokens. Implements [PreferredSizeWidget] so it can be
/// passed directly to `Scaffold.appBar`.
///
/// Example:
/// ```dart
/// Scaffold(
///   appBar: DsAppBar(
///     title: 'Perfil',
///     onBack: () => Navigator.of(context).pop(),
///     actions: [
///       DsButton(
///         text: 'Salvar',
///         size: DsButtonSize.small,
///         variant: DsButtonVariant.ghost,
///         onPressed: () {},
///       ),
///     ],
///   ),
/// )
/// ```
class DsAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Creates a design system app bar.
  const DsAppBar(
      {super.key, required this.title, this.onBack, this.actions = const []});

  /// The text displayed as the app bar's title.
  final String title;

  /// Called when the back button is tapped. When `null`, no back button
  /// is shown.
  final VoidCallback? onBack;

  /// Widgets shown at the end of the app bar, e.g. `DsButton`s.
  final List<Widget> actions;

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: preferredSize.height,
      backgroundColor: DsNeutral.white,
      surfaceTintColor: DsNeutral.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: onBack != null
          ? IconButton(
              icon: Icon(Icons.arrow_back, color: DsNeutral.gray800),
              onPressed: onBack,
            )
          : null,
      title: Text(title,
          style: DsTypography.h3.copyWith(color: DsNeutral.gray800)),
      actions: [...actions, const SizedBox(width: DsSpacing.sm)],
    );
  }
}
