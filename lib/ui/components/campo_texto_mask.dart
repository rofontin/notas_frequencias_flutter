import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CampoTextoMask extends StatelessWidget {
  final TextEditingController controller;
  final String texto;
  final TextInputType teclado;
  final TextInputFormatter mask;
  final Icon icone;

  const CampoTextoMask(
      {required this.controller,
      required this.texto,
      required this.teclado,
      required this.mask,
      Key? key, required this.icone})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: controller,
        keyboardType: teclado,
        decoration: InputDecoration(
          icon: icone,
          labelText: texto,
        ),
        inputFormatters: [mask],
      ),
    );
  }
}
