import 'package:notas_frequencia_flutter/datasources/local/TurmaHelper.dart';
import 'package:notas_frequencia_flutter/datasources/local/banco_dados.dart';
import 'package:notas_frequencia_flutter/models/Aluno.dart';
import 'package:notas_frequencia_flutter/models/Turma.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/utils/utils.dart';

const sqlCreateAluno = ''' CREATE TABLE $alunoTabela (
    $alunoRa INTEGER PRIMARY KEY AUTOINCREMENT,
    $alunoNome TEXT,
    $alunoCpf TEXT,
    $alunoDataNasc TEXT,
    $alunoDataMatri TEXT,
    $alunoTurma INTEGER,
    FOREIGN KEY($alunoTurma) REFERENCES $turmaTabela($turmaRegistro)
    ) ''';

class AlunoHelper {
  Future<Aluno> inserir(Aluno aluno) async {
    Database db = await BancoDados().db;
    aluno.ra = await db.insert(alunoTabela, aluno.toMap());
    return aluno;
  }

  Future<int> alterar(Aluno aluno) async {
    Database db = await BancoDados().db;
    return db.update(alunoTabela, aluno.toMap(),
        where: '$alunoRa = ?', whereArgs: [aluno.ra]);
  }

  Future<int> delete(Aluno aluno) async {
    Database db = await BancoDados().db;
    return db.delete(alunoTabela, where: '$alunoRa = ?', whereArgs: [aluno.ra]);
  }

  Future<Aluno?> findAluno(int ra) async {
    Database db = await BancoDados().db;

    List dados =
        await db.query(alunoTabela, where: '$alunoRa = ?', whereArgs: [ra]);

    if (dados.isNotEmpty) {
      int registroTurma = int.parse(dados.first[alunoTurma].toString());
      Turma turma = (await TurmaHelper().findTurma(registroTurma))!;
      return Aluno.fromMap(dados.first, turma);
    }

    return null;
  }

  Future<int> findTotal() async {
    Database db = await BancoDados().db;

    return firstIntValue(
            await db.rawQuery('SELECT COUNT(*) FROM $alunoTabela')) ??
        0;
  }

  Future<List<Aluno>> getByTurma(int registroTurma) async {
    Turma? turma = await TurmaHelper().findTurma(registroTurma);

    if (turma != null) {
      Database db = await BancoDados().db;

      List dados = await db.query(alunoTabela,
          where: '$alunoTurma = ?',
          whereArgs: [registroTurma],
          orderBy: alunoNome);
      return dados.map((e) => Aluno.fromMap(e, turma)).toList();
    }

    return [];
  }
}
