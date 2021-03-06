import 'package:notas_frequencia_flutter/models/Turma.dart';

const professorTabela = 'tbProfessor';
const professorRegistro = 'registro';
const professorNome = 'nome';
const professorCpf = 'cpf';
const professorDataNasc = 'dataNascimento';
const professorDataAdesao = 'dataAdesao';
const professorTurma = 'turma';

class Professor {
  int? registro;
  String nome;
  String cpf;
  String dataNascimento;
  String dataAdesao;
  Turma turma;

  Professor(
      {this.registro,
      required this.nome,
      required this.cpf,
      required this.dataNascimento,
      required this.dataAdesao,
      required this.turma});

  factory Professor.fromMap(Map map, Turma turma) {
    return Professor(
        nome: map[turmaNome],
        registro: int.tryParse(map[professorRegistro].toString()),
        cpf: map[professorCpf],
        dataNascimento: map[professorDataNasc],
        dataAdesao: map[professorDataAdesao],
        turma: turma);
  }

  Map<String, dynamic> toMap() {
    return {
      professorRegistro: registro,
      professorCpf: cpf,
      professorNome: nome,
      professorDataNasc: dataNascimento,
      professorDataAdesao: dataAdesao,
      professorTurma: turma.registro
    };
  }
}
