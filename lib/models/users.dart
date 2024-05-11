class UserM {
  String? id;
  String? name;
  String? email;

  UserM({
    required this.id,
    required this.name,
    required this.email,
  });
  UserM.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    email = json["email"];
    name = json["name"];
    
  }
  Map<String, dynamic> toMap() {
     return {
      'id': id,
      'email': email,
      'name': name,
    };
  }
}
