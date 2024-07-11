// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imc_calculator/main.dart';

void main() {
  testWidgets('Verifica se o texto do IMC calculado está presente após a ação',
      (WidgetTester tester) async {
    await tester.pumpWidget(IMCCalculatorApp());

    await tester.enterText(find.byType(TextFormField).at(0), 'Nome Teste');
    await tester.enterText(find.byType(TextFormField).at(1), '170');
    await tester.enterText(find.byType(TextFormField).at(2), '70');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    expect(
        find.text('Nome Teste, seu IMC é 24.22 (Peso normal)'), findsOneWidget);
  });
}
