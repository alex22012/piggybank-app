import 'package:flutter/material.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({Key? key}) : super(key: key);

  @override
  _CadastroState createState() {
    return _CadastroState();
  }
}

class _CadastroState extends State<Cadastro> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Cadastro"),
        ),
        body: Column(
          children: <Widget>[
            const TextField(
              decoration: InputDecoration(labelText: "Informe seu nome"),
            ),
            const TextField(
              decoration: InputDecoration(labelText: "Informe seu CPF"),
            ),
            const TextField(
              decoration: InputDecoration(labelText: "Informe seu email"),
            ),
            const TextField(
              decoration: InputDecoration(labelText: "Informe sua senha"),
            ),
            const ElevatedButton(
              child: Text("Criar conta"),
              onPressed: null,
            )
          ],
        ),
      ),
    );
  }
}
