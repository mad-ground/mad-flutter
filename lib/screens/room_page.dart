import 'package:flutter/material.dart';

class RoomPage extends StatefulWidget {
  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          'Room Page',
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ),
    );
  }
}