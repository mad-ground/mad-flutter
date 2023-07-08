import 'package:flutter/material.dart';
import 'package:madground/main.dart';

import '../component/button.dart';
import '../component/text_field.dart';
import 'home_page.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Image.network(
                'https://images.unsplash.com/photo-1525824236856-8c0a31dfe3be?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OXx8d2F0ZXJmYWxsfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60',
              ).image,
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.darken),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 50, 20, 50),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("MADGROUND", style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontFamily: 'ReadexPro',
                    fontWeight: FontWeight.w500,
                  ),),
                  CustomTextField(text:"Email Address"),
                  CustomTextField(text:"Password"),
                  Container(
                    child: CustomButton(
                      text: "Login",
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/main');
                      }
                    ),
                  ),
                ]
              ),
            ),
          ),
        ),
      ),
    );
  }
}