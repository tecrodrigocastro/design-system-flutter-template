import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget wrap(Widget child) =>
      MaterialApp(home: Scaffold(body: Center(child: child)));

  testWidgets('renders its child', (tester) async {
    await tester.pumpWidget(wrap(const DsCard(child: Text('Produto Premium'))));

    expect(find.text('Produto Premium'), findsOneWidget);
  });

  testWidgets('calls onTap when tapped', (tester) async {
    var tapCount = 0;
    await tester.pumpWidget(
      wrap(DsCard(
          onTap: () => tapCount++, child: const Text('Produto Premium'))),
    );

    await tester.tap(find.byType(DsCard));
    await tester.pump();

    expect(tapCount, 1);
  });

  testWidgets('has no tap feedback when onTap is null', (tester) async {
    await tester.pumpWidget(wrap(const DsCard(child: Text('Produto Premium'))));

    final inkWell = tester.widget<InkWell>(find.byType(InkWell));
    expect(inkWell.onTap, isNull);
  });
}
