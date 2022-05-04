class ShowModel {
  int id;
  String name;
  // String permalink;
  // String startDate;
  // String country;
  // String network;
  String status;
  String imageThumbnailPath;

  ShowModel({
    required this.id,
    required this.name,
    // required this.permalink,
    // required this.startDate,
    // required this.country,
    // required this.network,
    required this.status,
    required this.imageThumbnailPath
  });

factory ShowModel.fromMap(Map<String, dynamic> map) {
  return ShowModel(
    id: map['id'] ?? '',
    name: map['name'] ?? '',
    // permalink: map['permalink'] ?? '',
    // startDate: map['start_date'] ?? '',
    // id: map['id'] ?? '',
    // id: map['id'] ?? '',
    status: map['status'] ?? '',
    imageThumbnailPath: map['image_thumbnail_path'] ?? '',
    );
    
  }
}