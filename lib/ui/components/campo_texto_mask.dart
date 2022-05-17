import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CampoTextoMask extends StatelessWidget {
  final TextEditingController controller;
  final String texto;
  final TextInputType teclado;
  final TextInputFormatter mask;

  const CampoTextoMask(
      {required this.controller,
      required this.texto,
      required this.teclado,
      required this.mask,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: controller,
        keyboardType: teclado,
        decoration: InputDecoration(
          labelText: texto,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        ),
        inputFormatters: [mask],
      ),
    );
  }
}
