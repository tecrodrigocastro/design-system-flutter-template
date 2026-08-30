import 'package:flutter/material.dart';

import '../../../tokens/spacing.dart';
import '../../../tokens/typography.dart';
import '../../atoms/buttons/ds_button.dart';

/// A titled group of form fields with a submit action.
///
/// An organism that lays out [children] (typically `DsInput` widgets)
/// with consistent spacing and appends a `DsButton` submit action. It
/// does not implement validation — pass `errorText` to individual
/// `DsInput`s and gate [onSubmit] however your app validates its data.
///
/// Example:
/// ```dart
/// DsFormSection(
///   title: 'Dados de acesso',
///   submitLabel: 'Entrar',
///   isSubmitting: isLoading,
///   onSubmit: isLoading ? null : _handleLogin,
///   children: [
///     DsInput(label: 'E-mail', controller: emailController),
///     DsInput(label: 'Senha', obscureText: true, controller: passwordController),
///   ],
/// )
/// ```
class DsFormSection extends StatelessWidget {
  /// Creates a design system form section.
  const DsFormSection({
    super.key,
    required this.children,
    required this.submitLabel,
    required this.onSubmit,
    this.title,
    this.isSubmitting = false,
  });

  /// An optional heading shown above the fields.
  final String? title;

  /// The form fields, typically `DsInput` widgets, laid out with
  /// consistent vertical spacing.
  final List<Widget> children;

  /// The label for the submit button.
  final String submitLabel;

  /// Called when the submit button is tapped. Pass `null` to disable
  /// submission, e.g. while [isSubmitting] is `true`.
  final VoidCallback? onSubmit;

  /// Whether to show a loading spinner on the submit button and block
  /// further taps.
  final bool isSubmitting;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title != null) ...[
          Text(title!, style: DsTypography.h3),
          const SizedBox(height: DsSpacing.md),
        ],
        for (final field in children) ...[
          field,
          const SizedBox(height: DsSpacing.md)
        ],
        DsButton(
          text: submitLabel,
          isLoading: isSubmitting,
          fullWidth: true,
          onPressed: isSubmitting ? null : onSubmit,
        ),
      ],
    );
  }
}
