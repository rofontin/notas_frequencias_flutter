import 'package:flutter/material.dart';
import 'package:notas_frequencia_flutter/models/Turma.dart';
import 'package:notas_frequencia_flutter/ui/pages/aluno/alunos_page.dart';
import 'package:notas_frequencia_flutter/ui/pages/pages.dart';

class TurmaPage extends StatefulWidget {
  final Turma turma;

  const TurmaPage(this.turma, {Key? key}) : super(key: key);

  @override
  State<TurmaPage> createState() => _TurmaPageState();
}

class _TurmaPageState extends State<TurmaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Controle notas e frequências'),
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
}
