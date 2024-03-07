import 'package:flutter/material.dart';
import 'package:smartshop/models/product_model.dart';

class CartItem extends ChangeNotifier {
  List<ProductModel> products = [];

  addProduct(ProductModel productModel) {
    products.add(productModel);
    notifyListeners();
  }
}
