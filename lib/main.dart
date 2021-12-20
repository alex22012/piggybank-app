import 'package:flutter/material.dart';
import 'package:piggybank/screens/dashboard.dart';
import 'package:piggybank/screens/home.dart';
import 'package:piggybank/services/api.dart';

void main() async {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}
