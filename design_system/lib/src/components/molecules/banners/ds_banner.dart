import 'package:flutter/material.dart';

import '../../../../core/enums/ds_banner_size_enum.dart';
import '../../../../core/enums/ds_banner_variant_enum.dart';
import '../../../tokens/colors.dart';
import '../../../tokens/spacing.dart';
import '../../../tokens/typography.dart';

/// A banner for the design system, used for both inline feedback
/// messages and promotional/hero placements.
///
/// Communicates a status message with a semantic color and icon. Use
/// [DsBannerVariant] to pick the tone that matches the message, [image]
/// to lead with a thumbnail instead of an icon, and [tags] to attach
/// short labels (e.g. category or promotion names).
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
///
/// // Large promotional banner with an image and tags
/// DsBanner(
///   size: DsBannerSize.large,
///   title: 'Fim de semana promocional',
///   message: 'Ate 40% de desconto em produtos selecionados.',
///   image: const NetworkImage('https://example.com/banner.png'),
///   tags: const ['Promocao', 'Limitado'],
/// )
/// ```
class DsBanner extends StatelessWidget {
  /// Creates a design system banner.
  const DsBanner({
    super.key,
    required this.message,
    this.variant = DsBannerVariant.info,
    this.size = DsBannerSize.medium,
    this.title,
    this.icon,
    this.image,
    this.tags = const [],
    this.onClose,
  });

  /// The main message displayed in the banner.
  final String message;

  /// The semantic tone of the banner. Defaults to [DsBannerVariant.info].
  final DsBannerVariant variant;

  /// The size of the banner. Defaults to [DsBannerSize.medium].
  final DsBannerSize size;

  /// An optional bold title shown above [message].
  final String? title;

  /// Overrides the variant's default icon. When `null`, an icon is
  /// chosen automatically based on [variant].
  ///
  /// Ignored when [image] is provided.
  final IconData? icon;

  /// An optional thumbnail shown instead of [icon], e.g. for a
  /// promotional banner.
  final ImageProvider? image;

  /// Short labels rendered as pill-shaped chips below the message, e.g.
  /// category or promotion names. Empty by default.
  final List<String> tags;

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

  ({
    double leadingSize,
    double iconSize,
    EdgeInsets padding,
    TextStyle titleStyle,
    TextStyle messageStyle,
  }) _resolveSizing() {
    switch (size) {
      case DsBannerSize.small:
        return (
          leadingSize: 32,
          iconSize: 16,
          padding: const EdgeInsets.all(DsSpacing.sm),
          titleStyle:
              DsTypography.bodySmall.copyWith(fontWeight: FontWeight.w700),
          messageStyle: DsTypography.caption,
        );
      case DsBannerSize.medium:
        return (
          leadingSize: 48,
          iconSize: 20,
          padding: const EdgeInsets.all(DsSpacing.md),
          titleStyle:
              DsTypography.bodyMedium.copyWith(fontWeight: FontWeight.w700),
          messageStyle: DsTypography.bodyMedium,
        );
      case DsBannerSize.large:
        return (
          leadingSize: 64,
          iconSize: 24,
          padding: const EdgeInsets.all(DsSpacing.lg),
          titleStyle: DsTypography.h3,
          messageStyle: DsTypography.bodyLarge,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = _resolveStyle();
    final sizing = _resolveSizing();

    return Container(
      padding: sizing.padding,
      decoration: BoxDecoration(
        color: style.background,
        borderRadius: BorderRadius.circular(DsRadius.md),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (image != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(DsRadius.sm),
              child: Image(
                image: image!,
                width: sizing.leadingSize,
                height: sizing.leadingSize,
                fit: BoxFit.cover,
              ),
            )
          else
            Icon(style.icon, color: style.foreground, size: sizing.iconSize),
          const SizedBox(width: DsSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (title != null)
                  Text(title!,
                      style:
                          sizing.titleStyle.copyWith(color: style.foreground)),
                Text(message,
                    style:
                        sizing.messageStyle.copyWith(color: style.foreground)),
                if (tags.isNotEmpty) ...[
                  const SizedBox(height: DsSpacing.xs),
                  Wrap(
                    spacing: DsSpacing.xs,
                    runSpacing: DsSpacing.xs,
                    children: [
                      for (final tag in tags)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: DsSpacing.sm,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: style.foreground.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(DsRadius.full),
                          ),
                          child: Text(
                            tag,
                            style: DsTypography.caption
                                .copyWith(color: style.foreground),
                          ),
                        ),
                    ],
                  ),
                ],
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
