import 'package:flutter/material.dart';

class GeradorCustonService {
  static String mensagem(double imc) {
    if (imc < 16) {
      return 'Magreza Grave';
    } else if (imc >= 16 && imc < 17) {
      return 'Magreza Moderada';
    } else if (imc >= 17 && imc < 18.5) {
      return 'Magreza Leve';
    } else if (imc >= 18.5 && imc < 25) {
      return 'Saudavel';
    } else if (imc >= 25 && imc <= 30) {
      return 'Sobrepeso';
    } else if (imc >= 30 && imc < 35) {
      return 'Obesidade Grau 1';
    } else if (imc >= 35 && imc < 40) {
      return 'Obesidade Grau 2';
    } else {
      return 'Obesidade Grau 3';
    }
  }

  static CircleAvatar avatar(double imc) {
    if (imc < 16) {
      return const CircleAvatar(backgroundColor: Colors.red, child: Text(''));
    } else if (imc >= 16 && imc < 17) {
      return const CircleAvatar(
          backgroundColor: Colors.orange, child: Text(''));
    } else if (imc >= 17 && imc < 18.5) {
      return const CircleAvatar(
          backgroundColor: Colors.yellow, child: Text(''));
    } else if (imc >= 18.5 && imc < 25) {
      return const CircleAvatar(backgroundColor: Colors.green, child: Text(''));
    } else if (imc >= 25 && imc <= 30) {
      return const CircleAvatar(
          backgroundColor: Colors.yellow, child: Text(''));
    } else if (imc >= 30 && imc < 35) {
      return const CircleAvatar(
          backgroundColor: Colors.orange, child: Text(''));
    } else if (imc >= 35 && imc < 40) {
      return const CircleAvatar(
          backgroundColor: Color.fromARGB(255, 224, 79, 0), child: Text(''));
    } else {
      return const CircleAvatar(backgroundColor: Colors.red, child: Text(''));
    }
  }
}
