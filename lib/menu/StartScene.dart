import 'package:flutter/material.dart';
import 'package:madground/main.dart';

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
      Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
    }

    void loginCheck(){
      toGameMenuScene();
      //Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
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
    void toGameMenuScene(){ 
      Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
    }

    return const Scaffold(
      

    );
  }


}