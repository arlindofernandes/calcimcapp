import 'package:calcimcapp/model/imc.dart';

class ImcRepository {
  final List<Imc> _imcs = [];

  Future<void> adicionat(Imc imc) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _imcs.add(imc);
  }

  Future<void> alterar(String id, double peso, double altura) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _imcs.where((imc) => imc.id == id).first.altura = altura;
    _imcs.where((imc) => imc.id == id).first.peso = peso;
    
  }

  Future<void> remove(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _imcs.remove(_imcs.where((tarefa) => tarefa.id == id).first);
  }

  Future<List<Imc>> listar() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _imcs;
  }

}
