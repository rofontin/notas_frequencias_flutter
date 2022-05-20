import 'package:flutter/material.dart';
import 'package:notas_frequencia_flutter/datasources/datasources.dart';
import 'package:notas_frequencia_flutter/models/Turma.dart';
import 'package:notas_frequencia_flutter/ui/components/mensagem_alerta.dart';
import 'package:notas_frequencia_flutter/ui/pages/pages.dart';
import 'package:notas_frequencia_flutter/ui/pages/turma/cadastro_turma_page.dart';

class TurmasPage extends StatefulWidget {
  const TurmasPage({Key? key}) : super(key: key);

  @override
  State<TurmasPage> createState() => _TurmasPageState();
}

class _TurmasPageState extends State<TurmasPage> {
  final _turmaHelper = TurmaHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Turmas'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: _abrirTelaCadastro,
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

  Widget _criarLista(List<Turma> turmas) {
    return ListView.builder(
        padding: const EdgeInsets.all(4),
        itemCount: turmas.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.horizontal,
            child: _criarItemLista(turmas[index]),
            background: Container(
              alignment: const Alignment(-1, 0),
              color: Colors.blue,
              child: const Text('Editar Turma',
                style: TextStyle(color: Colors.white),),
            ),
            secondaryBackground: Container(
              alignment: const Alignment(1, 0),
              color: Colors.red,
              child: const Text('Excluir Turma',
                style: TextStyle(color: Colors.white),),
            ),
            onDismissed: (DismissDirection direction) {
              if (direction == DismissDirection.startToEnd) {
                _abrirTelaCadastro(turma: turmas[index]);
              }
              else if (direction == DismissDirection.endToStart) {
                _turmaHelper.delete(turmas[index]);
              }
            },
            confirmDismiss: (DismissDirection direction) async {
              if (direction == DismissDirection.endToStart) {
                return await MensagemAlerta.show(
                    context: context,
                    titulo: 'Atenção',
                    texto: 'Deseja excluir este turma?',
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

  Widget _criarItemLista(Turma turma) {
    return GestureDetector(
      child: Card(
        child: Container(
            padding: const EdgeInsets.all(16),
            child:Row(
              children: [
                const Icon(Icons.school,size: 40),
                Padding(padding: const EdgeInsets.only(left: 50),
                  child: Column(
                    children: [
                      Text(
                        turma.nome,
                        style: const TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "Data Término: "+turma.dataTermino  ,
                        style: const TextStyle(fontSize: 15),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),)

              ],
            )
        ),
      ),
      onTap: () => _abrirPaginaTurma(turma),
      onLongPress: () => _abrirTelaCadastro(turma: turma),
    );
  }

  void _abrirTelaCadastro({Turma? turma}) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CadastroTurmaPage(turma: turma)));

    setState(() {});
  }

  void _abrirPaginaTurma(Turma turma) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RelacionadosTurmaPage(turma)));
  }
}
