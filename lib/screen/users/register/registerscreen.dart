import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smartshop/utils/colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formkey = GlobalKey<FormState>();

  String email = "", password = "", name = "", ncin = "";
  TextEditingController namecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController mailcontroller = TextEditingController();
  TextEditingController numcincontroller = TextEditingController();
  bool visibility = true;

  registration() async {
    // Utilisation des données des champs de texte
    String email = mailcontroller.text;
    String password = passwordcontroller.text;
    String name = namecontroller.text;

    // Vérification des champs
    if (password != null && name != "" && email != "") {
      try {
        // Création d'un utilisateur avec Firebase Auth
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        // Récupération de l'UID de l'utilisateur créé
        String uid = userCredential.user!.uid;

        // Ajout de l'utilisateur à la collection "utilisateurs" de FirebaseFirestore
        await FirebaseFirestore.instance
            .collection('utilisateurs')
            .doc(uid)
            .set({
          'email': email,
          'nom': name,
          // Vous pouvez ajouter d'autres informations sur l'utilisateur ici
        });

        // Affichage d'un message de succès
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            "Utilisateur créé avec succès",
            style: TextStyle(fontSize: 20.0),
          ),
        ));

        // Redirection vers l'écran de connexion
        GoRouter.of(context).go('/login');
      } on FirebaseAuthException catch (e) {
        // Gestion des erreurs spécifiques à Firebase Auth
        if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content:
                Text("Le compte existe déjà", style: TextStyle(fontSize: 18.0)),
          ));
        }
      } catch (e) {
        // Gestion des autres erreurs
        print("Erreur lors de la création de l'utilisateur : $e");
      }
    }
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
                  padding: const EdgeInsets.only(top: 15),
                  child: const Image(
                    height: 64.38,
                    width: 152.29,
                    image: AssetImage('assets/images/logo.png'),
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.only(top: 15),
                  height: size.height / 14,
                  child: const Text(
                    "Créer un compte ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Form(
                  key: _formkey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: SizedBox(
                      height: 480,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              "Nom et Prénom",
                              style: TextStyle(
                                  color: GlobalColors.TextColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            // validator: (name) {
                            //   if (name!.isEmpty) {
                            //     return 'Ce champ est obligatoire';
                            //   }
                            //   if (name.length < 3) {
                            //     return 'le nom doit comporter plus de 2 caractères';
                            //   }
                            //   if (!name.contains(RegExp(r'[A-Z]')) ||
                            //       !name.contains(RegExp(r'[a-z]'))) {
                            //     return 'Le nom doit contenir des lettres.';
                            //   } else {
                            //     return null;
                            //   }
                            // },
                            controller: namecontroller,
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
                          const SizedBox(height: 10),
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
                          TextField(
                            // validator: (email) {
                            //   String pattern =
                            //       r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                            //   RegExp regex = RegExp(pattern);
                            //   if (email!.isEmpty) {
                            //     return 'Ce champ est obligatoire';
                            //   }
                            //   if (!regex.hasMatch(email)) {
                            //     return 'S"il vous plaît, mettez une adresse email valide';
                            //   } else {
                            //     return null;
                            //   }
                            // },
                            controller: mailcontroller,
                            decoration: const InputDecoration(
                              hintText: "Email",
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
                          TextField(
                            // validator: (password) {
                            //   if (password == null || password.isEmpty) {
                            //     return 'Veuillez entrer un mot de passe.';
                            //   }

                            //   // Vérifier la longueur du mot de passe
                            //   if (password.length < 6) {
                            //     return 'Le mot de passe doit contenir au moin 6 caractères.';
                            //   }

                            //   // Vérifier la présence d'au moins une minuscule
                            //   if (!password.contains(RegExp(r'[a-z]'))) {
                            //     return 'Le mot de passe doit contenir au moins une lettre minuscule.';
                            //   }

                            //   // Vérifier la présence d'au moins une majuscule
                            //   if (!password.contains(RegExp(r'[A-Z]'))) {
                            //     return 'Le mot de passe doit contenir au moins une lettre majuscule.';
                            //   }

                            //   // Vérifier la présence d'au moins un chiffre
                            //   if (!password.contains(RegExp(r'[0-9]'))) {
                            //     return 'Le mot de passe doit contenir au moins un chiffre.';
                            //   }

                            //   // Vérifier la présence d'au moins un caractère spécial
                            //   if (!password.contains(
                            //       RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                            //     return 'Le mot de passe doit contenir au moins un caractère spécial.';
                            //   }

                            //   return null;
                            // },
                            controller: passwordcontroller,
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
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              "Numéro Carte d’identité",
                              style: TextStyle(
                                  color: GlobalColors.TextColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const TextField(
                            // validator: (ncin) {
                            //   if (ncin!.isEmpty) {
                            //     return "Ce champ est obligatoire";
                            //   } else if (ncin.length != 8) {
                            //     return "CIN must be 8 characters";
                            //   }
                            //   return null;
                            // },
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              hintText: "12345678",
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
                              "Télècharger l'image de votre identité",
                              style: TextStyle(
                                  color: GlobalColors.TextColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(left: 130),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular((50)),
                                    border: Border.all(color: Colors.black),
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (builder) {
                                          return SimpleDialog(
                                            children: [
                                              TextButton(
                                                onPressed: pickImageFromGallery,
                                                child: const Text(
                                                    "Choisir une image dans la galerie"),
                                              ),
                                              TextButton(
                                                onPressed: pickImageFromCamera,
                                                child: const Text(
                                                    "Prendre une photo avec un appareil photo"),
                                              ),
                                              TextButton(
                                                onPressed: cancel,
                                                child: const Text("Annuler"),
                                              )
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    icon: const Icon(Icons.upload),
                                  ),
                                ),
                                SizedBox(width: 10),
                                if (isFile)
                                  Image.file(
                                    file!,
                                    width: 65,
                                    height: 65,
                                    fit: BoxFit.fill,
                                  )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width / 3,
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
                            "Tous les champs sont obligatoires",
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
                  registration();
                },
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
            const SizedBox(height: 14),
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
