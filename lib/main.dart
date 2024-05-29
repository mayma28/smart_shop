import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:smartshop/provider/cart_prov.dart';
import 'package:smartshop/screen/splashscreen.dart';
import 'package:smartshop/utils/router/routers.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return CartProvider();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: AppRoute.routes,
        home: SplashScreen(),
      ),
    );
  }
}
