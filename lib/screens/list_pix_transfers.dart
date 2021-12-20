import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:piggybank/classes/pix_transfer.dart';
import 'package:piggybank/screens/pix_transfer_more_info.dart';
import 'package:piggybank/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListPixTransfer extends StatefulWidget {
  const ListPixTransfer({Key? key}) : super(key: key);

  @override
  _ListPixTransfer createState() {
    return _ListPixTransfer();
  }
}

class _ListPixTransfer extends State<ListPixTransfer> {
  List<PixTransfer> listaPix = List<PixTransfer>.empty();
  String key = "";
  _ListPixTransfer() {
    pixTransfers();
  }
  void pixTransfers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt("userId")!.toInt();
    var respKey = await API.getUserPixKey(id);
    var respList = await API.getPixTransfers(id, respKey.body);
    setState(() {
      key = respKey.body;
      Iterable aux = json.decode(respList.body);
      listaPix = aux.map((json) => PixTransfer.fromJson(json)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Transferências PIX"),
          leading: BackButton(
            color: const Color(0xFFFFFFFF),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: ListView.builder(
            itemCount: listaPix.length,
            itemBuilder: (BuildContext context, int i) {
              return listaPix.isEmpty
                  ? const Text("Você não tem nenhuma transferência")
                  : GestureDetector(
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setInt("pixTransferId", listaPix[i].id);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const PixTransferMoreInfo()));
                      },
                      child: Card(
                        child: ListTile(
                          title: listaPix[i].originKey == key
                              ? Text(
                                  "Conta de destino: ${listaPix[i].destinationKey}")
                              : Text(
                                  "Chave de origem ${listaPix[i].originKey}"),
                          subtitle: Text(
                              "Valor da transferência: ${listaPix[i].amount}"),
                          leading: listaPix[i].originKey == key
                              ? const Icon(Icons.money_off)
                              : const Icon(Icons.monetization_on),
                        ),
                      ),
                    );
            }),
      ),
    );
  }
}
