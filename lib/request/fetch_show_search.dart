import 'package:api_series/models/search_show_model.dart';
import 'package:api_series/models/show_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

Future<List<SearchShowModel>> fetchSearch(String input) async {
    var url = 'https://www.episodate.com/api/search?q=$input';
    final response = await Dio().get(url);
    if(response.statusCode != 200) {
      return [];
    }
    final parsedResponse = Shows.fromJson(response.data);
    return parsedResponse.tv_show!.shows!;
}
