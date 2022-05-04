import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:api_series/models/show_model.dart';
import 'package:flutter/material.dart';

class ShowRepository with ChangeNotifier {
  int _page = 1;
  final List<ShowModel> _shows = [];

  List<ShowModel> get shows => _shows;

  getShows() async {
    final url = Uri.parse(
        'https://www.episodate.com/api/most-popular?page=$_page');
    final response = await http.get(url);
    final List<dynamic> results = jsonDecode(response.body)['tv_shows'];
    for (var i = 0; i < results.length; i++) {
      _shows.add(ShowModel.fromMap(results[i]));
    }
    _page++;
    notifyListeners();
  }
}