import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:madground/screens/room_page.dart';
import 'package:http/http.dart' as http;

import '../type/room.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Room> items = [];

  @override
  void initState() {
    super.initState();
    fetchRoomList();
  }

  Future<void> fetchRoomList() async {
    try {
      final response = await http.get(Uri.parse('http://143.248.200.49/room'));
      if (response.statusCode == 200) {
        final rooms = json.decode(response.body) as List<dynamic>;
        rooms.forEach((element) {
          items.add(Room.fromJson(element));
        });
        setState(() {});
      } else {
        print('Failed to fetch user list. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Failed to fetch user list: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [HomeListView(items: items)],
    );
  }
}

class HomeListView extends StatefulWidget {
  final List<Room> items;

  const HomeListView({required this.items});

  @override
  State<HomeListView> createState() => _HomeListViewState();
}

class _HomeListViewState extends State<HomeListView> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        //color: const Color.fromARGB(255, 60, 60, 60),
        child: ListView.builder(
          itemCount: widget.items.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(0),
                  ),
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 60, 60, 60),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                  ));
            }
            final item = widget.items[index - 1]; // 헤더를 제외한 아이템 인덱스 계산
            return Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
              child: RoomListItem(item: item),
            );
          },
        ),
      ),
    );
  }
}

class RoomListItem extends StatefulWidget {
  final Room item;
  const RoomListItem({
    super.key,
    required this.item,
  });

  @override
  State<RoomListItem> createState() => _RoomListItemState();
}

class _RoomListItemState extends State<RoomListItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RoomPage(room: widget.item)),
        );
      },
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(0),
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(0),
                ),
                child: Image.network(
                  'https://picsum.photos/seed/55/600',
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                      child: Text(
                        widget.item?.roomName ?? 'Room Name',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Nanum',
                            color: Colors.black,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Text(
                      widget.item?.host.username ?? 'Host Name',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
