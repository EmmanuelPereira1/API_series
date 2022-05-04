
class Album {
  final String email;
  final String password;
  final String first_name;
  final String last_name;


  const Album({
    required this.email,
    required this.password,
    required this.first_name,
    required this.last_name,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      email: json['email'],
      password: json['password'],
      first_name: json['first_name'],
      last_name: json['last_name'],
    );
  }
}