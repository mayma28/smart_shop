import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:provider/provider.dart';
import 'package:smartshop/models/product_model.dart';
import 'package:smartshop/ui/app_bar.dart';
import 'package:smartshop/ui/app_bottom_nav_bar.dart';

import '../provider/cart_prov.dart';

class QRCodePage extends StatefulWidget {
  const QRCodePage({super.key});

  @override
  State<QRCodePage> createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage> {
  ProductModel? scannedProduct;
// Callback function to receive scanned product data
  void onProductScanned(ProductModel? product) {
    setState(() {
      scannedProduct = product;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xfff7a644),
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            AppBaar(),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Votre QR code est :',
              style: TextStyle(
                fontSize: 20,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 50),
            Container(
              // margin: const EdgeInsets.symmetric(vertical: 5),
              padding: const EdgeInsets.only(left: 8),
              height: 300,
              width: MediaQuery.of(context).size.width,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: Consumer<CartProvider>(
                builder: (context, cart, child) {
                  return ListView.builder(
                    itemCount: cart.cartItem
                        .length, // Set itemCount to 1 as we only have one PrettyQr widget
                    itemBuilder: (context, i) {
                      return Center(
                        child: PrettyQr(
                          data:
                              "Nom de produit: ${cart.cartItem[i].name}, Prix: ${cart.cartItem[i].price} DT",
                          size: 250,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            // const SizedBox(height: 50),
            Column(
              children: [
                const Divider(
                  color: Colors.black,
                  indent: Checkbox.width,
                  endIndent: Checkbox.width,
                ),
                const SizedBox(height: 25),
                Container(
                  padding: const EdgeInsets.only(left: 18, top: 8),
                  child: Consumer<CartProvider>(
                    builder: (context, cart, child) {
                      return Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      );
                    },
                  ),
                ),
                const SizedBox(height: 68),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
