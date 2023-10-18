class ImcModel {
  int id = 0;
  int usuarioId = 1;
  DateTime dataRegistro = DateTime.now();
  double altura = 0.0;
  double peso = 0.0;
  double imc = 0.0;

  ImcModel.vazio();

  ImcModel({
    required this.id,
    required this.usuarioId,
    required this.dataRegistro,
    required this.altura,
    required this.peso,
    required this.imc,
  });

  Map<String, dynamic> toMap() {
    return {
      'UsuarioID': usuarioId,
      'DataRegistro': dataRegistro.toIso8601String(),
      'Altura': altura,
      'Peso': peso,
      'IMC': imc,
    };
  }

  factory ImcModel.fromMap(Map<String, dynamic> map) {
    return ImcModel(
      id: map['ID'],
      usuarioId: map['UsuarioID'],
      dataRegistro: DateTime.parse(map['DataRegistro']),
      altura: map['Altura'],
      peso: map['Peso'],
      imc: map['IMC'],
    );
  }
}
