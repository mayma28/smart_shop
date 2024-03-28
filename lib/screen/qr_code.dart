import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:provider/provider.dart';

import '../provider/cart_prov.dart';
import 'homescreen.dart';

class QRCodePage extends StatefulWidget {
  const QRCodePage({super.key});

  @override
  State<QRCodePage> createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage> {
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
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.shopping_cart_outlined, size: 37),
                      onPressed: () => {},
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Consumer<CartProvider>(
                        builder: (context, cart, child) {
                          return Text("${cart.count}");
                        },
                      ),
                    )
                  ],
                ),
              ],
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
            const SizedBox(height: 70),
            Consumer<CartProvider>(
              builder: (context, cart, child) {
                return PrettyQr(
                  data: "${cart.totalprice.toStringAsFixed(3)} DT",
                  size: 300,
                );
              },
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                Container(
                  // margin: EdgeInsets.symmetric(vertical: 5),
                  // padding: EdgeInsets.all(10),
                  // height: 350,
                  width: MediaQuery.of(context).size.width,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                ),
                const Divider(
                  color: Colors.black,
                  indent: Checkbox.width,
                  endIndent: Checkbox.width,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Consumer<CartProvider>(
                    builder: (context, cart, child) {
                      return Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Prix totale = ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
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
            Column(
              children: [
                Container(
                  height: 50,
                  width: 270,
                  decoration: const BoxDecoration(
                    color: Color(0xff0e3baf),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: () => {},
                        icon: const Icon(Icons.barcode_reader,
                            color: Colors.white, size: 35),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const HomePage();
                          }));
                        },
                        icon: const Icon(
                          Icons.home,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.settings,
                            color: Colors.white, size: 35),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
