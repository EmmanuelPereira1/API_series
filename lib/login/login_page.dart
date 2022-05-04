import 'dart:io';
import 'package:api_series/login/hometest.dart';
import 'package:api_series/request/get_api.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _messangerKey = GlobalKey<ScaffoldMessengerState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  void initState(){
    super.initState();
    login();
    request();
  }

  @override
  void dispose(){
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
                    OutlinedButton.icon(onPressed: () async {
                      login();
                    },
                    icon: const Icon(Icons.login),
                    label: const Text("LOGIN")
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }

  Future<void> login() async{
    if(passwordController.text.isNotEmpty && emailController.text.isNotEmpty){
      var dio = Dio();
      var url = "https://academy-auth.herokuapp.com/login";
      var response = await dio.post(url,
      data: ({
      'email': emailController.text,
      'password': passwordController.text}));
      if(response.statusCode==200) {
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const HomeTest()));
      } else {
        _messangerKey.currentState?.showSnackBar
        ( SnackBar(content: Text(response.data.toString())));
      }
    } else {
      _messangerKey.currentState?.showSnackBar
      (const  SnackBar(content: Text('Black Field Not Allowed.')));
    }
  }

}