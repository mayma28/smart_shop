import 'package:flutter/material.dart';
import 'package:smartshop/screen/homescreen.dart';
import 'package:smartshop/screen/users/login/loginscreen.dart';
import 'package:smartshop/screen/users/register/registerscreen.dart';
import 'package:smartshop/utils/colors.dart';

class Welcomscreen extends StatefulWidget {
  const Welcomscreen({Key? key}) : super(key: key);

  @override
  State<Welcomscreen> createState() => _WelcomscreenState();
}

class _WelcomscreenState extends State<Welcomscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: Container(
          decoration: BoxDecoration(
            color: GlobalColors.AppBarColor,
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 28),
              // height: size.height * 0.063,
              child: const Image(
                height: 105,
                width: 251,
                image: AssetImage('assets/images/logo.png'),
              ),
            ),
            const SizedBox(height: 25),
            const Image(
              height: 380,
              width: 460,
              image: AssetImage('assets/images/intro.png'),
            ),
            // const SizedBox(height: 5),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: GlobalColors.ButtonColor,
              ),
              width: MediaQuery.of(context).size.width * 0.5,
              alignment: AlignmentDirectional.center,
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const LoginScreen();
                      },
                    ),
                  );
                },
                child: const Text(
                  "Se connecter",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: GlobalColors.ButtonColor,
              ),
              width: MediaQuery.of(context).size.width * 0.5,
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const RegisterScreen();
                      },
                    ),
                  );
                },
                child: const Text(
                  "S'inscrire",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 28.2,
            ),
            Container(
              height: 60,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: GlobalColors.AppBarColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
