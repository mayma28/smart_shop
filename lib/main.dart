import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:smartshop/provider/cart_prov.dart';
import 'package:smartshop/screen/cartscreen.dart';
import 'package:smartshop/screen/splashscreen.dart';
import 'package:smartshop/screen/users/login/loginscreen.dart';
import 'package:smartshop/screen/users/signup/signupscreen.dart';
import 'package:smartshop/screen/welcom/welcomscreen.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:smartshop/screen/homescreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
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
          "splash": (context) => const SplashScreen(),
          "welcome": (context) => const Welcomscreen(),
          "signup": (context) => const SignUpScreen(),
          "login": (context) => const LoginPage(),
          "homepage": (context) => const HomePage(),
          "cart": (context) => const CartScreen(),
        },
        home: const SignUpScreen(),
      ),
    );
  }
}
