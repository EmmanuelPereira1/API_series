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
            itemCount: snapshot.data!.docs.length,
            shrinkWrap: true,
            primary: true,
            physics: const ScrollPhysics(),
            itemBuilder: (context, i) {
              QueryDocumentSnapshot document = snapshot.data!.docs[i];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Column(
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
                      onLongPress: () {
                    showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return Wrap(children: <Widget>[
                            ListTile(
                                leading: const Icon(Icons.delete),
                                title: const Text('Delete'),
                                onTap: () {
                                  var currentUser = FirebaseAuth.instance.currentUser;
                                  FirebaseFirestore.instance.runTransaction(
                                      (Transaction myTransaction) async {
                                    if (currentUser!.uid == document['owner_id']) {
                                      await myTransaction.delete(
                                          snapshot.data!.docs[i].reference);
                                    } else if (currentUser.uid != document['owner_id']){
                                      errorDeleteDialog();
                                    }
                                  });
                                }
                                )
                          ]);
                        });
                  }
                  ),
                );
              } 
          ),
        );
      },
    );
  }
  void errorDeleteDialog() {
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
                      Text(
                        "You can't delete this review",
                        style: Theme.of(context).textTheme.headline5,
                        textAlign: TextAlign.center,
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
                                child: Text("OK",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(color: Colors.white))),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )));
  }
}