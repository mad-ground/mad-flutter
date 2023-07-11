import 'package:flutter/material.dart';
import 'package:madground/type/user.dart';

class Room {
  final int? id;
  final String roomName;
  final User host;
  final List<User>? players;
  final String? profileImage;

  Room({
    required this.id,
    required this.roomName,
    required this.host,
    required this.players,
    required this.profileImage,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'].toInt(),
      roomName: json['roomName'],
      host: User.fromJson(json['host']),
      players: List<User>.from(json['players'].map((player) => User.fromJson(player))),
      profileImage: json['profileImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'roomName': roomName,
      'host': host.toJson(),
      'players': players?.map((player) => player.toJson()).toList(),
      'profileImage': profileImage,
    };
  }
}


