import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Interactive', type: DsInput)
Widget dsInputInteractiveUseCase(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(DsSpacing.md),
    child: DsInput(
      label: context.knobs.stringOrNull(label: 'Label', initialValue: 'E-mail'),
      hint: context.knobs.stringOrNull(label: 'Hint', initialValue: 'voce@exemplo.com'),
      errorText: context.knobs.stringOrNull(label: 'Error text'),
      variant: context.knobs.object.dropdown<DsInputVariant>(
        label: 'Variant',
        options: DsInputVariant.values,
        labelBuilder: (value) => value.name,
      ),
      enabled: context.knobs.boolean(label: 'Enabled', initialValue: true),
      obscureText: context.knobs.boolean(label: 'Obscure text'),
    ),
  );
}

@widgetbook.UseCase(name: 'States', type: DsInput)
Widget dsInputStatesUseCase(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(DsSpacing.md),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        DsInput(label: 'Padrao', hint: 'Digite aqui'),
        SizedBox(height: DsSpacing.md),
        DsInput(label: 'Desabilitado', hint: 'Digite aqui', enabled: false),
        SizedBox(height: DsSpacing.md),
        DsInput(
          label: 'Com erro',
          hint: 'Digite aqui',
          errorText: 'Campo obrigatorio',
        ),
      ],
    ),
  );
}
