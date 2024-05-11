import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:smartshop/navigation/app_router.dart';
import 'package:smartshop/provider/cart_prov.dart';
import 'package:smartshop/screen/cartscreen.dart';
import 'package:smartshop/screen/homescreen.dart';
import 'package:smartshop/screen/services/forgotpassword.dart';
import 'package:smartshop/screen/users/login/loginscreen.dart';
import 'package:smartshop/screen/users/register/registerscreen.dart';
import 'package:smartshop/screen/welcom/welcomscreen.dart';
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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return CartProvider();
      },
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: RegisterScreen(),
      ),
      // child: MaterialApp.router(
      //   debugShowCheckedModeBanner: false,
      //   routerConfig: AppRouter().router,
      // ),
    );
  }
}
