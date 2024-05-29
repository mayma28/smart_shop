import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:smartshop/screen/qr_codescreen.dart';
import 'package:smartshop/services/authentication.dart';
import 'package:smartshop/utils/widgets/app_bar.dart';
import 'package:smartshop/utils/widgets/app_bottom_nav_bar.dart';
import 'package:smartshop/utils/widgets/scaffold_app_bar.dart';

import '../provider/cart_prov.dart';
import '../utils/widgets/alert_snack_bar.dart';
import '../utils/widgets/drawer.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({
    super.key,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar(),
      key: _scaffoldKey,
      drawer: showDrawer(),
      bottomNavigationBar: AppBottomNavBar(
        selectedIndex: 0,
      ),
      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          return SingleChildScrollView(
            child: Column(
              children: [
                AppBaar(
                  scaffoldKey: _scaffoldKey,
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'Produits ajouter au panier.',
                  style: TextStyle(
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      padding: const EdgeInsets.all(10),
                      height: 350,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: cart.cartItem.isEmpty
                          ? const Center(
                              child: Text(
                                "Votre panier est vide",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            )
                          : ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              itemCount: cart.cartItem.length,
                              itemBuilder: (context, i) {
                                return Column(
                                  children: [
                                    ListTile(
                                      leading: Image.network(
                                        "${cart.cartItem[i].image}",
                                        height: 70,
                                        width: 70,
                                      ),
                                      title: Text(
                                        "${cart.cartItem[i].name}",
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Text(
                                        "Prix: ${cart.cartItem[i].price} DT",
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.remove),
                                            onPressed: () {
                                              cart.decreaseQuantity(
                                                  cart.cartItems[i]);
                                            },
                                          ),
                                          Text(
                                            cart.cartItems[i].quantity
                                                .toString(),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.add),
                                            onPressed: () {
                                              cart.increaseQuantity(
                                                  cart.cartItems[i]);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                    ),
                    const Divider(
                      color: Colors.black,
                      indent: Checkbox.width,
                      endIndent: Checkbox.width,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 18, top: 8),
                      child: Row(
                        children: [
                          const Text(
                            "Prix totale =",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "${cart.totalprice.toStringAsFixed(3)} DT",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    Container(
                      height: 43,
                      width: MediaQuery.of(context).size.width / 3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xffd9d9d9),
                      ),
                      child: MaterialButton(
                        onPressed: () async {
                          if (cart.cartItem.isEmpty) {
                            showErrorSnackBar(context, "Votre panier est vide");
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const QRCodePage();
                                },
                              ),
                            );
                            final currentUser = AuthServices().getUser();
                            await cart.saveListToHistoric(
                              userID: currentUser!.uid,
                            );
                          }
                        },
                        child: const Center(
                          child: Text(
                            "confirmer",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 13),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
