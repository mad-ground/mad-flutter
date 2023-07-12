import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:madground/screens/login_page.dart';
import 'package:madground/type/user.dart';
import 'package:provider/provider.dart';
import 'package:madground/socket/SocketSystem.dart';

import '../component/button.dart';
import '../providers/user_provider.dart';

class RoomInvitePage extends StatefulWidget {
  final String roomName;
  const RoomInvitePage({super.key, required this.roomName});

  @override
  State<RoomInvitePage> createState() => _RoomInvitePageState();
}

class _RoomInvitePageState extends State<RoomInvitePage> {
  List<User> userList = [];
  List<User> selectedUserList = [];

  @override
  void initState() {
    super.initState();
    fetchUserList();
  }

  void addSelectedList(user) {
    setState(() {
      selectedUserList.add(user);
    });
  }

  void removeSelectedUser(User user) {
    setState(() {
      selectedUserList.remove(user);
    });
  }

  Future<void> fetchUserList() async {
    try {
      final response = await http.get(Uri.parse('http://172.10.5.147:${SocketSystem.PORT_NO}/user'));
      if (response.statusCode == 200) {
        final users = json.decode(response.body) as List<dynamic>;
        users.forEach((element) {
          userList.add(User.fromJson(element));
        });
        var myId = context.read<UserProvider>().user?.id;
        userList.removeWhere(
            (user) => user.id == myId);
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Invite User'),
        titleTextStyle: const TextStyle(
            fontSize: 20,
            fontFamily: 'ReadexPro',
            color: Colors.white,
            fontWeight: FontWeight.w400),
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children: [Container(
          child: TextButton(
            onPressed: () {},
            child: Column(
              children: [
                Text(
                  'Selected User : ${selectedUserList.length}',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'ReadexPro',
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
                Divider(),
                RoomUserListView(
                    items: userList,
                    onSelect: addSelectedList,
                    onDeselect: removeSelectedUser)
              ],
            ),
          ),
        ),
        Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 150,
                child: CustomButton(
                        text: "Create Room",
                        onPressed: () {
                          
                        },
                      )
              ),
            ),
        ],
      ),
    );
  }
}

class RoomUserListView extends StatefulWidget {
  final List<User> items;
  final void Function(User user) onSelect;
  final void Function(User user) onDeselect;

  const RoomUserListView(
      {required this.items, required this.onSelect, required this.onDeselect});

  @override
  State<RoomUserListView> createState() => _RoomUserListViewState();
}

class _RoomUserListViewState extends State<RoomUserListView> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: ListView.builder(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
            child: RoomUserListItem(
                item: widget.items[index],
                onSelect: widget.onSelect,
                onDeselect: widget.onDeselect),
          );
        },
      ),
    );
  }
}

class RoomUserListItem extends StatefulWidget {
  final User item;
  final void Function(User user) onSelect;
  final void Function(User user) onDeselect;

  const RoomUserListItem(
      {super.key,
      required this.item,
      required this.onSelect,
      required this.onDeselect});

  @override
  State<RoomUserListItem> createState() => _RoomUserListItemState();
}

class _RoomUserListItemState extends State<RoomUserListItem> {
  bool isChecked = false;

  void toggleCheckbox() {
    setState(() {
      isChecked = !isChecked;
    });
    if (isChecked) {
      widget.onSelect(widget.item);
    } else {
      widget.onDeselect(widget.item);
    }
  }

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
                      '${widget.item.username}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      '${widget.item.id}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ]),
            GestureDetector(
              onTap: toggleCheckbox,
              child: Icon(
                isChecked ? Icons.check_box : Icons.check_box_outline_blank,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CheckBoxWidget extends StatefulWidget {
  final VoidCallback onPressed;

  const CheckBoxWidget({
    required this.onPressed,
  });
  @override
  _CheckBoxWidgetState createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    void toggleCheckbox() {
      setState(() {
        isChecked = !isChecked;
      });
      widget.onPressed;
    }

    return GestureDetector(
      onTap: toggleCheckbox,
      child: Icon(
        isChecked ? Icons.check_box : Icons.check_box_outline_blank,
        // color: isChecked ? Colors.green : Colors.black,
      ),
    );
  }
}
