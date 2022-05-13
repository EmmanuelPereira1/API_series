import 'package:api_series/config/gradientbackground.dart';
import 'package:api_series/login/google_sign_in_provider.dart';
import 'package:api_series/login/login_page.dart';
import 'package:api_series/login/register/register.dart';
import 'package:api_series/pages/main_page.dart';
import 'package:api_series/request/get_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/home_page.dart';

class LoginApi extends StatefulWidget {
  const LoginApi({Key? key}) : super(key: key);

  @override
  State<LoginApi> createState() => _LoginApiState();
}

class _LoginApiState extends State<LoginApi> {
  final _messangerKey = GlobalKey<ScaffoldMessengerState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var first_nameController = TextEditingController();
  var last_nameController = TextEditingController();
  bool isLogin = false;
  final _key = GlobalKey<FormState>();
  // var password;
  // var email;

  @override
  void initState() {
    super.initState();
    request();
    // getEmail();
    // getPassword();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      home: Scaffold(
        
        body: SingleChildScrollView(
          child: Container(
            decoration: GradientColor.gradient,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SafeArea(
                child: Center(
                  child: Form(
                    key: _key,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("lib/images/showanalytic_logo.png"),
                        const SizedBox(height: 100,),
                        TextFormField(
                          validator: (value) {
                           if (value == null || value.isEmpty){
                             return 'Enter an email.';
                           }
                           return null;
                         },
                          controller: emailController,
                          decoration: const InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            fillColor: Colors.white,
                            filled: true,
                            labelText: "EMAIL",
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25))),
                            suffixIcon: Icon(Icons.email,
                            color: Color(0XFF026873)),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                         validator: (value) {
                           if (value == null || value.isEmpty){
                             return 'Enter an password.';
                           }  
                           return null;
                         },
                          controller: passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                            fillColor: Colors.white,
                            filled: true,
                            labelText: "PASSWORD",
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25))),
                            suffixIcon: Icon(Icons.key,
                            color: Color(0XFF026873)),
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
                            if (_key.currentState!.validate()){
                            await login();
                            await authLogin();
                            if (isLogin == true) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => const MainPage())));
                            } 
                            setState(() {});
                            }
                          },
                          icon: const Icon(
                            Icons.login,
                            color: Colors.white,
                          ),
                          label: const Text(
                            "LOGIN",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        OutlinedButton.icon(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0XFF026873)),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => const RegisterApp())));
                          },
                          icon: const Icon(
                            Icons.app_registration_outlined,
                            color: Colors.white,
                          ),
                          label: const Text(
                            "REGISTER",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future authLogin() async {

    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.toString(),
        password: passwordController.text.toString());
  }

  Future<bool> login() async {
      
    if (passwordController.text.isNotEmpty && 
    emailController.text.isNotEmpty) {
      var dio = Dio();
      var url = "https://academy-auth.herokuapp.com/login";
      var response = await dio.post(url,
          data: ({
            'email': emailController.text,
            'password': passwordController.text
          }));
      if (response.statusCode == 201) {
        return isLogin = true;
      } else {
        return isLogin = false;
      }
    } else {
      _messangerKey.currentState?.showSnackBar(
        const SnackBar(
          content: Text('Black Field Not Allowed.'),
        ),
      );
      return false;
    }
  }
  // Future<void> getPassword() async {
  //   var currentUser = FirebaseAuth.instance.currentUser;
  //   final DocumentReference document =
  //       FirebaseFirestore.instance.collection("users").doc(currentUser!.uid);
  //   await document.get().then<dynamic>((DocumentSnapshot snapshot) async {
  //     Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
  //     setState(() {
  //       password = data['password'];
  //     });
  //   });
  // }
  // Future<void> getEmail () async {
  //   var currentUser = FirebaseAuth.instance.currentUser;
  //   final DocumentReference document =
  //       FirebaseFirestore.instance.collection("users").doc(currentUser!.uid);
  //   await document.get().then<dynamic>((DocumentSnapshot snapshot) async {
  //     Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
  //     setState(() {
  //       email = data['email'];
  //     });
  //   });
  // }
}



