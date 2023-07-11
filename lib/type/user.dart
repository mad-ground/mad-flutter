import 'package:madground/type/room.dart';
import 'package:madground/type/room_info.dart';

class User {
  int id;
  String username;
  String? name;
  String? email;
  String? profileImage;
  String type;
  int? roomId;

  User({
    required this.id,
    required this.username,
    required this.name,
    this.email,
    this.profileImage,
    required this.type,
    this.roomId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'].toInt(),
      username: json['username'],
      name: json['name'],
      email: json['email'],
      profileImage: json['profileImage'],
      type: json['type'],
      roomId: json['room'] != null ? RoomInfo.fromJson(json['room']).id : null,
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
