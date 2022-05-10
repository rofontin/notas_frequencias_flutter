import 'package:flutter/material.dart';
import 'package:notas_frequencia_flutter/models/Professor.dart';
import 'package:notas_frequencia_flutter/ui/components/circulo_espera.dart';

class ProfessoresPage extends StatefulWidget {
  const ProfessoresPage({Key? key}) : super(key: key);

  @override
  State<ProfessoresPage> createState() => _ProfessoresPageState();
}

class _ProfessoresPageState extends State<ProfessoresPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Professores'),
        actions: [
          IconButton(
              onPressed: _cadastroProfessor,
              icon: const Icon(
                Icons.person_add,
                size: 32,
              ))
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
            future: retornarListaProfessores,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return const CirculoEspera();
                default:
                  if (snapshot.hasError) {
                    return GestureDetector(
                      child: const Text('Erro ao acessar a API'),
                      onTap: () {
                        setState(() {});
                      },
                    );
                  } else {
                    return carregarListaProfessores;
                  }
              }
            },
          ))
        ],
      ),
    );
  }

  void _cadastroProfessor({Professor? professor}) async {
    await Navigator.push(context, MaterialPageRoute(
        builder: (context)=> CadProfessorPage()));
  }
}
