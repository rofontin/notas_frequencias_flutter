import 'package:flutter/material.dart';
import 'package:notas_frequencia_flutter/datasources/datasources.dart';
import 'package:notas_frequencia_flutter/models/Aluno.dart';
import 'package:notas_frequencia_flutter/models/Disciplina.dart';
import 'package:notas_frequencia_flutter/models/NotaFrequencia.dart';
import 'package:notas_frequencia_flutter/models/Turma.dart';
import 'package:notas_frequencia_flutter/ui/components/mensagem_alerta.dart';
import 'package:notas_frequencia_flutter/ui/pages/notafrequencia/cadastro_notafrequencia.dart';

class NotaFrequenciaPage extends StatefulWidget {
  final Turma turma;
  final Aluno aluno;

  const NotaFrequenciaPage(this.turma, this.aluno, {Key? key})
      : super(key: key);

  @override
  State<NotaFrequenciaPage> createState() => _NotaFrequenciaPageState();
}

class _NotaFrequenciaPageState extends State<NotaFrequenciaPage> {
  final _notaFrequenciaHelper = NotaFrequenciaHelper();
  final _disciplinaHelper = DisciplinaHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notas e Frequência - " + widget.aluno.nome),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: _cadastrarNotaFrequencia,
      ),
      body: FutureBuilder(
        future: _notaFrequenciaHelper.getByTurmaAndAluno(
            widget.turma.registro!, widget.aluno.ra!),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            default:
              if (snapshot.hasError) {
                return Text('Erro:' '${snapshot.error}');
              }
              return _criarLista(snapshot.data as List<NotaFrequencia>);
          }
        },
      ),
    );
  }

  void _cadastrarNotaFrequencia({NotaFrequencia? notaFrequencia}) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CadastroNotaFrequenciaPage(
                  widget.turma,
                  widget.aluno,
                  notaFrequencia: notaFrequencia,
                )));

    setState(() {});
  }

  Widget _criarLista(List<NotaFrequencia> notaFrequencias) {
    return ListView.builder(
        padding: const EdgeInsets.all(4),
        itemCount: notaFrequencias.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.horizontal,
            child: _criarItemLista(notaFrequencias[index]),
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
                _cadastrarNotaFrequencia(
                    notaFrequencia: notaFrequencias[index]);
              } else if (direction == DismissDirection.endToStart) {
                _notaFrequenciaHelper.delete(notaFrequencias[index].registro!);
              }
            },
            confirmDismiss: (DismissDirection direction) async {
              if (direction == DismissDirection.endToStart) {
                return await MensagemAlerta.show(
                    context: context,
                    titulo: 'Atenção',
                    texto: 'Deseja excluir este registro?',
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

  Widget _criarItemLista(NotaFrequencia notaFrequencia) {
    return FutureBuilder(
      future:
          _disciplinaHelper.findDisciplina(notaFrequencia.registroDisciplina),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const CircularProgressIndicator();
          default:
            if (snapshot.hasError) {
              return Text('Erro:' '${snapshot.error}');
            }
            return GestureDetector(
              child: Card(
                child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        const Icon(Icons.note, size: 40),
                        Padding(
                          padding: const EdgeInsets.only(left: 50),
                          child: Column(
                            children: [
                              Text(
                                "Disciplina: " +
                                    ((snapshot.data) as Disciplina).nome,
                                style: const TextStyle(fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                _getResultado(notaFrequencia,
                                    snapshot.data as Disciplina),
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
      },
    );
  }

  String _getResultado(NotaFrequencia notaFrequencia, Disciplina disciplina) {
    double nota = notaFrequencia.nota;
    double frequencia = notaFrequencia.frequencia;
    int cargaHoraria = disciplina.cargaHoraria;
    double frequenciaFinal = ((frequencia * 100) / cargaHoraria);

    String resultado = "\nNota: $nota \nFrequência: $frequenciaFinal%";
    if (nota >= 70.0 && frequenciaFinal >= 30.0) {
      return "Aprovado" + resultado;
    } else if (nota < 70.0) {
      return "Reprovado por nota." + resultado;
    } else if (frequenciaFinal < 30.0) {
      return "Reprovado por frequência." + resultado;
    }
    return "";
  }
}
