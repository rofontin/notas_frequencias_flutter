import 'package:flutter/material.dart';
import 'package:notas_frequencia_flutter/datasources/datasources.dart';
import 'package:notas_frequencia_flutter/models/Aluno.dart';
import 'package:notas_frequencia_flutter/models/Turma.dart';
import 'package:notas_frequencia_flutter/ui/pages/notafrequencia/notafrequencia_page.dart';

class NotaFrequenciaAlunosPage extends StatefulWidget {
  final Turma turma;

  const NotaFrequenciaAlunosPage(this.turma, {Key? key}) : super(key: key);

  @override
  State<NotaFrequenciaAlunosPage> createState() =>
      _NotaFrequenciaAlunosPageState();
}

class _NotaFrequenciaAlunosPageState extends State<NotaFrequenciaAlunosPage> {
  final _alunoHelper = AlunoHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.turma.nome + " - Alunos"),
      ),
      body: FutureBuilder(
        future: _alunoHelper.getByTurma(widget.turma.registro ?? 0),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            default:
              if (snapshot.hasError) {
                return Text('Erro:' '${snapshot.error}');
              }
              return _criarLista(snapshot.data as List<Aluno>);
          }
        },
      ),
    );
  }

  void _abrirTelaNotasPorAluno(Aluno aluno) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NotaFrequenciaPage(widget.turma, aluno)));

    setState(() {});
  }

  Widget _criarLista(List<Aluno> alunos) {
    return ListView.builder(
        padding: const EdgeInsets.all(4),
        itemCount: alunos.length,
        itemBuilder: (context, index) {
          return _criarItemLista(alunos[index]);
        });
  }

  Widget _criarItemLista(Aluno aluno) {
    return GestureDetector(
      child: Card(
        child: Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Icon(Icons.account_circle_outlined, size: 40),
                Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: Column(
                    children: [
                      Text(
                        aluno.nome,
                        style: const TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "Data da Matrícula: " + aluno.dataMatricula,
                        style: const TextStyle(fontSize: 15),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                )
              ],
            )),
      ),
      onTap: () => _abrirTelaNotasPorAluno(aluno),
    );
  }
}
