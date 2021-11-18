import 'package:flutter/material.dart';

class Titulo extends StatelessWidget {
  String titulo = "";
  Titulo({Key? key, required this.titulo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Text(titulo),
    );
  }
}
