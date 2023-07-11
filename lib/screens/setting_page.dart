import 'package:flutter/material.dart';
import 'package:madground/screens/login_page.dart';
import 'package:madground/socket/SocketSystem.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: TextButton(
          onPressed: () {
            SocketSystem.disconnectSocket();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
          child: Text('Go to Login Page(Logout)'),
        ),
      ),
    );
  }
}
