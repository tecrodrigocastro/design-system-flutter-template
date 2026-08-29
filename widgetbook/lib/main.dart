import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'main.directories.g.dart';

void main() {
  runApp(const WidgetbookGalleryApp());
}

/// Entry point for the Widgetbook gallery.
///
/// Running `dart run build_runner build` scans every `@widgetbook.UseCase`
/// in this project and regenerates [directories], so a new component or
/// use case shows up here automatically — no manual registration.
@widgetbook.App()
class WidgetbookGalleryApp extends StatelessWidget {
  /// Creates the Widgetbook gallery app.
  const WidgetbookGalleryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      directories: directories,
      addons: [
        MaterialThemeAddon(
          themes: [
            WidgetbookTheme(name: 'Light', data: DsTheme.light),
            WidgetbookTheme(name: 'Dark', data: DsTheme.dark),
          ],
        ),
        ViewportAddon(Viewports.all),
        TextScaleAddon(),
        InspectorAddon(),
      ],
    );
  }
}
