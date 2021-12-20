import 'package:flutter/material.dart';
import 'package:piggybank/components/acoes_pix_enviar.dart';
import 'package:piggybank/components/acoes_pix_receber.dart';
import 'package:piggybank/components/minhas_chaves.dart';
import 'package:piggybank/components/shared/divisor.dart';
import 'package:piggybank/components/shared/titulo.dart';

class AreaPix extends StatelessWidget {
  const AreaPix({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Área PIX"),
          leading: BackButton(
            color: const Color(0xFFFFFFFF),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
        ),
        body: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: Text("Bem vindo a sua área pix"),
            ),
            const MinhasChaves(),
            const Divisor(),
            Titulo(titulo: "Enviar"),
            const Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: AcoesPixEnviar(),
            ),
            const Divisor(),
            Titulo(titulo: "Receber"),
            const Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: AcoesPixReceber(),
            ),
          ],
        ),
      ),
    );
  }
}
