import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:madground/game1/Game1Client.dart';
import 'package:madground/type/room.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../component/button.dart';
import '../component/button_grey.dart';
import '../providers/user_provider.dart';
import '../socket/SocketSystem.dart';
import '../type/user.dart';

class RoomPage extends StatefulWidget {
  final Room room;
  var inRoom = false;
  RoomPage({required this.room});
  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  @override
  void initState() {
    super.initState();
  }

  enterRoom() async {
    //room이 없어졌을 때
    if (widget.room.id == '') {
      return;
    }
    SocketSystem.emitMessage('enterRoom', widget.room.id);
    setState(() {
      widget.inRoom = true;
    });
    // try {
    //   final response = await http.get(Uri.parse('http://172.10.5.147/room/${widget.room.id}'));
    //   if (response.statusCode == 200) {
    //     final room = Room.fromJson(jsonDecode(response.body));
    //     setState(() {});
    //   } else {
    //     print('Failed to fetch user list. Status code: ${response.statusCode}');
    //   }
    // } catch (error) {
    //   print('Failed to fetch user list: $error');
    // }
  }

  @override
  Widget build(BuildContext context) {
    exitRoom() {
      Navigator.pop(context, true);
    }

    return WillPopScope(
      onWillPop: () async {
        // 뒤로가기 버튼을 눌렀을 때 실행할 동작을 여기에 작성하세요.

        // 예를 들어, 뒤로가기 버튼을 눌렀을 때 다이얼로그를 표시하려면:
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('EXIT'),
            content: Text('정말로 방을 나가시겠습니까?'),
            actions: [
              TextButton(
                child: Text('취소'),
                onPressed: () {
                  Navigator.of(context).pop(false); // 다이얼로그를 닫고 뒤로가기를 취소합니다.
                },
              ),
              TextButton(
                child: Text('나가기'),
                onPressed: () {
                  SocketSystem.emitMessage('exitRoom', widget.room.id);
                  Navigator.of(context).pop(true);
                  exitRoom(); // 다이얼로그를 닫고 앱을 종료합니다.
                },
              ),
            ],
          ),
        );

        // 뒤로가기를 취소하려면 false를 반환하고, 앱을 종료하려면 true를 반환합니다.
        return false;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background_room.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  Flexible(
                      flex: 4,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
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
                              padding: EdgeInsets.fromLTRB(5, 15, 5, 0),
                              child: Text(
                                widget.room?.roomName ?? 'Room Name',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 27,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'ReadexPro',
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                              child: Text(
                                widget.room?.host?.username ?? 'Host Name',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'ReadexPro',
                                ),
                              ),
                            ),
                            RoomSetting(items: widget.room.players!,)
                          ],
                        ),
                      )),
                  Flexible(
                    flex: 5,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      child: RoomUserListView(items: widget.room.players!),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 150,
                child: widget.room.host?.id ==
                        context.watch<UserProvider>().user?.id
                    ? CustomButton(
                        text: "Start Game",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Game1Home()),
                          );
                        },
                      )
                    : !widget.inRoom &&
                            context.watch<UserProvider>().user?.roomId !=
                                widget.room.id
                        ? CustomButton(
                            text: "Enter Room",
                            onPressed: () {
                              if (widget.inRoom == false) {
                                enterRoom();
                              }
                            },
                          )
                        : CustomButtonGrey(
                            text: "Game Ready",
                            onPressed: () {},
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RoomSetting extends StatefulWidget {
  final List<User> items;
  const RoomSetting({
    super.key,
    required this.items,
  });

  @override
  State<RoomSetting> createState() => _RoomSettingState();
}

class _RoomSettingState extends State<RoomSetting> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(5, 15, 5, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            children: [
              Text(
                'round',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'ReadexPro',
                ),
              ),
              Text(
                'round',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'ReadexPro',
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                'players',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'ReadexPro',
                ),
              ),
              Text(
                widget.items?.length.toString()??"0",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'ReadexPro',
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                'game',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'ReadexPro',
                ),
              ),
              Text(
                '1',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'ReadexPro',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class RoomUserListView extends StatefulWidget {
  final List<User> items;

  const RoomUserListView({required this.items});

  @override
  State<RoomUserListView> createState() => _RoomUserListViewState();
}

class _RoomUserListViewState extends State<RoomUserListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
      itemCount: widget.items.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsetsDirectional.fromSTEB(40, 0, 40, 0),
          child: RoomUserListItem(item: widget.items[index]),
        );
      },
    );
  }
}

class RoomUserListItem extends StatefulWidget {
  final User? item;
  const RoomUserListItem({
    super.key,
    this.item,
  });

  @override
  State<RoomUserListItem> createState() => _RoomUserListItemState();
}

class _RoomUserListItemState extends State<RoomUserListItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(10, 8, 10, 8),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.network(
                  'https://picsum.photos/seed/55/600',
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.item?.username ?? 'User Name',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      widget.item?.email ?? 'Email',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ]),
            Icon(Icons.warning_amber),
          ],
        ),
      ),
    );
  }
}
