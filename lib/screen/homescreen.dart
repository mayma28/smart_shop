import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:smartshop/provider/cart_prov.dart';
import 'package:smartshop/screen/cartscreen.dart';
import 'package:smartshop/utils/colors.dart';
import '../models/product_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ProductModel? productModel;
  List<ProductModel> items = [];

  Future<void> _scanBarcode() async {
    try {
      final barcodeResult = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Annuler',
        true,
        ScanMode.BARCODE,
      );
      setState(() {});
      getData(barcodeResult: barcodeResult);
    } catch (e) {
      // Handle error
      print('Error in _scanBarcode: $e');
    }
  }

  void getData({required String barcodeResult}) async {
    // Retrieve data from the 'produits' collection with a document ID equal to barcodeResult
    await FirebaseFirestore.instance
        .collection('produits')
        .doc(barcodeResult)
        .get()

        // Once data is retrieved, convert it to a ProductModel object
        .then((value) {
      if (value.exists) {
        setState(() {
          productModel = ProductModel.fromJson(value.data()!);
          print(productModel!.name);
        });
      } else {
        setState(() {
          productModel = null; // Reset productModel to null if not found
        });
        print('Product not found');
      }
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
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
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
                      icon: const Icon(Icons.local_mall, size: 37),
                      onPressed: () => {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return const CartScreen();
                            },
                          ),
                        )
                      },
                    ),
                    Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Consumer<CartProvider>(
                          builder: (context, cart, child) {
                            return Text("${cart.count}");
                          },
                        ))
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Scanner le code de produits que vous\n voulez acheter.',
              style: TextStyle(
                fontSize: 20,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 295,
                    child: GridView.count(
                      crossAxisCount: 1,
                      children: <Widget>[
                        if (productModel != null)
                          Card(
                            child: Consumer<CartProvider>(
                              builder: (context, cart, child) {
                                return Column(
                                  children: [
                                    Image.network(productModel!.image!,
                                        height: 200),
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          const TextSpan(
                                            text: 'Nom : ',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontStyle: FontStyle.italic,
                                            ),
                                          ),
                                          TextSpan(
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontStyle: FontStyle.italic,
                                              ),
                                              text: productModel!
                                                  .name!), // Add null check
                                        ],
                                      ),
                                    ),
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          const TextSpan(
                                            text: 'Prix : ',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontStyle: FontStyle.italic,
                                            ),
                                          ),
                                          TextSpan(
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontStyle: FontStyle.italic,
                                            ),
                                            text:
                                                productModel!.price!.toString(),
                                          ), // Add null check
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          alignment: Alignment.bottomRight,
                                          child: IconButton(
                                            onPressed: () => {
                                              Provider.of<CartProvider>(context,
                                                      listen: false)
                                                  .add(productModel!, 1)
                                            },
                                            icon: const Icon(Icons
                                                .add_shopping_cart_outlined),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                );
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 176.0),
              child: Column(
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
                          onPressed: () => _scanBarcode(),
                          icon: const Icon(Icons.barcode_reader,
                              color: Colors.white, size: 35),
                        ),
                        IconButton(
                          onPressed: () => const HomePage(),
                          icon: const Icon(
                            Icons.home,
                            color: Colors.white,
                            size: 35,
                          ),
                        ),
                        IconButton(
                          onPressed: _scanBarcode,
                          icon: const Icon(Icons.settings,
                              color: Colors.white, size: 35),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      color: GlobalColors.AppBarColor,
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
}
