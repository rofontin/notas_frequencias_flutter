import 'package:notas_frequencia_flutter/datasources/local/banco_dados.dart';
import 'package:notas_frequencia_flutter/models/Turma.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/utils/utils.dart';

const sqlCreateTurma = ''' CREATE TABLE $turmaTabela (
    $turmaRegistro INTEGER PRIMARY KEY AUTOINCREMENT,
    $turmaNome TEXT,
    $turmaDataInicio TEXT,
    $turmaDataTermino TEXT
    ) ''';

class TurmaHelper {
  Future<Turma> inserir(Turma turma) async {
    Database db = await BancoDados().db;
    turma.registro = await db.insert(turmaTabela, turma.toMap());
    return turma;
  }

  Future<int> alterar(Turma turma) async {
    Database db = await BancoDados().db;
    return db.update(turmaTabela, turma.toMap(),
        where: '$turmaRegistro = ?', whereArgs: [turma.registro]);
  }

  Future<int> delete(int registro) async {
    Database db = await BancoDados().db;
    return db.delete(turmaTabela,
        where: '$turmaRegistro = ?', whereArgs: [registro]);
  }

  Future<Turma?> findTurma(int registro) async {
    Database db = await BancoDados().db;

    List dados = await db.query(turmaTabela,
        columns: [turmaRegistro, turmaNome, turmaDataInicio, turmaDataTermino],
        where: '$turmaRegistro = ?',
        whereArgs: [registro]);

    if (dados.isNotEmpty) {
      return Turma.fromMap(dados.first);
    }

    return null;
  }

  Future<int> findTotal() async {
    Database db = await BancoDados().db;

    return firstIntValue(
            await db.rawQuery('SELECT COUNT(*) FROM $turmaTabela')) ??
        0;
  }

  Future<List<Turma>> findAll() async {
    Database db = await BancoDados().db;
    List lista = await db.rawQuery('SELECT * FROM $turmaTabela');

    return lista.map((e) => Turma.fromMap(e)).toList();
  }
}
