import 'package:flutter/material.dart';

import '../../../../core/enums/ds_button_size_enum.dart';
import '../../../../core/enums/ds_button_variant_enum.dart';
import '../../../tokens/colors.dart';
import '../../../tokens/spacing.dart';
import '../../../tokens/typography.dart';

/// A button widget for the design system.
///
/// Supports multiple visual variants, sizes, a loading state, and an
/// optional leading icon. Use this widget instead of [ElevatedButton] or
/// [TextButton] directly so every button in the app stays visually
/// consistent.
///
/// Variants available:
/// - [DsButtonVariant.primary]: solid button filled with the brand color.
/// - [DsButtonVariant.secondary]: solid button filled with the accent color.
/// - [DsButtonVariant.outline]: transparent button with a colored border.
/// - [DsButtonVariant.ghost]: transparent button with no border.
///
/// Example:
/// ```dart
/// // Primary button (default)
/// DsButton(
///   text: 'Enviar',
///   onPressed: () => print('Enviado'),
/// )
///
/// // Ghost button
/// DsButton(
///   text: 'Cancelar',
///   variant: DsButtonVariant.ghost,
///   onPressed: () => print('Cancelado'),
/// )
///
/// // Outline button with icon and loading state
/// DsButton(
///   text: 'Salvando...',
///   variant: DsButtonVariant.outline,
///   size: DsButtonSize.large,
///   icon: Icons.save,
///   isLoading: isSaving,
///   onPressed: isSaving ? null : _handleSave,
/// )
/// ```
class DsButton extends StatelessWidget {
  /// Creates a design system button.
  const DsButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.variant = DsButtonVariant.primary,
    this.size = DsButtonSize.medium,
    this.isLoading = false,
    this.icon,
    this.fullWidth = false,
  });

  /// The text displayed on the button.
  final String text;

  /// Called when the button is tapped.
  ///
  /// The button renders as disabled when this is `null`, regardless of
  /// [isLoading].
  final VoidCallback? onPressed;

  /// The visual style of the button. Defaults to
  /// [DsButtonVariant.primary].
  final DsButtonVariant variant;

  /// The size of the button. Defaults to [DsButtonSize.medium].
  final DsButtonSize size;

  /// Whether to replace [text] with a spinner and ignore taps.
  ///
  /// The button keeps its size while loading, so surrounding layout does
  /// not shift.
  final bool isLoading;

  /// An optional icon shown before [text].
  final IconData? icon;

  /// Whether the button should expand to fill its parent's width.
  final bool fullWidth;

  bool get _isDisabled => onPressed == null || isLoading;

  ({Color background, Color foreground, Color? border}) _resolveColors() {
    if (_isDisabled) {
      return (
        background: variant == DsButtonVariant.outline ||
                variant == DsButtonVariant.ghost
            ? Colors.transparent
            : DsNeutral.gray100,
        foreground: DsNeutral.gray400,
        border: variant == DsButtonVariant.outline
            ? DsNeutral.gray200
            : null,
      );
    }

    switch (variant) {
      case DsButtonVariant.primary:
        return (
          background: DsPrimary.base,
          foreground: DsNeutral.white,
          border: null,
        );
      case DsButtonVariant.secondary:
        return (
          background: DsSecondary.base,
          foreground: DsNeutral.white,
          border: null,
        );
      case DsButtonVariant.outline:
        return (
          background: Colors.transparent,
          foreground: DsPrimary.base,
          border: DsPrimary.base,
        );
      case DsButtonVariant.ghost:
        return (
          background: Colors.transparent,
          foreground: DsPrimary.base,
          border: null,
        );
    }
  }

  ({double height, double horizontalPadding, double iconSize}) _resolveSizing() {
    switch (size) {
      case DsButtonSize.small:
        return (height: 32, horizontalPadding: DsSpacing.sm, iconSize: 16);
      case DsButtonSize.medium:
        return (height: 44, horizontalPadding: DsSpacing.md, iconSize: 18);
      case DsButtonSize.large:
        return (height: 52, horizontalPadding: DsSpacing.lg, iconSize: 20);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = _resolveColors();
    final sizing = _resolveSizing();

    return SizedBox(
      width: fullWidth ? double.infinity : null,
      height: sizing.height,
      child: Material(
        color: colors.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(sizing.height / 2),
          side: colors.border != null
              ? BorderSide(color: colors.border!)
              : BorderSide.none,
        ),
        child: InkWell(
          onTap: _isDisabled ? null : onPressed,
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(sizing.height / 2),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: sizing.horizontalPadding),
            child: Row(
              mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isLoading)
                  SizedBox(
                    width: sizing.iconSize,
                    height: sizing.iconSize,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: colors.foreground,
                    ),
                  )
                else if (icon != null)
                  Icon(icon, size: sizing.iconSize, color: colors.foreground),
                if (isLoading || icon != null) const SizedBox(width: DsSpacing.sm),
                Text(
                  text,
                  style: DsTypography.button.copyWith(color: colors.foreground),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
