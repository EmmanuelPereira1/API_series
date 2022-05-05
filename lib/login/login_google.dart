import 'package:api_series/login/google_sign_in.dart';
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
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.all(32),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Spacer(),
        FlutterLogo(size: 120),
        Spacer(),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Salve',
          ),
        ),
        SizedBox(height: 8),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'LOGIN GOOGLE'
          ),
        ),
        Spacer(),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            onPrimary: Colors.black,
            minimumSize: Size(double.infinity,50)
          ),
          onPressed: (){
            final provider = 
            Provider.of<GoogleSignInProvider>(context, listen: false);
            provider.googleLogin();
          },
          icon: FaIcon(FontAwesomeIcons.google, color: Colors.red,),
          label: Text('Sign Up with Google')
          ),
        SizedBox(height: 40),
        RichText(
          text: 
        TextSpan(
          text: 'num tem continha? :(',
          children: [
            TextSpan(
              text: 'Log in',
              style: TextStyle(decoration: TextDecoration.underline)
            )
          ]
          )
        )
      ],
    ),
    );
}