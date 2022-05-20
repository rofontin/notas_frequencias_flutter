import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notas_frequencia_flutter/datasources/datasources.dart';
import 'package:notas_frequencia_flutter/models/Aluno.dart';
import 'package:notas_frequencia_flutter/models/Turma.dart';
import 'package:notas_frequencia_flutter/ui/components/mensagem_alerta.dart';
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
        title: Text(widget.turma.nome+" - Alunos"),
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
          return Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.horizontal,
            child: _criarItemLista(alunos[index]),
            background: Container(
              alignment: const Alignment(-1, 0),
              color: Colors.blue,
              child: const Padding(padding: EdgeInsets.only(left: 20.0),
              child: Icon(
                Icons.drive_file_rename_outline_rounded,size: 40,
              ),)
            ),
            secondaryBackground: Container(
              alignment: const Alignment(1, 0),
              color: Colors.red,
              child: const Padding(padding: EdgeInsets.only(right: 20.0),
                child: Icon(
                  Icons.delete,size: 40,
                ),),
            ),
            onDismissed: (DismissDirection direction) {
              if (direction == DismissDirection.startToEnd) {
                _cadastrarAluno(aluno: alunos[index]);
              }
              else if (direction == DismissDirection.endToStart) {
                _alunoHelper.delete(alunos[index]);
              }
            },
            confirmDismiss: (DismissDirection direction) async {
              if (direction == DismissDirection.endToStart) {
                return await MensagemAlerta.show(
                    context: context,
                    titulo: 'Atenção',
                    texto: 'Deseja excluir esta Aluno?',
                    botoes: [
                      TextButton(
                          child: const Text('Sim'),
                          onPressed: (){ Navigator.of(context).pop(true); }
                      ),
                      ElevatedButton(
                          child: const Text('Não'),
                          onPressed: (){ Navigator.of(context).pop(false); }
                      ),
                    ]);
              }
              return true;
            },
          );
        }
    );
  }

  Widget _criarItemLista(Aluno aluno) {
    return GestureDetector(
      child: Card(
        child: Container(
            padding: const EdgeInsets.all(16),
            child:Row(
              children: [
                const Icon(Icons.account_circle_outlined,size: 40),
                Padding(padding: const EdgeInsets.only(left: 50),
                  child: Column(
                    children: [
                      Text(
                        aluno.nome,
                        style: const TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "Data da Matrícula: "+aluno.dataMatricula,
                        style: const TextStyle(fontSize: 15),
                        textAlign: TextAlign.center,
                      )
                    ],

                  ),)
              ],
            )
        ),
      ),
    );
  }
}
