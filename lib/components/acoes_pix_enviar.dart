import 'package:flutter/material.dart';

class AcoesPixEnviar extends StatelessWidget {
  const AcoesPixEnviar({Key? key}) : super(key: key);

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
                tooltip: "Pagar",
                onPressed: null,
                icon: Icon(Icons.payments_outlined),
              ),
              Text("Pagar"),
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
                tooltip: "QR code",
                onPressed: null,
                icon: Icon(Icons.qr_code),
              ),
              Text("Ler QR code"),
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
                tooltip: "Copia e cola",
                onPressed: null,
                icon: Icon(Icons.content_copy),
              ),
              Text("Pix copia e cola"),
            ],
          ),
        ),
      ],
    );
  }
}
