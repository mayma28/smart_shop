import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smartshop/models/cart_model.dart';
import 'package:smartshop/models/product_model.dart';

class CartProvider with ChangeNotifier {
  final List<CartModel> _cartItems = [];
  double _price = 0.0;

  List<CartModel> get cartItems => _cartItems;

  void addPurchaseToFirestore(String? product, double price, int quantity) {
  FirebaseFirestore.instance
      .collection('purchases')
      .where('product Name', isEqualTo: product)
      .get()
      .then((querySnapshot) {
    if (querySnapshot.docs.isNotEmpty) {
      final existingDoc = querySnapshot.docs.first;
      final existingQuantity = existingDoc['quantity'];
      final newQuantity = existingQuantity + quantity;

      // Update the existing document with the new quantity
      try {
        existingDoc.reference.update({'quantity': newQuantity});
        print('Quantity updated successfully');
      } catch (e) {
        print('Error updating quantity: $e');
      }
    } else {
      // If the product doesn't exist, add it as a new purchase
      FirebaseFirestore.instance.collection('purchases').add({
        'product Name': product,
        'price': price,
        'quantity': quantity,
        'timestamp': Timestamp.now(),
      }).then((_) => print('New purchase added'));
    }
  }).catchError((error) {
    print('Error fetching document: $error');
  });
}


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
    // Call addPurchaseToFirestore here
    addPurchaseToFirestore(product.name, product.price ?? 0.0, quantity);
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

  void updateQuantityInFirestore(String? productName, int quantity) {
  FirebaseFirestore.instance
      .collection('purchases')
      .where('product Name', isEqualTo: productName)
      .get()
      .then((querySnapshot) {
    if (querySnapshot.docs.isNotEmpty) {
      final existingDoc = querySnapshot.docs.first;
      try {
        existingDoc.reference.update({'quantity': quantity});
        print('Quantity updated successfully');
      } catch (e) {
        print('Error updating quantity: $e');
      }
    }
  }).catchError((error) {
    print('Error fetching document: $error');
  });
}

void removeItemFromFirestore(String? productName) {
  FirebaseFirestore.instance
      .collection('purchases')
      .where('product Name', isEqualTo: productName)
      .get()
      .then((querySnapshot) {
    if (querySnapshot.docs.isNotEmpty) {
      final existingDoc = querySnapshot.docs.first;
      try {
        existingDoc.reference.delete();
        print('Item removed from Firestore successfully');
      } catch (e) {
        print('Error removing item from Firestore: $e');
      }
    }
  }).catchError((error) {
    print('Error fetching document: $error');
  });
}

void increaseQuantity(CartModel cartItem) {
  // Find the index of the cartItem in the _cartItems list
  int index = _cartItems.indexWhere((item) => item == cartItem);
  if (index != -1) {
    // Increment the quantity of the specified cart item
    _cartItems[index].quantity++;
    // Increment the total price accordingly
    _price += _cartItems[index].productModel.price ?? 0.0;
    // Notify listeners of the change
    notifyListeners();
    // Update the corresponding document in Firestore
    updateQuantityInFirestore(cartItem.productModel.name, _cartItems[index].quantity);
  }
}

void decreaseQuantity(CartModel cartItem) {
  // Find the index of the cartItem in the _cartItems list
  int index = _cartItems.indexWhere((item) => item == cartItem);
  if (index != -1) {
    // Decrease the quantity of the specified cart item
    if (_cartItems[index].quantity > 1) {
      _cartItems[index].quantity--;
      // Decrease the total price accordingly
      _price -= _cartItems[index].productModel.price ?? 0.0;
      // Notify listeners of the change
      notifyListeners();
      // Update the corresponding document in Firestore
      updateQuantityInFirestore(cartItem.productModel.name, _cartItems[index].quantity);
    } else {
      // If quantity becomes zero, remove the product from the cart
      _cartItems.removeAt(index);
      _price -= cartItem.productModel.price ?? 0.0;
      // Notify listeners of the change
      notifyListeners();
      // Remove the corresponding document from Firestore
      removeItemFromFirestore(cartItem.productModel.name);
    }
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
