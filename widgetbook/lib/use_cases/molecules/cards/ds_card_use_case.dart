import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Interactive', type: DsCard)
Widget dsCardInteractiveUseCase(BuildContext context) {
  final isTappable = context.knobs.boolean(label: 'Tappable', initialValue: true);

  return Padding(
    padding: const EdgeInsets.all(DsSpacing.md),
    child: DsCard(
      elevation: context.knobs.double.slider(
        label: 'Elevation',
        initialValue: 1,
        min: 0,
        max: 8,
      ),
      onTap: isTappable ? () {} : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.knobs.string(label: 'Title', initialValue: 'Produto Premium'),
            style: DsTypography.h3,
          ),
          const SizedBox(height: DsSpacing.xs),
          Text('R\$ 299,90', style: DsTypography.bodyLarge),
        ],
      ),
    ),
  );
}
