import 'package:api_series/pages/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../request/get_api.dart';
import '../hometest.dart';

class RegisterApp extends StatefulWidget {
  const RegisterApp({ Key? key }) : super(key: key);

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
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: firstNameController,
                    decoration: const InputDecoration(
                      labelText: "FIRST NAME",
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.email),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: lastNameController,
                    decoration: const InputDecoration(
                      labelText: "LAST NAME",
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.email),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: "EMAIL",
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.email),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "PASSWORD",
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.email),
                    ),
                  ),
                  const SizedBox(
                    height: 45,
                  ),
                  OutlinedButton.icon(
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
                      icon: const Icon(Icons.login),
                      label: const Text("REGISTER"))
                ],
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
        if (response.statusCode == 201){
            response.data;
            isRegister = true;
        } else {
            return isRegister = false;
        }
    }
  }

  Future<void> saveCredentials() async  { if (
  passwordController.text.isNotEmpty &&
  emailController.text.isNotEmpty &&
  firstNameController.text.isNotEmpty &&
    lastNameController.text.isNotEmpty){
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
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.toString(), password: passwordController.text.toString());
  }
}