import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:madground/screens/room_invite_page.dart';
import 'package:http/http.dart' as http;
import '../component/button.dart';
import '../component/text_field.dart';
import '../socket/SocketSystem.dart';
import '../type/room.dart';

class RoomCreatePage extends StatefulWidget {
  var roomName = "";
  var roomProfileImage = "";

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

  Future<void> saveFileLocally() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      String? filePath = result.files.first.path;
      if (filePath != null) {
        // 파일 업로드 로직
        var request = http.MultipartRequest(
          'POST',
          Uri.parse('http://172.10.5.147/upload'), // 서버의 업로드 엔드포인트 URL로 변경
        );
        request.files.add(
          await http.MultipartFile.fromPath('file', filePath),
        );
        var streamedResponse = await request.send();
        var response = await http.Response.fromStream(streamedResponse);
        print(response.body);
        if (response.statusCode == 201) {
          setState(() {
            widget.roomProfileImage = response.body;
          });
          print('File uploaded successfully');
        } else {
          print('Failed to upload file');
        }
      }
    }
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
                      child: (widget.roomProfileImage != null &&
                              widget.roomProfileImage != '')
                          ? Image.network(
                              widget.roomProfileImage!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              'https://picsum.photos/seed/55/600',
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                    child: TextButton(
                        onPressed: saveFileLocally,
                        child: Text('+ select Image')),
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
                          builder: (context) => RoomInvitePage(
                              roomName: widget.roomName,
                              roomProfileImage: widget.roomProfileImage)),
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
