import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget wrap(Widget child) => MaterialApp(home: Scaffold(body: Center(child: child)));

  testWidgets('renders its message', (tester) async {
    await tester.pumpWidget(wrap(const DsBanner(message: 'Sua sessao expira em 5 minutos.')));

    expect(find.text('Sua sessao expira em 5 minutos.'), findsOneWidget);
  });

  testWidgets('renders its title when provided', (tester) async {
    await tester.pumpWidget(
      wrap(const DsBanner(title: 'Tudo certo', message: 'Alteracoes salvas.')),
    );

    expect(find.text('Tudo certo'), findsOneWidget);
  });

  testWidgets('shows a close button only when onClose is provided', (tester) async {
    await tester.pumpWidget(wrap(const DsBanner(message: 'Info')));
    expect(find.byIcon(Icons.close), findsNothing);

    var closed = false;
    await tester.pumpWidget(wrap(DsBanner(message: 'Info', onClose: () => closed = true)));
    expect(find.byIcon(Icons.close), findsOneWidget);

    await tester.tap(find.byIcon(Icons.close));
    await tester.pump();
    expect(closed, isTrue);
  });
}
