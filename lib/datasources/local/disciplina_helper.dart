import 'package:notas_frequencia_flutter/datasources/local/banco_dados.dart';
import 'package:notas_frequencia_flutter/models/Disciplina.dart';
import 'package:notas_frequencia_flutter/models/Professor.dart';
import 'package:notas_frequencia_flutter/models/Turma.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/utils/utils.dart';

const sqlCreateDisciplina = ''' CREATE TABLE $disciplinaTabela (
    $disciplinaRegistro INTEGER PRIMARY KEY AUTOINCREMENT,
    $disciplinaNome TEXT,
    $disciplinaCargaHoraria TEXT,
    $disciplinaTurma INTEGER,
    $disciplinaProfessor INTEGER,
    FOREIGN KEY($disciplinaTurma) REFERENCES $turmaTabela($turmaRegistro),
    FOREIGN KEY($disciplinaProfessor) REFERENCES $professorTabela($professorRegistro)
    ) ''';

class DisciplinaHelper {
  Future<Disciplina> inserir(Disciplina disciplina) async {
    Database db = await BancoDados().db;
    disciplina.registro = await db.insert(disciplinaTabela, disciplina.toMap());
    return disciplina;
  }

  Future<int> alterar(Disciplina disciplina) async {
    Database db = await BancoDados().db;
    return db.update(disciplinaTabela, disciplina.toMap(),
        where: '$disciplinaRegistro = ?', whereArgs: [disciplina.registro]);
  }

  Future<int> delete(Disciplina disciplina) async {
    Database db = await BancoDados().db;
    return db.delete(disciplinaTabela,
        where: '$disciplinaRegistro = ?', whereArgs: [disciplina.registro]);
  }

  Future<Disciplina?> findDisciplina(int registro) async {
    Database db = await BancoDados().db;
    List dados = await db.query(disciplinaTabela,
        where: '$disciplinaRegistro = ?', whereArgs: [registro]);

    if (dados.isNotEmpty) {
      return Disciplina.fromMap(dados.first);
    }
    return null;
  }

  Future<int> findTotal() async {
    Database db = await BancoDados().db;

    return firstIntValue(
            await db.rawQuery('SELECT COUNT(*) FROM $disciplinaTabela')) ??
        0;
  }

  Future<List<Disciplina>> getByTurma(int registroTurma) async {
    Database db = await BancoDados().db;

    List dados = await db.query(disciplinaTabela,
        where: '$disciplinaTurma = ?',
        whereArgs: [registroTurma],
        orderBy: disciplinaNome);
    return dados.map((e) => Disciplina.fromMap(e)).toList();
  }
}
