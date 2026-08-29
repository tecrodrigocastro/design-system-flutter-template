import 'package:flutter/material.dart';

import '../../../tokens/colors.dart';
import '../../../tokens/spacing.dart';

/// A surface container widget for the design system.
///
/// Groups related content behind a consistent background, border radius,
/// and elevation. Becomes tappable automatically when [onTap] is
/// provided.
///
/// Example:
/// ```dart
/// // Static card
/// DsCard(
///   child: Text('Produto Premium'),
/// )
///
/// // Tappable card with custom padding
/// DsCard(
///   padding: const EdgeInsets.all(DsSpacing.lg),
///   onTap: () => print('Card tapped'),
///   child: const Column(
///     crossAxisAlignment: CrossAxisAlignment.start,
///     children: [
///       Text('Produto Premium'),
///       Text('R\$ 299,90'),
///     ],
///   ),
/// )
/// ```
class DsCard extends StatelessWidget {
  /// Creates a design system card.
  const DsCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(DsSpacing.md),
    this.color,
    this.elevation = 1,
    this.onTap,
  });

  /// The content displayed inside the card.
  final Widget child;

  /// The space between the card's edges and [child]. Defaults to
  /// [DsSpacing.md] on all sides.
  final EdgeInsetsGeometry padding;

  /// The card's background color. Defaults to [DsNeutral.white].
  final Color? color;

  /// The card's shadow depth. Set to `0` for a flat card.
  final double elevation;

  /// Called when the card is tapped. When `null`, the card is not
  /// interactive and shows no tap feedback.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color ?? DsNeutral.white,
      elevation: elevation,
      shadowColor: DsNeutral.gray400.withValues(alpha: 0.4),
      borderRadius: BorderRadius.circular(DsRadius.md),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(DsRadius.md),
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
