import 'package:flutter/material.dart';
import 'package:madground/type/room.dart';

import '../type/user.dart';

class RoomPage extends StatefulWidget {
  final Room room;
  RoomPage({required this.room});
  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
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
                          widget.room?.host.username ?? 'Host Name',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'ReadexPro',
                          ),
                        ),
                      ),
                      RoomSetting()
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
    );
  }
}

class RoomSetting extends StatelessWidget {
  const RoomSetting({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(5, 15, 5, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
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
            'players',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              fontFamily: 'ReadexPro',
            ),
          ),
          Text(
            'time',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              fontFamily: 'ReadexPro',
            ),
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
