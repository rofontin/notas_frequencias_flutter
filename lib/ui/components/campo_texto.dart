import 'package:flutter/material.dart';

class CampoTexto extends StatelessWidget {
  final TextEditingController controller;
  final String texto;
  final TextInputType? teclado;
  final Icon icone;
  final bool? readOnly;

  const CampoTexto(
      {required this.controller,
      required this.texto,
      this.teclado,
      Key? key,
      required this.icone,
      this.readOnly})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: controller,
        keyboardType: teclado ?? TextInputType.text,
        decoration: InputDecoration(
          icon: icone,
          labelText: texto,
        ),
        readOnly: readOnly ?? false,
      ),
    );
  }
}
