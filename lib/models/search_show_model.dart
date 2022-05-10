// class SearchShowModel {
//   String? total;
//   int? page;
//   int? pages;
//   List<TvShows>? tvShows;

//   SearchShowModel({this.total, this.page, this.pages, this.tvShows});

//   SearchShowModel.fromJson(Map<String, dynamic> json) {
//     total = json['total'];
//     page = json['page'];
//     pages = json['pages'];
//     if (json['tv_shows'] != null) {
//       tvShows = <TvShows>[];
//       json['tv_shows'].forEach((v) {
//         tvShows!.add(TvShows.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['total'] = total;
//     data['page'] = page;
//     data['pages'] = pages;
//     if (tvShows != null) {
//       data['tv_shows'] = tvShows!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class TvShows {
//   int? id;
//   String? name;
//   String? imageThumbnailPath;

//   TvShows(
//       {this.id,
//       this.name,
//       this.imageThumbnailPath});

//   TvShows.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     imageThumbnailPath = json['image_thumbnail_path'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['id'] = id;
//     data['name'] = name;
//     data['image_thumbnail_path'] = imageThumbnailPath;
//     return data;
//   }
// }
import 'package:api_series/models/show_model.dart';

class Shows {
  int? total;
  int? page;
  int? pages;
  tvShow? tv_show;

  Shows({this.total, this.page, this.pages, this.tv_show});

  Shows.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    page = json['page'];
    pages = json['pages'];
    tv_show = json['tv_show'] != null ? tvShow.fromJson(json['tv_show']) : null;
  }
}

class tvShow {
  List<SearchShowModel>? shows;
  tvShow({this.shows});
  tvShow.fromJson(Map<String, dynamic> json) {
    if (json['tv_show'] != null) {
      shows = <SearchShowModel>[];
      json['tv_show'].forEach((v) {
        shows!.add(SearchShowModel.fromJson(v));
      });
    }
  }
}

class SearchShowModel {
  int? id;
  String? name;
  String? imageThumbnailPath;

  SearchShowModel({this.id, this.name, this.imageThumbnailPath});

  SearchShowModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageThumbnailPath = json['image_thumbnail_path'];
  }

}

