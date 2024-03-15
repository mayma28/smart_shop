import 'package:smartshop/models/product_model.dart';

class CartModel {
  final ProductModel productModel;
  int quantity;
  CartModel({
    required this.productModel,
    this.quantity = 1,
  });
}
