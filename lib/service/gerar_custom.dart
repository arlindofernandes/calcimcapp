import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
      return CircleAvatar(
          backgroundColor: Colors.white, child: Text(imc.round().toString()));
    } else if (imc >= 16 && imc < 17) {
      return const CircleAvatar(backgroundColor: Colors.white, child: Text(''));
    } else if (imc >= 17 && imc < 18.5) {
      return const CircleAvatar(backgroundColor: Colors.white, child: Text(''));
    } else if (imc >= 18.5 && imc < 25) {
      return const CircleAvatar(backgroundColor: Colors.green, child: Text(''));
    } else if (imc >= 25 && imc <= 30) {
      return const CircleAvatar(backgroundColor: Colors.white, child: Text(''));
    } else if (imc >= 30 && imc < 35) {
      return const CircleAvatar(backgroundColor: Colors.white, child: Text(''));
    } else if (imc >= 35 && imc < 40) {
      return CircleAvatar(
          backgroundColor: Colors.white, child: Text(imc.round().toString()));
    } else {
      return CircleAvatar(
          backgroundColor: Colors.red, child: Text(imc.round().toString()));
    }
  }

  static Color backColors(double imc) {
    if (imc < 16) {
      return Colors.blue.shade900;
    } else if (imc >= 16 && imc < 17) {
      return Colors.blue;
    } else if (imc >= 17 && imc < 18.5) {
      return Colors.green.shade300;
    } else if (imc >= 18.5 && imc < 25) {
      return Colors.green;
    } else if (imc >= 25 && imc <= 30) {
      return Colors.yellow;
    } else if (imc >= 30 && imc < 35) {
      return Colors.orange;
    } else if (imc >= 35 && imc < 40) {
      return Colors.orange.shade900;
    } else {
      return Colors.red;
    }
  }

  static String formatarDataHora(DateTime dataHora) {
    var formatador = DateFormat('dd/MM/yyyy');
    return formatador.format(dataHora);
  }
}
