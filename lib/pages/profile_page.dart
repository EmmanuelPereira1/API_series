import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../login/login_page.dart';

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

  @override
  void dispose() {
    _newPasswordController.dispose();
    super.dispose();
  }

  var newPassword;
  String? firstName;
  String? email;
  int? totalReviews;
  final TextEditingController _newPasswordController = TextEditingController();
  var currentUser = FirebaseAuth.instance.currentUser;
  final _formKey = GlobalKey<FormState>();
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
            body: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        width: 340,
                        height: 340,
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: const Color(0XFF026873)),
                        child: Column(
                          children: [
                            const SizedBox(height: 50),
                            Text(firstName!,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 5),
                            Text(email!,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .copyWith(color: Colors.grey[400])),
                            const SizedBox(height: 10),
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(
                            //       horizontal: 50, vertical: 16),
                            //   child: TextField(
                            //     enabled: false,
                            //     style: const TextStyle(
                            //         color: Colors.black),
                            //     controller: _newPasswordController,
                            //     decoration: InputDecoration(
                            //       filled: true,
                            //       fillColor: Colors.grey[600],
                            //       enabledBorder:
                            //           const UnderlineInputBorder(
                            //               borderSide: BorderSide(
                            //                   color: Colors.white)),
                            //       focusedBorder:
                            //           const UnderlineInputBorder(
                            //               borderSide: BorderSide(
                            //                   color: Colors.white)),
                            //       hintText: 'Change Password',
                            //       hintStyle: Theme.of(context)
                            //           .textTheme
                            //           .headline5!
                            //           .copyWith(color: Colors.black),
                            //       suffixIcon: IconButton(
                            //           onPressed: () {},
                            //           icon: const Icon(Icons.send,
                            //               color: Colors.amber)),
                            //     ),
                            //   ),
                            // ),
                            Form(
                                key: _formKey,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 50, vertical: 16),
                                  child: TextFormField(
                                    autofocus: false,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        labelText: "New Password",
                                        hintText: "Enter New Password",
                                        labelStyle: Theme.of(context)
                                            .textTheme
                                            .headline5,
                                        border: const OutlineInputBorder(),
                                        errorStyle: const TextStyle(
                                            color: Colors.black26,
                                            fontSize: 15.0)),
                                    controller: _newPasswordController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please Enter Password";
                                      }
                                      return null;
                                    },
                                  ),
                                )),
                            IconButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      newPassword = _newPasswordController.text;
                                    });
                                    changePassword();
                                    updatePassword();
                                  }
                                },
                                icon: Icon(Icons.edit)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Total reviews:",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(
                                            color: Colors.amber,
                                            fontWeight: FontWeight.bold)),
                                const SizedBox(width: 5),
                                Text(totalReviews!.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(fontWeight: FontWeight.bold)),
                              ],
                            )
                          ],
                        ))
                  ],
                ),
                Positioned(
                  top: 70,
                  left: 100,
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("lib/images/showanalytic_logo.png"),
                      ),
                    ),
                  ),
                ),
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
    QuerySnapshot _myDoc = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("my_reviews")
        .get();
    List<DocumentSnapshot> _myDocCount = _myDoc.docs;
    totalReviews = _myDocCount.length;
  }

  changePassword() async {
    try {
      await currentUser!.updatePassword(newPassword);
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginPage()));
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.black26,
        content: Text("Your password has been changed"),
      ));
    } catch (error) {
      
    }
  }

  updatePassword() async {
    final user = FirebaseAuth.instance.currentUser!;
    final firestore = FirebaseFirestore.instance;
    if (currentUser != null) {
      await firestore
          .collection("users")
          .doc(user.uid)
          .update({"password": _newPasswordController.text});
    }
  }
}
