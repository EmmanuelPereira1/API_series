import 'package:api_series/request/fetch_show_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/show_messages.dart';

class ShowDetailsPage extends StatefulWidget {
  final int id;
  final String? name;
  final String? description;
  final String? imageThumbnailPath;
  final String? country;
  final String? status;
  final String? network;
  final List? genres;

  const ShowDetailsPage({
    Key? key,
    required this.id,
    this.name,
    this.description,
    this.imageThumbnailPath,
    this.country,
    this.status,
    this.network,
    this.genres,
  }) : super(key: key);

  @override
  State<ShowDetailsPage> createState() => _ShowDetailsPageState();
}

class _ShowDetailsPageState extends State<ShowDetailsPage> {
  bool toggle = false;
  bool loading = false;
  num? ratingReview;
  String? first_name;
  final storeMessage = FirebaseFirestore.instance;
  CollectionReference userRef =
      FirebaseFirestore.instance.collection('reviews');
  final TextEditingController _reviewController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getFirstName();
  }

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
              [CustomAppbar()],
          body: SingleChildScrollView(
            child: FutureBuilder<ShowDetails>(
              future: fetchShowDetails(widget.id),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Stack(
                        children: [
                          AspectRatio(
                            aspectRatio: 400 / 451,
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      snapshot.data!.imageThumbnailPath),
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 443,
                            width: 451,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Color(0xCC000000),
                                  Color(0x00000000),
                                ],
                              ),
                            ),
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(15, 0, 0, 15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Wrap(
                                    // crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(snapshot.data!.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(snapshot.data!.status,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4!
                                              .copyWith(
                                                  fontWeight:
                                                      FontWeight.normal)),
                                      const SizedBox(width: 6),
                                      Column(
                                        children: const [
                                          Icon(Icons.circle,
                                              color: Colors.white, size: 6),
                                              SizedBox(height: 10)
                                        ],
                                      ),
                                      const SizedBox(width: 6),
                                      Text(snapshot.data!.country,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4!
                                              .copyWith(
                                                  fontWeight:
                                                      FontWeight.normal)),
                                      const SizedBox(width: 6),
                                      Column(
                                        children: const [
                                          Icon(Icons.circle,
                                              color: Colors.white, size: 6),
                                              SizedBox(height: 10)
                                        ],
                                      ),
                                      const SizedBox(width: 6),
                                      Text(snapshot.data!.network,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4!
                                              .copyWith(
                                                  fontWeight:
                                                      FontWeight.normal)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Container(
                        width: 350,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          color: Colors.grey[800],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Column(
                            children: [
                              ExpansionTile(
                                title: Container(
                                  width: 350,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    color: Colors.grey[800],
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 120),
                                        child: Row(
                                          children: [
                                            Text("Synopsis",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline4!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 32),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              snapshot.data!.startDate,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5!
                                                  .copyWith(
                                                      color: Colors.grey[400]),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              snapshot.data!.genres.join(", "),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5!
                                                  .copyWith(
                                                      color: Colors.grey[400]),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                children: [
                                  Container(
                                    width: 350,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      color: Colors.grey[800],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Text(
                                        snapshot.data!.description,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5!
                                            .copyWith(
                                              fontWeight: FontWeight.bold,
                                              height: 1.5,
                                            ),
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Column(
                                  children: [
                                    Wrap(
                                      children: [
                                        Text("Rate ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4),
                                        Text(
                                          snapshot.data!.name,
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
                                    Container(
                                      color: Colors.grey[350],
                                      width: 205,
                                      height: 1,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 30),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  RatingBar.builder(
                                    initialRating: 0.0,
                                    minRating: 0.0,
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
                                      ratingReview = rating;
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 50, vertical: 16),
                                    child: TextField(
                                      style:
                                          const TextStyle(color: Colors.white),
                                      controller: _reviewController,
                                      decoration: InputDecoration(
                                        enabledBorder:
                                            const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white)),
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white)),
                                        hintText: 'Review this show...',
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .headline5,
                                        suffixIcon: IconButton(
                                            onPressed: () async {
                                              if (_reviewController
                                                      .text.isNotEmpty &&
                                                  ratingReview != null) {
                                                var currentUser = FirebaseAuth
                                                    .instance.currentUser;
                                                final reviewDoc = storeMessage
                                                    .collection("reviews")
                                                    .doc();
                                                await reviewDoc.set({
                                                  "owner_id": currentUser!.uid,
                                                  "id": reviewDoc.id,
                                                  "id_show": widget.id,
                                                  "review_text":
                                                      _reviewController.text
                                                          .trim(),
                                                  "first_name": first_name,
                                                  "rating": ratingReview,
                                                });
                                                final myReviewDoc = storeMessage
                                                    .collection("users")
                                                    .doc(FirebaseAuth.instance
                                                        .currentUser!.uid)
                                                    .collection('my_reviews')
                                                    .doc(reviewDoc.id);
                                                await myReviewDoc.set({
                                                  "owner_id": currentUser.uid,
                                                  "id": myReviewDoc.id,
                                                  'show_name':
                                                      snapshot.data!.name,
                                                  "id_show": widget.id,
                                                  "review_text":
                                                      _reviewController.text
                                                          .trim(),
                                                  "first_name": first_name,
                                                  "rating": ratingReview,
                                                });
                                                _reviewController.clear();
                                              } else if (ratingReview == null) {
                                                return rateDialog();
                                              } else if (_reviewController
                                                  .text.isEmpty) {
                                                return reviewDialog();
                                              }
                                            },
                                            icon: const Icon(Icons.send,
                                                color: Colors.amber)),
                                      ),
                                    ),
                                  ),
                                  ExpansionTile(
                                    title: Text(
                                      "More rating",
                                      style:
                                          Theme.of(context).textTheme.headline3,
                                    ),
                                    children: [
                                      ShowMessages(id: widget.id),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ),
      ),
    );
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

  void rateDialog() {
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
                        "Please rate the show.",
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

  void reviewDialog() {
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
                        "Please enter a review.",
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
