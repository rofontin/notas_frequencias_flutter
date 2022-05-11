import 'package:notas_frequencia_flutter/models/Professor.dart';

const disciplinaTabela = 'tbDisciplina';
const disciplinaRegistro = 'registro';
const disciplinaNome = 'nome';
const disciplinaCargaHoraria = 'cargaHoraria';
const disciplinaProfessor = 'professor';

class Disciplina {
  int? registro;
  String nome;
  int cargaHoraria;
  Professor professor;

  Disciplina(
      {this.registro,
      required this.nome,
      required this.cargaHoraria,
      required this.professor});

  factory Disciplina.fromMap(Map map, Professor professor) {
    return Disciplina(
        nome: map[disciplinaNome],
        registro: int.tryParse(map[disciplinaRegistro].toString()),
        cargaHoraria: int.parse(map[disciplinaCargaHoraria].toString()),
        professor: professor);
  }

  Map<String, dynamic> toMap() {
    return {
      disciplinaRegistro: registro,
      disciplinaNome: nome,
      disciplinaCargaHoraria: cargaHoraria,
      disciplinaProfessor: professor.registro
    };
  }
}
