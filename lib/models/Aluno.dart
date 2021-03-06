import 'package:notas_frequencia_flutter/models/Turma.dart';

const alunoTabela = 'tbAluno';
const alunoRa = 'ra';
const alunoNome = 'nome';
const alunoCpf = 'cpf';
const alunoDataNasc = 'dataNascimento';
const alunoDataMatri = 'dataMatricula';
const alunoTurma = 'turma';

class Aluno {
  int? ra;
  String nome;
  String cpf;
  String dataNascimento;
  String dataMatricula;
  Turma turma;

  Aluno(
      {this.ra,
      required this.nome,
      required this.cpf,
      required this.dataNascimento,
      required this.dataMatricula,
      required this.turma});

  factory Aluno.fromMap(Map map, Turma turma) {
    return Aluno(
        nome: map[alunoNome],
        ra: int.tryParse(map[alunoRa].toString()),
        cpf: map[alunoCpf],
        dataNascimento: map[alunoDataNasc],
        dataMatricula: map[alunoDataMatri],
        turma: turma);
  }

  Map<String, dynamic> toMap() {
    return {
      alunoRa: ra,
      alunoNome: nome,
      alunoCpf: cpf,
      alunoDataNasc: dataNascimento,
      alunoDataMatri: dataMatricula,
      alunoTurma: turma.registro
    };
  }
}
