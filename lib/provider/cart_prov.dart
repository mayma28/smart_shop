import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smartshop/models/cart_model.dart';
import 'package:smartshop/models/product_model.dart';

class CartProvider with ChangeNotifier {
  final List<CartModel> _cartItems = [];
  double _price = 0.0;

  List<CartModel> get cartItems => _cartItems;

  void add(String productID, int quantity) async{
    final prod = await FirebaseFirestore.instance.collection("produits").doc(productID).get();
    final product = ProductModel.fromJson(prod.data()!);
    int index =
        _cartItems.indexWhere((item) => item.productModel.name == product.name);
    if (index != -1) {
      _cartItems[index].quantity += quantity;
    } else {
      _cartItems.add(CartModel(productModel: product, quantity: quantity));
    }
    _price += (product.price) * quantity;
    notifyListeners();
  }

  void remove(ProductModel product) {
    // Find the index of the product in the cart
    int index =
        _cartItems.indexWhere((item) => item.productModel.name == product.name);
    if (index != -1) {
      // Subtract the price of the removed product from the total price
      _price -= (product.price) * _cartItems[index].quantity;
      // Remove the product from the cart
      _cartItems.removeAt(index);
      notifyListeners();
    }
  }

  void increaseQuantity(CartModel cartItems) {
    cartItems.quantity++;
    _price += cartItems.productModel.price;
    notifyListeners();
  }

  void decreaseQuantity(CartModel cartItem) {
    if (cartItem.quantity > 1) {
      cartItem.quantity--;
      _price -= cartItem.productModel.price;
      notifyListeners();
    } else {
      // If quantity becomes zero, remove the product from the cart
      _cartItems.remove(cartItem);
      _price -= cartItem.productModel.price;
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

  saveListToHistoric({required String userID}) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final date = DateTime.now();
    final y = date.year;
    final m = date.month;
    final d = date.day;
    final h = date.hour < 10 ? "0${date.hour}" : "${date.hour}";
    final min = date.minute < 10 ? "0${date.minute}" : "${date.minute}";

    NumberFormat formatter = NumberFormat('##0.00');
    Map purchase = {
      "date": "$d/$m/$y",
      "product": _cartItems.map((cartModel) {
        return {
          "name": cartModel.productModel.name,
          "quantity": cartModel.quantity,
        };
      }).toList(),
      "price": formatter.format(totalprice),
      "time": "$h:$min",
    };
    try {
      DocumentSnapshot doc =
          await _firestore.collection('history').doc(userID).get();
      if (doc.exists) {
        final documentData = doc.data() as Map<String, dynamic>?;
        final history = documentData!['history'] as List<dynamic>;
        history.add(purchase);
        await _firestore.collection('history').doc(userID).set({
          "history": history,
        });
      } else {
        await _firestore.collection('history').doc(userID).set({
          "history": [purchase],
        });
      }

      DocumentSnapshot suggDoc =
          await _firestore.collection('suggestion').doc(userID).get();
      if (suggDoc.exists) {
        final documentData = suggDoc.data() as Map<String, dynamic>?;
        final products = documentData!['products'] as List<dynamic>;
        for (final item in _cartItems) {
          final productID = item.productModel.id;
          final productQuantity = item.quantity;

          await FirebaseFirestore.instance.collection("produits").doc(productID).update({"quantity":FieldValue.increment(productQuantity*-1)},);

          bool found = false;
          for (int i = 0; i < products.length; i++) {
            if (products[i]["id"] == productID) {
              products[i]["times"] = products[i]["times"] + 1;
              found = true;
              break;
            }
          }
          if (!found) {
            products.add(
              {
                "id": productID,
                "name": item.productModel.name,
                "price": item.productModel.price,
                "image": item.productModel.image,
                "times": 1,
              },
            );
          }
        }
        print(products);
        await _firestore.collection('suggestion').doc(userID).set(
          {
            "products": products,
          },
        );
      } else {
        final products = [];
        for (final item in _cartItems) {
          products.add(
            {
              "id": item.productModel.id,
              "name": item.productModel.name,
              "price": item.productModel.price,
              "image": item.productModel.image,
              "times": 1,
            },
          );
        }
        await _firestore.collection('suggestion').doc(userID).set(
          {
            "products": products,
          },
        );
      }
      _cartItems.clear();
      _price = 0.0;
    } catch (e) {
      print('Error fetching document: $e');
    }
  }
}
