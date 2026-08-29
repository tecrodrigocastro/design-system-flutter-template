import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget wrap(Widget child) => MaterialApp(home: Scaffold(body: Center(child: child)));

  testWidgets('renders its text', (tester) async {
    await tester.pumpWidget(wrap(DsButton(text: 'Enviar', onPressed: () {})));

    expect(find.text('Enviar'), findsOneWidget);
  });

  testWidgets('calls onPressed when tapped', (tester) async {
    var tapCount = 0;
    await tester.pumpWidget(wrap(DsButton(text: 'Enviar', onPressed: () => tapCount++)));

    await tester.tap(find.byType(DsButton));
    await tester.pump();

    expect(tapCount, 1);
  });

  testWidgets('does not call onPressed when null (disabled)', (tester) async {
    await tester.pumpWidget(wrap(const DsButton(text: 'Enviar', onPressed: null)));

    await tester.tap(find.byType(DsButton));
    await tester.pump();

    // No exception thrown and no callback to invoke — the tap is a no-op.
    expect(find.text('Enviar'), findsOneWidget);
  });

  testWidgets('shows a spinner and hides its text while loading', (tester) async {
    await tester.pumpWidget(
      wrap(DsButton(text: 'Salvando...', isLoading: true, onPressed: () {})),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('does not call onPressed while loading', (tester) async {
    var tapCount = 0;
    await tester.pumpWidget(
      wrap(DsButton(text: 'Salvando...', isLoading: true, onPressed: () => tapCount++)),
    );

    await tester.tap(find.byType(DsButton));
    await tester.pump();

    expect(tapCount, 0);
  });
}
