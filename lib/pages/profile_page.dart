import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    getFirstName();
    getEmail();
    countDocuments();
  }

  String? firstName;
  String? email;
  int? totalReviews;

  var currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    if (firstName != null) {
      return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0XFF026873),
              Color(0XFF101A26),
              Color(0XFF101A26),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    ClipRect(
                        child: BackdropFilter(
                            filter:
                                ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                            child: Container(
                                width: 340,
                                height: 340,
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: const Color(0XFF026873)),
                                child: Column(
                                  children: [
                                    Text(firstName!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1!
                                            .copyWith(
                                                fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 5),
                                    Text(email!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3!
                                            .copyWith(color: Colors.grey[400])),
                                            const SizedBox(height: 10),
                                            Text(totalReviews!.toString())
                                  ],
                                ))))
                  ],
                )
              ],
            )),
      );
    } else {
      return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0XFF026873),
                Color(0XFF101A26),
                Color(0XFF101A26),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: const Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(child: CircularProgressIndicator())));
    }
  }

  Future<void> getFirstName() async {
    var currentUser = FirebaseAuth.instance.currentUser;
    final DocumentReference document =
        FirebaseFirestore.instance.collection("users").doc(currentUser!.uid);
    await document.get().then<dynamic>((DocumentSnapshot snapshot) async {
      Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
      setState(() {
        firstName = data['first_name'];
      });
    });
  }

  Future<void> getEmail() async {
    var currentUser = FirebaseAuth.instance.currentUser;
    final DocumentReference document =
        FirebaseFirestore.instance.collection("users").doc(currentUser!.uid);
    await document.get().then<dynamic>((DocumentSnapshot snapshot) async {
      Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
      setState(() {
        email = data['email'];
      });
    });
  }

  void countDocuments() async {
    QuerySnapshot _myDoc = await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("my_reviews").get();
    List<DocumentSnapshot> _myDocCount = _myDoc.docs;
    totalReviews = _myDocCount.length;  
}
}
