import 'package:flutter/material.dart';
import 'package:madground/component/button.dart';
import 'package:madground/menu/StartMenu.dart';
import 'dart:async';
import 'package:madground/socket/SocketSystem.dart';
import 'dart:ui';
import 'package:madground/menu/GameOverMenu.dart';

class Game1System {
  Game1System(this.startTimer, this.endTimer, this.reloadState);
  bool isCurrentUser = true;
  late BuildContext context;
  int currentUserIdx = -1;

  List<String> userList = [];
  List<String> userNameList = [];
  int num = 31;
  bool isSelectionPhase = false;
  Function startTimer, endTimer, reloadState;
  bool isShowTimer = false;

  void initUserList(){
    userList = [];
    userNameList = [];
  }
  void setUserList(List<String> userList, List<String> userNameList){
    print("Set User List");
    print(userList);
    print(userNameList);
    this.userList = userList;
    this.userNameList = userNameList;
    reloadState();
  }
  String _getUserName(int index){
    if(index >= userNameList.length){
      return "";
    }
    return userNameList[index];
  }
  String getUserName(int r, int c){
    if(!isUserValid(r, c)){
      return "";
    }
    return _getUserName(r*5+c);
  }
  bool isUserValid(int r, int c){
    return (r*5+c < userList.length);
  }

  Color getTextColor(int r, int c){
    if(!isUserValid(r, c)){
      return Colors.black;
    }
    //print(SocketSystem.user.id.toString() + " " + userList[r*5+c]);
    
    if(r*5+c == currentUserIdx && SocketSystem.user.id.toString() == userList[r*5+c]){
      return Colors.purple;
    }else if(r*5+c == currentUserIdx){
      return Colors.red;
    }else if(SocketSystem.user.id.toString() == userList[r*5+c]){
      return Colors.blue;
    }
    return Colors.black;
  }

  void setCurrentUser(String userId){
    for(int i=0; i<userList.length; i++){
      if(userList[i] == userId){
        currentUserIdx = i;
        break;
      }
    }
    if (userId == SocketSystem.user.id.toString()){
      isCurrentUser = true;
      isSelectionPhase = true;
      isShowTimer = true;
      startTimer();
    }else{
      isShowTimer = true;
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
    if(isCurrentUser && isSelectionPhase && btnNumber <= num){
      isSelectionPhase = false;
      isShowTimer = false;
      // 서버 연결 시
      SocketSystem.emitMessage("game1_selection", [btnNumber, SocketSystem.roomId]);
      endTimer();
      // TEST
      //showSelection(btnNumber);

    }
    // TEST START
    /*if(btnNumber==1){
      setCurrentUser("my_user_id");
    }else if(btnNumber==2){
      setCurrentUser("other_user_id");
    }*/
    reloadState();
    // TEST END
  }

  int getCurrentNum(){
    return num;
  }

  int selection = 0;

  bool isCurrentSelection(int selection){
    return (this.selection == selection);
  }


  void showSelection(int selection) {
    print("Show Selection : " + selection.toString());
    this.selection = num - selection;
    isSelectionPhase = false;
    isShowTimer = false;
    num = selection;
    endTimer();
    reloadState();
  }

  void gameOver(String userId) {
    print("GameOver " + userId);
    selection = 0;
    if(userId == SocketSystem.user.id.toString()){
      // 내 게임 오버 처리
        Navigator.push(context, MaterialPageRoute(builder: (context) => GameOverMenu()));
      }else{
      // 다른 유저 게임 오버 처리
      for(int i=0; i<userList.length; i++){
        if(userList[i] == userId.toString()){
          userNameList[i] = "Game Over";
          break;
        }
      }
    }
  }

  void setContext(BuildContext  context){
    this.context = context;
  }

  void gameEnd() {
      // 다음 게임으로 넘어가기
      SocketSystem.setCurrentState("LoadingMenu");
      
      Navigator.pop(context);
  }

  void setCurrentTurn(String userId, int num){
    selection = 0;
    setCurrentUser(userId);
    this.num = num;
    reloadState();
  }

  Color getBtnColor(int btnNum){
    if(!isSelectionPhase && !isCurrentSelection(btnNum)){
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
    game1System.initUserList();
    SocketSystem.game1System = game1System;
  }

  void startTimer(){
    const int MAX_TIME = 3;
    _seconds = MAX_TIME;
    _isTimerRunning = true;
    print("TIMER START");
    print("$_seconds $_isTimerRunning");
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if(mounted){
        setState(() {
        print("TIMER RUNNING $_seconds");
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
    }});
    print(_timer.toString());
    reloadState();
  }

  void endTimer(){
    print("TIMER END");
    if(_isTimerRunning){
      _isTimerRunning = false;
      _timer.cancel();
    }
    reloadState();
  }


  void reloadState(){
    if(mounted){
      setState((){});
    }
  }

  @override
  Widget build(BuildContext context) {
    game1System.setContext(context);
    return Scaffold(
      body: Column(children: [
        Padding(
          padding: EdgeInsets.only(top: 50.0, left: (MediaQuery.of(context).size.width - 360)/2),
          child: SizedBox(
            height: 80,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Visibility(
                  visible: game1System.isUserValid(0, index),
                    child: SizedBox(
                      width: 50,
                      child: Column(children: [
                        Image.asset('images/test.png', width: 50, height: 50),
                        Text(
                          game1System.getUserName(0, index), 
                          maxLines:1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 10, color: game1System.getTextColor(0, index))
                        )
                      ]),
                    ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(
                width:27,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: (MediaQuery.of(context).size.width - 360)/2),
          child: SizedBox(
            height: 80,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Visibility(
                  visible: game1System.isUserValid(1, index),
                  child: Column(children: [
                      Image.asset('images/test.png', width: 50, height: 50),
                      Text(
                        game1System.getUserName(1, index),
                        maxLines:1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 10, color: game1System.getTextColor(1, index))
                      )
                  ]),
                );
              },
              separatorBuilder: (context, index) => SizedBox(
                width: 27,
              ),
            ),
          ),
        ),
        Visibility(
          visible: game1System.isShowTimer,
          child: SizedBox(
            height : 80,
            child: Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child:Text(
                  "$_seconds", style: TextStyle(color: game1System.getTimerColor(), fontSize: 20),
              ),
            ),
          ),
        ),
        Visibility(
          visible: !game1System.isShowTimer,
          child: SizedBox(
            height : 80,
            child: Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child:Text(
                  "", style: TextStyle(color: game1System.getTimerColor(), fontSize: 20),
              ),
            ),
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
