class Transferencia {
  int id;
  int userId;
  String originAgency;
  String originAccount;
  String destinationAgency;
  String destinationAccount;
  double amount;
  Transferencia(this.id, this.userId, this.originAgency, this.originAccount,
      this.destinationAgency, this.destinationAccount, this.amount);
  Transferencia.fromJson(Map json)
      : id = json["id"],
        userId = json["userId"],
        originAgency = json["originAgency"],
        originAccount = json["originAccount"],
        destinationAgency = json["destinationAgency"],
        destinationAccount = json["destinationAccount"],
        amount = json["amount"];
}
