import 'package:flutter/material.dart';
import 'package:piggybank/components/shared/textinput.dart';
import 'package:piggybank/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PagamentoPix extends StatefulWidget {
  const PagamentoPix({Key? key}) : super(key: key);

  @override
  _PagamentoPixState createState() => _PagamentoPixState();
}

class _PagamentoPixState extends State<PagamentoPix> {
  TextEditingController txtKey = TextEditingController();
  TextEditingController txtNome = TextEditingController();
  TextEditingController txtValor = TextEditingController();
  TextEditingController txtSenha = TextEditingController();
  bool checked = false;
  void verificarSenha() async {
    showDialog(
        context: context,
        builder: (context) {
          return (AlertDialog(
            title: const Text("Informe sua senha"),
            content: TextInput("Senha", txtSenha, true, "****"),
            actions: [
              ElevatedButton(
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    int id = prefs.getInt('userId')!.toInt();
                    var resp = await API.verifyPassword(id, txtSenha.text);
                    if (resp.statusCode == 204) {
                      Navigator.pop(context, false);
                      fazerTransferencia();
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return (const AlertDialog(
                              title: Text("Senha incorreta"),
                              content: Text(
                                  "A senha que você digitou está incorreta"),
                            ));
                          });
                    }
                  },
                  child: const Text("Confirmar"))
            ],
          ));
        });
  }

  void fazerTransferencia() async {
    //Pegando o id, a chave e o saldo
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt("userId")!.toInt();
    var resp = await API.getUserPixKey(id);
    String pixKey = resp.body;
    double balance = prefs.getDouble("balance")!.toDouble();
    String key = txtKey.text;
    double amount = double.parse(txtValor.text);
    if (balance >= amount) {
      var resp = await API.newPixTransfer(id, pixKey, key, amount);
      if (resp.statusCode == 201) {
        //Atualiza o saldo do usuario
        var resp2 = await API.depositar(id, "", amount, "diminuir");
        if (resp2.statusCode == 204) {
          var destinationId = await API.getUserByPixKey(txtKey.text);
          var resp3 = await API.depositar(
              int.parse(destinationId.body), "", amount, "adicao");
          if (resp3.statusCode == 204) {
            if (checked == true) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Informe o nome do contato"),
                    content: TextInput("Nome", txtNome, false, "fulano"),
                    actions: [
                      ElevatedButton(
                          onPressed: () async {
                            var resp = await API.newContact(id, txtNome.text,
                                int.parse(destinationId.body));
                            if (resp.statusCode == 201) {
                              Navigator.pop(context, false);
                              Navigator.pop(context, true);
                            }
                          },
                          child: const Text("Confirmar"))
                    ],
                  );
                },
              );
            } else {
              Navigator.pop(context, true);
            }
          }
        }
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return (const AlertDialog(
                title: Text("Transferência falhou"),
                content: Text("A chave de destino está incorreta"),
              ));
            });
      }
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return (const AlertDialog(
              title: Text("Transferência falhou"),
              content: Text("Saldo insuficiente"),
            ));
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Pagamento por pix"),
          leading: BackButton(
            color: const Color(0xFFFFFFFF),
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
        ),
        body: Column(
          children: <Widget>[
            TextInput("Informe a chave", txtKey, false, ""),
            TextInput("Informe o valor", txtValor, false, "0.00"),
            Row(
              children: [
                Checkbox(
                    value: checked,
                    onChanged: (bool? value) {
                      setState(() {
                        checked = value!;
                      });
                    }),
                const Text("Adicionar amigo"),
              ],
            ),
            ElevatedButton(
              child: const Text("Transferir"),
              onPressed: verificarSenha,
            ),
          ],
        ),
      ),
    );
  }
}
