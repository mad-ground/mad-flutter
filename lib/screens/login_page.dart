import 'package:flutter/material.dart';
import 'package:madground/main.dart';

import '../component/button.dart';
import '../component/text_field.dart';
import '../container/login_container.dart';
import 'home_page.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage('assets/images/background_login.png'),
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.6), BlendMode.darken),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
            child: Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                  child: Text(
                    "MADGROUND",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontFamily: 'ReadexPro',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                LoginContainer(),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
