import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:smartshop/screen/services/forgotpassword.dart';
import 'package:smartshop/screen/users/register/registerscreen.dart';
import 'package:smartshop/utils/colors.dart';

// import '../users_auth/firebase_auth_implementation/firebase_auth_services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = "", password = "";

  TextEditingController mailcontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();

  final _formkey = GlobalKey<FormState>();
  bool visibility = true;

  userLogin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      GoRouter.of(context).go('/home');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Aucun utilisateur n'a été trouvé pour cet e-mail",
              style: TextStyle(fontSize: 18.0),
            )));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Mauvais mot de passe fourni par l'utilisateur",
              style: TextStyle(fontSize: 18.0),
            )));
      }
    }
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
                  padding: const EdgeInsets.only(top: 15),
                  child: const Image(
                    height: 64.38,
                    width: 152.29,
                    image: AssetImage('assets/images/logo.png'),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                const Image(
                  height: 242,
                  width: 245,
                  image: AssetImage('assets/images/login.png'),
                ),
                const SizedBox(height: 5),
                Form(
                  key: _formkey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 45),
                    child: SizedBox(
                      height: 224,
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
                            validator: validateEmail,
                            controller: mailcontroller,
                            decoration: const InputDecoration(
                              hintText: "Votre Email",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(19),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
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
                            validator: validatePassword,
                            controller: passwordcontroller,
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
            const SizedBox(height: 6),
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width / 2.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: GlobalColors.ButtonColor,
              ),
              child: MaterialButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Row(
                        children: [
                          Icon(
                            Icons.error,
                            color: Colors.white,
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Veuillez saisir tous les champs",
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ],
                      ),
                      backgroundColor: Colors.orange,
                      dismissDirection: DismissDirection.horizontal,
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.only(bottom: 690, left: 5, right: 5),
                    ),
                  );
                  userLogin();
                },
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
            SizedBox(
              height: 33,
              child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgotPassword(),
                        ));
                  },
                  child: Text(
                    'Mot de passe oublier ?',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xffc5c5c5),
                    ),
                  )),
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
                          builder: (context) => const RegisterScreen(),
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
            // const SizedBox(height: 2),
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

  String? validateEmail(String? email) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (email!.isEmpty) {
      return 'Ce champ est obligatoire';
    }
    if (!regex.hasMatch(email)) {
      return 'S"il vous plaît, mettez une adresse email valide';
    } else {
      return null;
    }
  }

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Veuillez entrer un mot de passe.';
    }

    // Vérifier la longueur du mot de passe
    if (password.length < 6) {
      return 'Le mot de passe doit contenir au moin 6 caractères.';
    }

    // Vérifier la présence d'au moins une minuscule
    if (!password.contains(RegExp(r'[a-z]'))) {
      return 'Le mot de passe doit contenir au moins une lettre minuscule.';
    }

    // Vérifier la présence d'au moins une majuscule
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return 'Le mot de passe doit contenir au moins une lettre majuscule.';
    }

    // Vérifier la présence d'au moins un chiffre
    if (!password.contains(RegExp(r'[0-9]'))) {
      return 'Le mot de passe doit contenir au moins un chiffre.';
    }

    // Vérifier la présence d'au moins un caractère spécial
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Le mot de passe doit contenir au moins un caractère spécial.';
    }

    return null;
  }
}
