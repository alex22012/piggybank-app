class User {
  int id;
  String name;
  User(this.id, this.name);
  User.fromJson(Map json)
      : id = json["id"],
        name = json["name"];
}
