import 'package:api_series/config/theme.dart';
import 'package:api_series/models/reviews_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../request/show_list.dart';
import '../widgets/custom_appbar.dart';

class ShowInfo extends StatefulWidget {
  int id;
  String name;
  String startDate;
  String country;
  String network;
  String status;
  String imageThumbnailPath;

  ShowInfo({
    Key? key,
    required this.id,
    required this.name,
    required this.country,
    required this.network,
    required this.startDate,
    required this.status,
    required this.imageThumbnailPath,
  }) : super(key: key);

  @override
  State<ShowInfo> createState() => _ShowInfoState();
}

class _ShowInfoState extends State<ShowInfo> {
  @override
  void initState() {
    super.initState();
    // getIdUser();
    getFirstName();
  }

  String? first_name;
  String? id_user;
  String? rating;
  final TextEditingController _reviewController = TextEditingController();
  final storeMessage = FirebaseFirestore.instance;
  CollectionReference userRef =
      FirebaseFirestore.instance.collection('reviews');
  ReviewModel? review;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: <Color>[
              Color(0XFF101A26),
              Color(0XFF026873),
              Color(0xFF35F2DF)
            ])),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: NestedScrollView(
                floatHeaderSlivers: true,
                headerSliverBuilder: (context, innerBoxIsScrolled) =>
                    [const CustomAppBar()],
                body: SingleChildScrollView(
                    child: Column(
                  children: [
                    Stack(
                      children: [
                        AspectRatio(
                          aspectRatio: 400 / 451,
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(widget.imageThumbnailPath),
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 410,
                          width: 451,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.center,
                              end: Alignment.topCenter,
                              colors: [
                                Color(0xCC000000),
                                Color(0x00000000),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(15, 335, 30, 2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline2!
                                      .copyWith(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  Text(widget.status,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4!
                                          .copyWith(
                                              fontWeight: FontWeight.normal)),
                                  const SizedBox(width: 6),
                                  const Icon(Icons.circle,
                                      color: Colors.white, size: 6),
                                  const SizedBox(width: 6),
                                  Text(widget.country,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4!
                                          .copyWith(
                                              fontWeight: FontWeight.normal)),
                                  const SizedBox(width: 6),
                                  const Icon(Icons.circle,
                                      color: Colors.white, size: 6),
                                  const SizedBox(width: 6),
                                  Text(widget.network,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4!
                                          .copyWith(
                                              fontWeight: FontWeight.normal)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Container(
                      width: 350,
                      height: 220,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: Colors.grey[800],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text("Rate ",
                                    style:
                                        Theme.of(context).textTheme.headline4),
                                Text(
                                  widget.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4!
                                      .copyWith(
                                          color: Colors.amber[300],
                                          fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  color: Colors.grey[350],
                                  width: 205,
                                  height: 1,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                RatingBar.builder(
                                  initialRating: 0.5,
                                  minRating: 0.5,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemPadding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {
                                    final postDoc =
                                        storeMessage.collection("reviews").doc();
                                    postDoc.update({
                                      "rating": rating,
                                    });
                                    _reviewController.clear();
                                  },
                                ),
                                const SizedBox(height: 10),
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 16),
                                    child: TextField(
                                        controller: _reviewController,
                                        decoration: InputDecoration(
                                          enabledBorder:
                                              const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white)),
                                          hintText: 'Review this show...',
                                          hintStyle: Theme.of(context)
                                              .textTheme
                                              .headline5,
                                          suffixIcon: IconButton(
                                              onPressed: () async {
                                                if (_reviewController
                                                    .text.isNotEmpty) {
                                                  final postDoc = storeMessage
                                                      .collection("reviews")
                                                      .doc();
                                                  await postDoc.set({
                                                    "review_text":
                                                        _reviewController.text
                                                            .trim(),
                                                    "first_name": first_name,
                                                    // "id_user": id_user,
                                                    // "id": review!.id
                                                  });
                                                  _reviewController.clear();
                                                }
                                              },
                                              icon: const Icon(Icons.send,
                                                  color: Colors.black)),
                                        )))
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )))));
  }

  Future<void> getFirstName() async {
    var currentUser = FirebaseAuth.instance.currentUser;
    final DocumentReference document =
        FirebaseFirestore.instance.collection("users").doc(currentUser!.uid);
    await document.get().then<dynamic>((DocumentSnapshot snapshot) async {
      Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
      setState(() {
        first_name = data['first_name'];
      });
    });
  }

  // Future<void> getIdUser() async {
  //   var currentUser = FirebaseAuth.instance.currentUser;
  //   final DocumentReference document =
  //       FirebaseFirestore.instance.collection("users").doc(currentUser!.uid);
  //   await document.get().then<dynamic>((DocumentSnapshot snapshot) async {
  //     Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
  //     setState(() {
  //       id_user = data[currentUser.uid];
  //     });
  //   });
  // }
}
