import 'package:flutter/material.dart';
import 'package:notas_frequencia_flutter/models/Professor.dart';

class DropDownMenuProfessor extends StatefulWidget {
  final Future<List<Professor>> listProfessor;

  const DropDownMenuProfessor(this.listProfessor, {Key? key}) : super(key: key);

  @override
  State<DropDownMenuProfessor> createState() => _DropDownMenuProfessorState();
}

class _DropDownMenuProfessorState extends State<DropDownMenuProfessor> {
  Professor? professorSelecionado;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0), border: Border.all()),
          child: _getDropdownButtonHideUnderline()),
    );
  }

  Widget _getDropdownButtonHideUnderline() {
    return DropdownButtonHideUnderline(
      child: FutureBuilder<List<Professor>>(
        future: widget.listProfessor,
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
                value: professorSelecionado,
                icon: const Icon(Icons.arrow_drop_down),
                iconSize: 30,
                elevation: 16,
                onChanged: (newValue) {
                  setState(() {
                    professorSelecionado = newValue as Professor?;
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
}
