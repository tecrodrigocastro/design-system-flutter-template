import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Interactive', type: DsAppBar)
Widget dsAppBarInteractiveUseCase(BuildContext context) {
  final hasBack =
      context.knobs.boolean(label: 'Back button', initialValue: true);
  final hasAction = context.knobs.boolean(label: 'Action', initialValue: true);

  return Scaffold(
    appBar: DsAppBar(
      title: context.knobs.string(label: 'Title', initialValue: 'Perfil'),
      onBack: hasBack ? () {} : null,
      actions: hasAction
          ? [
              DsButton(
                text: 'Salvar',
                size: DsButtonSize.small,
                variant: DsButtonVariant.ghost,
                onPressed: () {},
              ),
            ]
          : const [],
    ),
    body: const SizedBox.shrink(),
  );
}
