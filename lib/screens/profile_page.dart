import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../providers/user_provider.dart';
import '../type/user.dart';
import 'package:madground/socket/SocketSystem.dart';

// class ProfilePage extends StatefulWidget {
//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   @override
//   Widget build(BuildContext context) {

//     return Container(
//       child: Center(
//         child: Text(
//           '현재 유저: ${context.watch<UserProvider>().user?.username}',
//           style: Theme.of(context).textTheme.bodyText2,
//         ),
//       ),
//     );
//   }
// }

class ProfilePage extends StatefulWidget {
  late User user;
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    widget.user = context.read<UserProvider>().user!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    changeProfileUser(user) {
      setState(() {
        widget.user = user;
      });
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        child: Column(
          children: [
            Container(
                height: 300,
                decoration: const BoxDecoration(color: Color.fromARGB(255, 48, 48, 48)),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                      child: Container(
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
                    ),
                    ProfileSetting(user: widget.user)
                  ],
                ),
              ),
            Container(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Column(
                  children: [
                    UserListView(onTap: changeProfileUser, id: widget.user.id),
                    Container(
                      height: 70,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileSetting extends StatelessWidget {
  final User? user;
  const ProfileSetting({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              '${user?.username}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                fontFamily: 'ReadexPro',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              '${user?.email}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontFamily: 'ReadexPro',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              '${user?.id}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontFamily: 'ReadexPro',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UserListView extends StatefulWidget {
  final void Function(User user) onTap;
  final int id;
  const UserListView({
    super.key,
    required this.onTap,
    required this.id,
  });
  @override
  State<UserListView> createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  List<User> userList = [];

  Future<void> fetchUserList() async {
    try {
      final response = await http.get(Uri.parse('http://172.10.5.147:${SocketSystem.PORT_NO}/user'));
      if (response.statusCode == 200) {
        final users = json.decode(response.body) as List<dynamic>;
        users.forEach((element) {
          userList.add(User.fromJson(element));
        });
        userList.removeWhere((user) => user.id == widget.id);
        setState(() {});
      } else {
        print('Failed to fetch user list. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Failed to fetch user list: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: userList.map((user) {
          return Padding(
            padding: EdgeInsetsDirectional.fromSTEB(5, 20, 5, 20),
            child: UserListItem(item: user, onTap: widget.onTap),
          );
        }).toList(),
      ),
    );
  }
}

class UserListItem extends StatefulWidget {
  final User item;
  final void Function(User user) onTap;
  const UserListItem({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  State<UserListItem> createState() => _UserListItemState();
}

class _UserListItemState extends State<UserListItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap(widget.item);
      },
      child: SizedBox(
        height: 200,
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10, 8, 10, 8),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                        'state message',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Follow"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
