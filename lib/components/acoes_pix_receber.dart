import 'package:flutter/material.dart';
import 'package:piggybank/screens/pix_qr_code.dart';

class AcoesPixReceber extends StatelessWidget {
  const AcoesPixReceber({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: 100,
          height: 70,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                tooltip: "Cobrar",
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PixQrCode()));
                },
                icon: const Icon(Icons.monetization_on),
              ),
              const Text("Cobrar"),
            ],
          ),
        ),
        SizedBox(
          width: 100,
          height: 70,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const <Widget>[
              IconButton(
                tooltip: "Depositar",
                onPressed: null,
                icon: Icon(Icons.savings_outlined),
              ),
              Text("Depositar"),
            ],
          ),
        ),
      ],
    );
  }
}
