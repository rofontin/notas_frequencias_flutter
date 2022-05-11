import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CampoData extends StatefulWidget {
  final TextEditingController controller;
  final String texto;
  final int inicio;
  final int fim;

  const CampoData(
      {required this.controller,
      required this.texto,
      required this.inicio,
      required this.fim,
      Key? key})
      : super(key: key);

  @override
  State<CampoData> createState() => _CampoDataState();
}

class _CampoDataState extends State<CampoData> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
            icon: const Icon(Icons.calendar_today), labelText: widget.texto),
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(widget.inicio),
              lastDate: DateTime(widget.fim));

          if (pickedDate != null) {
            String formattedDate = DateFormat('dd/MM/yyy').format(pickedDate);

            setState(() {
              widget.controller.text = formattedDate;
            });
          }
        },
      ),
    );
  }
}
