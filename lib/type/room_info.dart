import 'package:flutter/material.dart';
import 'package:madground/type/user.dart';

class RoomInfo {
  final int? id;
  final String roomName;
  final String? profileImage;

  RoomInfo({
    required this.id,
    required this.roomName,
    required this.profileImage,
  });

  factory RoomInfo.fromJson(Map<String, dynamic> json) {
    return RoomInfo(
      id: json['id'].toInt(),
      roomName: json['roomName'],
      profileImage: json['profileImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'roomName': roomName,
      'profileImage': profileImage,
    };
  }
}


