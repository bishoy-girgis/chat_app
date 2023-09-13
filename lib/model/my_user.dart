class MyUser {
  static const String collectionName = "users";
  String? id;
  String? userName;
  String? fullName;
  String? email;

  MyUser({this.id, this.userName, this.email, this.fullName});

  MyUser.fromFireStore(Map<String, dynamic> json)
      : this(
          id: json["id"],
          email: json["email"],
          fullName: json["fullName"],
          userName: json["userName"],
        );

  Map<String, dynamic> toFireStore() {
    return {
      "id": id,
      "email": email,
      "userName": userName,
      "fullName": fullName,
    };
  }
}
