class ProductModel {
  String id;
  String name;
  num price;
  String image;
  num quantity;

  ProductModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        price: json["price"],
        quantity: json["quantity"],
      );
  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'name': name,
      'price': price,
      'id': id,
      'quantity':quantity,
    };
  }
}
