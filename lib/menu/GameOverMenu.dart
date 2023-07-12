import 'package:flutter/material.dart';
import 'package:madground/socket/SocketSystem.dart';
import 'package:madground/game1/Game1Client.dart';
import 'package:madground/game2/Game2Client.dart';
import 'package:madground/game3/Game3Client.dart';


class GameOverMenuSystem{
  late BuildContext context;
  Function reloadState;
  GameOverMenuSystem(this.reloadState){
    SocketSystem.setCurrentState("GameOver");
    SocketSystem.gameOverMenuSystem = this;
    SocketSystem.emitMessage("gameOver_getRank", SocketSystem.roomId);
  }
  String imgLoc = "assets/images/background.jpg";
  String imgDefault = "assets/images/background.jpg";
  String imgRank1 = "assets/images/background.jpg";
  String imgRank2 = "assets/images/background.jpg";
  String imgRank3 = "assets/images/background.jpg";
  String imgRank4 = "assets/images/background.jpg";
  int rank = 0;

  String getResultImg(){
    return imgLoc;
  }

  void setRank(int rank){
    this.rank = rank;
    if(rank==1){
      imgLoc = imgRank1;
    }else if(rank<=3){
      imgLoc = imgRank2;
    }else if(rank<=5){
      imgLoc = imgRank3;
    }else{
      imgLoc = imgRank4;
    }
  }

  void setContext(BuildContext context){
    print("Set Context");
    this.context = context;
  }
  int getRank(){
    return rank;
  }
}

class GameOverMenuPage extends StatelessWidget {
  const GameOverMenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loading Menu',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: const GameOverMenu(),
    );
  }
}

class GameOverMenu extends StatefulWidget {
  const GameOverMenu({Key? key}) : super(key: key);
  @override
  State<GameOverMenu> createState() => _GameOverMenuState();
}

class _GameOverMenuState extends State<GameOverMenu> {
  
  late GameOverMenuSystem gameOverMenuSystem;
  _GameOverMenuState(){
    gameOverMenuSystem = GameOverMenuSystem(reloadState);
  }

  void reloadState(){
    if(mounted){
      setState((){});
    }
  }

  @override
  Widget build(BuildContext context) {
    gameOverMenuSystem.setContext(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text("TOP #${gameOverMenuSystem.getRank()}", style: TextStyle(fontSize: 30))),
          Center(child:
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(gameOverMenuSystem.getResultImg()),
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
