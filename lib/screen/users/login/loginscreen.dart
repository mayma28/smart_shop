import 'package:flutter/material.dart';
import 'package:smartshop/screen/homescreen.dart';
import 'package:smartshop/screen/users/signup/signupscreen.dart';
import 'package:smartshop/utils/colors.dart';

final _formKey = GlobalKey<FormState>();

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _identifiant = TextEditingController();
  final _password = TextEditingController();
  bool visibility = true;
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 7),
                height: size.height * 0.063,
                child: const Image(
                  image: AssetImage('assets/images/logo.png'),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                height: size.height * 0.325,
                child: const Image(
                  image: AssetImage('assets/images/login.png'),
                ),
              ),
              const SizedBox(height: 10),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          "Identifiant",
                          style: TextStyle(
                              color: GlobalColors.TextColor, fontSize: 15),
                        ),
                      ),
                      TextFormField(
                        validator: (identifiant) => identifiant!.isEmpty
                            ? "ne peux pas être vide"
                            : null,
                        controller: _identifiant,
                        decoration: const InputDecoration(
                          hintText: "Votre identifiant",
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          "Mot de passe",
                          style: TextStyle(
                              color: GlobalColors.TextColor, fontSize: 15),
                        ),
                      ),
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
                              borderSide: BorderSide.none),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width / 3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: GlobalColors.ButtonColor,
                ),
                child: MaterialButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pushReplacementNamed(context, 'homepage');
                    } else {
                      print('Erorr');
                    }
                  },
                  child: const Center(
                    child: Text(
                      "Suivant",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
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
              const SizedBox(
                height: 2.2,
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
      ),
    );
  }
}

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.06,
      width: size.width * 0.8,
      margin: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        border: Border.all(),
        color: const Color(0xffffffff),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
