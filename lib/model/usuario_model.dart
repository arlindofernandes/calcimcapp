class Usuario {
  int id = 0;
  String nome = '';
  double altura = 0;
  double? peso = 0;

  Usuario.vazio();
  Usuario(
      {required this.id, required this.nome, required this.altura, this.peso});

  Map<String, dynamic> toMap() {
    return {
      'ID': id,
      'Nome': nome,
      'Altura': altura,
      'Peso': peso,
    };
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      id: map['ID'],
      nome: map['Nome'],
      altura: map['Altura'],
      peso: map['Peso'],
    );
  }
}
