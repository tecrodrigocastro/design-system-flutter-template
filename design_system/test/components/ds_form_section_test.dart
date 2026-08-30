import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget wrap(Widget child) => MaterialApp(home: Scaffold(body: child));

  testWidgets('renders its title and fields', (tester) async {
    await tester.pumpWidget(
      wrap(
        DsFormSection(
          title: 'Dados de acesso',
          submitLabel: 'Entrar',
          onSubmit: () {},
          children: const [DsInput(label: 'E-mail'), DsInput(label: 'Senha')],
        ),
      ),
    );

    expect(find.text('Dados de acesso'), findsOneWidget);
    expect(find.text('E-mail'), findsOneWidget);
    expect(find.text('Senha'), findsOneWidget);
    expect(find.text('Entrar'), findsOneWidget);
  });

  testWidgets('calls onSubmit when the submit button is tapped',
      (tester) async {
    var submitted = false;
    await tester.pumpWidget(
      wrap(
        DsFormSection(
          submitLabel: 'Entrar',
          onSubmit: () => submitted = true,
          children: const [],
        ),
      ),
    );

    await tester.tap(find.text('Entrar'));
    await tester.pump();

    expect(submitted, isTrue);
  });

  testWidgets('disables the submit button while isSubmitting is true',
      (tester) async {
    var submitted = false;
    await tester.pumpWidget(
      wrap(
        DsFormSection(
          submitLabel: 'Entrar',
          isSubmitting: true,
          onSubmit: () => submitted = true,
          children: const [],
        ),
      ),
    );

    await tester.tap(find.byType(DsButton));
    await tester.pump();

    expect(submitted, isFalse);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
