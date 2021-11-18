import 'package:flutter/material.dart';

class ListaTransferencias extends StatefulWidget {
  @override
  _ListaTransferenciasState createState() {
    return _ListaTransferenciasState();
  }
}

class _ListaTransferenciasState extends State<ListaTransferencias> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Lista de transferências"),
        ),
        body: const Text("Você não tem nenhuma transferência"),
      ),
    );
  }
}
