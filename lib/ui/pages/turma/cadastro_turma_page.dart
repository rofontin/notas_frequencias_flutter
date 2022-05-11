import 'package:flutter/material.dart';
import 'package:notas_frequencia_flutter/datasources/datasources.dart';
import 'package:notas_frequencia_flutter/models/Turma.dart';
import 'package:notas_frequencia_flutter/ui/components/campo_data.dart';
import 'package:notas_frequencia_flutter/ui/components/campo_texto.dart';

class CadastroTurmaPage extends StatefulWidget {
  final Turma? turma;

  const CadastroTurmaPage({this.turma, Key? key}) : super(key: key);

  @override
  State<CadastroTurmaPage> createState() => _CadastroTurmaPageState();
}

class _CadastroTurmaPageState extends State<CadastroTurmaPage> {
  final _turmaHelper = TurmaHelper();
  final _nomeController = TextEditingController();
  final _dataInicioController = TextEditingController();
  final _dataTerminoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.turma != null) {
      _nomeController.text = widget.turma!.nome;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro Turma'),
      ),
      body: ListView(
        children: [
          CampoTexto(controller: _nomeController, texto: "Nome da Turma"),
          CampoData(
              controller: _dataInicioController,
              texto: "Data início",
              inicio: 2000,
              fim: 2100),
          CampoData(
              controller: _dataTerminoController,
              texto: "Data Término",
              inicio: 2000,
              fim: 2100),
          ElevatedButton(onPressed: _salvarTurma, child: const Text('Salvar'))
        ],
      ),
    );
  }

  void _salvarTurma() {
    if (widget.turma != null) {
      widget.turma!.nome = _nomeController.text;
      _turmaHelper.alterar(widget.turma!);
    } else {
      _turmaHelper.inserir(Turma(
          nome: _nomeController.text,
          dataInicio: _dataInicioController.text,
          dataTermino: _dataTerminoController.text));
    }
    Navigator.pop(context);
  }
}
