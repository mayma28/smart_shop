import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:smartshop/provider/cart_prov.dart';
import 'package:smartshop/screen/cartscreen.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:smartshop/screen/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return CartProvider();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          /*  "signup": (context) => SignUpPage(),
        "login": (context) => LoginPage(),*/
          "homepage": (context) => const HomePage(),
          "cart": (context) => const CartScreen(),
        },
        home: const HomePage(),
      ),
    );
  }
}
