class CartModel {
  String? name;
  String? price;
  String? image;
  int? quantity;
  double? totalPrice;

  CartModel({
    required this.name,
    required this.price,
    required this.image,
    required this.quantity,
    required this.totalPrice,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    image = json["image"];
    name = json["name"];
    price = json["price"];
    quantity = json['quantity'];
    totalPrice = json["price"];
  }
  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'name': name,
      'price': price,
      'quantity': quantity,
      'totalPrice': totalPrice,
    };
  }
}
