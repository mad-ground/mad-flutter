import 'package:flutter/material.dart';
import 'package:madground/main.dart';
import 'package:madground/menu/GameMenu.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:madground/socket/SocketSystem.dart';

class StartMenuPage extends StatelessWidget {
  const StartMenuPage({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Namer App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: const StartMenu(),
    );
  }
}

class StartMenu extends StatelessWidget {
  const StartMenu({super.key});
  @override
  Widget build(BuildContext context) {
    

    void loginCheck(){
      Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
    }

    void onStartBtnPressed(){
      loginCheck();
    }

    

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('Start'), 
              onPressed: (){
                onStartBtnPressed();
              }
            ),
          ],
        ),
      )
    );
  }
}

class LoginPage extends StatelessWidget{
  const LoginPage({Key? key}) : super(key: key);

  

  @override
  Widget build(BuildContext context){
    void toGameMenu(String userName){ 
      SocketSystem.connectServer();
      Navigator.push(context, MaterialPageRoute(builder: (context) => GameMenu(userName: userName)));
    }

    void naverLogin() async{
      final NaverLoginResult result = await FlutterNaverLogin.logIn();
      String id = result.account.name;
      print(result.account.id);
      print(id);
      String userName = id; // = checkNaverId(id);
      toGameMenu(userName);
    }

    void otherLogin(){
      toGameMenu("testUser");
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                naverLogin();
              },
              child: const Text('Naver Login'),
            ),
            const SizedBox(height: 30), // Add space between the buttons
            ElevatedButton(
              onPressed: () {
                // Code to execute when Button 2 is pressed
              },
              child: const Text('Kakao Login'),
            ),
            const SizedBox(height: 30), // Add space between the buttons
            ElevatedButton(
              onPressed: () {
                otherLogin();
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }


}