import 'package:notas_frequencia_flutter/datasources/local/banco_dados.dart';
import 'package:notas_frequencia_flutter/models/Aluno.dart';
import 'package:notas_frequencia_flutter/models/Disciplina.dart';
import 'package:notas_frequencia_flutter/models/NotaFrequencia.dart';
import 'package:notas_frequencia_flutter/models/Turma.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/utils/utils.dart';

const sqlCreateNotaFrequencia = ''' CREATE TABLE $notaFrequenciaTabela (
    $notaFrequenciaRegistro INTEGER PRIMARY KEY AUTOINCREMENT,
    $notaFrequenciaNota INTEGER(10,2),
    $notaFrequenciaFreq INTEGER(10,2),
    $notaFrequenciaAluno INTEGER,
    $notaFrequenciaDisciplina INTEGER,
    $notaFrequenciaTurma INTEGER,
    FOREIGN KEY($notaFrequenciaTurma) REFERENCES $turmaTabela($turmaRegistro),
    FOREIGN KEY($notaFrequenciaAluno) REFERENCES $alunoTabela($alunoRa),
    FOREIGN KEY($notaFrequenciaDisciplina) REFERENCES $disciplinaTabela($disciplinaRegistro)
    ) ''';

class NotaFrequenciaHelper {
  Future<NotaFrequencia> inserir(NotaFrequencia notaFrequencia) async {
    Database db = await BancoDados().db;
    notaFrequencia.registro =
        await db.insert(notaFrequenciaTabela, notaFrequencia.toMap());
    return notaFrequencia;
  }

  Future<int> alterar(NotaFrequencia notaFrequencia) async {
    Database db = await BancoDados().db;
    return db.update(notaFrequenciaTabela, notaFrequencia.toMap(),
        where: '$notaFrequenciaRegistro = ?',
        whereArgs: [notaFrequencia.registro]);
  }

  Future<int> delete(int registro) async {
    Database db = await BancoDados().db;
    return db.delete(notaFrequenciaTabela,
        where: '$notaFrequenciaRegistro = ?', whereArgs: [registro]);
  }

  Future<NotaFrequencia?> findNotaFrequencia(int registro) async {
    Database db = await BancoDados().db;
    List dados = await db.query(notaFrequenciaTabela,
        where: '$notaFrequenciaRegistro = ?', whereArgs: [registro]);

    if (dados.isNotEmpty) {
      return NotaFrequencia.fromMap(dados.first);
    }
    return null;
  }

  Future<int> findTotal() async {
    Database db = await BancoDados().db;

    return firstIntValue(
            await db.rawQuery('SELECT COUNT(*) FROM $notaFrequenciaTabela')) ??
        0;
  }

  Future<List<NotaFrequencia>> getByTurma(int registroTurma) async {
    Database db = await BancoDados().db;

    List dados = await db.query(notaFrequenciaTabela,
        where: '$notaFrequenciaTurma = ?',
        whereArgs: [registroTurma],
        orderBy: notaFrequenciaRegistro);

    return dados.map((e) => NotaFrequencia.fromMap(e)).toList();
  }

  Future<List<NotaFrequencia>> getByTurmaAndAluno(int registroTurma, int registroAluno) async {
    Database db = await BancoDados().db;

    List dados = await db.query(notaFrequenciaTabela,
        where: '$notaFrequenciaTurma = ? and $notaFrequenciaAluno = ?',
        whereArgs: [registroTurma, registroAluno],
        orderBy: notaFrequenciaRegistro);

    return dados.map((e) => NotaFrequencia.fromMap(e)).toList();
  }

  Future<List<NotaFrequencia>> findAll() async {
    Database db = await BancoDados().db;
    List lista = await db.rawQuery('SELECT * FROM $notaFrequenciaTabela');

    return lista.map((e) => NotaFrequencia.fromMap(e)).toList();
  }
}
