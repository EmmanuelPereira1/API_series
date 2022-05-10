import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShowMenssages extends StatefulWidget {
  const ShowMenssages({Key? key}) : super(key: key);

  @override
  State<ShowMenssages> createState() => _ShowMenssagesState();
}

class _ShowMenssagesState extends State<ShowMenssages> {
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
                        margin: const EdgeInsets.all(10.0),
                        elevation: 0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(document['first_name'],
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline2!
                                        .copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Text(document['review_text'],
                            style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(color: Colors.black))
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
