class User {
  final String first_name;
  final String last_name;
  final String email;
  final String password;

   User({
    required this.first_name,
    required this.last_name,
    required this.email,
    required this.password,
  });

  User copy({
    required String first_name,
    required String last_name,
    required String email,
    required String password,
  }) => 
        User(
          first_name: first_name,
          last_name: last_name,
          email: email,
          password: password,
        );

  static User fromJson(Map<String,dynamic> json) => User(

    first_name: json['first_name'],
    last_name: json['last_name'],
    email: json['email'],
    password: json['password'],
  );

  Map<String, dynamic> toJson() =>{
    'first_name': first_name,
    'last_name': last_name,
    'email': email,
    'password': password,
  };
}