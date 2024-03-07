class ProductModel {
  String? name;
  String? price;
  String? image;

  ProductModel({required this.name, required this.price, required this.image});

  ProductModel.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    image = json["image"];
    price = json["price"];
  }
  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'name': name,
      'price': price,
    };
  }
}
