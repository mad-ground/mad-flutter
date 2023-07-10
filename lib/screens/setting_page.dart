
import 'package:flutter/material.dart';
import 'package:madground/screens/login_page.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: TextButton(
          onPressed: () {
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