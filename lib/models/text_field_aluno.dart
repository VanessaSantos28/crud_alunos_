import 'package:flutter/material.dart';

class TextFieldAluno extends StatelessWidget {
  final TextEditingController controllerAluo;
  final String hintTextAluno;
  final int? nLinhas;

  const TextFieldAluno(
      {super.key,
      required this.controllerAluo,
      required this.hintTextAluno,
      this.nLinhas});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        final isValidator = value ?? "";
        if (isValidator.isEmpty) {
          return "Campo Obrigatório";
        }
        return null;
      },
      maxLines: nLinhas,
      controller: controllerAluo,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        hintText: hintTextAluno,
        hintStyle: TextStyle(color: Colors.grey),
      ),
    );
  }
}
