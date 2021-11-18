import 'package:flutter/material.dart';

class Divisor extends StatelessWidget {
  const Divisor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 20,
      indent: 10,
      endIndent: 10,
      thickness: 5,
    );
  }
}
