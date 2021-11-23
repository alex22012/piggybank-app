import 'package:flutter/material.dart';
import 'package:piggybank/screens/dashboard.dart';
import 'package:piggybank/screens/home.dart';
import 'package:piggybank/services/api.dart';

void main() async {
  runApp(const Main());
  var resp = await API.getTransfers(1);
  print(resp.body);
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Home());
  }
}
