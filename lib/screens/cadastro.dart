import 'package:flutter/material.dart';
import 'package:piggybank/components/shared/textinput.dart';
import 'package:piggybank/screens/dashboard.dart';
import 'package:piggybank/services/api.dart';
import 'package:piggybank/services/controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({Key? key}) : super(key: key);
  @override
  _CadastroState createState() {
    return _CadastroState();
  }
}

class _CadastroState extends State<Cadastro> {
  TextEditingController txtNome = TextEditingController();
  TextEditingController txtCpf = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  void criarContaClick(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = txtNome.text;
    String cpf = txtCpf.text;
    String email = txtEmail.text;
    String password = txtPassword.text;
    if (Controller.validateData(name, email, cpf) &&
        Controller.validatePassword(password)) {
      var resp = await API.createUserAccount(name, cpf, email, password);
      //Salvando o id do usuario
      if (resp.statusCode == 201) {
        prefs.setInt("userId", int.parse(resp.body));
        abrirConta(int.parse(resp.body), prefs, context);
      }
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              title: Text("Dados incorretos"),
              content: Text(
                  "Verifique os dados informados! A senha precisa ter ao menos 8 caracteres não repetidos na sequência"),
            );
          });
    }
  }

  void abrirConta(int id, SharedPreferences prefs, BuildContext context) async {
    var resp = await API.abrirConta(id);
    if (resp.statusCode == 201) {
      prefs.setString("agency", "2000-0");
      prefs.setString("account", resp.body);
      prefs.setDouble("balance", 0);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const DashBoard()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Cadastro"),
          leading: BackButton(
            color: const Color(0xFFFFFFFF),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: <Widget>[
            TextInput("Informe seu nome", txtNome, false, ""),
            TextInput("Informe seu cpf", txtCpf, false, ""),
            TextInput("Informe seu email", txtEmail, false, ""),
            TextInput("Informe sua senha", txtPassword, true, ""),
            ElevatedButton(
              child: const Text("Criar conta"),
              onPressed: () {
                criarContaClick(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
