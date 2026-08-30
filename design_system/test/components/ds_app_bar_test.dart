import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget wrap(PreferredSizeWidget appBar) =>
      MaterialApp(home: Scaffold(appBar: appBar));

  testWidgets('renders its title', (tester) async {
    await tester.pumpWidget(wrap(const DsAppBar(title: 'Perfil')));

    expect(find.text('Perfil'), findsOneWidget);
  });

  testWidgets('shows a back button only when onBack is provided',
      (tester) async {
    await tester.pumpWidget(wrap(const DsAppBar(title: 'Perfil')));
    expect(find.byIcon(Icons.arrow_back), findsNothing);

    var didGoBack = false;
    await tester.pumpWidget(
        wrap(DsAppBar(title: 'Perfil', onBack: () => didGoBack = true)));
    expect(find.byIcon(Icons.arrow_back), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_back));
    expect(didGoBack, isTrue);
  });

  testWidgets('renders its actions', (tester) async {
    await tester.pumpWidget(
      wrap(
        DsAppBar(
          title: 'Perfil',
          actions: [DsButton(text: 'Salvar', onPressed: () {})],
        ),
      ),
    );

    expect(find.text('Salvar'), findsOneWidget);
  });
}
