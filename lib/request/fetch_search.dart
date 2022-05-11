import 'package:api_series/models/search_show_model.dart';
import 'package:dio/dio.dart';

class FetchSearch {
  Future<List<TvShows>> fetchSearch(String input) async {
    var url = 'https://www.episodate.com/api/search?q=$input';
    final response = await Dio().get(url);
    if (response.statusCode != 200) {
      return [];
    }
    final parsedResponse = SearchShowModel.fromJson(response.data);
    return parsedResponse.tvShows!;
  }
}
