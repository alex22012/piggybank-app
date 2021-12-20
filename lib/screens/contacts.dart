import 'dart:convert';

import "package:flutter/material.dart";
import 'package:piggybank/classes/contact.dart';
import 'package:piggybank/components/shared/textinput.dart';
import 'package:piggybank/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Contacts extends StatefulWidget {
  const Contacts({Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _ContactsState createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  List<Contact> listaC = List<Contact>.empty();
  TextEditingController txtValor = TextEditingController();
  TextEditingController txtSenha = TextEditingController();

  _ContactsState() {
    contacts();
  }
  void contacts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt("userId")!.toInt();
    var resp = await API.getContacts(id);
    setState(() {
      Iterable listAux = json.decode(resp.body);
      listaC = listAux.map((json) => Contact.fromJson(json)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Contatos"),
          leading: BackButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
        ),
        body: ListView.builder(
          itemCount: listaC.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                title: Text("Nome do contato: ${listaC[index].name}"),
                trailing: TextButton(
                  onPressed: () async {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title:
                                const Text("Informe o valor da transferência"),
                            actions: [
                              TextInput("Valor", txtValor, false, "0.00"),
                              TextInput("Senha", txtSenha, true, "****"),
                              ElevatedButton(
                                  onPressed: () async {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    int id = prefs.getInt("userId")!.toInt();
                                    var resp = await API.verifyPassword(
                                        id, txtSenha.text);
                                    if (resp.statusCode == 204) {
                                      double balance = prefs
                                          .getDouble("balance")!
                                          .toDouble();
                                      int userId =
                                          prefs.getInt("userId")!.toInt();
                                      var userKey = await API
                                          .getUserPixKey(listaC[index].userId);
                                      var destinyKey = await API.getUserPixKey(
                                          listaC[index].contactId);
                                      double amount =
                                          double.parse(txtValor.text);
                                      if (amount <= balance) {
                                        var result = await API.newPixTransfer(
                                            userId,
                                            userKey.body,
                                            destinyKey.body,
                                            amount);
                                        if (result.statusCode == 201) {
                                          //Atualizo os saldos
                                          var att1 = await API.depositar(
                                              userId, "", amount, "diminuir");
                                          var att2 = await API.depositar(
                                              listaC[index].contactId,
                                              "",
                                              amount,
                                              "adicao");
                                          if (att1.statusCode == 204 &&
                                              att2.statusCode == 204) {
                                            Navigator.pop(context, false);
                                            Navigator.pop(context, true);
                                          }
                                        }
                                      }
                                    }
                                  },
                                  child: const Text("Confirmar"))
                            ],
                          );
                        });
                  },
                  child: const Text("Transferir"),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
