import 'package:flutter/material.dart';
import 'package:piggybank/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NovaChavePix extends StatefulWidget {
  const NovaChavePix({Key? key}) : super(key: key);

  @override
  _NovaChavePixState createState() => _NovaChavePixState();
}

class _NovaChavePixState extends State<NovaChavePix> {
  TextEditingController txtKey = TextEditingController();
  void criarChave() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt("userId")!.toInt();
    var resp = await API.newPixKey(id);
    setState(() {
      txtKey.text = resp.body;
    });
    prefs.setString("pixkey", resp.body);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Nova chave PIX"),
          leading: BackButton(
            color: const Color(0xFFFFFFFF),
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
        ),
        body: Column(
          children: <Widget>[
            TextField(
              controller: txtKey,
              decoration: const InputDecoration(labelText: "Chave"),
            ),
            ElevatedButton(
                onPressed: criarChave, child: const Text("Gerar chave"))
          ],
        ),
      ),
    );
  }
}
