class PixTransfer {
  int id;
  int userId;
  String originKey;
  String destinationKey;
  double amount;
  PixTransfer(
      this.id, this.userId, this.originKey, this.destinationKey, this.amount);
  PixTransfer.fromJson(Map json)
      : id = json["id"],
        userId = json["userId"],
        originKey = json["originKey"],
        destinationKey = json["destinationKey"],
        amount = json["amount"];
}
