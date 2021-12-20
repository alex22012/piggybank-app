import 'package:flutter/material.dart';
import 'package:piggybank/components/shared/textinput.dart';
import 'package:piggybank/services/api.dart';
import 'package:piggybank/services/controller.dart';
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
  TextEditingController txtSenhaAlert = TextEditingController();
  void verificarSenha() async {
    showDialog(
      context: context,
      builder: (context) {
        return (AlertDialog(
          title: const Text("Informe sua senha"),
          content: TextInput("Senha", txtSenhaAlert, true, "*****"),
          actions: [
            ElevatedButton(
              child: const Text("Confirmar"),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                int id = prefs.getInt("userId")!.toInt();
                var resp = await API.verifyPassword(id, txtSenhaAlert.text);
                if (resp.statusCode == 204) {
                  Navigator.pop(context);
                  fazerTransferencia();
                } else {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return (const AlertDialog(
                          title: Text("Senha incorreta"),
                        ));
                      });
                }
              },
            ),
          ],
        ));
      },
    );
  }

  void fazerTransferencia() async {
    //Pegando o id, agencia, saldo e conta do usuario
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt("userId")!.toInt();
    String? agency = prefs.getString("agency");
    String? account = prefs.getString("account");
    double balance = prefs.getDouble("balance")!.toDouble();
    print("$agency | $account | $balance");
    //Verifico se ele tem saldo na conta
    if (balance >= double.parse(txtValor.text) &&
        Controller.validateTransferData(
            txtAgencia.text, txtAgencia.text, double.parse(txtValor.text))) {
      //Faço a transferencia
      var resp = await API.fazerTransferencia(id, agency, account,
          txtAgencia.text, txtConta.text, double.parse(txtValor.text));
      if (resp.statusCode == 201) {
        //Atualizo o saldo na conta
        var resp2 = await API.depositar(
            id, "", double.parse(txtValor.text), "diminuir");
        if (resp2.statusCode == 204) {
          var resp3 = await API.depositar(
              0, txtConta.text, double.parse(txtValor.text), "adicao");
          if (resp3.statusCode == 204) {
            Navigator.pop(context, true);
          }
        }
      } else if (resp.statusCode == 404) {
        showDialog(
            context: context,
            builder: (context) {
              return (const AlertDialog(
                title: Text("Erro na transferência"),
                content: Text("A conta ou agência de destino está incorreta"),
              ));
            });
      }
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              title: Text("Os dados informados estão incorretos"),
              content:
                  Text("Verifique a agência e a conta corrente novamente."),
            );
          });
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
              Navigator.pop(context, false);
            },
          ),
        ),
        body: Column(
          children: <Widget>[
            TextInput("Agência de destino", txtAgencia, false, "00000"),
            TextInput("Conta de destino", txtConta, false, "000000"),
            TextInput(
                "Informe o valor da transferência", txtValor, false, "0.00"),
            ElevatedButton(
              child: const Text("Transferir"),
              onPressed: verificarSenha,
            )
          ],
        ),
      ),
    );
  }
}
