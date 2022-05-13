import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../config/gradientbackground.dart';
import '../login/login_page.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
            backgroundColor: Colors.transparent,
            child: Container(
                decoration: GradientColor.gradient,
                child: ListView(children: <Widget>[
                  DrawerHeader(
                      child: Image.asset(
                    'lib/images/showanalytic_logo.png',
                    width: 50,
                  )),
                  ListTile(
                    leading: const Icon(Icons.login, color: Colors.white),
                    title: const Text(
                      "LOGOUT",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const LoginPage() 
                        )
                      );
                      },
                  ),
                ])));
  }
}