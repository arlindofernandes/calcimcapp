import 'package:calcimcapp/model/imc.dart';
import 'package:calcimcapp/repository/sqlitedatabase.dart';

class ImcRepository {
  Future<List<ImcModel>> obterDados(int id) async {
    List<ImcModel> imcs = [];
    var db = await SQLiteDataBase().obterDataBase();
    var result = await db
        .rawQuery('SELECT * FROM Historico_IMC WHERE UsuarioID = ?', [id]);
    for (var element in result) {
      imcs.add(ImcModel.fromMap(element));
    }
    return imcs;
  }

  Future<void> salvar(ImcModel imcModel) async {
    var db = await SQLiteDataBase().obterDataBase();
    await db.insert('Historico_IMC', imcModel.toMap());
  }

  Future<void> atualizar(ImcModel imcModel) async {
    var db = await SQLiteDataBase().obterDataBase();
    await db.rawInsert(
        'UPDATE Historico_IMC SET altura = ?, peso = ? WHERE id = ?',
        [imcModel.altura, imcModel.peso, imcModel.id]);
  }

  Future<void> remover(int id) async {
    var db = await SQLiteDataBase().obterDataBase();
    await db.rawInsert('DELETE FROM Historico_IMC WHERE id = ?', [id]);
  }
}
