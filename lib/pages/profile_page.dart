import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../login/login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    _setupPage();
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    super.dispose();
  }

  Future<void> _setupPage() async {
    await countDocuments();

    await getPassword();
    await getEmail();
    await reauthentiacateUser();
    await getFirstName();
  }

  String? password;
  String? email;
  var newPassword;
  String? firstName;
  int? totalReviews;
  final TextEditingController _newPasswordController = TextEditingController();
  var currentUser = FirebaseAuth.instance.currentUser;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).viewInsets.bottom;

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
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                        margin: const EdgeInsets.only(left: 10),
                        width: 340,
                        height: 340,
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
                            Form(
                                key: _formKey,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 50, vertical: 16),
                                  child: TextFormField(
                                    autofocus: false,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                          onPressed: () async {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              setState(() {
                                                newPassword =
                                                    _newPasswordController.text;
                                              });
                                              await reauthentiacateUser();
                                              await updatePasswordDio();
                                              await updatePassword();
                                              await updatePasswordAuth(
                                                  newPassword);
                                              showMyDialog();
                                            }
                                          },
                                          icon: const Icon(Icons.edit),
                                          color: Colors.amber,
                                        ),
                                        labelText: "New Password",
                                        hintText: "Enter New Password",
                                        labelStyle: Theme.of(context)
                                            .textTheme
                                            .headline5,
                                        border: const OutlineInputBorder(),
                                        errorStyle: const TextStyle(
                                            color: Colors.amber,
                                            fontSize: 15.0)),
                                    controller: _newPasswordController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter password";
                                      } else if (value.length < 6) {
                                        return "Password must contain at least 6 characters";
                                      } else if (_newPasswordController.text ==
                                          password) {
                                        return "Password is the same as before";
                                      }
                                      return null;
                                    },
                                  ),
                                )),
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
                            ),
                            const SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                    onPressed: () async {
                                      await reauthentiacateUser();
                                      await deleteAccountDio();
                                      await deleteAccountFirebase();
                                    },
                                    child: Text(
                                      "Delete Account",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5!
                                          .copyWith(
                                              color: const Color.fromARGB(
                                                  255, 186, 18, 18),
                                              fontWeight: FontWeight.bold),
                                    )),
                                const Icon(Icons.delete,
                                    size: 20,
                                    color: Color.fromARGB(255, 186, 18, 18)),
                              ],
                            )
                          ],
                        )),
                    Positioned(
                      top: -80,
                      left: 100,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image:
                                AssetImage("lib/images/showanalytic_logo.png"),
                          ),
                        ),
                      ),
                    ),
                  ],
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

  Future<void> getPassword() async {
    var currentUser = FirebaseAuth.instance.currentUser;
    final DocumentReference document =
        FirebaseFirestore.instance.collection("users").doc(currentUser!.uid);
    await document.get().then<dynamic>((DocumentSnapshot snapshot) async {
      Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
      setState(() {
        password = data['password'];
      });
    });
  }

  Future<void> countDocuments() async {
    QuerySnapshot _myDoc = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("my_reviews")
        .get();
    List<DocumentSnapshot> _myDocCount = _myDoc.docs;
    totalReviews = _myDocCount.length;
  }

  Future<void> updatePasswordAuth(String newPassword) async {
    final user = await FirebaseAuth.instance.currentUser!;
    user.updatePassword(newPassword).then((_) {
      print("Successfully changed password");
    }).catchError((error) {
      print("Password can't be changed" + error.toString());
    });
  }

  Future<void> reauthentiacateUser() async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
    print("user reauthenticated");
  }

  Future<void> updatePassword() async {
    final user = FirebaseAuth.instance.currentUser!;
    final firestore = FirebaseFirestore.instance;
    if (currentUser != null) {
      await firestore
          .collection("users")
          .doc(user.uid)
          .update({"password": _newPasswordController.text});
    }
  }

  Future updatePasswordDio() async {
    final user = FirebaseAuth.instance.currentUser!;
    if (_newPasswordController.text.isNotEmpty) {
      var dio = Dio();
      var url = "https://academy-auth.herokuapp.com/update";
      var response = await dio.patch(url,
          options: Options(headers: {
            'x-access-token':
                "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiNjI3MTU4OThlNGE5MDE1YzgxZDVlYTE1IiwiZW1haWwiOiJwZWRybzEzQHRlc3RlLmNvbSIsImlhdCI6MTY1MTYwMzgwOCwiZXhwIjoxNjU0MTk1ODA4fQ.Jjh6UyXmfNICuqxyNzFybRfZ4hLo4zKZZ8Mteqz-Sf8"
          }),
          data: ({
            "email": user.email,
            "new_password": _newPasswordController.text
          }));
      if (response.statusCode == 201) {
        print("deu certo");
        response.data;
      } else {
        print("puts campeão");
      }
    }
  }

  void showMyDialog() {
    showDialog(
        context: context,
        builder: (context) => Center(
                child: Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: Container(
                color: const Color(0XFF026873),
                height: 100,
                width: 200,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, top: 5, right: 5),
                  child: Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Your password has been changed.",
                            style: Theme.of(context).textTheme.headline5,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 5),
                          Text("Please login again.",
                              style: Theme.of(context).textTheme.headline5),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 60,
                            height: 30,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.transparent),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: TextButton(
                                  onPressed: () {
                                    FirebaseAuth.instance.signOut();
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage()),
                                    );
                                  },
                                  child: Text("OK",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .copyWith(color: Colors.white))),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )));
  }

  Future deleteAccountDio() async {
    var dio = Dio();
    var url = "https://academy-auth.herokuapp.com/delete-user";
    var response = await dio.post(url,
        options: Options(headers: {
          'x-access-token':
              "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiNjI2YjFmYzdmYmE2NzkzMTZmZTRkZjkxIiwiZW1haWwiOiJwZWRybzJAdGVzdGUuY29tIiwiaWF0IjoxNjUyNDY4MTk1LCJleHAiOjE2NTUwNjAxOTV9.GelaR6dgsucBXFykJ9zcpcCaEnMT8vc7s7NULXlHa1c"
        }),
        data: ({
          "email": email,
        }));
    if (response.statusCode == 201) {
      print("deu certo dio");
      response.data;
    } else {
      print("puts campeão");
    }
  }

  Future deleteAccountFirebase() async {
    bool step1 = true;
    bool step2 = false;
    bool step3 = false;
    bool step4 = false;
    while (true) {
      if (step1) {
        //delete user info in the database
        var delete = await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser!.uid)
            .delete();
        step1 = false;
        step2 = true;
      }

      if (step2) {
        //delete user
        currentUser!.delete();
        step2 = false;
        step3 = true;
      }

      if (step3) {
        await FirebaseAuth.instance.signOut();
        step3 = false;
        step4 = true;
      }

      if (step4) {
        //go to sign up log in page
        await Navigator.pushNamed(context, '/');
        step4 = false;
      }

      if (!step1 && !step2 && !step3 && !step4) {
        break;
      }
    }
  }
}
