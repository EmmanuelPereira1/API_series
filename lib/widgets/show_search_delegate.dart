import 'package:api_series/config/theme.dart';
import 'package:api_series/models/search_show_model.dart';
import 'package:api_series/pages/home_page.dart';
import 'package:api_series/request/fetch_search.dart';
import 'package:api_series/request/show_list.dart';
import 'package:api_series/widgets/search_result_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../config/gradientbackground.dart';
import '../pages/show_details_page.dart';

class ShowSearchDelegate extends SearchDelegate {
  FetchSearch showsList = FetchSearch();

  ShowSearchDelegate({required this.showsList});

  // @override
  // ThemeData appBarTheme(BuildContext context) {
  //   return ThemeData(
  //     appBarTheme: const AppBarTheme(
  //       color: Color(0XFF026873),
  //     ),
  //     textTheme: const TextTheme(
  //         headline6: TextStyle(
  //             color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
  //   );
  // }

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back));

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
          },
        ),
      ];

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<TvShows>>(
        future: showsList.fetchSearch(query),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          List<TvShows>? data = snapshot.data;
          return Container(
            decoration: GradientColor.gradient,
            child: ListView.builder(
                itemCount: data?.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Ink(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => ShowDetailsPage(
                                      id: data![index].id!,
                                    )),
                              ),
                            );
                          },
                          child: SearchResultCard(
                              id: data![index].id!,
                              name: data[index].name!,
                              imageThumbnailPath:
                                  data[index].imageThumbnailPath!),
                        ),
                      ),
                      const SizedBox(height: 2)
                    ],
                  );
                }),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      decoration: GradientColor.gradient,
      child: const Scaffold(
        backgroundColor: Colors.transparent,
        body: ShowsList()
      ),
    );
  }
}
