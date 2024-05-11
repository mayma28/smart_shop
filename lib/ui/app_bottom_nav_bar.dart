import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:molten_navigationbar_flutter/molten_navigationbar_flutter.dart';
import 'package:smartshop/models/product_model.dart';
import 'package:smartshop/utils/colors.dart';

import '../screen/history/historicscreen.dart';
import '../screen/homescreen.dart';
// import 'package:go_router/go_router.dart';

class AppBottomNavBar extends StatefulWidget {
  const AppBottomNavBar({
    Key? key,
  });

  @override
  State<AppBottomNavBar> createState() => _AppBottomNavBarState();
}

class _AppBottomNavBarState extends State<AppBottomNavBar> {
  int _selectedIndex = 0;
  ProductModel? productModel;
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
          // Pass the scanned product data to the callback function
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
    return MoltenBottomNavigationBar(
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
              ));
        } else if (clickedIndex == 1) {
          // Check if the QR code scanner icon is clicked
          _scanBarcode();
          // Call the _scanBarcode() function
        } else if (clickedIndex == 2) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HistoricScreen(),
              ));
        }
        setState(
          () {
            _selectedIndex = clickedIndex;
          },
        );
      },
    );
  }
}
