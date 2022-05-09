class ReviewModel {
  final String id;
  final String? id_user;
  final String? review_text;
  final String? first_name;
  final DateTime? rating;

  ReviewModel(
      {required this.id,
      required this.id_user,
      required this.review_text,
      required this.first_name,
      required this.rating, 
      });
}
