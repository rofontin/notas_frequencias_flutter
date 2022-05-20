import 'package:flutter/material.dart';
import 'package:notas_frequencia_flutter/datasources/datasources.dart';
import 'package:notas_frequencia_flutter/models/Turma.dart';
import 'package:notas_frequencia_flutter/ui/pages/notafrequencia/notafrequencia_alunos_page.dart';

class NotaFrequenciaTurmasPage extends StatefulWidget {
  const NotaFrequenciaTurmasPage({Key? key}) : super(key: key);

  @override
  State<NotaFrequenciaTurmasPage> createState() =>
      _NotaFrequenciaTurmasPageState();
}

class _NotaFrequenciaTurmasPageState extends State<NotaFrequenciaTurmasPage> {
  final _turmaHelper = TurmaHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notas e frequências - Turmas"),
      ),
      body: FutureBuilder(
        future: _turmaHelper.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            default:
              if (snapshot.hasError) {
                return Text('Erro:' '${snapshot.error}');
              }
              return _criarLista(snapshot.data as List<Turma>);
          }
        },
      ),
    );
  }

  void _abrirTelaNotasPorTurma(Turma turma) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NotaFrequenciaAlunosPage(turma)));

    setState(() {});
  }

  Widget _criarLista(List<Turma> turmas) {
    return ListView.builder(
        padding: const EdgeInsets.all(4),
        itemCount: turmas.length,
        itemBuilder: (context, index) {
          return _criarItemLista(turmas[index]);
        });
  }

  Widget _criarItemLista(Turma turma) {
    return GestureDetector(
      child: Card(
        child: Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Icon(Icons.school, size: 40),
                Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: Column(
                    children: [
                      Text(
                        turma.nome,
                        style: const TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "Data Término: " + turma.dataTermino,
                        style: const TextStyle(fontSize: 15),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                )
              ],
            )),
      ),
      onTap: () => _abrirTelaNotasPorTurma(turma),
    );
  }
}
