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
  String? stateMessage;

  User(
      {required this.id,
      required this.username,
      required this.name,
      this.email,
      this.profileImage,
      required this.type,
      this.roomId,
      this.stateMessage});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'].toInt(),
      username: json['username'],
      name: json['name'],
      email: json['email'],
      profileImage: json['profileImage'],
      type: json['type'],
      roomId: json['room'] != null ? RoomInfo.fromJson(json['room']).id : null,
      stateMessage: json['profileImage'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'username': username,
      'type': type,
    };
    if (profileImage != null && profileImage != '') {
      json['profileImage'] = profileImage;
    }
    if (email != null && email != '') {
      json['email'] = email;
    }
    if (name != null && name != '') {
      json['name'] = name;
    }
    if (stateMessage != null && stateMessage != '') {
      json['stateMessage'] = stateMessage;
    }

    return json;
  }
}
