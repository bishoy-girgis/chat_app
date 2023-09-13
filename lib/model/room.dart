class Room {
  static const String collectionName = "room";
  String? id;
  String? title;
  String? description;
  String? catId;

  Room({this.id, this.description, this.title, this.catId});

  Room.fromFireStore(Map<String, dynamic> json)
      : this(
            id: json["id"],
            description: json["description"],
            catId: json["catId"],
            title: json["title"]);

  Map<String, dynamic> toFireStore() {
    return {
      "id": id,
      "description": description,
      "title": title,
      "catId": catId
    };
  }
}
