import 'package:flutter/material.dart';
import 'package:madground/component/button.dart';
import 'package:madground/menu/StartMenu.dart';
import 'dart:async';
import 'package:madground/socket/SocketSystem.dart';


class Game1System {
  Game1System(this.startTimer, this.endTimer, this.reloadState);
  bool isCurrentUser = true;
  
  late List<String> userList;
  int num = 31;
  Function startTimer, endTimer, reloadState;
  void setUserList(List<String> userList){

  }
  void setCurrentUser(String userId){
    if (userId == "my_user_id"){
      isCurrentUser = true;
      startTimer();
    }else{
      isCurrentUser = false;
      startTimer();
    }
  }

  Color getTimerColor(){
    if(isCurrentUser){
      return Colors.red;
    }else{
      return Colors.grey;
    }
  }

  void onBtnClick(int btnNumber){
    if(isCurrentUser){
      // 서버 연결 시 
      //SocketSystem.emitMessage("game1_selection", btnNumber);
      endTimer();
      // TEST
      showSelection(btnNumber);

    }
    // TEST START
    if(btnNumber==1){
      setCurrentUser("my_user_id");
    }else if(btnNumber==2){
      setCurrentUser("other_user_id");
    }
    reloadState();
    // TEST END
  }

  int getCurrentNum(){
    return num;
  }

  void userInit(List<String> _userList) {
    
  }

  int selection = 0;
  
  bool isCurrentSelection(int selection){
    return (this.selection == selection);
  }


  void showSelection(int selection) {
    this.selection = selection;
    num -= selection;
    reloadState();
  }

  void gameOver(String userId, bool gameEnd) {
    selection = 0;
    if(userId == "my_user_id"){
      // 내 게임 오버 처리

      }else{
      // 다른 유저 게임 오버 처리

    }
  }

  void gameEnd() {
      // 다음 게임으로 넘어가기
  }

  void setCurrentTurn(String userId, int num){
    selection = 0;
    setCurrentUser(userId);
    this.num = num;
    reloadState();
  }

  Color getBtnColor(int btnNum){
    if(!isCurrentUser && !isCurrentSelection(btnNum)){
      return Colors.grey;
    }
    if(btnNum==1){
      return Colors.red;
    }else if(btnNum==2){
      if(num>=2){
        return Colors.yellow;
      }
      return Colors.grey;
    }else{
      if(num>=3){
        return Colors.green;
      }
      else {
        return Colors.grey;
      }
    }
  }
}


class Game1Home extends StatelessWidget {
  const Game1Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Namer App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: const Game1Page(),
    );
  }
}

class Game1Page extends StatefulWidget {
  const Game1Page({Key? key}) : super(key: key);

  @override
  State<Game1Page> createState() => _Game1PageState();
}

class _Game1PageState extends State<Game1Page> {
  late Timer _timer;
  int _seconds = 0;
  bool _isTimerRunning = false;
  late Game1System game1System;
  
  _Game1PageState(){
    game1System = Game1System(startTimer, endTimer, reloadState);    
  }

  void startTimer(){
    const int MAX_TIME = 5;
    _seconds = MAX_TIME;
    _isTimerRunning = true;
    print("TIMER START");
    print("$_seconds $_isTimerRunning");
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        print("TIMER RUNNING " + "$_seconds");
        if(!_isTimerRunning){
          _timer.cancel();
          _isTimerRunning = false;
        }
        if(_seconds>0){
          _seconds--;
        }else{
          _isTimerRunning = false;
          _timer.cancel();
          if(game1System.isCurrentUser){
            game1System.onBtnClick(1);
          }
        }
      });
    });
    print(_timer.toString());
    setState((){});
  }

  void endTimer(){
    print("TIMER END");
    if(_isTimerRunning){
      _isTimerRunning = false;
      _timer.cancel();
    }
    setState((){});
  }


  void reloadState(){
    setState((){});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: SizedBox(
            height: 80.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7.0),
                  child: Column(children: [
                    Image.asset('images/test.png', width: 50, height: 50),
                    const Text('hello')
                  ]),
                );
              },
            ),
          ),
        ),
        SizedBox(
          height: 80.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7.0),
                child: Column(children: [
                  Image.asset('images/test.png', width: 50, height: 50),
                  const Text('hello')
                ]),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child:Text(
              "$_seconds", style: TextStyle(color: game1System.getTimerColor(), fontSize: 20),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 70.0),
          child: Center(
            child: Container(
              width: 150,
              height: 150,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              padding: const EdgeInsets.all(16),
              child: Text(
                '${game1System.getCurrentNum()}',
                style: const TextStyle(color: Colors.white, fontSize: 50),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 120.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: game1System.getBtnColor(1), // Set the desired background color
                  ),
                  child: const Text('1',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  onPressed: () {
                    // Code for button 1 onPressed event
                    if(game1System.isCurrentUser){
                      game1System.onBtnClick(1);
                    }else{
                      null;
                    }                    
                  },
                ),
              ),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.yellow, // Set the desired background color
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: game1System.getBtnColor(2), // Set the desired background color
                  ),
                  child: const Text('2',
                      style: TextStyle(color: Colors.black, fontSize: 20)),
                  onPressed: () {
                    // Code for button 2 onPressed event
                    if(game1System.isCurrentUser && game1System.getCurrentNum()>=2){
                      game1System.onBtnClick(2);
                    }else{
                      null;
                    }
                  },
                ),
              ),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green, // Set the desired background color
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: game1System.getBtnColor(3), // Set the desired background color
                  ),
                  child: const Text('3',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  onPressed: () {
                    // Code for button 3 onPressed event
                    if(game1System.isCurrentUser && game1System.getCurrentNum()>=3){
                      game1System.onBtnClick(3);
                    }else{
                      null;
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
