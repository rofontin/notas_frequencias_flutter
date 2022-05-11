import 'package:flutter/material.dart';
import 'package:notas_frequencia_flutter/datasources/datasources.dart';
import 'package:notas_frequencia_flutter/models/Turma.dart';
import 'package:notas_frequencia_flutter/ui/pages/pages.dart';
import 'package:notas_frequencia_flutter/ui/pages/turma/cadastro_turma_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
          return _criarItemLista(turmas[index]);
        });
  }

  Widget _criarItemLista(Turma turma) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            turma.nome,
            style: const TextStyle(fontSize: 28),
          ),
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
        context, MaterialPageRoute(builder: (context) => TurmaPage(turma)));
  }
}
