import 'package:flutter/material.dart';
import 'package:madground/socket/SocketSystem.dart';
import 'package:madground/game1/Game1Client.dart';
import 'package:madground/game2/Game2Client.dart';


class LoadingMenuSystem{
  BuildContext context;
  Function reloadState;
  LoadingMenuSystem(this.context, this.reloadState);
  String imgLoc = "assets/images/background.jpg";
  int nxtGameNo = 0;

  String getNextGameImg(){
    return imgLoc;
  }

  void setNextGame(int gameNo){
    this.nxtGameNo = gameNo;
    if(gameNo==1){
      
    }else if(gameNo==2){
      
    }
    reloadState();
  }

  void gameStart(){
    imgLoc = "assets/images/background.jpg";
    if(nxtGameNo==1){
      SocketSystem.setCurrentState("Game1");
      Navigator.push(context, MaterialPageRoute(builder: (_) => Game1Page()));
    }else if(nxtGameNo==2){
      SocketSystem.setCurrentState("Game2");
      Navigator.push(context, MaterialPageRoute(builder: (_) => Game2Page()));
      //SocketSystem.game2System.gameStart();
    }
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


  void reloadState(){
    setState((){});
  }

  @override
  Widget build(BuildContext context) {
    loadingMenuSystem = LoadingMenuSystem(context, reloadState);
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
