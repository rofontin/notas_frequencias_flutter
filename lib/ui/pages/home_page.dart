import 'package:flutter/material.dart';
import 'pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
            onTap: _abrirListagemProfessores,
          ),
          ListTile(
            leading: const Icon(Icons.list_outlined),
            title: const Text(
              'Alunos',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 24),
            ),
            onTap: _abrirListagemAlunos,
          ),
          ListTile(
            leading: const Icon(Icons.list_outlined),
            title: const Text(
              'Disciplinas',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 24),
            ),
            onTap: _abrirListagemDisciplinas,
          ),
          ListTile(
            leading: const Icon(Icons.list_outlined),
            title: const Text(
              'Turmas',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 24),
            ),
            onTap: _abrirListagemTurmas,
          ),
        ],
      ),
    );
  }

  void _abrirListagemProfessores() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfessoresPage(),));
  }

  void _abrirListagemAlunos() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const AlunosPage(),));
  }

  void _abrirListagemTurmas() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const TurmasPage(),));
  }

  void _abrirListagemDisciplinas() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const DisciplinasPage(),));
  }
}
