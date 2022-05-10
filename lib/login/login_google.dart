import 'package:api_series/config/gradientbackground.dart';
import 'package:api_series/login/google_sign_in.dart';
import 'package:api_series/login/login_page.dart';
import 'package:api_series/login/register/register.dart';
import 'package:api_series/pages/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';


class LoginGoogle extends StatefulWidget {
  const LoginGoogle({ Key? key }) : super(key: key);

  @override
  State<LoginGoogle> createState() => _LoginGoogleState();
}

class _LoginGoogleState extends State<LoginGoogle> {
  @override
  Widget build(BuildContext context) {

  return Scaffold(
    body: Scaffold(
      body: Container(
        decoration: GradientColor.gradient,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Image.asset("lib/images/showanalytic_logo.png"),
              const Spacer(),             
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  primary: const Color(0XFF026873),
                  onPrimary: const Color.fromARGB(255, 255, 255, 255),
                  minimumSize: const Size(double.infinity,50)
                ),
                onPressed: (){
                  Navigator.push(
                    context, MaterialPageRoute(builder: (context) => const LoginPage()));
                },
                icon: const FaIcon(Icons.login, color: Colors.white),
                label: const Text('Login with Account')
                ),
                const SizedBox(height: 17),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  primary: const Color(0XFF026873),
                  onPrimary: Colors.white,
                  minimumSize: const Size(double.infinity,50)
                ),
                onPressed: () async {
                    final provider = 
                  Provider.of<GoogleSignInProvider>(context, listen: false);
                  provider.googleLogin(); 
                },
                icon: const FaIcon(FontAwesomeIcons.google, color: Colors.white,),
                label: const Text('Sign Up with Google')
                ),
                const SizedBox(height: 20,),
              TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterApp())
                );
              },
              child: const Text("Register Account",
              style: TextStyle(
                color: Colors.white,
                decoration: TextDecoration.underline
              ),)),
              const Spacer(),
            ],
          ),
        ),
      ),
    ),
  );
}
}