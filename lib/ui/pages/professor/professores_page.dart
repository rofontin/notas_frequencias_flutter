import 'package:flutter/material.dart';
import 'package:notas_frequencia_flutter/datasources/datasources.dart';
import 'package:notas_frequencia_flutter/models/Professor.dart';
import 'package:notas_frequencia_flutter/models/Turma.dart';
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
          return _criarItemLista(professor[index]);
        });
  }

  Widget _criarItemLista(Professor professor) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            professor.nome,
            style: const TextStyle(fontSize: 28),
          ),
        ),
      ),
      onTap: () => _cadastrarProfessor(professor: professor),
    );
  }
}
