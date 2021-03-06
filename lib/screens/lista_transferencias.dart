import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:piggybank/classes/transferencia.dart';
import 'package:piggybank/screens/transfer_more_info.dart';
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
  String userAccount = "";
  void getTransferList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt("userId")!.toInt();
    String account = prefs.getString("account")!.toString();
    setState(() {
      userAccount = account;
    });
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
          title: const Text("Lista de transferĂȘncias"),
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
            return GestureDetector(
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setInt("transferId", lista[i].id);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TransferMoreInfo(),
                  ),
                );
              },
              child: Card(
                child: ListTile(
                  title: Text(
                      "Conta ${userAccount == lista[i].originAccount ? lista[i].destinationAccount : lista[i].originAccount}"),
                  subtitle: Text("Valor: ${lista[i].amount}"),
                  leading: userAccount == lista[i].originAccount
                      ? const Icon(Icons.money_off)
                      : const Icon(Icons.monetization_on),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
