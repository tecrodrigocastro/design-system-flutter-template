import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget wrap(Widget child) => MaterialApp(home: Scaffold(body: child));

  testWidgets('renders its title and message', (tester) async {
    await tester.pumpWidget(
      wrap(const DsEmptyState(
          title: 'Nenhum pedido ainda', message: 'Compre algo primeiro.')),
    );

    expect(find.text('Nenhum pedido ainda'), findsOneWidget);
    expect(find.text('Compre algo primeiro.'), findsOneWidget);
  });

  testWidgets('shows the action button only when label and callback are set',
      (tester) async {
    await tester.pumpWidget(wrap(const DsEmptyState(title: 'Vazio')));
    expect(find.byType(DsButton), findsNothing);

    var tapped = false;
    await tester.pumpWidget(
      wrap(
        DsEmptyState(
            title: 'Vazio',
            actionLabel: 'Explorar',
            onAction: () => tapped = true),
      ),
    );
    expect(find.text('Explorar'), findsOneWidget);

    await tester.tap(find.byType(DsButton));
    await tester.pump();
    expect(tapped, isTrue);
  });

  testWidgets('falls back to the default icon when none is provided',
      (tester) async {
    await tester.pumpWidget(wrap(const DsEmptyState(title: 'Vazio')));

    expect(find.byIcon(Icons.inbox_outlined), findsOneWidget);
  });
}
