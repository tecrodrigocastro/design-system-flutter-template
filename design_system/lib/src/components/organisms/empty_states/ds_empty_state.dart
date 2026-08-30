import 'package:flutter/material.dart';

import '../../../tokens/colors.dart';
import '../../../tokens/spacing.dart';
import '../../../tokens/typography.dart';
import '../../atoms/buttons/ds_button.dart';

/// A placeholder for empty lists, empty search results, or error states.
///
/// An organism composed of an icon or image, a title, an optional
/// message, and an optional `DsButton` call to action.
///
/// Example:
/// ```dart
/// DsEmptyState(
///   icon: Icons.inbox_outlined,
///   title: 'Nenhum pedido ainda',
///   message: 'Seus pedidos aparecerao aqui assim que voce comprar algo.',
///   actionLabel: 'Explorar produtos',
///   onAction: () {},
/// )
/// ```
class DsEmptyState extends StatelessWidget {
  /// Creates a design system empty state.
  const DsEmptyState({
    super.key,
    required this.title,
    this.icon,
    this.image,
    this.message,
    this.actionLabel,
    this.onAction,
  });

  /// The main heading, e.g. "Nenhum pedido ainda".
  final String title;

  /// An icon shown above [title]. Ignored when [image] is provided.
  /// Defaults to [Icons.inbox_outlined] when neither is set.
  final IconData? icon;

  /// An optional illustration shown above [title] instead of [icon].
  final ImageProvider? image;

  /// Supporting text shown below [title].
  final String? message;

  /// The label for the call-to-action button. Required together with
  /// [onAction] to show the button; when either is `null`, no button is
  /// shown.
  final String? actionLabel;

  /// Called when the call-to-action button is tapped.
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(DsSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (image != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(DsRadius.lg),
                child: Image(
                    image: image!, width: 96, height: 96, fit: BoxFit.cover),
              )
            else
              Icon(icon ?? Icons.inbox_outlined,
                  size: 48, color: DsNeutral.gray400),
            const SizedBox(height: DsSpacing.md),
            Text(
              title,
              textAlign: TextAlign.center,
              style: DsTypography.h3.copyWith(color: DsNeutral.gray800),
            ),
            if (message != null) ...[
              const SizedBox(height: DsSpacing.xs),
              Text(
                message!,
                textAlign: TextAlign.center,
                style:
                    DsTypography.bodyMedium.copyWith(color: DsNeutral.gray500),
              ),
            ],
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: DsSpacing.lg),
              DsButton(text: actionLabel!, onPressed: onAction),
            ],
          ],
        ),
      ),
    );
  }
}
