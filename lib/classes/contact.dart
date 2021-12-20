class Contact {
  int userId;
  String name;
  int contactId;
  Contact(this.userId, this.name, this.contactId);
  Contact.fromJson(Map json)
      : userId = json["userId"],
        name = json["name"],
        contactId = json["contactId"];
}
