import 'dart:ui';

import 'package:api_series/pages/show_details_page.dart';
import 'package:flutter/material.dart';

class SearchResultCard extends StatelessWidget {
  const SearchResultCard({
    Key? key,
    required this.id,
    required this.name,
    required this.imageThumbnailPath,
  }) : super(key: key);

  final int id;
  final String name;
  final String imageThumbnailPath;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
                width: 340,
                height: 120,
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.grey[900]),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(children: [
                    const SizedBox(width: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 70,
                          height: 100,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(imageThumbnailPath),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Wrap(
                          children: [
                            Text(name.toUpperCase(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(color: Colors.amber, fontSize: 18, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    )
                  ]),
                ))));
  }
}
