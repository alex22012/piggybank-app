import 'package:flutter/material.dart';
import 'package:piggybank/components/shared/textinput.dart';
import 'package:piggybank/screens/dashboard.dart';
import 'package:piggybank/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  void login(BuildContext context) async {
    String email = txtEmail.text;
    String password = txtPassword.text;
    var resp = await API.login(email, password);
    if (resp.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt("userId", int.parse(resp.body));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => DashBoard()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
          leading: BackButton(
            color: const Color(0xFFFFFFFF),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: <Widget>[
            TextInput("Informe seu email", txtEmail, false, ""),
            TextInput("Informe sua senha", txtPassword, true, ""),
            ElevatedButton(
              onPressed: () {
                login(context);
              },
              child: const Text("Entrar"),
            ),
          ],
        ),
      ),
    );
  }
}
