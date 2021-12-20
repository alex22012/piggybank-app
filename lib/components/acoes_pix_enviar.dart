import 'package:flutter/material.dart';
import 'package:piggybank/screens/pagamento_pix.dart';

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
            children: <Widget>[
              IconButton(
                tooltip: "Pagar",
                onPressed: () async {
                  bool resp = await Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PagamentoPix()));
                  if (resp) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return (const AlertDialog(
                            title: Text("Pix enviado com sucesso"),
                          ));
                        });
                  }
                },
                icon: const Icon(Icons.payments_outlined),
              ),
              const Text("Pagar"),
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
