import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smartshop/screen/welcom/welcomscreen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Welcomscreen();
      }));
    });
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/splashscreen.png"),
              fit: BoxFit.cover),
        ),
      ),
    );
  }
}
