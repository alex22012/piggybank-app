import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:piggybank/classes/pix_transfer.dart';
import 'package:piggybank/classes/user.dart';
import 'package:piggybank/components/shared/textinput.dart';
import 'package:piggybank/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PixTransferMoreInfo extends StatefulWidget {
  const PixTransferMoreInfo({Key? key}) : super(key: key);

  @override
  _PixTransferMoreInfo createState() {
    return _PixTransferMoreInfo();
  }
}

class _PixTransferMoreInfo extends State<PixTransferMoreInfo> {
  PixTransfer transfer = PixTransfer(0, 0, "", "", 0);
  int userId = 0;
  User origin = User(0, "");
  User destiny = User(1, "");
  TextEditingController txtNome = TextEditingController();
  _PixTransferMoreInfo() {
    getTransfer();
  }
  void getTransfer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt("pixTransferId")!.toInt();
    var resp = await API.getPixTransfer(id);
    var json = jsonDecode(resp.body);
    setState(() {
      transfer = PixTransfer.fromJson(json);
      userId = id;
    });
    getOriginAndDestinationUser();
  }

  void getOriginAndDestinationUser() async {
    var idOrigin = await API.getUserByPixKey(transfer.originKey);
    var idDestination = await API.getUserByPixKey(transfer.destinationKey);
    var originUser = await API.getUserData(idOrigin.body);
    var destinationUser = await API.getUserData(idDestination.body);
    setState(() {
      var jsonOrigin = jsonDecode(originUser.body);
      var jsonDestination = jsonDecode(destinationUser.body);
      origin = User.fromJson(jsonOrigin);
      destiny = User.fromJson(jsonDestination);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Transferência PIX"),
          leading: BackButton(
            color: const Color(0xFFFFFFFF),
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
        ),
        body: Column(
          children: [
            const Text(
              "Resumo da transferência",
              style: TextStyle(fontSize: 20),
            ),
            Card(
              child: ListTile(
                title: Text("Usuário de origem: ${origin.name}"),
                subtitle: Text("Chave de origem: ${transfer.originKey}"),
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Usuário de destino: ${destiny.name}"),
                subtitle: Text("Chave de destino: ${transfer.destinationKey}"),
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Valor da transferência: ${transfer.amount}"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
