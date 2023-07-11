import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

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
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
          color: Color.fromARGB(255, 68, 68, 68)
        ),
        child: Column(
          children: [
            Flexible(
                flex: 3,
                  child: Container(
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
                        ProfileSetting()
                      ],
                    ),
                  ),
                ),
            Flexible(
              flex: 7,
              child: Stack(
                children: [
                  Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Container()
                ),
                ]
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileSetting extends StatelessWidget {
  const ProfileSetting({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            'round',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              fontFamily: 'ReadexPro',
            ),
          ),
          Text(
            'players',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              fontFamily: 'ReadexPro',
            ),
          ),
          Text(
            'time',
            style: TextStyle(
              color: Colors.white,
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
class UserListView extends StatelessWidget {
  final List<String> items;

  const UserListView({required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsetsDirectional.fromSTEB(40, 0, 40, 0),
          child: UserListItem(),
        );
      },
    );
  }
}

class UserListItem extends StatelessWidget {
  const UserListItem({
    super.key,
  });
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
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [ClipRRect(
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
                      'User',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      'state message',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
