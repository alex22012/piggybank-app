class PixKey {
  int userId;
  String key;
  PixKey(this.userId, this.key);
  PixKey.fromJson(Map json)
      : userId = json["userId"],
        key = json["key"];
}
