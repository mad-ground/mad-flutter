import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:madground/component/button.dart';
import 'package:madground/component/text_field.dart';
import 'package:madground/providers/user_provider.dart';
import 'package:madground/screens/room_invite_page.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

import '../main.dart';
import '../type/user.dart';

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
                tabs: const [
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
      height: 350,
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

class SigninTap extends StatefulWidget {
  SigninTap({
    super.key,
  });
  var username = "";
  var password = "";
  var passwordCon = "";

  @override
  State<SigninTap> createState() => _SigninTapState();
}

class _SigninTapState extends State<SigninTap> {
  void onUsernameChanged(String value) {
    widget.username = value;
  }

  void onPasswordChanged(String value) {
    widget.password = value;
  }

  void onPasswordConChanged(String value) {
    widget.passwordCon = value;
  }

  void handleSignin() async {
    // 로그인 요청을 보낼 URL
    String url = 'http://143.248.200.49/user';

    // 로그인 요청에 필요한 데이터 (예: 사용자 이름과 비밀번호)
    Map<String, dynamic> data = {
      'username': widget.username,
      'password': widget.password,
    };

    // 로그인 요청 보내기
    http.Response response = await http.post(Uri.parse(url), body: data);

    // 응답 처리
    if (response.statusCode == 201) {
      User user = User.fromJson(jsonDecode(response.body));
      print('가입 성공: ${user.username})');
      context.read<UserProvider>().setUser(user);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
      );
    } else {
      print('가입 실패');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(text: "User Name", onChanged: onUsernameChanged),
        CustomTextField(text: "Password", onChanged: onPasswordChanged),
        CustomTextField(
            text: "Password  Confirm", onChanged: onPasswordConChanged),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
          child: CustomButton(
            text: "Create Account",
            onPressed: () {
              if (widget.password != widget.passwordCon) {
                print('패스워드 불일치');
                return;
              }
              handleSignin();
            },
          ),
        ),
      ],
    );
  }
}

class LoginTap extends StatefulWidget {
  var username = "";
  var password = "";
  LoginTap({
    super.key,
  });

  @override
  State<LoginTap> createState() => _LoginTapState();
}

class _LoginTapState extends State<LoginTap> {
  @override
  Widget build(BuildContext context) {
    void onUsernameChanged(String value) {
      widget.username = value;
    }

    void onPasswordChanged(String value) {
      widget.password = value;
    }

    void handleLogin() async {
      // 로그인 요청을 보낼 URL
      String url = 'http://143.248.200.49/auth/login';

      // 로그인 요청에 필요한 데이터 (예: 사용자 이름과 비밀번호)
      Map<String, dynamic> data = {
        'username': 'dusdh',
        'password': '1234',
        // 'username': widget.username,
        // 'password': widget.password,
      };

      // 로그인 요청 보내기
      http.Response response = await http.post(Uri.parse(url), body: data);

      // 응답 처리
      if (response.statusCode == 201) {
        User user = User.fromJson(jsonDecode(response.body)['user']);
        print('로그인 성공: ${user.username})');
        context.read<UserProvider>().setUser(user);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => RoomInvitePage()),
        );
        print("성공");
      } else {
        setState(() {
          widget.username = "";
          widget.password = "";
        });
        // Fluttertoast.showToast(
        //   msg: "아이디와 패스워드를 확인해 주세요",
        //   toastLength: Toast.LENGTH_LONG,
        //   gravity: ToastGravity.BOTTOM,
        //   backgroundColor: Colors.grey[800],
        //   textColor: Colors.white,
        //   fontSize: 16.0,
        // );
        print('로그인 실패');
      }
    }

    return Column(
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
          child:
              CustomTextField(text: "User Name", onChanged: onUsernameChanged),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 24),
          child:
              CustomTextField(text: "Password", onChanged: onPasswordChanged),
        ),
        CustomButton(
          text: "Login",
          onPressed: () {
            print("로그인 버튼 클릭");
            handleLogin();
          },
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
          child: TextButton(
            child: Text("Forgot Password?"),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
