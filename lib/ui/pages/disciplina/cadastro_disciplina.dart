import 'package:flutter/material.dart';
import 'package:notas_frequencia_flutter/datasources/datasources.dart';
import 'package:notas_frequencia_flutter/models/Disciplina.dart';
import 'package:notas_frequencia_flutter/models/Professor.dart';
import 'package:notas_frequencia_flutter/models/Turma.dart';
import 'package:notas_frequencia_flutter/ui/components/campo_texto.dart';

class CadastroDisciplinaPage extends StatefulWidget {
  final Turma turma;
  final Disciplina? disciplina;

  const CadastroDisciplinaPage(this.turma, {this.disciplina, Key? key})
      : super(key: key);

  @override
  State<CadastroDisciplinaPage> createState() => _CadastroDisciplinaPageState();
}

class _CadastroDisciplinaPageState extends State<CadastroDisciplinaPage> {
  final _disciplinaHelper = DisciplinaHelper();
  final _professorHelper = ProfessorHelper();
  final _nomeController = TextEditingController();
  final _cargaHorarioController = TextEditingController();
  Professor? _professorSelecionado;
  var _campo;

  @override
  void initState() {
    super.initState();

    if (widget.disciplina != null) {
      _nomeController.text = widget.disciplina!.nome;
      _cargaHorarioController.text = widget.disciplina!.cargaHoraria.toString();
      _campo = widget.disciplina!.professor?.nome;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro Disciplina'),
      ),
      body: ListView(
        children: [
          CampoTexto(controller: _nomeController, texto: "Nome da Disciplina"),
          CampoTexto(
              controller: _cargaHorarioController,
              texto: "Carga horária",
              teclado: TextInputType.number),
          FutureBuilder(
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
                  return getDrop(snapshot.data as List<Professor>);
              }
            },
          ),
          ElevatedButton(
              onPressed: _salvarDisciplina, child: const Text('Salvar'))
        ],
      ),
    );
  }

  Widget getDrop(List<Professor> professores) {
    _professorSelecionado ??= professores[0];

    var items = professores.map((item) {
      return DropdownMenuItem<Professor>(
        child: Text(item.nome),
        value: item,
      );
    }).toList();

    return DropdownButton<Professor>(
      items: items,
      onChanged: (newVal) => setState(() => _professorSelecionado = newVal!),
      value: _professorSelecionado,
    );
  }

  void _salvarDisciplina() {
    if (widget.disciplina != null) {
      widget.disciplina!.nome = _nomeController.text;
      _disciplinaHelper.alterar(widget.disciplina!);
    } else {
      _disciplinaHelper.inserir(Disciplina(
          nome: _nomeController.text,
          cargaHoraria: int.parse(_cargaHorarioController.text),
          turma: widget.turma,
          professor: _professorSelecionado));
    }
    Navigator.pop(context);
  }
}
