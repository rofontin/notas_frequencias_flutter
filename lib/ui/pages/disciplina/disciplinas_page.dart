import 'package:flutter/material.dart';
import 'package:notas_frequencia_flutter/datasources/datasources.dart';
import 'package:notas_frequencia_flutter/models/Aluno.dart';
import 'package:notas_frequencia_flutter/models/Disciplina.dart';
import 'package:notas_frequencia_flutter/models/Turma.dart';
import 'package:notas_frequencia_flutter/ui/pages/aluno/cadastro_aluno_page.dart';
import 'package:notas_frequencia_flutter/ui/pages/disciplina/cadastro_disciplina.dart';

class DisciplinasPage extends StatefulWidget {
  final Turma turma;

  const DisciplinasPage(this.turma, {Key? key}) : super(key: key);

  @override
  State<DisciplinasPage> createState() => _DisciplinasPageState();
}

class _DisciplinasPageState extends State<DisciplinasPage> {
  final _disciplinaHelper = DisciplinaHelper();

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
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CadastroDisciplinaPage(
                  widget.turma,
                  disciplina: disciplina,
                )));

    setState(() {});
  }

  Widget _criarLista(List<Disciplina> disciplinas) {
    return ListView.builder(
        padding: const EdgeInsets.all(4),
        itemCount: disciplinas.length,
        itemBuilder: (context, index) {
          return _criarItemLista(disciplinas[index]);
        });
  }

  Widget _criarItemLista(Disciplina disciplinas) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            disciplinas.nome,
            style: const TextStyle(fontSize: 28),
          ),
        ),
      ),
      onTap: () => _cadastrarDisciplina(disciplina: disciplinas),
    );
  }
}
