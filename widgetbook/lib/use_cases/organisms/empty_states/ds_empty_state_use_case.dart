import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Interactive', type: DsEmptyState)
Widget dsEmptyStateInteractiveUseCase(BuildContext context) {
  final hasAction = context.knobs.boolean(label: 'Action', initialValue: true);

  return DsEmptyState(
    title: context.knobs
        .string(label: 'Title', initialValue: 'Nenhum pedido ainda'),
    message: context.knobs.stringOrNull(
      label: 'Message',
      initialValue: 'Seus pedidos aparecerao aqui assim que voce comprar algo.',
    ),
    actionLabel: hasAction ? 'Explorar produtos' : null,
    onAction: hasAction ? () {} : null,
  );
}
