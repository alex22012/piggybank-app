import 'package:flutter/material.dart';
import 'package:piggybank/screens/cadastro.dart';
import 'package:piggybank/screens/login.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
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
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Login()));
                },
                child: const Text("Entrar"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Cadastro()));
                },
                child: const Text("Criar conta"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
