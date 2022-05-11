import 'package:api_series/config/gradientbackground.dart';
import 'package:api_series/pages/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../request/get_api.dart';

class RegisterApp extends StatefulWidget {
  const RegisterApp({Key? key}) : super(key: key);

  @override
  State<RegisterApp> createState() => _RegisterAppState();
}

class _RegisterAppState extends State<RegisterApp> {
  final _messangerKey = GlobalKey<ScaffoldMessengerState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  bool isRegister = false;

  @override
  void initState() {
    super.initState();
    request();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: _messangerKey,
      home: Scaffold(
        body: Container(
          decoration: GradientColor.gradient,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "lib/images/showanalytic_logo.png",
                      width: 270,
                    ),
                    const SizedBox(height: 70),
                    TextFormField(
                      controller: firstNameController,
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        labelText: "FIRST NAME",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        suffixIcon: Icon(
                          Icons.person,
                          color: Color(0XFF026873),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: lastNameController,
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        labelText: "LAST NAME",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        suffixIcon: Icon(
                          Icons.person,
                          color: Color(0XFF026873),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        labelText: "EMAIL",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        suffixIcon: Icon(
                          Icons.email,
                          color: Color(0XFF026873),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        labelText: "PASSWORD",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        suffixIcon: Icon(
                          Icons.key,
                          color: Color(0XFF026873),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 45,
                    ),
                    OutlinedButton.icon(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0XFF026873)),
                        ),
                        onPressed: () async {
                          await register();
                          await signUp();
                          await saveCredentials();
                          if (isRegister == true) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => const HomePage())));
                          } else {
                            _messangerKey.currentState?.showSnackBar(
                                const SnackBar(content: Text('puts campeão')));
                          }
                        },
                        icon: const Icon(
                          Icons.app_registration_outlined,
                          color: Colors.white,
                        ),
                        label: const Text(
                          "REGISTER",
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future register() async {
    if (passwordController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty) {
      var dio = Dio();
      var url = "https://academy-auth.herokuapp.com/register";
      var response = await dio.post(url,
          data: ({
            'first_name': firstNameController.text,
            'last_name': lastNameController.text,
            'email': emailController.text,
            'password': passwordController.text
          }));
      if (response.statusCode == 201) {
        // FirebaseAuth.instance.currentUser!.isAnonymous;
        response.data;
        isRegister = true;
      } else {
        return isRegister = false;
      }
    }
  }

  Future<void> saveCredentials() async {
    if (passwordController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty) {
      final firestore = FirebaseFirestore.instance;
      var currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser?.uid != null) {
        await firestore.collection("users").doc(currentUser!.uid).set({
          "first_name": firstNameController.text,
          "last_name": lastNameController.text,
          "email": emailController.text,
          "password": passwordController.text,
        });
        // await firestore.collection("users").doc(currentUser.uid).update({
        //   "tag": tagText,
        // });
      }
    }
  }

  Future signUp() async {

    final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.toString(),
        password: passwordController.text.toString());
  }
}
