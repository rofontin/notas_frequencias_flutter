import 'package:flutter/material.dart';
import 'package:notas_frequencia_flutter/ui/pages/notafrequencia/notafrequencia_page.dart';
import 'package:notas_frequencia_flutter/ui/pages/turma/turmas_page.dart';

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
        title: const Text('Controle Notas e Frequências'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.list_outlined),
            title: const Text(
              'Turmas',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 24),
            ),
            onTap:() => _abrirListagemTurma(),
          ),
          ListTile(
            leading: const Icon(Icons.list_outlined),
            title: const Text(
              'Notas e frequências',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 24),
            ),
            onTap:() => _abrirListagemNotasFrenquencia(),
          ),
        ],
      ),
    );
  }

  void _abrirListagemTurma() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const TurmasPage()));
  }

  void _abrirListagemNotasFrenquencia() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const NotaFrequenciaPage()));
  }
}
