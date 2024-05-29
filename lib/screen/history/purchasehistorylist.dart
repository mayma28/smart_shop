import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smartshop/screen/purchase_cart.dart';
import 'package:smartshop/services/authentication.dart';

class PurchaseHistoryList extends StatefulWidget {
  const PurchaseHistoryList({Key? key}) : super(key: key);

  @override
  State<PurchaseHistoryList> createState() => _PurchaseHistoryListState();
}

class _PurchaseHistoryListState extends State<PurchaseHistoryList> {
  String userID = "";
  @override
  void initState() {
    userID = AuthServices().getUser()!.uid;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      future:
          FirebaseFirestore.instance.collection('history').doc(userID).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.all(30.0),
            child: CircularProgressIndicator(),
          );
        }
        final data = snapshot.data!.data();
        if (data == null) {
          return const Center(
              child: Text(
            "Vous n'avez pas des achats",
            style: TextStyle(fontSize: 18),
          ));
        } else {
          final history = data['history'] as List<dynamic>;
          return ListView.builder(
            itemCount: history.length,
            itemBuilder: (context, index) {
              Map purchase = history[history.length-index-1];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PurchaseCartScreen(
                        purchase: purchase,
                      ),
                    ),
                  );
                },
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 163, 163, 163),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      '${purchase['date']}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
