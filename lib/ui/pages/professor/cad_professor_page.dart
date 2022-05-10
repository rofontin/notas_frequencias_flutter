import 'package:flutter/material.dart';
import 'package:notas_frequencia_flutter/datasources/datasources.dart';
import 'package:notas_frequencia_flutter/models/Professor.dart';
import 'package:notas_frequencia_flutter/ui/components/campo_texto.dart';

class CadProfessorPage extends StatefulWidget{
  final Professor professor;

  const CadProfessorPage(this.professor, {Key? key}) : super(key: key);

  @override
  State<CadProfessorPage> createState() => _CadProfessorState();
  }
class _CadProfessorState extends State<CadProfessorPage> {
  final _professorHelper = ProfessorHelper();
  final _nomeController = TextEditingController();

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
      appBar: AppBar(title: Text('Cadastro Professor')),
      body: ListView(
        children: [
          CampoTexto(
              controller: _nomeController,
              texto: 'Nome do professor'
          ),
          CampoTexto(
              controller: _nomeController,
              texto: 'CPF'
          ),CampoTexto(
              controller: _nomeController,
              texto: 'Nome do professor'
          ),
          CampoTexto(
              controller: _nomeController,
              texto: 'Nome do professor'
          ),
          CampoTexto(
              controller: _nomeController,
              texto: 'Nome do professor'
          ),
          ElevatedButton(
              onPressed: _salvarProfessor,
              child: const Text('Salvar')
          ),
          _criarBotaoExcluir(),
        ],
      ),
    );
  }

  Widget _criarBotaoExcluir() {
    if (widget.professor != null) {
      return ElevatedButton(
          onPressed: _excluirProfessor,
          child: const Text('Excluir')
      );
    }
    return Container();
  }

  void _excluirProfessor() {
    _professorHelper.delete(widget.professor!);
    Navigator.pop(context);
  }

  void _salvarProfessor() {
    if (widget.professor != null) {
      widget.professor!.nome = _nomeController.text;
      _professorHelper.alterar(widget.professor!);
    }
    else {
      _professorHelper.inserir(Professor(
          nome: _nomeController.text,
          cpf: cpf,
          dataNascimento: dataNascimento,
          dataAdesao: dataAdesao,
          turma: turma)
      );
    }
    Navigator.pop(context);
  }
}
}