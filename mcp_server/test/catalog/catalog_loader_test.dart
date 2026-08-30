import 'dart:io';

import 'package:mcp_server/src/catalog/catalog_loader.dart';
import 'package:mcp_server/src/catalog/models.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

void main() {
  final designSystemRoot =
      p.normalize(p.join(Directory.current.path, '..', 'design_system'));

  late DesignSystemCatalog catalog;

  setUpAll(() {
    catalog = loadDesignSystemCatalog(packageRoot: designSystemRoot);
  });

  test('finds components in all three Atomic Design categories', () {
    final categories = catalog.components.map((c) => c.category).toSet();
    expect(categories, containsAll(ComponentCategory.values));
  });

  test('classifies DsButton as an atom and extracts its constructor params',
      () {
    final button = catalog.components.firstWhere((c) => c.name == 'DsButton');

    expect(button.category, ComponentCategory.atom);
    expect(button.doc, contains('button widget for the design system'));
    expect(button.params.any((param) => param.name == 'key'), isFalse);

    final variant =
        button.params.firstWhere((param) => param.name == 'variant');
    expect(variant.type, 'DsButtonVariant');
    expect(variant.required, isFalse);
    expect(variant.defaultValue, 'DsButtonVariant.primary');

    final onPressed =
        button.params.firstWhere((param) => param.name == 'onPressed');
    expect(onPressed.required, isTrue);
    expect(onPressed.doc, isNotNull);
  });

  test('classifies DsCard as a molecule and DsAppBar as an organism', () {
    final card = catalog.components.firstWhere((c) => c.name == 'DsCard');
    final appBar = catalog.components.firstWhere((c) => c.name == 'DsAppBar');

    expect(card.category, ComponentCategory.molecule);
    expect(appBar.category, ComponentCategory.organism);
  });

  test('extracts enum values with their doc comments', () {
    final variant =
        catalog.enums.firstWhere((e) => e.name == 'DsButtonVariant');

    expect(
      variant.values.map((v) => v.name),
      containsAll(['primary', 'secondary', 'outline', 'ghost']),
    );
    expect(variant.values.first.doc, isNotNull);
  });

  test('extracts literal values for simple token classes', () {
    final primary =
        catalog.tokenClasses.firstWhere((t) => t.name == 'DsPrimary');
    final base = primary.members.firstWhere((m) => m.name == 'base');

    expect(base.value, 'Color(0xFF782DC8)');
    expect(base.type, 'Color');
  });

  test('DsTheme exposes computed members without a literal value', () {
    final theme = catalog.tokenClasses.firstWhere((t) => t.name == 'DsTheme');
    final light = theme.members.firstWhere((m) => m.name == 'light');

    expect(light.value, isNull);
    expect(light.type, 'ThemeData');
  });
}
