import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

Future<ShowDetails> fetchShowDetails(int idShow) async {
  final response = await Dio()
      .get('https://www.episodate.com/api/show-details?q=$idShow');

  if (response.statusCode == 200) {
    return ShowDetails.fromJson(response.data);
  } else {
    throw Exception('Failed to load ShowDetails');
  }
}

class ShowDetails {
  final String name;
  final String description;
  final String imageThumbnailPath;
  final String status;
  final String country;
  final String network;
  final String startDate;
  final List genres;

  const ShowDetails({
    required this.name,
    required this.description,
    required this.imageThumbnailPath,
    required this.status,
    required this.country,
    required this.network,
    required this.startDate,
    required this.genres,
  });

  factory ShowDetails.fromJson(Map<String, dynamic> json) {
    return ShowDetails(
      name: json['tvShow']['name'],
      description: json['tvShow']['description'],
      imageThumbnailPath: json['tvShow']['image_thumbnail_path'],
      status: json['tvShow']['status'],
      country: json['tvShow']['country'],
      network: json['tvShow']['network'],
      startDate: json['tvShow']['start_date'],
      genres: json['tvShow']['genres'],
    );
  }
}
