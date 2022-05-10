import 'package:api_series/models/search_show_model.dart';
import 'package:api_series/widgets/search_result_card.dart';
import 'package:flutter/material.dart';

import '../config/gradientbackground.dart';

class ShowSearchDelegate extends SearchDelegate {
  
  final List<SearchShowModel> showList;

  ShowSearchDelegate({required this.showList});
  
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
    List<SearchShowModel> suggestions = showList.where((searchResult) {
      final result = searchResult.name!.toLowerCase();
      final input = query.toLowerCase();
      return result.contains(input);
    }).toList();
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: suggestions.length,
          itemBuilder: (context, index) {
            final suggestion = suggestions[index];
            return SearchResultCard(id: suggestion.id!, imageThumbnailPath: suggestion.imageThumbnailPath!, name: suggestion.name!);
          },
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<SearchShowModel> suggestions = showList.where((searchResult) {
      final result = searchResult.name!.toLowerCase();
      final input = query.toLowerCase();
      return result.contains(input);
    }).toList();
    return Container(
      decoration: GradientColor.gradient,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: suggestions.length,
          itemBuilder: (context, index) {
            final suggestion = suggestions[index];
            return SearchResultCard(id: suggestion.id!, imageThumbnailPath: suggestion.imageThumbnailPath!, name: suggestion.name!);
          },
        ),
      ),
    );
  }
}