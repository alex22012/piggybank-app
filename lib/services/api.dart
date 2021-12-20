import 'dart:convert';

import 'package:http/http.dart' as http;

const base_url = "http://192.168.0.107:3000";
const headers = <String, String>{
  "Content-Type": "application/json",
  "Accept": "application/json"
};

class API {
  static Future<http.Response> createUserAccount(
      name, cpf, email, password) async {
    var resp = await http.post(
      Uri.parse("$base_url/users"),
      headers: headers,
      body: jsonEncode(
        <String, dynamic>{
          "name": name,
          "cpf": cpf,
          "email": email,
          "password": password
        },
      ),
    );
    return resp;
  }

  static Future<http.Response> login(email, password) async {
    var resp = await http.post(
      Uri.parse("$base_url/users/login"),
      headers: headers,
      body: jsonEncode(
        <String, String>{"email": email, "password": password},
      ),
    );
    return resp;
  }

  static Future<http.Response> getAccount(userId) async {
    var resp = await http.get(Uri.parse("$base_url/users/$userId/account"),
        headers: headers);
    return resp;
  }

  static Future<http.Response> abrirConta(userId) async {
    var resp = await http.post(Uri.parse("$base_url/users/$userId/new-account"),
        headers: headers);
    return resp;
  }

  static Future<http.Response> depositar(
      userId, accountNumber, amount, op) async {
    var resp = await http.put(
      Uri.parse("$base_url/users/$userId/account/update-balance"),
      headers: headers,
      body: jsonEncode(
        <String, dynamic>{
          "amount": amount,
          "op": op,
          "accountNumber": accountNumber
        },
      ),
    );
    return resp;
  }

  static Future<http.Response> fazerTransferencia(userId, originAgency,
      originAccount, destinationAgency, destinationAccount, amount) async {
    var resp = await http.post(
      Uri.parse("$base_url/users/$userId/new-transfer"),
      headers: headers,
      body: jsonEncode(
        <String, dynamic>{
          "userId": userId,
          "originAgency": originAgency,
          "originAccount": originAccount,
          "destinationAgency": destinationAgency,
          "destinationAccount": destinationAccount,
          "amount": amount
        },
      ),
    );
    return resp;
  }

  static Future<http.Response> getTransfers(userId) async {
    var resp = await http.get(
        Uri.parse("$base_url/users/$userId/transfers-history"),
        headers: headers);
    return resp;
  }

  static Future<http.Response> newPixKey(userId) async {
    var resp = await http.post(Uri.parse("$base_url/users/$userId/new-pixkey"));
    return resp;
  }

  static Future<http.Response> getPixKey(userId) async {
    var resp = await http.get(Uri.parse("$base_url/users/$userId/pix-keys"),
        headers: headers);
    return resp;
  }

  static Future<http.Response> newPixTransfer(
      userId, originKey, destinationKey, amount) async {
    var resp = await http.post(
      Uri.parse("$base_url/users/$userId/new-pix-transfer"),
      headers: headers,
      body: jsonEncode({
        "originKey": originKey,
        "destinationKey": destinationKey,
        "amount": amount
      }),
    );
    return resp;
  }

  static Future<http.Response> verifyPassword(id, password) async {
    var resp = await http.post(
      Uri.parse("$base_url/user/$id/verify-password"),
      headers: headers,
      body: jsonEncode({"pass": password}),
    );
    return resp;
  }

  static Future<http.Response> getUserByPixKey(pixKey) async {
    var resp = await http.get(Uri.parse("$base_url/pix-key/$pixKey/user-id"),
        headers: headers);
    return resp;
  }

  static Future<http.Response> getUserPixKey(userId) async {
    var resp = await http.get(Uri.parse("$base_url/users/$userId/pix-key"),
        headers: headers);
    return resp;
  }

  static Future<http.Response> getTransfer(transferId) async {
    var resp = await http.get(Uri.parse("$base_url/transfers/$transferId"),
        headers: headers);
    return resp;
  }

  static Future<http.Response> getPixTransfers(userId, key) async {
    var resp = await http.get(
        Uri.parse("$base_url/users/$userId/key/$key/pix-transfers-history"),
        headers: headers);
    return resp;
  }

  static Future<http.Response> getPixTransfer(transferId) async {
    var resp = await http.get(Uri.parse("$base_url/pix-transfer/$transferId"),
        headers: headers);
    return resp;
  }

  static Future<http.Response> getUserData(userId) async {
    var resp =
        await http.get(Uri.parse("$base_url/users/$userId"), headers: headers);
    return resp;
  }

  static Future<http.Response> newContact(
      userId, contactName, contactId) async {
    var resp = await http.post(
      Uri.parse("$base_url/users/$userId/contacts"),
      headers: headers,
      body: jsonEncode(
        {"name": contactName, "contactId": contactId},
      ),
    );
    print(resp);
    return resp;
  }

  static Future<http.Response> getContacts(userId) async {
    var resp = await http.get(Uri.parse("$base_url/users/$userId/contacts"),
        headers: headers);
    return resp;
  }
}
