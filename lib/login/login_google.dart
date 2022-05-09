import 'package:api_series/config/gradientbackground.dart';
import 'package:api_series/login/google_sign_in.dart';
import 'package:api_series/login/register/register.dart';
import 'package:flutter/gestures.dart';
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
  Widget build(BuildContext context) => Scaffold(
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
                  primary: Color(0XFF026873),
                  onPrimary: Color.fromARGB(255, 255, 255, 255),
                  minimumSize: const Size(double.infinity,50)
                ),
                onPressed: (){
                  final provider = 
                  Provider.of<GoogleSignInProvider>(context, listen: false);
                  provider.googleLogin();
                },
                icon: const FaIcon(Icons.login, color: Colors.white),
                label: const Text('Sign Up with Google')
                ),
                const SizedBox(height: 17),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  primary: Color(0XFF026873),
                  onPrimary: Colors.white,
                  minimumSize: const Size(double.infinity,50)
                ),
                onPressed: (){
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
              child: const Text("Registrar",
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