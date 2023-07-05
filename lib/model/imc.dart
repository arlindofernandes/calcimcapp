import 'package:flutter/material.dart';

class Imc {
  final String _id = UniqueKey().toString();
  double _peso;
  double _altura;

  String getId() {
    return _id;
  }

  String get id => _id;

  Imc(this._peso, this._altura);

  double get peso => _peso;

  double get altura => _altura;

  set peso(double peso) {
    _peso = peso;
  }

  set altura(double altura) {
    _altura = altura;
  }

  double calculaIMC() {
    return peso / (altura * 2);
  }
}
