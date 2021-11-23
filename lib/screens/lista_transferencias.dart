import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:piggybank/classes/transferencia.dart';
import 'package:piggybank/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListaTransferencias extends StatefulWidget {
  @override
  _ListaTransferenciasState createState() {
    return _ListaTransferenciasState();
  }
}

class _ListaTransferenciasState extends State<ListaTransferencias> {
  List<Transferencia> lista = List<Transferencia>.empty();
  void getTransferList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt("userId")!.toInt();
    var resp = await API.getTransfers(id);
    //Pegando a lista de json
    setState(() {
      Iterable list = json.decode(resp.body);
      lista = list.map((json) => Transferencia.fromJson(json)).toList();
    });
  }

  _ListaTransferenciasState() {
    getTransferList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Lista de transferências"),
          leading: BackButton(
            color: const Color(0xFFFFFFFF),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: ListView.builder(
          itemCount: lista.length,
          itemBuilder: (BuildContext context, int i) {
            return Card(
              child: ListTile(
                title: Text("Conta: " + lista[i].destinationAccount),
                subtitle: Text("Valor: ${lista[i].amount}"),
              ),
            );
          },
        ),
      ),
    );
  }
}
