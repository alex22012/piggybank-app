import 'package:flutter/material.dart';
import 'package:piggybank/screens/area_pix.dart';
import 'package:piggybank/screens/deposito.dart';
import 'package:piggybank/screens/lista_transferencias.dart';
import 'package:piggybank/screens/new_transfer.dart';

class BotoesAcaoConta extends StatelessWidget {
  Function cbRefreshBalance;
  BotoesAcaoConta(this.cbRefreshBalance, {Key? key}) : super(key: key);
  void goToTransferList(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ListaTransferencias()));
  }

  void goToNewTransfer(BuildContext context) async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => const NewTransfer()));
    if (result) {
      showDialog(
          context: context,
          builder: (context) {
            return (const AlertDialog(
              title: Text("Tranferência realizada com sucesso"),
              content: Text("O valor será creditado na conta de destino"),
            ));
          });
      cbRefreshBalance();
    }
  }

  void goToAreaPIX(BuildContext context) async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => const AreaPix()));
    if (result) {
      cbRefreshBalance();
    }
  }

  void goToDeposito(BuildContext context) async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Deposito()));
    if (result) {
      cbRefreshBalance();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 30.0, left: 0.0, right: 0.0, bottom: 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.2,
            height: 100,
            child: ElevatedButton(
              onPressed: () {
                goToTransferList(context);
              },
              child: const Text("Ver histório de transferências"),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.2,
            height: 100,
            child: ElevatedButton(
              onPressed: () {
                goToNewTransfer(context);
              },
              child: const Text("Realizar uma transferência"),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.2,
            height: 100,
            child: ElevatedButton(
              onPressed: () {
                goToAreaPIX(context);
              },
              child: const Text("Área PIX"),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.2,
            height: 100,
            child: ElevatedButton(
              onPressed: () {
                goToDeposito(context);
              },
              child: const Text("Depositar"),
            ),
          ),
        ],
      ),
    );
  }
}
