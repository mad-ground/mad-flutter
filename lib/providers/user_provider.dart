
import 'package:flutter/material.dart';

import '../type/user.dart';

class UserProvider with ChangeNotifier {
  User? _user = null;
  User? get user => _user;

  void setUser(userData) {
    _user = userData;
    notifyListeners();
  }

  void removeUser() {
    _user = null;
    notifyListeners();
  }
}
