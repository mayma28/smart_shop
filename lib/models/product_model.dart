class ProductModel {
  
  String? name;
  double? price;
  String? image;

  ProductModel({
    
    required this.name,
    required this.image,
    required this.price,
  });

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
