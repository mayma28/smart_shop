import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smartshop/screen/history/purchasehistorylist.dart';
import 'package:smartshop/utils/widgets/drawer.dart';
import 'package:smartshop/utils/widgets/scaffold_app_bar.dart';
import '../../utils/widgets/app_bar.dart';
import '../../utils/widgets/app_bottom_nav_bar.dart';

class HistoricScreen extends StatefulWidget {
  const HistoricScreen({super.key});

  @override
  State<HistoricScreen> createState() => _HistoricScreenState();
}

class _HistoricScreenState extends State<HistoricScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar(),
      key: _scaffoldKey,
      drawer: showDrawer(),
      bottomNavigationBar: AppBottomNavBar(
        selectedIndex: 2,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppBaar(
              scaffoldKey: _scaffoldKey,
            ),
            const SizedBox(height: 30),
            const Text(
              'Historique d’achat.',
              style: TextStyle(
                fontSize: 20,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              padding: const EdgeInsets.all(10),
              height: 450,
              width: MediaQuery.of(context).size.width,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: PurchaseHistoryList(),
            ),
          ],
        ),
      ),
    );
  }
}
