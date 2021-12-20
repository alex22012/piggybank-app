import 'package:flutter/material.dart';
import 'package:piggybank/screens/area_chaves.dart';
import 'package:piggybank/screens/list_pix_transfers.dart';

class MinhasChaves extends StatelessWidget {
  const MinhasChaves({Key? key}) : super(key: key);

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
                tooltip: "Minhas chaves",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AreaChavesPix()));
                },
                icon: const Icon(Icons.vpn_key),
              ),
              const Text("Minhas chaves"),
            ],
          ),
        ),
        SizedBox(
          width: 100,
          height: 70,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                tooltip: "Minhas transferências",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ListPixTransfer()));
                },
                icon: const Icon(Icons.transfer_within_a_station),
              ),
              const Text("Transferências"),
            ],
          ),
        ),
      ],
    );
  }
}
