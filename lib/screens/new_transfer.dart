import 'package:flutter/material.dart';

class NewTransfer extends StatefulWidget {
  const NewTransfer({Key? key}) : super(key: key);

  @override
  _NewTransferState createState() => _NewTransferState();
}

class _NewTransferState extends State<NewTransfer> {
  TextEditingController txtAgencia = TextEditingController();
  TextEditingController txtConta = TextEditingController();
  TextEditingController txtValor = TextEditingController();
  void fazerTransferencia() {
    String agencia = txtAgencia.text;
    String conta = txtAgencia.text;
    double valor = double.parse(txtValor.text);
    debugPrint("$agencia, $conta, $valor");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text("Nova transferência"),
            ),
            body: Column(
              children: <Widget>[
                TextField(
                  controller: txtAgencia,
                  decoration: const InputDecoration(
                      labelText: "Agência de destino", hintText: "00000"),
                ),
                TextField(
                  controller: txtConta,
                  decoration: const InputDecoration(
                      labelText: "Conta de destino", hintText: "000000"),
                ),
                TextField(
                  controller: txtValor,
                  decoration: const InputDecoration(
                      labelText: "Informe o valor da transferência",
                      hintText: "0.00"),
                ),
                ElevatedButton(
                  child: const Text("Transferir"),
                  onPressed: fazerTransferencia,
                )
              ],
            )));
  }
}
