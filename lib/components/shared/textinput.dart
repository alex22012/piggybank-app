import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String textoInput;
  final bool pass;
  final String hintText;
  TextEditingController controlador = TextEditingController();
  TextInput(this.textoInput, this.controlador, this.pass, this.hintText,
      {Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: TextField(
        obscureText: pass,
        controller: controlador,
        decoration: InputDecoration(
            labelText: textoInput, hintText: hintText != "" ? hintText : null),
      ),
    );
  }
}
