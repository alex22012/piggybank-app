class Account {
  int id;
  String agency;
  String account;
  double balance;
  Account(this.id, this.agency, this.account, this.balance);
  Account.fromJson(Map json)
      : id = json["userId"],
        agency = json["agency"],
        account = json["account"],
        balance = json["balance"];
}
