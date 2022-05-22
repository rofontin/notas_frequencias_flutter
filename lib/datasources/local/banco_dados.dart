import 'package:notas_frequencia_flutter/datasources/datasources.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class BancoDados {
  static const String _nomeBanco = 'nota_frequencia.db';
  static final BancoDados _instancia = BancoDados.internal();

  factory BancoDados() => _instancia;

  BancoDados.internal();

  Database? _db;

  Future<Database> get db async {
    _db ??= await initDb();
    return _db!;
  }

  Future<Database> initDb() async {
    final path = await getDatabasesPath();
    final pathDb = join(path, _nomeBanco);

    return await openDatabase(pathDb, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(sqlCreateTurma);
      await db.execute(sqlCreateAluno);
      await db.execute(sqlCreateProfessor);
      await db.execute(sqlCreateDisciplina);
      await db.execute(sqlCreateNotaFrequencia);
    });
  }

  void close() async {
    Database meuDb = await db;
    meuDb.close();
  }
}
