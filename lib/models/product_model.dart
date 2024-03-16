class ProductModel {
  String? id;
  String? name;
  double? price;
  String? image;

  ProductModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    image = json["image"];
    price = json["price"];
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'name': name,
      'price': price,
    };
  }
}
