import 'package:flutter/material.dart';
import 'package:madground/main.dart';

import '../component/button.dart';
import 'home_page.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Center(
            child: CustomButton(
              text: "Login",
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/main');
              }
            ),
          ),
        ),
      ),
    );
  }
}