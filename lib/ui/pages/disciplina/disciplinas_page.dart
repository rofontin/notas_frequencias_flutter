import 'package:flutter/material.dart';
import 'package:notas_frequencia_flutter/datasources/datasources.dart';
import 'package:notas_frequencia_flutter/models/Disciplina.dart';
import 'package:notas_frequencia_flutter/models/Professor.dart';
import 'package:notas_frequencia_flutter/models/Turma.dart';
import 'package:notas_frequencia_flutter/ui/components/mensagem_alerta.dart';
import 'package:notas_frequencia_flutter/ui/pages/disciplina/cadastro_disciplina.dart';

class DisciplinasPage extends StatefulWidget {
  final Turma turma;

  const DisciplinasPage(this.turma, {Key? key}) : super(key: key);

  @override
  State<DisciplinasPage> createState() => _DisciplinasPageState();
}

class _DisciplinasPageState extends State<DisciplinasPage> {
  final _disciplinaHelper = DisciplinaHelper();
  final _professorHelper = ProfessorHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.turma.nome + " - Disciplinas"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: _cadastrarDisciplina,
      ),
      body: FutureBuilder(
        future: _disciplinaHelper.getByTurma(widget.turma.registro ?? 0),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            default:
              if (snapshot.hasError) {
                return Text('Erro:' '${snapshot.error}');
              }
              return _criarLista(snapshot.data as List<Disciplina>);
          }
        },
      ),
    );
  }

  void _cadastrarDisciplina({Disciplina? disciplina}) async {
    Professor? professor;
    if (disciplina != null) {
      professor =
          await _professorHelper.findProfessor(disciplina.registroProfessor);
    }

    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CadastroDisciplinaPage(
                  widget.turma,
                  disciplina: disciplina,
                  professor: professor,
                )));

    setState(() {});
  }

  Widget _criarLista(List<Disciplina> disciplinas) {
    return ListView.builder(
        padding: const EdgeInsets.all(4),
        itemCount: disciplinas.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.horizontal,
            child: _criarItemLista(disciplinas[index]),
            background: Container(
                alignment: const Alignment(-1, 0),
                color: Colors.blue,
                child: const Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Icon(
                    Icons.drive_file_rename_outline_rounded,
                    size: 40,
                  ),
                )),
            secondaryBackground: Container(
              alignment: const Alignment(1, 0),
              color: Colors.red,
              child: const Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: Icon(
                  Icons.delete,
                  size: 40,
                ),
              ),
            ),
            onDismissed: (DismissDirection direction) {
              if (direction == DismissDirection.startToEnd) {
                _cadastrarDisciplina(disciplina: disciplinas[index]);
              } else if (direction == DismissDirection.endToStart) {
                _disciplinaHelper.delete(disciplinas[index]);
              }
            },
            confirmDismiss: (DismissDirection direction) async {
              if (direction == DismissDirection.endToStart) {
                return await MensagemAlerta.show(
                    context: context,
                    titulo: 'Atenção',
                    texto: 'Deseja excluir este Disciplina?',
                    botoes: [
                      TextButton(
                          child: const Text('Sim'),
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          }),
                      ElevatedButton(
                          child: const Text('Não'),
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          }),
                    ]);
              }
              return true;
            },
          );
        });
  }

  Widget _criarItemLista(Disciplina disciplina) {
    return GestureDetector(
      child: Card(
        child: Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Icon(Icons.my_library_books, size: 40),
                Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: Column(
                    children: [
                      Text(
                        disciplina.nome,
                        style: const TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "Carga Horária: " +
                            disciplina.cargaHoraria.toString() +
                            " Horas",
                        style: const TextStyle(fontSize: 15),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
