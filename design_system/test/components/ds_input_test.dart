import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget wrap(Widget child) =>
      MaterialApp(home: Scaffold(body: Center(child: child)));

  testWidgets('renders its label and hint', (tester) async {
    await tester.pumpWidget(
        wrap(const DsInput(label: 'E-mail', hint: 'voce@exemplo.com')));

    expect(find.text('E-mail'), findsOneWidget);
    expect(find.text('voce@exemplo.com'), findsOneWidget);
  });

  testWidgets('calls onChanged as the user types', (tester) async {
    String? lastValue;
    await tester
        .pumpWidget(wrap(DsInput(onChanged: (value) => lastValue = value)));

    await tester.enterText(find.byType(TextField), 'ola');

    expect(lastValue, 'ola');
  });

  testWidgets('shows the error message when errorText is set', (tester) async {
    await tester
        .pumpWidget(wrap(const DsInput(errorText: 'Campo obrigatorio')));

    expect(find.text('Campo obrigatorio'), findsOneWidget);
  });
}
