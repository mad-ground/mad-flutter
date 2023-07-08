import 'package:flutter/material.dart';
import 'package:madground/main.dart';
import 'package:madground/menu/GameMenuScene.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';

class StartScenePage extends StatelessWidget {
  const StartScenePage({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Namer App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: const StartScene(),
    );
  }
}

class StartScene extends StatelessWidget {
  const StartScene({super.key});
  @override
  Widget build(BuildContext context) {
    void toGameMenuScene(){ 
      Navigator.push(context, MaterialPageRoute(builder: (context) => GameMenuScene(userName: "retro3014")));
    }

    void loginCheck(){
      //toGameMenuScene();
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
    void toGameMenuScene(String userName){ 
      Navigator.push(context, MaterialPageRoute(builder: (context) => GameMenuScene(userName: userName)));
    }

    void naverLogin() async{
      final NaverLoginResult result = await FlutterNaverLogin.logIn();
      String id = result.account.name;
      print(id);
      String userName = id; // = checkNaverId(id);
      toGameMenuScene(userName);
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
                // Code to execute when Button 3 is pressed
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }


}