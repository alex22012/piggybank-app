import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:piggybank/classes/transferencia.dart';
import 'package:piggybank/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransferMoreInfo extends StatefulWidget {
  @override
  _TransferMoreInfo createState() {
    return _TransferMoreInfo();
  }
}

class _TransferMoreInfo extends State<TransferMoreInfo> {
  Transferencia t = Transferencia(0, 0, "", "", "", "", 0);
  String account = "";
  _TransferMoreInfo() {
    getTransfer();
  }
  void getTransfer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int transferId = prefs.getInt("transferId")!.toInt();
    var resp = await API.getTransfer(transferId);
    setState(() {
      account = prefs.getString('account')!.toString();
      var jsonT = jsonDecode(resp.body);
      t = Transferencia.fromJson(jsonT);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Transferência"),
          leading: BackButton(
            color: const Color(0xFFFFFFFF),
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
        ),
        body: Column(
          children: [
            Text(t.originAccount == account
                ? "Transferência enviada"
                : "Transferência recebida"),
            Card(
              child: ListTile(
                title: Text("Conta de origem: " + t.originAccount),
                subtitle: Text("Agência de origem: " + t.originAgency),
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Conta de destino: " + t.destinationAccount),
                subtitle: Text("Agência de destino: " + t.destinationAgency),
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Valor da transferência: " + t.amount.toString()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
