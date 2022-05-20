import 'package:flutter/material.dart';
import 'package:notas_frequencia_flutter/datasources/datasources.dart';
import 'package:notas_frequencia_flutter/models/Professor.dart';
import 'package:notas_frequencia_flutter/models/Turma.dart';
import 'package:notas_frequencia_flutter/ui/components/mensagem_alerta.dart';
import 'package:notas_frequencia_flutter/ui/pages/professor/cadastro_professor_page.dart';

class ProfessoresPage extends StatefulWidget {
  final Turma turma;

  const ProfessoresPage({Key? key, required this.turma}) : super(key: key);

  @override
  State<ProfessoresPage> createState() => _ProfessoresPageState();
}

class _ProfessoresPageState extends State<ProfessoresPage> {
  final _professorHelper = ProfessorHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.turma.nome+" - Professores"),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: _cadastrarProfessor
      ),
      body: FutureBuilder(
          future: _professorHelper.getByTurma(widget.turma.registro ?? 0),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return const CircularProgressIndicator();
              default:
                if (snapshot.hasError) {
                  return Text('Erro:' '${snapshot.error}');
                }
                return _criarLista(snapshot.data as List<Professor>);
            }
          }),
    );
  }
  void _cadastrarProfessor({Professor? professor}) async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => CadastroProfessorPage(professor: professor, turma: widget.turma,)));

    setState(() {});
  }
  Widget _criarLista(List<Professor> professor) {
    return ListView.builder(
        padding: const EdgeInsets.all(4),
        itemCount: professor.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.horizontal,
            child: _criarItemLista(professor[index]),
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
                _cadastrarProfessor(professor: professor[index]);
              }
              else if (direction == DismissDirection.endToStart) {
                _professorHelper.delete(professor[index]);
              }
            },
            confirmDismiss: (DismissDirection direction) async {
              if (direction == DismissDirection.endToStart) {
                return await MensagemAlerta.show(
                    context: context,
                    titulo: 'Atenção',
                    texto: 'Deseja excluir este professor?',
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

  Widget _criarItemLista(Professor professor) {
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
                      professor.nome,
                      style: const TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "Data de Adesão: "+professor.dataAdesao,
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
