import 'package:flutter/material.dart';
import 'package:notas_frequencia_flutter/datasources/datasources.dart';
import 'package:notas_frequencia_flutter/models/Professor.dart';
import 'package:notas_frequencia_flutter/models/Turma.dart';
import 'package:notas_frequencia_flutter/ui/components/campo_data.dart';
import 'package:notas_frequencia_flutter/ui/components/campo_texto.dart';

class CadastroProfessorPage extends StatefulWidget {
  final Professor? professor;
  final Turma turma;

  const CadastroProfessorPage({Key? key, this.professor,required this.turma}) : super(key: key);

  @override
  State<CadastroProfessorPage> createState() => _CadastroProfessorPageState();
}

class _CadastroProfessorPageState extends State<CadastroProfessorPage> {
  final _professorHelper = ProfessorHelper();
  final _nomeController = TextEditingController();
  final _cpfController = TextEditingController();
  final _dataNascimentoController = TextEditingController();
  final _dataAdesaoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.professor != null) {
      _nomeController.text = widget.professor!.nome;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro Professor'),
      ),
      body: ListView(
        children: [
          CampoTexto(controller: _nomeController, texto: "Nome do Professor"),
          CampoTexto(controller: _cpfController, texto: "CPF"),
          CampoData(
              controller: _dataNascimentoController,
              texto: "Data Nascimento",
              inicio: 2000,
              fim: 2100),
          CampoData(
              controller: _dataAdesaoController,
              texto: "Data Adesão",
              inicio: 2000,
              fim: 2100),
          ElevatedButton(onPressed: _salvarProfessor, child: const Text('Salvar')),
        ],
      ),
    );
  }

  void _salvarProfessor() {
    if (widget.professor != null) {
      widget.professor!.nome = _nomeController.text;
      _professorHelper.alterar(widget.professor!);
    } else {
      _professorHelper.inserir(Professor(
          nome: _nomeController.text,
          cpf: _cpfController.text,
          dataNascimento: _dataNascimentoController.text,
          dataAdesao: _dataAdesaoController.text,
          turma: widget.turma,));
    }
    Navigator.pop(context);
  }
}