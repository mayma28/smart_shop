import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PurchaseHistoryList extends StatefulWidget {
  const PurchaseHistoryList({Key? key}) : super(key: key);

  @override
  State<PurchaseHistoryList> createState() => _PurchaseHistoryListState();
}

class _PurchaseHistoryListState extends State<PurchaseHistoryList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('purchases').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator(); // Show a loading indicator if data is not yet available
        }
        final purchases = snapshot.data!.docs;
        return ListView.builder(
          itemCount: purchases.length,
          itemBuilder: (context, index) {
            final purchase = purchases[index];
            final productName = purchase['product Name'];
            final price = purchase['price'];
            final quantity = purchase['quantity'];
            final timestamp = purchase['timestamp'];
            return ListTile(
              title: Text(productName),
              subtitle: Text(
                  'Price: ${price.toStringAsFixed(2)} DT | Quantity: $quantity'),
              trailing: Text(timestamp.toDate().toString()),
            );
          },
        );
      },
    );
  }
}
