import 'package:flutter/material.dart';
import 'package:piggybank/services/api.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PixQrCode extends StatefulWidget {
  const PixQrCode({Key? key}) : super(key: key);

  @override
  _PixQrCodeState createState() {
    return _PixQrCodeState();
  }
}

class _PixQrCodeState extends State<PixQrCode> {
  String key = "";
  _PixQrCodeState() {
    getKey();
  }
  void getKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt("userId")!.toInt();
    var resp = await API.getPixKey(id);
    setState(() {
      key = resp.body;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Seu Qr Code"),
          leading: BackButton(onPressed: () {
            Navigator.pop(context, false);
          }),
        ),
        body: Center(
          child: Column(
            children: [
              const Text("Seu QR code para compartilhamento"),
              QrImage(
                data: key,
                size: 300,
                errorCorrectionLevel: QrErrorCorrectLevel.H,
              )
            ],
          ),
        ),
      ),
    );
  }
}
