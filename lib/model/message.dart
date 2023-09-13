class Message {
  static const String collectionName = "Message";
  String? id;
  String? content;
  String? senderId;
  String? senderName;
  int? dateTime;
  String? roomId;

  Message(
      {this.dateTime,
      this.id,
      this.content,
      this.roomId,
      this.senderId,
      this.senderName});

  Message.fromFireStore(Map<String, dynamic> json)
      : this(
            id: json["id"],
            content: json["content"],
            dateTime: json["dateTime"],
            roomId: json["roomId"],
            senderId: json["senderId"],
            senderName: json["senderName"]);

  Map<String, dynamic> toFireStore() {
    return {
      "id": id,
      "content": content,
      "senderName": senderName,
      "senderId": senderId,
      "dateTime": dateTime,
      "roomId": roomId,
    };
  }
}
