import 'package:flutter/material.dart';
import 'package:notas_frequencia_flutter/datasources/datasources.dart';
import 'package:notas_frequencia_flutter/models/Aluno.dart';
import 'package:notas_frequencia_flutter/models/Turma.dart';
import 'package:notas_frequencia_flutter/ui/pages/aluno/cadastro_aluno_page.dart';

class AlunosPage extends StatefulWidget {
  final Turma turma;

  const AlunosPage(this.turma, {Key? key}) : super(key: key);

  @override
  State<AlunosPage> createState() => _AlunosPageState();
}

class _AlunosPageState extends State<AlunosPage> {
  final _alunoHelper = AlunoHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.turma.nome),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: _cadastrarAluno,
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

  void _cadastrarAluno({Aluno? aluno}) async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => CadastroAlunoPage(widget.turma, aluno: aluno,)));

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
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            aluno.nome,
            style: const TextStyle(fontSize: 28),
          ),
        ),
      ),
      onTap: () => _cadastrarAluno(aluno: aluno),
    );
  }
}
