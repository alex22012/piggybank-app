import 'package:flutter/material.dart';
import 'package:piggybank/screens/dashboard.dart';
import 'package:piggybank/screens/home.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: DashBoard());
  }
}
