import 'package:flutter/material.dart';

class ResultadoIMC {
  final String message;
  final IconData icon;

  ResultadoIMC({required this.message, required this.icon});
}

class CalcularIMC {
  final String nome;
  final double altura;
  final double peso;

  CalcularIMC({required this.nome, required this.altura, required this.peso});

  ResultadoIMC calcular() {
    final double alturaEmMetros = altura / 100;
    final double imc = peso / (alturaEmMetros * alturaEmMetros);

    if (imc < 18.5) {
      return ResultadoIMC(
        message: '$nome, seu IMC é ${imc.toStringAsFixed(2)} (Abaixo do peso)',
        icon: Icons.warning,
      );
    } else if (imc >= 18.5 && imc < 24.9) {
      return ResultadoIMC(
        message: '$nome, seu IMC é ${imc.toStringAsFixed(2)} (Peso normal)',
        icon: Icons.check_circle,
      );
    } else if (imc >= 25 && imc < 29.9) {
      return ResultadoIMC(
        message: '$nome, seu IMC é ${imc.toStringAsFixed(2)} (Sobrepeso)',
        icon: Icons.warning,
      );
    } else {
      return ResultadoIMC(
        message: '$nome, seu IMC é ${imc.toStringAsFixed(2)} (Obesidade)',
        icon: Icons.warning,
      );
    }
  }
}
