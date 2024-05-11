import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:molten_navigationbar_flutter/molten_navigationbar_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smartshop/provider/cart_prov.dart';
import 'package:smartshop/screen/history/historicscreen.dart';
import 'package:smartshop/ui/app_bar.dart';
import 'package:smartshop/utils/colors.dart';
import '../models/product_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  ProductModel? scannedProduct;
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
      bottomNavigationBar: MoltenBottomNavigationBar(
        selectedIndex: _selectedIndex,
        domeCircleColor: Color(0xfffac49b),
        barColor: GlobalColors.AppBarColor,
        domeHeight: 16,
        domeCircleSize: 65,
        borderRaduis: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        tabs: [
          MoltenTab(
            icon: Icon(Icons.home,
                color: _selectedIndex == 0 ? Color(0xff1640af) : Colors.white,
                size: 45),
          ),
          MoltenTab(
            icon: Icon(Icons.qr_code_scanner_outlined,
                color: _selectedIndex == 1 ? Color(0xff1640af) : Colors.white,
                size: 45),
          ),
          MoltenTab(
            icon: Icon(Icons.history_outlined,
                color: _selectedIndex == 2 ? Color(0xff1640af) : Colors.white,
                size: 45),
          ),
        ],
        onTabChange: (clickedIndex) {
          if (clickedIndex == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ),
            );
          } else if (clickedIndex == 1) {
            // Check if the QR code scanner icon is clicked
            _scanBarcode();
            // Call the _scanBarcode() function
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HistoricScreen(),
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
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            const AppBaar(),
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
          ],
        ),
      ),
    );
  }
}
