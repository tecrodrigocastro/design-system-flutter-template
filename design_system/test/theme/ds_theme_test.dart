import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('light theme uses the light brightness and brand primary color', () {
    expect(DsTheme.light.brightness, Brightness.light);
    expect(DsTheme.light.colorScheme.primary, DsPrimary.base);
  });

  test('dark theme uses the dark brightness and brand primary color', () {
    expect(DsTheme.dark.brightness, Brightness.dark);
    expect(DsTheme.dark.colorScheme.primary, DsPrimary.base);
  });

  test('text theme reads from DsTypography', () {
    expect(DsTheme.light.textTheme.headlineLarge?.fontSize,
        DsTypography.h1.fontSize);
    expect(DsTheme.light.textTheme.bodyMedium?.fontSize,
        DsTypography.bodyMedium.fontSize);
  });
}
