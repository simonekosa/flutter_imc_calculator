import 'package:flutter/material.dart';
import 'pessoa.dart'; // Importando a classe Pessoa
import 'imc_resultado.dart'; // Importando ResultadoIMC

class CalcularIMC {
  final Pessoa pessoa;

  CalcularIMC({required this.pessoa});

  ResultadoIMC calcularIMC() {
    final double alturaEmMetros = pessoa.altura / 100;
    final double imc = pessoa.peso / (alturaEmMetros * alturaEmMetros);

    if (imc < 18.5) {
      return ResultadoIMC(
        message:
            '${pessoa.nome}, seu IMC é ${imc.toStringAsFixed(2)} (Abaixo do peso)',
        icon: Icons.warning,
      );
    } else if (imc >= 18.5 && imc < 24.9) {
      return ResultadoIMC(
        message:
            '${pessoa.nome}, seu IMC é ${imc.toStringAsFixed(2)} (Peso normal)',
        icon: Icons.check_circle,
      );
    } else if (imc >= 25 && imc < 29.9) {
      return ResultadoIMC(
        message:
            '${pessoa.nome}, seu IMC é ${imc.toStringAsFixed(2)} (Sobrepeso)',
        icon: Icons.warning,
      );
    } else {
      return ResultadoIMC(
        message:
            '${pessoa.nome}, seu IMC é ${imc.toStringAsFixed(2)} (Obesidade)',
        icon: Icons.warning,
      );
    }
  }
}
