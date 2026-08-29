import 'package:flutter/material.dart';

import '../../../../core/enums/ds_banner_variant_enum.dart';
import '../../../tokens/colors.dart';
import '../../../tokens/spacing.dart';
import '../../../tokens/typography.dart';

/// An inline feedback banner for the design system.
///
/// Communicates a status message with a semantic color and icon. Use
/// [DsBannerVariant] to pick the tone that matches the message.
///
/// Example:
/// ```dart
/// // Informational banner (default)
/// DsBanner(message: 'Sua sessao expira em 5 minutos.')
///
/// // Dismissible success banner with a title
/// DsBanner(
///   variant: DsBannerVariant.success,
///   title: 'Tudo certo',
///   message: 'Suas alteracoes foram salvas.',
///   onClose: () => print('Banner fechado'),
/// )
/// ```
class DsBanner extends StatelessWidget {
  /// Creates a design system banner.
  const DsBanner({
    super.key,
    required this.message,
    this.variant = DsBannerVariant.info,
    this.title,
    this.icon,
    this.onClose,
  });

  /// The main message displayed in the banner.
  final String message;

  /// The semantic tone of the banner. Defaults to [DsBannerVariant.info].
  final DsBannerVariant variant;

  /// An optional bold title shown above [message].
  final String? title;

  /// Overrides the variant's default icon. When `null`, an icon is
  /// chosen automatically based on [variant].
  final IconData? icon;

  /// Called when the close button is tapped. When `null`, no close
  /// button is shown and the banner cannot be dismissed by the user.
  final VoidCallback? onClose;

  ({Color background, Color foreground, IconData icon}) _resolveStyle() {
    switch (variant) {
      case DsBannerVariant.info:
        return (
          background: DsPrimary.lighten2,
          foreground: DsPrimary.darken2,
          icon: icon ?? Icons.info_outline,
        );
      case DsBannerVariant.success:
        return (
          background: DsSuccess.lighten2,
          foreground: DsSuccess.darken1,
          icon: icon ?? Icons.check_circle_outline,
        );
      case DsBannerVariant.warning:
        return (
          background: DsWarning.lighten2,
          foreground: DsWarning.darken1,
          icon: icon ?? Icons.warning_amber_outlined,
        );
      case DsBannerVariant.danger:
        return (
          background: DsDanger.lighten2,
          foreground: DsDanger.darken1,
          icon: icon ?? Icons.error_outline,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = _resolveStyle();

    return Container(
      padding: const EdgeInsets.all(DsSpacing.md),
      decoration: BoxDecoration(
        color: style.background,
        borderRadius: BorderRadius.circular(DsRadius.md),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(style.icon, color: style.foreground, size: 20),
          const SizedBox(width: DsSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (title != null)
                  Text(
                    title!,
                    style: DsTypography.bodyMedium.copyWith(
                      color: style.foreground,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                Text(
                  message,
                  style: DsTypography.bodyMedium.copyWith(color: style.foreground),
                ),
              ],
            ),
          ),
          if (onClose != null)
            InkWell(
              onTap: onClose,
              borderRadius: BorderRadius.circular(DsRadius.full),
              child: Icon(Icons.close, color: style.foreground, size: 18),
            ),
        ],
      ),
    );
  }
}
