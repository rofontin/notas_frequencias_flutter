import 'package:flutter/material.dart';
import 'package:notas_frequencia_flutter/datasources/datasources.dart';
import 'package:notas_frequencia_flutter/models/Aluno.dart';
import 'package:notas_frequencia_flutter/models/Turma.dart';
import 'package:notas_frequencia_flutter/ui/components/campo_data.dart';
import 'package:notas_frequencia_flutter/ui/components/campo_texto.dart';

class CadastroAlunoPage extends StatefulWidget {
  final Turma turma;
  final Aluno? aluno;

  const CadastroAlunoPage(this.turma, {this.aluno, Key? key}) : super(key: key);

  @override
  State<CadastroAlunoPage> createState() => _CadastroAlunoPageState();
}

class _CadastroAlunoPageState extends State<CadastroAlunoPage> {
  final _alunoHelper = AlunoHelper();
  final _nomeController = TextEditingController();
  final _cpfController = TextEditingController();
  final _dataNascimentoController = TextEditingController();
  final _dataMatriculaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.aluno != null) {
      _nomeController.text = widget.aluno!.nome;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro Aluno'),
      ),
      body: ListView(
        children: [
          CampoTexto(controller: _nomeController, texto: "Nome do Aluno"),
          CampoTexto(controller: _cpfController, texto: "CPF"),
          CampoData(
              controller: _dataNascimentoController,
              texto: "Data Nascimento",
              inicio: 1950,
              fim: 2022),
          CampoData(
              controller: _dataMatriculaController,
              texto: "Data Matrícula",
              inicio: 2000,
              fim: 2100),
          ElevatedButton(onPressed: _salvarAluno, child: const Text('Salvar')),
        ],
      ),
    );
  }

  void _salvarAluno() {
    if (widget.aluno != null) {
      widget.aluno!.nome = _nomeController.text;
      _alunoHelper.alterar(widget.aluno!);
    } else {
      _alunoHelper.inserir(Aluno(
          nome: _nomeController.text,
          cpf: _cpfController.text,
          dataNascimento: _dataNascimentoController.text,
          dataMatricula: _dataMatriculaController.text,
          turma: widget.turma));
    }
    Navigator.pop(context);
  }
}
