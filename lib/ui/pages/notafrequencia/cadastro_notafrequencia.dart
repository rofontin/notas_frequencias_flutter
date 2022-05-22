import 'package:flutter/material.dart';
import 'package:notas_frequencia_flutter/datasources/datasources.dart';
import 'package:notas_frequencia_flutter/models/Aluno.dart';
import 'package:notas_frequencia_flutter/models/Disciplina.dart';
import 'package:notas_frequencia_flutter/models/NotaFrequencia.dart';
import 'package:notas_frequencia_flutter/models/Turma.dart';
import 'package:notas_frequencia_flutter/ui/components/campo_texto.dart';

class CadastroNotaFrequenciaPage extends StatefulWidget {
  final Turma turma;
  final Aluno aluno;
  final NotaFrequencia? notaFrequencia;

  const CadastroNotaFrequenciaPage(this.turma, this.aluno,
      {this.notaFrequencia, Key? key})
      : super(key: key);

  @override
  State<CadastroNotaFrequenciaPage> createState() =>
      _CadastroNotaFrequenciaPageState();
}

class _CadastroNotaFrequenciaPageState
    extends State<CadastroNotaFrequenciaPage> {
  final _notaFrequenciaHelper = NotaFrequenciaHelper();
  final _disciplinaHelper = DisciplinaHelper();
  final _notaController = TextEditingController();
  final _frequenciaController = TextEditingController();

  Future<List<Disciplina>>? _listDisciplina;
  Disciplina? _disciplinaSelecionado;

  @override
  void initState() {
    super.initState();
    _listDisciplina = _disciplinaHelper.getByTurma(widget.turma.registro ?? 0);

    if (widget.notaFrequencia != null) {
      _notaController.text = widget.notaFrequencia!.nota.toString();
      _frequenciaController.text = widget.notaFrequencia!.frequencia.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro Nota e frequência'),
      ),
      body: ListView(
        children: [
          CampoTexto(
            controller: TextEditingController(text: widget.turma.nome),
            texto: "Nome da Turma",
            icone: const Icon(Icons.school),
            readOnly: true,
          ),
          CampoTexto(
            controller: TextEditingController(text: widget.aluno.nome),
            texto: "Nome do Aluno",
            icone: const Icon(Icons.account_circle_outlined),
            readOnly: true,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all()),
                child: _getDropdownButtonHideUnderline()),
          ),
          CampoTexto(
            controller: _notaController,
            texto: "Nota",
            icone: const Icon(Icons.book_sharp),
            teclado: TextInputType.number,
          ),
          CampoTexto(
            controller: _frequenciaController,
            texto: "Frequência (horas)",
            icone: const Icon(Icons.book_sharp),
            teclado: TextInputType.number,
          ),
          ElevatedButton(
              onPressed: _salvarDisciplina, child: const Text('Salvar')),
        ],
      ),
    );
  }

  Widget _getDropdownButtonHideUnderline() {
    return DropdownButtonHideUnderline(
      child: FutureBuilder<List<Disciplina>>(
        future: _listDisciplina,
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
                value: _disciplinaSelecionado,
                icon: const Icon(Icons.arrow_drop_down),
                iconSize: 30,
                elevation: 16,
                onChanged: (newValue) {
                  setState(() {
                    _disciplinaSelecionado = newValue as Disciplina?;
                  });
                },
                items: snapshot.data!
                    .map<DropdownMenuItem<Disciplina>>((Disciplina value) {
                  return DropdownMenuItem<Disciplina>(
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
    if (widget.notaFrequencia != null) {
      widget.notaFrequencia!.nota = double.parse(_notaController.text);
      widget.notaFrequencia!.frequencia =
          double.parse(_frequenciaController.text);
      widget.notaFrequencia!.registroDisciplina =
          _disciplinaSelecionado!.registro!;
      _notaFrequenciaHelper.alterar(widget.notaFrequencia!);
    } else {
      _notaFrequenciaHelper.inserir(NotaFrequencia(
          registroAluno: widget.aluno.ra!,
          registroDisciplina: _disciplinaSelecionado!.registro!,
          registroTurma: widget.turma.registro!,
          nota: double.parse(_notaController.text),
          frequencia: double.parse(_frequenciaController.text)));
    }
    Navigator.pop(context);
  }
}
