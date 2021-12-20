import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:piggybank/classes/pix_key.dart';
import 'package:piggybank/screens/nova_chave_pix.dart';
import 'package:piggybank/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AreaChavesPix extends StatefulWidget {
  const AreaChavesPix({Key? key}) : super(key: key);
  @override
  _AreaChavesPix createState() {
    return _AreaChavesPix();
  }
}

class _AreaChavesPix extends State<AreaChavesPix> {
  List<PixKey> lista = List<PixKey>.empty();
  void getKeys() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt("userId")!.toInt();
    var resp = await API.getPixKey(id);
    setState(() {
      Iterable list = json.decode(resp.body);
      lista = list.map((json) => PixKey.fromJson(json)).toList();
    });
  }

  _AreaChavesPix() {
    getKeys();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const NovaChavePix()));
          },
        ),
        appBar: AppBar(
          title: const Text("Minhas chaves"),
          leading: BackButton(
            color: const Color(0xFFFFFFFF),
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
        ),
        body: ListView.builder(
          itemCount: lista.length,
          itemBuilder: (BuildContext context, int i) {
            return Card(
              child: ListTile(
                title: Text(lista[i].key),
              ),
            );
          },
        ),
      ),
    );
  }
}
