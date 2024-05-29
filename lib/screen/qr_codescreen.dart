import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:provider/provider.dart';
import 'package:smartshop/models/cart_model.dart';
import 'package:smartshop/utils/widgets/app_bar.dart';
import 'package:smartshop/utils/widgets/app_bottom_nav_bar.dart';
import 'package:smartshop/utils/widgets/scaffold_app_bar.dart';
import '../provider/cart_prov.dart';
import '../utils/widgets/drawer.dart';

class QRCodePage extends StatefulWidget {
  const QRCodePage({super.key});

  @override
  State<QRCodePage> createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage> {
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
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            AppBaar(
              scaffoldKey: _scaffoldKey,
            ),
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
              padding: const EdgeInsets.only(left: 8),
              height: 300,
              width: MediaQuery.of(context).size.width,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: Consumer<CartProvider>(
                builder: (context, cart, child) {
                  String data = "Nom des produits: \n";
                  for (CartModel item in cart.cartItems) {
                    data +=
                        "- ${item.productModel.name}, , ${item.quantity} piéces \n, Prix: ${item.productModel.price} DT";
                  }
                  NumberFormat formatter = NumberFormat('##0.00');

                  data +=
                      "Prix totale: ${formatter.format(cart.totalprice)} DT";
                  return Center(
                    child: PrettyQr(
                      data: data,
                      size: 250,
                    ),
                  );
                },
              ),
            ),
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
