import 'package:api_series/login/login_google.dart';
import 'package:api_series/pages/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GoogleLogin extends StatelessWidget {
  const GoogleLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return Scaffold(
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
          if  (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData){
            saveCredentials();
            return const HomePage();
          } else if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong"));
          } else {
            return const LoginGoogle();
          }
        }),
      );
  }
Future saveCredentials() async {
      final user = FirebaseAuth.instance.currentUser!;
      final firestore = FirebaseFirestore.instance;
      var currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser?.uid != null) {
        await firestore.collection("users").doc().set
        ({
          "first_name": user.displayName,
          // "last_name": "",
          "email": user.email,
          // "password": "",
        });
        // await firestore.collection("users").doc(currentUser.uid).update({
        //   "tag": tagText,
        // });
      }
    }
      
}
