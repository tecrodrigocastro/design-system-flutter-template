// dart format width=80
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:widgetbook/widgetbook.dart' as _widgetbook;
import 'package:widgetbook_gallery/use_cases/atoms/buttons/ds_button_use_case.dart'
    as _widgetbook_gallery_use_cases_atoms_buttons_ds_button_use_case;
import 'package:widgetbook_gallery/use_cases/atoms/inputs/ds_input_use_case.dart'
    as _widgetbook_gallery_use_cases_atoms_inputs_ds_input_use_case;
import 'package:widgetbook_gallery/use_cases/molecules/banners/ds_banner_use_case.dart'
    as _widgetbook_gallery_use_cases_molecules_banners_ds_banner_use_case;
import 'package:widgetbook_gallery/use_cases/molecules/cards/ds_card_use_case.dart'
    as _widgetbook_gallery_use_cases_molecules_cards_ds_card_use_case;

final directories = <_widgetbook.WidgetbookNode>[
  _widgetbook.WidgetbookFolder(
    name: 'components',
    children: [
      _widgetbook.WidgetbookFolder(
        name: 'atoms',
        children: [
          _widgetbook.WidgetbookFolder(
            name: 'buttons',
            children: [
              _widgetbook.WidgetbookComponent(
                name: 'DsButton',
                useCases: [
                  _widgetbook.WidgetbookUseCase(
                    name: 'All variants',
                    builder:
                        _widgetbook_gallery_use_cases_atoms_buttons_ds_button_use_case
                            .dsButtonAllVariantsUseCase,
                  ),
                  _widgetbook.WidgetbookUseCase(
                    name: 'Interactive',
                    builder:
                        _widgetbook_gallery_use_cases_atoms_buttons_ds_button_use_case
                            .dsButtonInteractiveUseCase,
                  ),
                ],
              )
            ],
          ),
          _widgetbook.WidgetbookFolder(
            name: 'inputs',
            children: [
              _widgetbook.WidgetbookComponent(
                name: 'DsInput',
                useCases: [
                  _widgetbook.WidgetbookUseCase(
                    name: 'Interactive',
                    builder:
                        _widgetbook_gallery_use_cases_atoms_inputs_ds_input_use_case
                            .dsInputInteractiveUseCase,
                  ),
                  _widgetbook.WidgetbookUseCase(
                    name: 'States',
                    builder:
                        _widgetbook_gallery_use_cases_atoms_inputs_ds_input_use_case
                            .dsInputStatesUseCase,
                  ),
                ],
              )
            ],
          ),
        ],
      ),
      _widgetbook.WidgetbookFolder(
        name: 'molecules',
        children: [
          _widgetbook.WidgetbookFolder(
            name: 'banners',
            children: [
              _widgetbook.WidgetbookComponent(
                name: 'DsBanner',
                useCases: [
                  _widgetbook.WidgetbookUseCase(
                    name: 'All variants',
                    builder:
                        _widgetbook_gallery_use_cases_molecules_banners_ds_banner_use_case
                            .dsBannerAllVariantsUseCase,
                  ),
                  _widgetbook.WidgetbookUseCase(
                    name: 'Different sizes',
                    builder:
                        _widgetbook_gallery_use_cases_molecules_banners_ds_banner_use_case
                            .dsBannerDifferentSizesUseCase,
                  ),
                  _widgetbook.WidgetbookUseCase(
                    name: 'Interactive',
                    builder:
                        _widgetbook_gallery_use_cases_molecules_banners_ds_banner_use_case
                            .dsBannerInteractiveUseCase,
                  ),
                  _widgetbook.WidgetbookUseCase(
                    name: 'With images',
                    builder:
                        _widgetbook_gallery_use_cases_molecules_banners_ds_banner_use_case
                            .dsBannerWithImagesUseCase,
                  ),
                ],
              )
            ],
          ),
          _widgetbook.WidgetbookFolder(
            name: 'cards',
            children: [
              _widgetbook.WidgetbookComponent(
                name: 'DsCard',
                useCases: [
                  _widgetbook.WidgetbookUseCase(
                    name: 'Interactive',
                    builder:
                        _widgetbook_gallery_use_cases_molecules_cards_ds_card_use_case
                            .dsCardInteractiveUseCase,
                  )
                ],
              )
            ],
          ),
        ],
      ),
    ],
  )
];
