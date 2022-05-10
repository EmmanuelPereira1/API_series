import 'package:api_series/models/show_model.dart';
import 'package:api_series/pages/show_details_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ShowMenssages extends StatefulWidget {
  final int id;

  ShowMenssages({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<ShowMenssages> createState() => _ShowMenssagesState();
}

class _ShowMenssagesState extends State<ShowMenssages> {
  int? id_show;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("reviews").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          reverse: true,
          itemCount: snapshot.data!.docs.reversed.length,
          shrinkWrap: true,
          primary: true,
          physics: const ScrollPhysics(),
          itemBuilder: (context, i) {
            QueryDocumentSnapshot document = snapshot.data!.docs[i];
            if (widget.id == document['id_show']) {
              return ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
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
            } else {
              return const Center();
            }
          },
        );
      },
    );
  }
}
