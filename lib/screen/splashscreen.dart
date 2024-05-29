import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartshop/screen/homescreen.dart';
import 'package:smartshop/screen/welcomscreen.dart';

import '../models/users.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  getData() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      setState(
        () {
          final userData = snapshot.data()!;
          UserM.current = UserM(
            email: userData['email'],
            id: userData['id'],
            name: userData['name'],
            password: userData['password'],
            cin: userData['cin'],
            cardID: userData['cardID'],
          );
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
    Timer(
      const Duration(seconds: 5),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return FirebaseAuth.instance.currentUser == null
                ? const Welcomscreen()
                : const HomeScreen();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/splashscreen.png",
            ),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
