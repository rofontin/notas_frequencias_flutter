import 'package:notas_frequencia_flutter/datasources/local/TurmaHelper.dart';
import 'package:notas_frequencia_flutter/datasources/local/banco_dados.dart';
import 'package:notas_frequencia_flutter/models/Professor.dart';
import 'package:notas_frequencia_flutter/models/Turma.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/utils/utils.dart';

const sqlCreateProfessor = ''' CREATE TABLE $professorTabela (
    $professorRegistro INTEGER PRIMARY KEY AUTOINCREMENT,
    $professorNome TEXT,
    $professorCpf TEXT,
    $professorDataNasc TEXT,
    $professorDataAdesao TEXT,
    FOREIGN KEY($professorTurma) REFERENCES $turmaTabela($turmaRegistro)
    ) ''';

class ProfessorHelper {
  Future<Professor> inserir(Professor professor) async {
    Database db = await BancoDados().db;
    professor.registro = await db.insert(professorTabela, professor.toMap());
    return professor;
  }

  Future<int> alterar(Professor professor) async {
    Database db = await BancoDados().db;
    return db.update(professorTabela, professor.toMap(),
        where: '$professorRegistro = ?', whereArgs: [professor.registro]);
  }

  Future<int> delete(int registro) async {
    Database db = await BancoDados().db;
    return db.delete(professorTabela,
        where: '$professorRegistro = ?', whereArgs: [registro]);
  }

  Future<Professor?> findProfessor(int registro) async {
    Database db = await BancoDados().db;

    List dados = await db.query(professorTabela,
        where: '$professorRegistro = ?', whereArgs: [registro]);

    if (dados.isNotEmpty) {
      int registroTurma = int.parse(dados.first[professorTurma].toString());
      Turma turma = (await TurmaHelper().findTurma(registroTurma))!;
      return Professor.fromMap(dados.first, turma);
    }

    return null;
  }

  Future<int> findTotal() async {
    Database db = await BancoDados().db;

    return firstIntValue(
            await db.rawQuery('SELECT COUNT(*) FROM $professorTabela')) ??
        0;
  }

  Future<List<Professor>> getByTurma(int registroTurma) async {
    Turma? turma = await TurmaHelper().findTurma(registroTurma);

    if (turma != null) {
      Database db = await BancoDados().db;

      List dados = await db.query(professorTabela,
          where: '$professorTurma = ?',
          whereArgs: [registroTurma],
          orderBy: professorNome);
      return dados.map((e) => Professor.fromMap(e, turma)).toList();
    }

    return [];
  }
}
