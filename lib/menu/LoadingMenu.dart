import 'package:flutter/material.dart';
import 'package:madground/socket/SocketSystem.dart';
import 'package:madground/game1/Game1Client.dart';
import 'package:madground/game2/Game2Client.dart';
import 'package:madground/game3/Game3Client.dart';


class LoadingMenuSystem{
  late BuildContext context;
  Function reloadState;
  LoadingMenuSystem(this.reloadState){
    SocketSystem.loadingMenuSystem = this;
    SocketSystem.setCurrentState("LoadingMenu");
  }
  String imgLoc = "assets/images/background.jpg";
  String imgDefault = "assets/images/background.jpg";
  String imgGame1 = "assets/images/background.jpg";
  String imgGame2 = "assets/images/background.jpg";
  String imgGame3 = "assets/images/background.jpg";
  int nxtGameNo = 0;

  String getNextGameImg(){
    return imgLoc;
  }

  void setNextGame(int gameNo){
    print("Set Next Game " + gameNo.toString());
    nxtGameNo = gameNo;
    print("Next Game No " + nxtGameNo.toString());
    if(gameNo==1){
      imgLoc = imgGame1;
    }else if(gameNo==2){
      imgLoc = imgGame2;
    }else if(gameNo==3){
      imgLoc = imgGame3;
    }
    reloadState();
  }

  void gameStart(){
    print("Game Start");
    imgLoc = "assets/images/background.jpg";
    print("Next Game No " + nxtGameNo.toString());
    if(nxtGameNo==1){
      print("Game1 Start");
      SocketSystem.setCurrentState("Game1");
      print(context);
      Navigator.push(context, MaterialPageRoute(builder: (_) => Game1Page()));
    }else if(nxtGameNo==2){
      SocketSystem.setCurrentState("Game2");
      Navigator.push(context, MaterialPageRoute(builder: (_) => Game2Page()));
      //SocketSystem.game2System.gameStart();
    }else if(nxtGameNo==3){
      SocketSystem.setCurrentState("Game3");
      Navigator.push(context, MaterialPageRoute(builder: (_) => Game3Page()));
    }
  }

  void setContext(BuildContext context){
    print("Set Context");
    this.context = context;
  }
}

class LoadingMenuPage extends StatelessWidget {
  const LoadingMenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loading Menu',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: const LoadingMenu(),
    );
  }
}

class LoadingMenu extends StatefulWidget {
  const LoadingMenu({Key? key}) : super(key: key);
  @override
  State<LoadingMenu> createState() => _LoadingMenuState();
}

class _LoadingMenuState extends State<LoadingMenu> {
  
  late LoadingMenuSystem loadingMenuSystem;
  _LoadingMenuState(){
    loadingMenuSystem = LoadingMenuSystem(reloadState);
  }

  void reloadState(){
    if(mounted){
      setState((){});
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Reload");
    loadingMenuSystem.setContext(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text("Loading Next Game...", style: TextStyle(fontSize: 20))),
          Center(child:
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(loadingMenuSystem.getNextGameImg()),
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.6), BlendMode.darken),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
