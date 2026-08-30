import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Interactive', type: DsFormSection)
Widget dsFormSectionInteractiveUseCase(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(DsSpacing.md),
    child: DsFormSection(
      title: context.knobs
          .stringOrNull(label: 'Title', initialValue: 'Dados de acesso'),
      submitLabel:
          context.knobs.string(label: 'Submit label', initialValue: 'Entrar'),
      isSubmitting: context.knobs.boolean(label: 'Submitting'),
      onSubmit: () {},
      children: const [
        DsInput(label: 'E-mail', hint: 'voce@exemplo.com'),
        DsInput(label: 'Senha', obscureText: true),
      ],
    ),
  );
}
