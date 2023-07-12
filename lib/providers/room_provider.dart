
import 'package:flutter/material.dart';

import '../type/room.dart';
import '../type/user.dart';

class RoomProvider with ChangeNotifier {
  Room? _room = null;
  Room? get room => _room;

  void setRoom(roomData) {
    _room = roomData;
    notifyListeners();
  }

  void removeRoom() {
    _room = null;
    notifyListeners();
  }
}
