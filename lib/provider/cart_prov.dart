import 'package:flutter/material.dart';
import 'package:smartshop/models/cart_model.dart';
import 'package:smartshop/models/product_model.dart';

class CartProvider with ChangeNotifier {
  final List<CartModel> _cartItems = [];
  double _price = 0.0;

  List<CartModel> get cartItems => _cartItems;


  void add(ProductModel product, int quantity) {
    // Check if the product already exists in the cart
    int index =
        _cartItems.indexWhere((item) => item.productModel.name == product.name);
    if (index != -1) {
      // If the product exists, update its quantity
      _cartItems[index].quantity += quantity;
    } else {
      // If the product doesn't exist, add it to the cart
      _cartItems.add(CartModel(productModel: product, quantity: quantity));
    }
    _price += (product.price ?? 0.0) * quantity;
    notifyListeners();
  }

  void remove(ProductModel product) {
    // Find the index of the product in the cart
    int index =
        _cartItems.indexWhere((item) => item.productModel.name == product.name);
    if (index != -1) {
      // Subtract the price of the removed product from the total price
      _price -= (product.price ?? 0.0) * _cartItems[index].quantity;
      // Remove the product from the cart
      _cartItems.removeAt(index);
      notifyListeners();
    }
  }

  void increaseQuantity(CartModel cartItems) {
    cartItems.quantity++;
    _price += cartItems.productModel.price ?? 0.0;
    notifyListeners();
  }

  void decreaseQuantity(CartModel cartItem) {
    if (cartItem.quantity > 1) {
      cartItem.quantity--;
      _price -= cartItem.productModel.price ?? 0.0;
      notifyListeners();
    } else {
      // If quantity becomes zero, remove the product from the cart
      _cartItems.remove(cartItem);
      _price -= cartItem.productModel.price ?? 0.0;
      notifyListeners();
    }
  }

  int get count {
    return _cartItems.length;
  }

  double get totalprice {
    return _price;
  }

  List<ProductModel> get cartItem {
    return _cartItems.map((cartModel) => cartModel.productModel).toList();
  }
}
