import 'package:flutter/material.dart';
import 'package:smartshop/models/product_model.dart';

class Cart with ChangeNotifier {
  List<ProductModel> _products = [];
  double _price = 0.0;

  void addProduct(ProductModel productModel) {
    _products.add(productModel);
    _price += productModel.price as double;
    notifyListeners();
  }

  void remove(ProductModel productModel) {
    _products.add(productModel);
    _price -= productModel.price as double;
    notifyListeners();
  }

  int get count {
    return _products.length;
  }

  double get totalprice {
    return _price;
  }

  List<ProductModel> get cartitem {
    return _products;
  }
}
