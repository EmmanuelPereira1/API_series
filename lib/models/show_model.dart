class ShowModel {
  int id;
  String name;
  String startDate;
  String country;
  String network;
  String status;
  String imageThumbnailPath;

  ShowModel({
    required this.id,
    required this.name,
    required this.startDate,
    required this.country,
    required this.network,
    required this.status,
    required this.imageThumbnailPath
  });

factory ShowModel.fromMap(Map<String, dynamic> map) {
  return ShowModel(
    id: map['id'] ?? '',
    name: map['name'] ?? '',
    startDate: map['start_date'] ?? '',
    country: map['country'] ?? '',
    network: map['network'] ?? '',
    status: map['status'] ?? '',
    imageThumbnailPath: map['image_thumbnail_path'] ?? '',
    );
    
  }
}