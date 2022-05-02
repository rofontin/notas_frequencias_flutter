import 'package:flutter/material.dart';

class CirculoEspera extends StatelessWidget {
  const CirculoEspera({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        CircularProgressIndicator(
          strokeWidth: 7,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
        ),
        Text("Aguarde...", style: TextStyle(fontSize: 28),)
      ],
    ));
  }
}
