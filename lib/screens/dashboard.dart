import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:piggybank/classes/account.dart';
import 'package:piggybank/components/botoes_acao_conta.dart';
import 'package:piggybank/screens/contacts.dart';
import 'package:piggybank/screens/home.dart';
import 'package:piggybank/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() {
    return _DashBoardState();
  }
}

class _DashBoardState extends State<DashBoard> {
  bool moneyIsVisible = true;
  Account conta = Account(0, "", "", 1);
  void setMoneyIsVisible() {
    setState(() {
      moneyIsVisible = !moneyIsVisible;
    });
  }

  void getAccount() async {
    //Pego o id
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt("userId")!.toInt();
    var resp = await API.getAccount(id);
    var jsonAccount = json.decode(resp.body);
    Account ac = Account.fromJson(jsonAccount);
    await prefs.setString("account", ac.account);
    await prefs.setString("agency", ac.agency);
    await prefs.setDouble("balance", ac.balance);
    setState(() {
      conta = ac;
    });
  }

  _DashBoardState() {
    getAccount();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Bem vindo"),
          actions: [
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.remove("userId");
                await prefs.remove("account");
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Home()));
              },
            ),
            IconButton(
              icon: const Icon(Icons.account_box),
              onPressed: () async {
                bool result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Contacts(),
                  ),
                );
                if (result) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title:
                              Text("A transferência foi enviada com sucesso"),
                          actions: [
                            ElevatedButton(
                                onPressed: () {
                                  getAccount();
                                  Navigator.pop(context, false);
                                },
                                child: const Text("Confirmar"))
                          ],
                        );
                      });
                }
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Card(
              child: ListTile(
                trailing: moneyIsVisible == true
                    ? IconButton(
                        icon: const Icon(Icons.visibility),
                        onPressed: setMoneyIsVisible,
                      )
                    : IconButton(
                        icon: const Icon(Icons.visibility_off),
                        onPressed: setMoneyIsVisible,
                      ),
                title: const Text("Saldo disponível na sua conta"),
                subtitle: moneyIsVisible == true
                    ? Text(conta.balance.toStringAsFixed(2))
                    : const Text("Seu dinheiro está na barriga do porquinho"),
              ),
            ),
            BotoesAcaoConta(() {
              getAccount();
            })
          ],
        ),
      ),
    );
  }
}
