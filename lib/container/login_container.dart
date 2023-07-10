import 'package:flutter/material.dart';
import 'package:madground/component/button.dart';
import 'package:madground/component/text_field.dart';

import '../main.dart';

class LoginContainer extends StatefulWidget {
  const LoginContainer({super.key});

  @override
  State<LoginContainer> createState() => _LoginContainerState();
}

class _LoginContainerState extends State<LoginContainer> {
  @override
  Widget build(BuildContext context) {
    return // Generated code for this TabBar Widget...
        Container(
      child: DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment(0, 0),
              child: TabBar(
                isScrollable: true,
                labelStyle: Theme.of(context).textTheme.bodyMedium,
                unselectedLabelStyle: Theme.of(context).textTheme.bodyMedium,
                labelColor: Colors.white,
                unselectedLabelColor: Color(0xFF919191),
                labelPadding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                tabs: [
                  Tab(
                    text: 'Sign In',
                  ),
                  Tab(
                    text: 'Sign Up',
                  ),
                ],
              ),
            ),
            Container(
              child: LoginTapBarView(),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginTapBarView extends StatelessWidget {
  const LoginTapBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: TabBarView(
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(44, 0, 44, 0),
            child: SingleChildScrollView(
              child: LoginTap(),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(44, 0, 44, 0),
            child: SingleChildScrollView(
              child: SigninTap(),
            ),
          ),
        ],
      ),
    );
  }
}

class SigninTap extends StatelessWidget {
  const SigninTap({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      // 수정: MainAxisSize.min으로 변경
      children: [
        const Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
          child: CustomTextField(text: "Email Address"),
        ),
        const Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
          child: CustomTextField(text: "Password"),
        ),
        const Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
          child: CustomTextField(text: "Password  Confirm"),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
          child: CustomButton(
            text: "Create Account",
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MainPage()),
              );
            },
          ),
        ),
      ],
    );
  }
}

class LoginTap extends StatelessWidget {
  const LoginTap({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
          child: CustomTextField(text: "Email Address"),
        ),
        const Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
          child: CustomTextField(text: "Password"),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
          child: CustomButton(
            text: "Login",
            onPressed: () {
              Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MainPage()),
                    );
            },
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
          child: TextButton(
            child: Text("Forgot Password?"),
            onPressed: () {
            },
          ),
        ),
      ],
    );
  }
}
