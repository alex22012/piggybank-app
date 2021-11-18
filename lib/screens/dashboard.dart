import 'package:flutter/material.dart';
import 'package:piggybank/components/botoes_acao_conta.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() {
    return _DashBoardState();
  }
}

class _DashBoardState extends State<DashBoard> {
  bool moneyIsVisible = true;
  void setMoneyIsVisible() {
    setState(() {
      moneyIsVisible = !moneyIsVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Bem vindo"),
          actions: const [
            IconButton(
              icon: Icon(Icons.show_chart_outlined),
              onPressed: null,
            )
          ],
        ),
        body: Column(
          children: [
            Card(
              child: ListTile(
                trailing: moneyIsVisible == true
                    ? IconButton(
                        icon: const Icon(Icons.visibility),
                        onPressed: setMoneyIsVisible,
                      )
                    : IconButton(
                        icon: const Icon(Icons.visibility_off),
                        onPressed: setMoneyIsVisible,
                      ),
                title: const Text("Saldo disponível na sua conta"),
                subtitle: moneyIsVisible == true
                    ? const Text("300")
                    : const Text("Seu dinheiro está na barriga do porquinho"),
              ),
            ),
            const BotoesAcaoConta()
          ],
        ),
      ),
    );
  }
}
