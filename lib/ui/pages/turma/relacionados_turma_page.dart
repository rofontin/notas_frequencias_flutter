import 'package:flutter/material.dart';
import 'package:notas_frequencia_flutter/models/Turma.dart';
import 'package:notas_frequencia_flutter/ui/pages/pages.dart';

class RelacionadosTurmaPage extends StatefulWidget {
  final Turma turma;

  const RelacionadosTurmaPage(this.turma, {Key? key}) : super(key: key);

  @override
  State<RelacionadosTurmaPage> createState() => _RelacionadosTurmaPageState();
}

class _RelacionadosTurmaPageState extends State<RelacionadosTurmaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Turma de '+ widget.turma.nome),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.list_outlined),
            title: const Text(
              'Professores',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 24),
            ),
            onTap:() => _abrirListagemProfessores(widget.turma),
          ),
          ListTile(
            leading: const Icon(Icons.list_outlined),
            title: const Text(
              'Alunos',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 24),
            ),
            onTap:() => _abrirListagemAlunos(widget.turma),
          ),
          ListTile(
            leading: const Icon(Icons.list_outlined),
            title: const Text(
              'Disciplinas',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 24),
            ),
            onTap:() => _abrirListagemDisciplinas(widget.turma),
          ),
        ],
      ),
    );
  }

  void _abrirListagemProfessores(Turma turma) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ProfessoresPage(turma: turma,)));
  }

  void _abrirListagemAlunos(Turma turma) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AlunosPage(turma)));
  }

  void _abrirListagemDisciplinas(Turma turma) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => DisciplinasPage(turma)));
  }
}
