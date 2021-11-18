import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Login'),
            leading: const Text("Oi"),
          ),
          body: Column(
            children: const <Widget>[
              TextField(
                decoration: InputDecoration(labelText: "Informe seu email"),
              ),
              TextField(
                decoration: InputDecoration(labelText: "Informe sua senha"),
              ),
              ElevatedButton(
                onPressed: null,
                child: Text("Entrar"),
              ),
            ],
          )),
    );
  }
}
