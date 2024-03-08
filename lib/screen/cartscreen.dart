import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartshop/models/product_model.dart';
import 'package:smartshop/provider/cartItem.dart';
import 'package:smartshop/screen/homepage.dart';
import '../models/cart_model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({
    super.key,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("my cart"),
      ),
      body: Consumer<Cart>(
        builder: (context, cart, child) {
          return ListView.builder(
            itemCount: cart.cartitem.length,
            itemBuilder: (context, i) {
              return Card(
                child: ListTile(
                  title: Text("${cart.cartitem[i].name}"),
                  trailing: IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      cart.remove(cart.cartitem[i]);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
