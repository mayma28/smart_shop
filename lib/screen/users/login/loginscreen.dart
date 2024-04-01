import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartshop/screen/homescreen.dart';
import 'package:smartshop/screen/users/signup/signupscreen.dart';
import 'package:smartshop/utils/colors.dart';

import '../users_auth/firebase_auth_implementation/firebase_auth_services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuthService _auth = FirebaseAuthService();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  bool visibility = true;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 7),
                  height: size.height * 0.063,
                  child: const Image(
                    image: AssetImage('assets/images/logo.png'),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  height: size.height * 0.325,
                  child: const Image(
                    image: AssetImage('assets/images/login.png'),
                  ),
                ),
                const SizedBox(height: 10),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 45),
                    child: SizedBox(
                      height: 212,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              "Email",
                              style: TextStyle(
                                  color: GlobalColors.TextColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            validator: (email) =>
                                email!.isEmpty ? "ne peux pas être vide" : null,
                            controller: _email,
                            decoration: const InputDecoration(
                              hintText: "Votre identifiant",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(19),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Container(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              "Mot de passe",
                              style: TextStyle(
                                  color: GlobalColors.TextColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            validator: (mdp) =>
                                mdp!.isEmpty ? "ne peux pas être vide" : null,
                            controller: _password,
                            obscureText: visibility,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    visibility = !visibility;
                                  });
                                },
                                icon: Icon(
                                  visibility
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.grey,
                                ),
                              ),
                              hintText: "*********",
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(19),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 7),
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width / 2.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: GlobalColors.ButtonColor,
              ),
              child: MaterialButton(
                onPressed: _signIn,
                child: const Center(
                  child: Text(
                    "Suivant",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Mot de passe oublier ?',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xffc5c5c5),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Vous n'êtes pas membre?",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ));
                  },
                  child: const Text(
                    "S'inscrire",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xff0e3baf),
                    ),
                  ),
                ),
              ],
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
  }void _signIn() async {
    String email = _email.text;
    String password = _password.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    if (user != null) {
      print("utilisateur connecté avec succée");
      Navigator.pushReplacementNamed(context, 'homepage');
    } else {
      print("error");
    }
  }
}
