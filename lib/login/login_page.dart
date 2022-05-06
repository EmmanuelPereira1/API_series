import 'package:api_series/login/hometest.dart';
import 'package:api_series/login/register/register.dart';
import 'package:api_series/request/get_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _messangerKey = GlobalKey<ScaffoldMessengerState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool isLogin = false;

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
                        await login();
                        if (isLogin == true) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => const HomeTest())));
                        } else {
                          _messangerKey.currentState?.showSnackBar(
                              const SnackBar(content: Text('puts campeão')));
                        }
                      },
                      icon: const Icon(Icons.login),
                      label: const Text("LOGIN")),

                      OutlinedButton.icon(
                      onPressed: () {
                        
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => const RegisterApp())));
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

  Future<bool> login() async {
    if (passwordController.text.isNotEmpty && emailController.text.isNotEmpty) {
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
}

