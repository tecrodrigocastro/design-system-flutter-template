import 'dart:convert';

import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// A 1x1 transparent PNG, so image tests don't depend on network access.
final _pixel = MemoryImage(
  base64Decode(
    'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNk'
    '+A8AAQUBAScY42YAAAAASUVORK5CYII=',
  ),
);

void main() {
  Widget wrap(Widget child) =>
      MaterialApp(home: Scaffold(body: Center(child: child)));

  testWidgets('renders its message', (tester) async {
    await tester.pumpWidget(
        wrap(const DsBanner(message: 'Sua sessao expira em 5 minutos.')));

    expect(find.text('Sua sessao expira em 5 minutos.'), findsOneWidget);
  });

  testWidgets('renders its title when provided', (tester) async {
    await tester.pumpWidget(
      wrap(const DsBanner(title: 'Tudo certo', message: 'Alteracoes salvas.')),
    );

    expect(find.text('Tudo certo'), findsOneWidget);
  });

  testWidgets('shows a close button only when onClose is provided',
      (tester) async {
    await tester.pumpWidget(wrap(const DsBanner(message: 'Info')));
    expect(find.byIcon(Icons.close), findsNothing);

    var closed = false;
    await tester.pumpWidget(
        wrap(DsBanner(message: 'Info', onClose: () => closed = true)));
    expect(find.byIcon(Icons.close), findsOneWidget);

    await tester.tap(find.byIcon(Icons.close));
    await tester.pump();
    expect(closed, isTrue);
  });

  testWidgets('renders its tags', (tester) async {
    await tester.pumpWidget(
      wrap(const DsBanner(message: 'Promo', tags: ['Novo', 'Limitado'])),
    );

    expect(find.text('Novo'), findsOneWidget);
    expect(find.text('Limitado'), findsOneWidget);
  });

  testWidgets('renders an image instead of the default icon when provided',
      (tester) async {
    await tester.pumpWidget(wrap(DsBanner(message: 'Promo', image: _pixel)));
    await tester.pumpAndSettle();

    expect(find.byType(Image), findsOneWidget);
    expect(find.byIcon(Icons.info_outline), findsNothing);
  });
}
