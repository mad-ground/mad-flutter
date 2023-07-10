import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {

    return Container(
      child: Center(
        child: Text(
          '현재 유저: ${context.watch<UserProvider>().user?.username}',
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ),
    );
  }
}