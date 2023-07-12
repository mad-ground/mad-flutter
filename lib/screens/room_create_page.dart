import 'package:flutter/material.dart';
import 'package:madground/screens/room_invite_page.dart';

import '../component/button.dart';
import '../component/text_field.dart';
import '../type/room.dart';

class RoomCreatePage extends StatefulWidget {
  var roomName = "";

  @override
  State<RoomCreatePage> createState() => _RoomCreatePageState();
}

class _RoomCreatePageState extends State<RoomCreatePage> {
  @override
  void initState() {
    super.initState();
  }

  void onRoomNameChanged(String value) {
    widget.roomName = value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Room'),
        titleTextStyle: const TextStyle(
            fontSize: 20,
            fontFamily: 'ReadexPro',
            color: Colors.white,
            fontWeight: FontWeight.w400),
        backgroundColor: Colors.black,
      ),
      body: Container(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(30, 0, 30, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.all(20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        'https://picsum.photos/seed/55/600',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      'Room Name',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'ReadexPro',
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                      child: CustomTextField(
                          text: "Room Name", onChanged: onRoomNameChanged)),
                  // Container(
                  //   child: Text(
                  //     'Room Password',
                  //     style: TextStyle(
                  //         fontSize: 20,
                  //         fontFamily: 'ReadexPro',
                  //         color: Colors.black,
                  //         fontWeight: FontWeight.w600),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                  //   child:
                  //
                ],
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 150,
                child: CustomButton(
                  text: "Invite Players",
                  onPressed: () {
                    if (widget.roomName == '' || widget.roomName.isEmpty) {
                      return;
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              RoomInvitePage(roomName: widget.roomName)),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
