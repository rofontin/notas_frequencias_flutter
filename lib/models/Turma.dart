const turmaTabela = 'tbTurma';
const turmaRegistro = 'registro';
const turmaNome = 'nome';
const turmaDataInicio = 'dataInicio';
const turmaDataTermino = 'dataTermino';

class Turma {
  int? registro;
  String nome;
  String dataInicio;
  String dataTermino;

  Turma(
      {this.registro,
      required this.nome,
      required this.dataInicio,
      required this.dataTermino});

  factory Turma.fromMap(Map map) {
    return Turma(
        nome: map[turmaNome],
        registro: int.tryParse(map[turmaRegistro].toString()),
        dataInicio: map[turmaDataInicio],
        dataTermino: map[turmaDataTermino]);
  }

  Map<String, dynamic> toMap() {
    return {
      turmaRegistro: registro,
      turmaNome: nome,
      turmaDataInicio: dataInicio,
      turmaDataTermino: dataTermino
    };
  }
}
