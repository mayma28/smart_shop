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
  CartModel? cartModel;

  // void getData() async {
  //   await FirebaseFirestore.instance
  //       .collection('produits')
  //       .doc()
  //       .get()
  //       .then((value) {
  //     if (value.exists) {
  //       setState(() {
  //         cartModel = CartModel.fromJson(value.data()!);
  //         print(cartModel!.name);
  //       });
  //     } else {
  //       setState(() {
  //         cartModel = null; // Reset productModel to null if not found
  //       });
  //       print('Product not found');
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // List<ProductModel> products = Provider.of<CartItem>(context).products;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: Container(
          //
          decoration: const BoxDecoration(
            color: Color(0xfff7a644),
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.person_2_sharp, size: 37),
                ),
                const SizedBox(
                  height: 60,
                  width: 110,
                  child: Image(
                    image: AssetImage('assets/images/logo.png'),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const CartScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.shopping_cart_outlined, size: 37),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Produits ajouter au panier ',
                  style: TextStyle(
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Card(
              child: ListTile(
                title: Text(cartModel!.name!),
                subtitle: Text(cartModel!.price!),
                leading: Image.network(cartModel!.image!),
              ),
            ),
            // else
            //   Scaffold(
            //     body: Center(child: Text('Votre pannier est vide')),
            //   ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 493.0),
              child: Column(
                children: [
                  Container(
                    height: 55,
                    width: 270,
                    decoration: const BoxDecoration(
                      color: Color(0xff0e3baf),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.barcode_reader,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.home,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.settings,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    height: 60,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      color: Color(0xfff7a644),
                    ),
                    child: const Positioned(
                      bottom: 50,
                      right: 25,
                      child: Row(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // @override
  // void initState() {
  //   super.initState();
  //   getData();
  // }
}
