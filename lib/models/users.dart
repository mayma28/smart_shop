class UserM {
  String id;
  String name;
  String email;
  String password;
  String cin;
  String cardID;

  UserM({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.cin,
    required this.cardID,
  });
  static UserM? current;
  factory UserM.fromJson(Map<String, dynamic> j) => UserM(
      id: j["id"],
      name: j["name"],
      email: j["email"],
      password: j["password"],
      cin: j["cin"],
      cardID: j["cardID"]);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      "password": password,
      "cin": cin,
      "cardID": cardID,
    };
  }
}
