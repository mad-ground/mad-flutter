import 'package:flutter/material.dart';
import 'package:madground/screens/login_page.dart';

class RoomCreatePage extends StatefulWidget {
  @override
  State<RoomCreatePage> createState() => _RoomCreatePageState();
}

class _RoomCreatePageState extends State<RoomCreatePage> {
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
          child: Text('room create page'),
        ),
      ),
    );
  }
}