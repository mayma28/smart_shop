import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:molten_navigationbar_flutter/molten_navigationbar_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smartshop/provider/cart_prov.dart';
import 'package:smartshop/screen/history/historicscreen.dart';
import 'package:smartshop/utils/widgets/app_bar.dart';
import 'package:smartshop/utils/theme/colors.dart';
import 'package:smartshop/utils/widgets/scaffold_app_bar.dart';
import 'package:smartshop/utils/widgets/suggested_products.dart';
import '../models/product_model.dart';
import '../utils/widgets/alert_snack_bar.dart';
import '../utils/widgets/drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  ProductModel? scannedProduct;
  ProductModel? productModel;
  String? productID;
  List<ProductModel> items = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _scanBarcode() async {
    try {
      final barcodeResult = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Annuler',
        true,
        ScanMode.BARCODE,
      );
      await getData(barcodeResult: barcodeResult);
    } catch (e) {
      // Handle error
      print('Error in _scanBarcode: $e');
    }
  }

  Future getData({required String barcodeResult}) async {
    print(barcodeResult);
    try {
      final value = await FirebaseFirestore.instance
          .collection('produits')
          .doc(barcodeResult)
          .get();
      if (value.exists) {
        setState(() {
          productModel = ProductModel.fromJson(value.data()!);
          productID=barcodeResult;
        });
      } else {
        setState(() {
          productModel = null;
          productID=null;
        });
        print('Product not found');
        showErrorSnackBar(context, "Produits invalide");
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar(),
      key: _scaffoldKey,
      drawer: const showDrawer(),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            AppBaar(
              scaffoldKey: _scaffoldKey,
            ),
            const SizedBox(height: 30),
            const Text(
              'Scanner le code de produits que vous\n voulez acheter.',
              style: TextStyle(
                fontSize: 20,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            if (productModel == null) const SizedBox(height: 50),
            productModel != null
                ? SizedBox(
                    child: Card(
                      child: Consumer<CartProvider>(
                        builder: (context, cart, child) {
                          return Column(
                            children: [
                              Image.network(productModel!.image, height: 200),
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
                                            .name), // Add null check
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
                                      text: productModel!.price.toString(),
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
                                            .add(productID!, 1)
                                      },
                                      icon: const Icon(
                                          Icons.add_shopping_cart_outlined),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  )
                : const MySuggestedProducts(),
          ],
        ),
      ),
      bottomNavigationBar: MoltenBottomNavigationBar(
        selectedIndex: _selectedIndex,
        domeCircleColor: const Color(0xfffac49b),
        barColor: GlobalColors.AppBarColor,
        domeHeight: 16,
        domeCircleSize: 65,
        borderRaduis: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        tabs: [
          MoltenTab(
            icon: Icon(Icons.home,
                color: _selectedIndex == 0
                    ? const Color(0xff1640af)
                    : Colors.white,
                size: 45),
          ),
          MoltenTab(
            icon: Icon(Icons.qr_code_scanner_outlined,
                color: _selectedIndex == 1
                    ? const Color(0xff1640af)
                    : Colors.white,
                size: 45),
          ),
          MoltenTab(
            icon: Icon(Icons.history_outlined,
                color: _selectedIndex == 2
                    ? const Color(0xff1640af)
                    : Colors.white,
                size: 45),
          ),
        ],
        onTabChange: (clickedIndex) {
          if (clickedIndex == 0) {
          } else if (clickedIndex == 1) {
            // Check if the QR code scanner icon is clicked
            _scanBarcode();
            // Call the _scanBarcode() function
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HistoricScreen(),
              ),
            );
          }
          setState(
            () {
              _selectedIndex = clickedIndex;
            },
          );
        },
      ),
    );
  }
}
