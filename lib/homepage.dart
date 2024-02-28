import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartshop/product_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // ignore:
  ProductModel? productModel; // Initialize with null value

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
    }
  }

  void getData({required String barcodeResult}) async {
    await FirebaseFirestore.instance
        .collection('produits')
        .doc(barcodeResult)
        .get()
        .then((value) {
      setState(() {
        productModel = ProductModel.fromJson(value.data()!);
        print(productModel!.name);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Barcode Scanner'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 16),
            if (productModel != null)
              Column(
                children: [
                  Image.network(productModel!.image!),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(productModel!.name!), // Add null check
                  Text(productModel!.price!), // Add null check
                ],
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _scanBarcode,
        tooltip: 'Scan Barcode',
        child: const Icon(Icons.qr_code),
      ),
    );
  }
}