class User {
  int id;
  String username;
  String? name;
  String? email;
  String? profileImage;
  String type;

  User({
    required this.id,
    required this.username,
    required this.name,
    this.email,
    this.profileImage,
    required this.type,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'].toInt(),
      username: json['username'],
      name: json['name'],
      email: json['email'],
      profileImage: json['profileImage'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'name': name,
      'email': email,
      'profileImage': profileImage,
      'type': type,
    };
  }
}
