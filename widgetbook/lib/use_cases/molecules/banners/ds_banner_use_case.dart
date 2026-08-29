import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

const _sampleImageUrl =
    'https://picsum.photos/seed/design-system-banner/200/200';

@widgetbook.UseCase(name: 'Interactive', type: DsBanner)
Widget dsBannerInteractiveUseCase(BuildContext context) {
  final dismissible =
      context.knobs.boolean(label: 'Dismissible', initialValue: true);
  final hasImage = context.knobs.boolean(label: 'Image');
  final tagsInput = context.knobs
      .string(label: 'Tags (comma separated)', initialValue: 'Novo');

  return Padding(
    padding: const EdgeInsets.all(DsSpacing.md),
    child: DsBanner(
      variant: context.knobs.object.dropdown<DsBannerVariant>(
        label: 'Variant',
        options: DsBannerVariant.values,
        labelBuilder: (value) => value.name,
      ),
      size: context.knobs.object.dropdown<DsBannerSize>(
        label: 'Size',
        options: DsBannerSize.values,
        labelBuilder: (value) => value.name,
      ),
      title: context.knobs.stringOrNull(label: 'Title'),
      message: context.knobs.string(
        label: 'Message',
        initialValue: 'Sua sessao expira em 5 minutos.',
      ),
      image: hasImage ? const NetworkImage(_sampleImageUrl) : null,
      tags: tagsInput.isEmpty
          ? const []
          : tagsInput.split(',').map((tag) => tag.trim()).toList(),
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

@widgetbook.UseCase(name: 'Different sizes', type: DsBanner)
Widget dsBannerDifferentSizesUseCase(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(DsSpacing.md),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final size in DsBannerSize.values) ...[
          DsBanner(
            size: size,
            title: size.name,
            message: 'Banner de tamanho ${size.name}.',
            tags: const ['Exemplo'],
          ),
          const SizedBox(height: DsSpacing.sm),
        ],
      ],
    ),
  );
}

@widgetbook.UseCase(name: 'With images', type: DsBanner)
Widget dsBannerWithImagesUseCase(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(DsSpacing.md),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        DsBanner(
          size: DsBannerSize.large,
          title: 'Fim de semana promocional',
          message: 'Ate 40% de desconto em produtos selecionados.',
          image: NetworkImage(_sampleImageUrl),
          tags: ['Promocao', 'Limitado'],
        ),
        SizedBox(height: DsSpacing.sm),
        DsBanner(
          variant: DsBannerVariant.success,
          title: 'Pedido confirmado',
          message: 'Seu produto chega ate sexta-feira.',
          image: NetworkImage(_sampleImageUrl),
        ),
      ],
    ),
  );
}
