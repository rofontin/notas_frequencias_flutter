import 'package:notas_frequencia_flutter/models/Professor.dart';
import 'package:notas_frequencia_flutter/models/Turma.dart';

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
  Turma turma;
  Professor? professor;

  Disciplina(
      {this.registro,
      required this.nome,
      required this.cargaHoraria,
      required this.turma,
      required this.professor});

  factory Disciplina.fromMap(Map map, Turma turma, {Professor? professor}) {
    return Disciplina(
        nome: map[disciplinaNome],
        registro: int.tryParse(map[disciplinaRegistro].toString()),
        cargaHoraria: int.parse(map[disciplinaCargaHoraria].toString()),
        turma: turma,
        professor: professor);
  }

  Map<String, dynamic> toMap() {
    return {
      disciplinaRegistro: registro,
      disciplinaNome: nome,
      disciplinaCargaHoraria: cargaHoraria,
      disciplinaTurma: turma.registro,
      disciplinaProfessor: professor?.registro
    };
  }
}
