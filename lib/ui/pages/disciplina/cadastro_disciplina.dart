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
  Future<List<Professor>>? _listProfessor;
  Professor? _professorSelecionado;

  @override
  void initState() {
    super.initState();
    _listProfessor = _professorHelper.getByTurma(widget.turma.registro ?? 0);

    if (widget.disciplina != null) {
      _nomeController.text = widget.disciplina!.nome;
      _cargaHorarioController.text = widget.disciplina!.cargaHoraria.toString();
      _professorSelecionado = widget.disciplina!.professor;
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
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all()),
                child: _getDropdownButtonHideUnderline()),
          ),
          ElevatedButton(
              onPressed: _salvarDisciplina, child: const Text('Salvar'))
        ],
      ),
    );
  }

  Widget _getDropdownButtonHideUnderline() {
    return DropdownButtonHideUnderline(
      child: FutureBuilder<List<Professor>>(
        future: _listProfessor,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            default:
              if (snapshot.hasError) {
                return Text('Erro:' '${snapshot.error}');
              }
              return DropdownButton(
                value: _professorSelecionado,
                icon: const Icon(Icons.arrow_drop_down),
                iconSize: 30,
                elevation: 16,
                onChanged: (newValue) {
                  setState(() {
                    _professorSelecionado = newValue as Professor?;
                  });
                },
                items: snapshot.data!
                    .map<DropdownMenuItem<Professor>>((Professor value) {
                  return DropdownMenuItem<Professor>(
                    value: value,
                    child: Text(value.nome),
                  );
                }).toList(),
              );
          }
        },
      ),
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
