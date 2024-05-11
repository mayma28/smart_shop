import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../models/product_model.dart';

class BarCodeScanner extends StatefulWidget {
  const BarCodeScanner({super.key});

  @override
  State<BarCodeScanner> createState() => _BarCodeScannerState();
}

class _BarCodeScannerState extends State<BarCodeScanner> {
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
      body: Center(),
    );
  }
}
