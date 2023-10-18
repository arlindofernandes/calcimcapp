import 'package:calcimcapp/model/usuario_model.dart';
import 'package:calcimcapp/repository/sqlitedatabase.dart';

class UsuarioRepository {
  Future<Usuario> getUsuario() async {
    var db = await SQLiteDataBase().obterDataBase();
    var result = await db.rawQuery('SELECT * FROM Usuarios');
    if (result.isNotEmpty) {
      return Usuario.fromMap(result.first);
    } else {
      Usuario usuario = Usuario(id: 1, nome: '', altura: 0.0, peso: 0.0);
      await db.insert('Usuarios', usuario.toMap());
      return usuario;
    }
  }

  Future<void> updateUsuario(Usuario usuario) async {
    var db = await SQLiteDataBase().obterDataBase();
    db.rawInsert(
        'UPDATE Usuarios SET nome = ?, altura = ? , peso = ? WHERE id = ?',
        [usuario.nome, usuario.altura, usuario.peso, usuario.id]);
  }
  Future<void> updatePeso(Usuario usuario) async {
    var db = await SQLiteDataBase().obterDataBase();
    db.rawInsert(
        'UPDATE Usuarios SET  peso = ? WHERE id = ?',
        [ usuario.peso, usuario.id]);
  }
}
