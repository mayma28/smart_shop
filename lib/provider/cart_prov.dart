import 'package:flutter/material.dart';
import 'package:smartshop/models/cart_model.dart';
import 'package:smartshop/models/product_model.dart';

class CartProvider with ChangeNotifier {
  List<ProductModel> _items = [];
  final List<CartModel> _cartItems = [];
  List<CartModel> get cartItems => _cartItems;

  double price = 0;
 int quantity = 1;

  void add(ProductModel item , int quantity) {
    var isExist = _cartItems.where((element) => element.productModel.name == item.name);
    if (isExist.isEmpty) {
      _items.add(item);
      price += item.price!;
    } else
      isExist.first.quantity += 1;
    notifyListeners();
  }

  int getProductQuantity(int productId) {
    int quantity = 0;
    for (CartModel item in _cartItems) {
      if (item.productModel == 1) {
        quantity += item.quantity;
      }
    }
    return quantity;
  }

  void remove(ProductModel item) {
    _items.remove(item);
    price -= item.price!;
    notifyListeners();
  }

  int get count {
    return _items.length;
  }

  double get totalPrice {
    return price;
  }
  void updateCartItemQuantity(int index, int newQuantity) {
    if (index >= 0 && index < _cartItems.length) {
      _cartItems[index].quantity = newQuantity;
      notifyListeners();
    }
  }

  void increaseCartItemQuantity(int index) {
    if (index >= 0 && index < _cartItems.length) {
      _cartItems[index].quantity++;
      notifyListeners();
    }
  }

  void decreaseCartItemQuantity(int index) {
    if (index >= 0 && index < _cartItems.length) {
      if (_cartItems[index].quantity > 1) {
        _cartItems[index].quantity--;
        notifyListeners();
      } else {
        // If the quantity is 1, remove the item from the cart
        _cartItems.removeAt(index);
        notifyListeners();
      }
    }
  }
  

  List<ProductModel> get cartItem {
    return _items;
  }
}







