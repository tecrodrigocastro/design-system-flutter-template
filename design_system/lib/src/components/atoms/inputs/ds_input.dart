import 'package:flutter/material.dart';

import '../../../../core/enums/ds_input_variant_enum.dart';
import '../../../tokens/colors.dart';
import '../../../tokens/spacing.dart';
import '../../../tokens/typography.dart';

/// A text input widget for the design system.
///
/// Wraps [TextField] with the library's tokens for color, spacing, and
/// typography, plus a built-in label and error message so forms stay
/// consistent without repeating [InputDecoration] boilerplate.
///
/// Example:
/// ```dart
/// // Basic outline input (default)
/// DsInput(
///   label: 'E-mail',
///   hint: 'voce@exemplo.com',
///   onChanged: (value) => print(value),
/// )
///
/// // Filled input with an error
/// DsInput(
///   label: 'Senha',
///   variant: DsInputVariant.filled,
///   obscureText: true,
///   errorText: 'Senha deve ter ao menos 8 caracteres',
/// )
/// ```
class DsInput extends StatelessWidget {
  /// Creates a design system text input.
  const DsInput({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.errorText,
    this.variant = DsInputVariant.outline,
    this.enabled = true,
    this.obscureText = false,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
  });

  /// Controls the text being edited. Optional if you only need
  /// [onChanged].
  final TextEditingController? controller;

  /// Text shown above the field.
  final String? label;

  /// Placeholder text shown inside the field when empty.
  final String? hint;

  /// Error message shown below the field, in [DsDanger.base].
  ///
  /// When non-null, the field's border also switches to [DsDanger.base].
  final String? errorText;

  /// The visual style of the field. Defaults to [DsInputVariant.outline].
  final DsInputVariant variant;

  /// Whether the field accepts input.
  final bool enabled;

  /// Whether to hide the entered text, e.g. for passwords.
  final bool obscureText;

  /// The type of keyboard to show, e.g. [TextInputType.emailAddress].
  final TextInputType? keyboardType;

  /// An optional icon shown at the start of the field.
  final IconData? prefixIcon;

  /// An optional icon shown at the end of the field.
  final IconData? suffixIcon;

  /// Called every time the text changes.
  final ValueChanged<String>? onChanged;

  bool get _hasError => errorText != null && errorText!.isNotEmpty;

  Color get _borderColor {
    if (_hasError) return DsDanger.base;
    if (!enabled) return DsNeutral.gray200;
    return DsNeutral.gray300;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(label!,
              style: DsTypography.bodySmall.copyWith(color: DsNeutral.gray600)),
          const SizedBox(height: DsSpacing.xs),
        ],
        TextField(
          controller: controller,
          enabled: enabled,
          obscureText: obscureText,
          keyboardType: keyboardType,
          onChanged: onChanged,
          style: DsTypography.bodyMedium.copyWith(color: DsNeutral.gray800),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle:
                DsTypography.bodyMedium.copyWith(color: DsNeutral.gray400),
            filled: variant == DsInputVariant.filled,
            fillColor: DsNeutral.gray50,
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, color: DsNeutral.gray500)
                : null,
            suffixIcon: suffixIcon != null
                ? Icon(suffixIcon, color: DsNeutral.gray500)
                : null,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: DsSpacing.md,
              vertical: DsSpacing.sm,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(DsRadius.sm),
              borderSide: BorderSide(color: _borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(DsRadius.sm),
              borderSide: BorderSide(color: _borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(DsRadius.sm),
              borderSide: BorderSide(
                  color: _hasError ? DsDanger.base : DsPrimary.base, width: 2),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(DsRadius.sm),
              borderSide: BorderSide(color: _borderColor),
            ),
          ),
        ),
        if (_hasError) ...[
          const SizedBox(height: DsSpacing.xs),
          Text(errorText!,
              style: DsTypography.caption.copyWith(color: DsDanger.base)),
        ],
      ],
    );
  }
}
