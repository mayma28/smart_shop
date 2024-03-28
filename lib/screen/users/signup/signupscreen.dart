import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smartshop/screen/homescreen.dart';
import 'package:smartshop/utils/colors.dart';
import '../../../ui/CustomTextField.dart';
import '../../../ui/TextFieldContainer.dart';

final _formKey = GlobalKey<FormState>();

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _name = TextEditingController();
  final _adresse = TextEditingController();
  final _numtel = TextEditingController();
  final _numcin = TextEditingController();

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
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 7),
                  height: size.height * 0.075,
                  child: const Image(
                    image: AssetImage('assets/images/logo.png'),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.only(top: 35),
                  height: size.height / 8,
                  child: const Text(
                    "Créer un compte ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Form(
                  key: _formKey,
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
                      TextFieldContainer(
                        child: TextFormField(
                          validator: (name) =>
                              name!.isEmpty ? "ne peux pas être vide" : null,
                          controller: _name,
                          decoration: const InputDecoration(
                            hintText: "Nom et Prénom",
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          "Adresse",
                          style: TextStyle(
                              color: GlobalColors.TextColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      TextFieldContainer(
                        child: TextFormField(
                          validator: (adresse) =>
                              adresse!.isEmpty ? "ne peux pas être vide" : null,
                          controller: _adresse,
                          decoration: const InputDecoration(
                            hintText: "Adresse",
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          "Numéro de télephone",
                          style: TextStyle(
                              color: GlobalColors.TextColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      TextFieldContainer(
                        child: TextFormField(
                          validator: (numtel) =>
                              numtel!.isEmpty ? "ne peux pas être vide" : null,
                          controller: _numtel,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            hintText: "+216 12345678",
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "N° CIN",
                      style: TextStyle(
                          color: GlobalColors.TextColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Télècharger l'image \n de votre identité",
                      style: TextStyle(
                          color: GlobalColors.TextColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      height: size.height * 0.06,
                      width: size.width / 3,
                      margin: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 40),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        color: const Color(0xffffffff),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        validator: (ncin) {
                          if (ncin!.isEmpty) {
                            Text("ne peux pas être vide");
                          } else
                            (ncin!.length != 8);
                          {
                            Text("Le CIN doit être 8 caractèrs");
                          }
                          ;
                        },
                        controller: _numcin,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: "N° CIN",
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                        ),
                      ),
                    ),
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
                          icon: const Icon(Icons.upload_file),
                        ),
                        if (isFile)
                          Image.file(
                            file!,
                            width: 80,
                            height: 55,
                            fit: BoxFit.fill,
                          )
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 40),
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
                        Navigator.pushReplacementNamed(context, 'login');
                      } else {
                        print('Erorr');
                      }
                    },
                    child: const Center(
                      child: Text(
                        "Enregistrer",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 34.5,
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
      ),
    );
  }
}
