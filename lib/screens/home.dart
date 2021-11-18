import 'package:flutter/material.dart';
import 'package:piggybank/screens/cadastro.dart';
import 'package:piggybank/screens/login.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(
          width: 300.0,
          height: 300.0,
          child: Image(
              image: NetworkImage(
                  "https://image.freepik.com/free-vector/piggy-bank-logo-template_59362-87.jpg"),
              fit: BoxFit.contain),
        ),
        const Text("Bem vindo ao PiggyBank"),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Login()));
          },
          child: const Text("Entrar"),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Cadastro()));
          },
          child: const Text("Criar conta"),
        ),
      ],
    );
  }
}
