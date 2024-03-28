import 'package:flutter/material.dart';
import 'package:smartshop/screen/homescreen.dart';
import 'package:smartshop/screen/users/login/loginscreen.dart';
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(8),
            alignment: AlignmentDirectional.center,
            child: MaterialButton(
              color: GlobalColors.ButtonColor,
              padding: EdgeInsets.all(18),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return HomePage();
                    },
                  ),
                );
              },
              child: Text(
                "Se connecter en tant que passager",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.54,
            child: MaterialButton(
              color: GlobalColors.ButtonColor,
              padding: EdgeInsets.all(18),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginPage();
                    },
                  ),
                );
              },
              child: Text(
                "Se connecter en tant que Client",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
