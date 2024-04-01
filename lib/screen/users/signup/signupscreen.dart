import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smartshop/screen/users/users_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:smartshop/utils/colors.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FirebaseAuthService _auth = FirebaseAuthService();

  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _numcin = TextEditingController();
  bool visibility = true;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _numcin.dispose();
    super.dispose();
  }

  bool isFile = false;
  File? file;

  pickImageFromGallery() async {
    XFile? xFileImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    File image = File(xFileImage!.path);
    Navigator.of(context).pop();
    setState(() {
      file = image;
      isFile = true;
    });
  }

  pickImageFromCamera() async {
    XFile? xFileImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    File image = File(xFileImage!.path);
    Navigator.of(context).pop();
    setState(() {
      file = image;
      isFile = true;
    });
  }

  void cancel() {
    Navigator.of(context).pop();
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
                  padding: const EdgeInsets.only(top: 5),
                  height: size.height * 0.060,
                  child: const Image(
                    image: AssetImage('assets/images/logo.png'),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.only(top: 15),
                  height: size.height / 12,
                  child: const Text(
                    "Créer un compte ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 45),
                    child: SizedBox(
                      height: 480,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 40),
                            child: Text(
                              "Nom et Prénom",
                              style: TextStyle(
                                  color: GlobalColors.TextColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            validator: (name) =>
                                name!.isEmpty ? "ne peux pas être vide" : null,
                            controller: _name,
                            decoration: const InputDecoration(
                              hintText: "Nom et Prénom",
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(19),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.only(left: 40),
                            child: Text(
                              "Adresse Email",
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
                              hintText: "Adresse",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(19),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.only(left: 40),
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
                            validator: (password) => password!.isEmpty
                                ? "ne peux pas être vide"
                                : null,
                            controller: _password,
                            obscureText: visibility,
                            // keyboardType: TextInputType.phone,
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
                          const SizedBox(height: 20),
                          Stack(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 120,
                                    height: 100,
                                    child: Column(
                                      children: [
                                        Text(
                                          "N° CIN",
                                          style: TextStyle(
                                              color: GlobalColors.TextColor,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(height: 10),
                                        TextFormField(
                                          validator: (ncin) {
                                            if (ncin!.isEmpty) {
                                              const Text(
                                                  "ne peux pas être vide");
                                            } else
                                              (ncin!.length != 8);

                                            const Text(
                                                "Le CIN doit être 8 caractèrs");

                                            ;
                                          },
                                          keyboardType: TextInputType.phone,
                                          decoration: const InputDecoration(
                                            hintText: "12345678",
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(19),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 120,
                                    height: 120,
                                    child: Column(
                                      children: [
                                        Text(
                                          "Télècharger l'image \n de votre identité",
                                          style: TextStyle(
                                              color: GlobalColors.TextColor,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (builder) {
                                                    return SimpleDialog(
                                                      children: [
                                                        TextButton(
                                                          onPressed:
                                                              pickImageFromGallery,
                                                          child: const Text(
                                                              "Choisir une image dans la galerie"),
                                                        ),
                                                        TextButton(
                                                          onPressed:
                                                              pickImageFromCamera,
                                                          child: const Text(
                                                              "Prendre une photo avec un appareil photo"),
                                                        ),
                                                        TextButton(
                                                          onPressed: cancel,
                                                          child: const Text(
                                                              "Annuler"),
                                                        )
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                              icon:
                                                  const Icon(Icons.upload_file),
                                            ),
                                            if (isFile)
                                              Image.file(
                                                file!,
                                                width: 70,
                                                height: 55,
                                                fit: BoxFit.fill,
                                              )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width / 3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: GlobalColors.ButtonColor,
              ),
              child: MaterialButton(
                onPressed: _signUp,
                child: const Center(
                  child: Text(
                    "Enregistrer",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 29.2,
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

  void _signUp() async {
    String name = _name.text;
    String email = _email.text;
    String password = _password.text;
    String cin = _numcin.text;

    User? user = await _auth.signUpWithEmailAndPassword(email, password);

    if (user != null) {
      print("utilisateur créé avec succée");
      Navigator.pushReplacementNamed(context, 'login');
    } else {
      print("error");
    }
  }
}
