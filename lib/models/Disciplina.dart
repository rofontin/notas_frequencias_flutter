const disciplinaTabela = 'tbDisciplina';
const disciplinaRegistro = 'registro';
const disciplinaNome = 'nome';
const disciplinaCargaHoraria = 'cargaHoraria';
const disciplinaTurma = 'turma';
const disciplinaProfessor = 'professor';

class Disciplina {
  int? registro;
  String nome;
  int cargaHoraria;
  int registroTurma;
  int registroProfessor;

  Disciplina(
      {this.registro,
      required this.nome,
      required this.cargaHoraria,
      required this.registroTurma,
      required this.registroProfessor});

  factory Disciplina.fromMap(Map map) {
    return Disciplina(
        nome: map[disciplinaNome],
        registro: int.tryParse(map[disciplinaRegistro].toString()),
        cargaHoraria: int.parse(map[disciplinaCargaHoraria].toString()),
        registroTurma: int.parse(map[disciplinaTurma].toString()),
        registroProfessor: int.parse(map[disciplinaProfessor].toString()));
  }

  Map<String, dynamic> toMap() {
    return {
      disciplinaRegistro: registro,
      disciplinaNome: nome,
      disciplinaCargaHoraria: cargaHoraria,
      disciplinaTurma: registroTurma,
      disciplinaProfessor: registroProfessor
    };
  }
}
