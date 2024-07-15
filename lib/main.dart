import 'package:flutter/material.dart';
import 'classes/pessoa.dart';
import 'componentes/custom_app_bar.dart';
import 'componentes/custom_button.dart';
import 'componentes/custom_alert_dialog.dart';
import 'classes/classe_calcular.dart' as calc;
import 'classes/imc_resultado.dart' as res;

void main() {
  runApp(IMCCalculatorApp());
}

class IMCCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de IMC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IMCCalculatorPage(),
    );
  }
}

class IMCCalculatorPage extends StatefulWidget {
  @override
  _IMCCalculatorPageState createState() => _IMCCalculatorPageState();
}

class _IMCCalculatorPageState extends State<IMCCalculatorPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final List<String> _results = [];

  void _calculateIMC() {
    final String nome = _nomeController.text;
    final double altura = double.parse(_heightController.text);
    final double peso = double.parse(_weightController.text);

    Pessoa pessoa = Pessoa(nome: nome, altura: altura, peso: peso);

    calc.CalcularIMC imcCalculator = calc.CalcularIMC(pessoa: pessoa);
    final res.ResultadoIMC resultado = imcCalculator.calcular();

    setState(() {
      _results.add(resultado.message);
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          message: resultado.message,
          icon: resultado.icon,
          results: _results,
        );
      },
    );
  }

  void _handleBackFromResults(bool? shouldClear) {
    if (shouldClear == true) {
      _nomeController.clear();
      _heightController.clear();
      _weightController.clear();
      setState(() {
        _results.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Calculadora de IMC'),
      backgroundColor: Colors.grey[200],
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
                SizedBox(height: 16),
                TextField(
                  controller: _heightController,
                  decoration: InputDecoration(
                    labelText: 'Altura (cm)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _weightController,
                  decoration: InputDecoration(
                    labelText: 'Peso (kg)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20),
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
