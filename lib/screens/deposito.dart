import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:piggybank/components/shared/textinput.dart';
import 'package:piggybank/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Deposito extends StatefulWidget {
  const Deposito({Key? key}) : super(key: key);

  @override
  _DepositoState createState() {
    return _DepositoState();
  }
}

class _DepositoState extends State<Deposito> {
  TextEditingController txtValor = TextEditingController();
  void depositar() async {
    //Pegando o id
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double amount = double.parse(txtValor.text);
    var id = prefs.getInt("userId")!.toInt();
    var resp = await API.depositar(id, amount, "adicao");
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Depósito"),
          leading: BackButton(
            color: const Color(0xFFFFFFFF),
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
        ),
        body: Column(
          children: <Widget>[
            TextInput("Informe o valor do depósito", txtValor, false, "0.00"),
            ElevatedButton(
              child: const Text("Depositar"),
              onPressed: depositar,
            )
          ],
        ),
      ),
    );
  }
}
