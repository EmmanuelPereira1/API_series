import 'package:api_series/config/gradientbackground.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FavoritePage extends StatefulWidget {

  const FavoritePage({Key? key,
  }) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  String? first_name;
  String? id_show;
  String? rating;
  String? review_text;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('my_reviews')
      .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Container(
          decoration: GradientColor.gradient,
          child: ListView.builder(
            // reverse: true,
            itemCount: snapshot.data!.docs.length,
            shrinkWrap: true,
            primary: true,
            physics: const ScrollPhysics(),
            itemBuilder: (context, i) {
              QueryDocumentSnapshot document = snapshot.data!.docs[i];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Card(
                          color: Colors.white,
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          child: SingleChildScrollView(
                            child: Card(
                              color: Colors.white,
                              margin: const EdgeInsets.all(10.0),
                              elevation: 0,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(document['first_name'],
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4!
                                              .copyWith(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold)),
                                      RatingBarIndicator(
                                        rating: document['rating'],
                                        itemBuilder: (context, index) => const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        itemCount: 5,
                                        itemSize: 20.0,
                                        direction: Axis.horizontal,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    document['review_text'],
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(
                                          color: Colors.grey[600],
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                );
              } 
              
            
          ),
        );
      },
    );
  }

  // Future<void> getMyReviews() async {
  //   var currentUser = FirebaseAuth.instance.currentUser;

  //   final DocumentReference document = FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(currentUser!.uid)
  //       .collection("my_reviews")
  //       .doc();

  //   await document.get().then<dynamic>(
  //     (DocumentSnapshot snapshot) async {
  //       Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;

  //       setState(
  //         () {
  //           first_name = data['first_name'];
  //           id_show = data['id_show'];
  //           rating = data['rating'];
  //           review_text = data['review_text'];
  //         },
  //       );
  //     },
  //   );
  // }
}