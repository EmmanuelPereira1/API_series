import 'package:api_series/config/gradientbackground.dart';
import 'package:api_series/login/register/register.dart';
import 'package:api_series/pages/home_page.dart';
import 'package:api_series/request/get_api.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginApi extends StatefulWidget {
  const LoginApi({Key? key}) : super(key: key);

  @override
  State<LoginApi> createState() => _LoginApiState();
}

class _LoginApiState extends State<LoginApi> {
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
                    Image.asset("lib/images/showanalytic_logo.png"),
                    const SizedBox(height: 100,),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
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
                     
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
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
                        await login();
                        if (isLogin == true) {
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
        // FirebaseAuth.instance.currentUser!.isAnonymous;
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

