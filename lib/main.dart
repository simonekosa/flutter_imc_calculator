import 'package:flutter/material.dart';
import 'classes/pessoa.dart';
import 'componentes/custom_app_bar.dart';
import 'componentes/custom_button.dart';
import 'componentes/custom_alert_dialog.dart';
import 'classes/classe_calcular.dart' as calc;
import 'classes/imc_resultado.dart' as res;

void main() {
  runApp(const IMCCalculatorApp());
}

class IMCCalculatorApp extends StatelessWidget {
  const IMCCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de IMC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const IMCCalculatorPage(),
    );
  }
}

class IMCCalculatorPage extends StatefulWidget {
  const IMCCalculatorPage({super.key});

  @override
  _IMCCalculatorPageState createState() => _IMCCalculatorPageState();
}

class _IMCCalculatorPageState extends State<IMCCalculatorPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _alturaController = TextEditingController();
  final _pesoController = TextEditingController();

  void _calculateIMC() {
    final String nome = _nomeController.text;
    final double altura = double.parse(_alturaController.text);
    final double peso = double.parse(_pesoController.text);

    Pessoa pessoa = Pessoa(nome: nome, altura: altura, peso: peso);

    calc.CalcularIMC imcCalculator = calc.CalcularIMC(pessoa: pessoa);
    final res.ResultadoIMC resultado = imcCalculator.calcularIMC();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
            message: resultado.message, icon: resultado.icon);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
          title: 'Calculadora de IMC'), // Usando o CustomAppBar
      backgroundColor: Colors.grey[200], // Cor de fundo
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _nomeController,
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _alturaController,
                  decoration: InputDecoration(
                    labelText: 'Altura (cm)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _pesoController,
                  decoration: InputDecoration(
                    labelText: 'Peso (kg)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                CustomButton(
                  text: 'Calcular IMC',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _calculateIMC();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
