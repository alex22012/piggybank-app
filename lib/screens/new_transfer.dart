import 'package:flutter/material.dart';
import 'package:piggybank/components/shared/textinput.dart';
import 'package:piggybank/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewTransfer extends StatefulWidget {
  const NewTransfer({Key? key}) : super(key: key);

  @override
  _NewTransferState createState() => _NewTransferState();
}

class _NewTransferState extends State<NewTransfer> {
  TextEditingController txtAgencia = TextEditingController();
  TextEditingController txtConta = TextEditingController();
  TextEditingController txtValor = TextEditingController();
  void fazerTransferencia() async {
    //Pegando o id, agencia, saldo e conta do usuario
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt("userId")!.toInt();
    String agency = prefs.getString("agency").toString();
    String account = prefs.getString("account").toString();
    double balance = prefs.getDouble("balance")!.toDouble();
    //Verifico se ele tem saldo na conta
    if (balance >= double.parse(txtValor.text)) {
      //Faço a transferencia
      var resp = await API.fazerTransferencia(id, agency, account,
          txtAgencia.text, txtConta.text, double.parse(txtValor.text));
      if (resp.statusCode == 201) {
        //Atualizo o saldo na conta
        var resp2 =
            await API.depositar(id, double.parse(txtValor.text), "diminuir");
        if (resp2.statusCode == 204) {
          Navigator.pop(context, true);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text("Nova transferência"),
              leading: BackButton(
                color: const Color(0xFFFFFFFF),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: Column(
              children: <Widget>[
                TextInput("Agência de destino", txtAgencia, false, "00000"),
                TextInput("Conta de destino", txtConta, false, "000000"),
                TextInput("Informe o valor da transferência", txtValor, false,
                    "0.00"),
                ElevatedButton(
                  child: const Text("Transferir"),
                  onPressed: fazerTransferencia,
                )
              ],
            )));
  }
}
