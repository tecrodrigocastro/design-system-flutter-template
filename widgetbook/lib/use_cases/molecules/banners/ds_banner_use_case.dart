import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Interactive', type: DsBanner)
Widget dsBannerInteractiveUseCase(BuildContext context) {
  final dismissible = context.knobs.boolean(label: 'Dismissible', initialValue: true);

  return Padding(
    padding: const EdgeInsets.all(DsSpacing.md),
    child: DsBanner(
      variant: context.knobs.object.dropdown<DsBannerVariant>(
        label: 'Variant',
        options: DsBannerVariant.values,
        labelBuilder: (value) => value.name,
      ),
      title: context.knobs.stringOrNull(label: 'Title'),
      message: context.knobs.string(
        label: 'Message',
        initialValue: 'Sua sessao expira em 5 minutos.',
      ),
      onClose: dismissible ? () {} : null,
    ),
  );
}

@widgetbook.UseCase(name: 'All variants', type: DsBanner)
Widget dsBannerAllVariantsUseCase(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(DsSpacing.md),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final variant in DsBannerVariant.values) ...[
          DsBanner(variant: variant, message: 'Mensagem de ${variant.name}'),
          const SizedBox(height: DsSpacing.sm),
        ],
      ],
    ),
  );
}
