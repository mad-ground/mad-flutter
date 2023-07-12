import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:madground/screens/room_invite_page.dart';
import 'package:http/http.dart' as http;
import '../component/button.dart';
import '../component/text_field.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../type/room.dart';
import '../type/user.dart';
import 'package:madground/socket/SocketSystem.dart';

class ProfileEditPage extends StatefulWidget {
  late User user;
  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  @override
  void initState() {
    widget.user = context.read<UserProvider>().user!;
    super.initState();
  }

  void onNameChange(String value) {
    widget.user.name = value;
  }

  void onEmailChange(String value) {
    widget.user.email = value;
  }

  void onStateChange(String value) {
    widget.user.stateMessage = value;
  }

  changeProfileUser(user) {
    print(user.id);
    setState(() {
      widget.user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    void handleUpdate() async {
      String url = 'http://172.10.5.147${SocketSystem.PORT_NO}/user/${widget.user.id}';
      http.Response response =
          await http.put(Uri.parse(url), body: widget.user.toJson());
      print('response: ${widget.user.toJson()}');

      if (response.statusCode == 200) {
        User user = User.fromJson(jsonDecode(response.body));
        context.read<UserProvider>().setUser(user);
        print(user.email);
        Navigator.pop(context, true);
      } else {
        print('업데이트 실패');
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Profile Edit'),
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
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
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
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                    child: TextButton(
                        onPressed: () {}, child: Text('+ select Image')),
                  ),
                  Container(
                    child: Text(
                      'Name',
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
                        text: "Name",
                        onChanged: onNameChange,
                        initText: widget.user.name,
                      )),
                  Container(
                    child: Text(
                      'Email',
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
                        text: "Email",
                        onChanged: onEmailChange,
                        initText: widget.user.email,
                      )),
                  Container(
                    child: Text(
                      'State Message',
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
                        text: "State Message",
                        onChanged: onStateChange,
                        initText: widget.user.name,
                      )),
                ],
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 150,
                child: CustomButton(
                  text: "Update Profile",
                  onPressed: () {
                    handleUpdate();
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
