import 'package:flutter/material.dart';

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
            children: const <Widget>[
              IconButton(
                tooltip: "Cobrar",
                onPressed: null,
                icon: Icon(Icons.monetization_on),
              ),
              Text("Cobrar"),
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
