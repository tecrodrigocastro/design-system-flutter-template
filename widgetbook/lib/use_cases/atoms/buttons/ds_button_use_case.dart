import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Interactive', type: DsButton)
Widget dsButtonInteractiveUseCase(BuildContext context) {
  final hasIcon = context.knobs.boolean(label: 'Icon', initialValue: false);

  return DsButton(
    text: context.knobs.string(label: 'Text', initialValue: 'Button'),
    variant: context.knobs.object.dropdown<DsButtonVariant>(
      label: 'Variant',
      options: DsButtonVariant.values,
      labelBuilder: (value) => value.name,
    ),
    size: context.knobs.object.dropdown<DsButtonSize>(
      label: 'Size',
      options: DsButtonSize.values,
      labelBuilder: (value) => value.name,
    ),
    isLoading: context.knobs.boolean(label: 'Loading'),
    fullWidth: context.knobs.boolean(label: 'Full width'),
    icon: hasIcon ? Icons.favorite_outline : null,
    onPressed: context.knobs.boolean(label: 'Enabled', initialValue: true)
        ? () {}
        : null,
  );
}

@widgetbook.UseCase(name: 'All variants', type: DsButton)
Widget dsButtonAllVariantsUseCase(BuildContext context) {
  return Center(
    child: Wrap(
      spacing: DsSpacing.md,
      runSpacing: DsSpacing.md,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        for (final variant in DsButtonVariant.values)
          DsButton(text: variant.name, variant: variant, onPressed: () {}),
      ],
    ),
  );
}
