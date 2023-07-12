import 'package:flutter/material.dart';
import 'package:madground/component/button.dart';
import 'package:madground/menu/StartMenu.dart';
import 'dart:async';
import 'package:madground/socket/SocketSystem.dart';

class Game2System {
  late Function startTimer, endTimer, reloadState;
  Game2System(this.startTimer, this.endTimer, this.reloadState);
  List<String> userList = [];
  List<String> userNameList = [];
  List<String> userSelection = [];
  List<String> userOList = [], userXList = [];
  String mySelection = "O";
  String answer = "O";
  String question = "";
  bool isSelectionPhase = false;
  bool isShowSelection = true;
  bool isShowAnswer = false;

  String getQuestion() {
    return "안녕하세요 안녕안녕";
  }


  // 2. game2_changeSelection
  void onBtnClick(String btnType) {
    // TEST
    if(!isSelectionPhase){
      initQuestion(["1", "2", "3", "4", "5", "6", "7", "8"], ["user1", "user2", "user3", "user4", "user5", "user6", "user7", "user8"], "Question 1");
    }
    // TEST
    if(isSelectionPhase && isShowSelection && mySelection!=btnType){
      //SocketSystem.emitMessage("game2_changeSelection", btnType);
      mySelection = btnType;
      updateSelection("user1", btnType);
    }else if(isSelectionPhase){
      mySelection = btnType;
    }
    reloadState();
  }

  Color getBtnColor(String btnType) {
    if(isBtnClickPhase() || (isShowAnswer && btnType==answer)){
      if(btnType=="O"){
        return Colors.green;
      }else{
        return Colors.red;
      }
    }else{
      return Colors.white;
    }
  }

  bool isBtnClickPhase(){
    // TEST
    return true;
    // TEST
    return isSelectionPhase;
  }

  // 4. game2_updateSelection
  void updateSelection(String userName, String selection){
    if(selection == "O"){
      if(userXList.remove(userName)==true){
        userOList.add(userName);
        userOList.sort();
      }
    }else{
      if(userOList.remove(userName)==true){
        userXList.add(userName);
        userXList.sort();
      }
    }
    reloadState();
  }
  String getMySelection(){
    return mySelection;
  }
  Color getMySelectionColor(){
    if(mySelection=="O"){
      return Colors.green;
    }else{
      return Colors.red;
    }
  }

  // 1. game2_initQuestion
  void initQuestion(List<String> userList, List<String> userNameList, String question) {
    this.userList = userList;
    this.userNameList = [];
    userOList = [];
    userXList = [];
    for(int i=0; i<userNameList.length; i++){
      this.userNameList.add(userNameList[i]);
      this.userOList.add(userNameList[i]);
    }
    userSelection = List.empty(growable: true);
    for(int i=0; i<userList.length; i++){
      userSelection.add("O");
    }
    this.question = question;
    mySelection = "O";
    isSelectionPhase = true;
    isShowSelection = true;
    startTimer();
    reloadState();
  }

  // 3. game2_finalSelection
  void sendSelection() {
    isSelectionPhase = false;
    isShowSelection = false;
    reloadState();
    
    //SocketSystem.emitMessage("game2_finalSelection", mySelection);
    // TEST 
    finalResult(["O", "O", "O", "O", "X", "X", "O", "X"], "O");
    // TEST
  }

  bool showTimer() {
    return isSelectionPhase;
  }
  
  String getUserName(String s, int r, int c) {
    int idx = r*4+c;
    if(s=="O"){
      if(idx>=userOList.length){
        return "";
      }
      return userOList[idx];
    }else{
      if(idx>=userXList.length){
        return "";
      }
      return userXList[idx];
    }
  }
  
  bool isUserValid(String s, int r, int c) {
    if(!isShowSelection){
      return false;
    }
    if(s=="O"){
      return r*4+c < userOList.length;
    }else{
      return r*4+c < userXList.length;
    }
  }

  void stopShowSelection(){
    isShowSelection = false;
    reloadState();
  }
  
  void showAnswer(String answer){
    isShowAnswer = true;
    this.answer = answer;

  }

  // 5. game2_finalResult
  void finalResult(List<String> userSelectionList, String answer){
    userOList = [];
    userXList = [];
    print(userNameList);
    print(userSelectionList);
    for(int i=0; i<userSelectionList.length; i++){
      if("my_user_id" == userList[i]){
        mySelection = userSelectionList[i];
      }
      print(userNameList[i]);
      if(userSelectionList[i]=="O"){
        userOList.add(userNameList[i]);
      }else{
        userXList.add(userNameList[i]);
      }
    }
    userOList.sort();
    userXList.sort();
    showAnswer(answer);
    if(mySelection != answer){
      // Game Over
    }
    isShowSelection = true;
    reloadState();
  }

  // 6. game2_gameover
}

class Game2Home extends StatelessWidget {
  const Game2Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Namer App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: const Game2Page(),
    );
  }
}

class Game2Page extends StatefulWidget {
  const Game2Page({Key? key}) : super(key: key);

  @override
  State<Game2Page> createState() => _Game2PageState();
}

class _Game2PageState extends State<Game2Page> {
  late Game2System game2System;
  late Timer _timer;
  int _seconds = 0;
  bool _isTimerRunning = false;
  _Game2PageState() {
    game2System = Game2System(startTimer, endTimer, reloadState);
    // TEST
    //game2System.initQuestion(["1", "2", "3", "4", "5", "6", "7", "8"], ["user1", "user2", "user3", "user4", "user5", "user6", "user7", "user8"], "Question 1");
    // TEST
    SocketSystem.game2System = game2System;
  }

  void reloadState() {
    setState(() {});
  }

  void startTimer() {
    const int MAX_TIME = 10;
    _seconds = MAX_TIME;
    _isTimerRunning = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (!_isTimerRunning) {
          _timer.cancel();
        } else if (_seconds > 0) {
          _seconds--;
          if(_seconds==5){
            game2System.stopShowSelection();
          }
        } else {
          _isTimerRunning = false;
          _timer.cancel();
          game2System.sendSelection();
        }
      });
    });
    reloadState();
  }

  void endTimer() {
    _isTimerRunning = false;
    _timer.cancel();
    reloadState();
  }

  final int _BOX_HEIGHT = 300;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Visibility(
          visible: game2System.showTimer(),
          child: Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: SizedBox(
              height: 40,
              child: Center(
                child: Text("$_seconds",
                    style: TextStyle(fontSize: 30-_seconds.toDouble(), color: Colors.red)),
              ),
            ),
          ),
        ),
        Visibility(
          visible: !game2System.showTimer(),
          child: Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: const SizedBox(height: 40)
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: _BOX_HEIGHT.toDouble(),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8 - 20,
                  height: _BOX_HEIGHT - 20,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                          child: Text(
                            "Question",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          )
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              game2System.getQuestion(),
                              style: const TextStyle(color: Colors.white, fontSize: 30),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                          child: Text(
                            "My Answer",
                            style: TextStyle(color: Colors.black, fontSize: 10),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                          child: Text(
                            game2System.getMySelection(),
                            style: TextStyle(color: game2System.getMySelectionColor(), fontSize: 20),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Row(children: [
          Padding(
            padding: EdgeInsets.only(
                top: 40.0, left: MediaQuery.of(context).size.width * 0.1),
            child: Column(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width * 0.4 - 10,
                    height: MediaQuery.of(context).size.width * 0.4 - 10,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(game2System.getBtnColor("O")),
                          ),
                          onPressed: () {
                            if(game2System.isBtnClickPhase()){
                              game2System.onBtnClick("O");
                            }else{
                              null;
                            }
                          },
                          child: const Text("O",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 30))),
                    )),
                Container(
                  width: MediaQuery.of(context).size.width * 0.4 - 10,
                  height: (MediaQuery.of(context).size.width * 0.4 - 10)/4 + 15,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: (MediaQuery.of(context).size.width * 0.4 - 10) / 4,
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Visibility(
                            visible: game2System.isUserValid("O", 0, index),
                            child: Column(children: [
                              Image.asset('images/test.png', width: (MediaQuery.of(context).size.width * 0.4 - 10) / 4, height: (MediaQuery.of(context).size.width * 0.4 - 10) / 4),
                              Text(game2System.getUserName("O", 0, index),
                                maxLines:1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 6,
                                    color: Colors.black
                                )
                              )
                            ]),
                          ),
                        ),
                      );
                    }
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.4 - 10,
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: (MediaQuery.of(context).size.width * 0.4 - 10) / 4,
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Visibility(
                            visible: game2System.isUserValid("O", 1, index),
                            child: Column(children: [
                              Image.asset('images/test.png', width: (MediaQuery.of(context).size.width * 0.4 - 10) / 4, height: (MediaQuery.of(context).size.width * 0.4 - 10) / 4),
                              Text(game2System.getUserName("O", 1, index),
                                maxLines:1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 6,
                                    color: Colors.black
                                )
                              )
                            ]),
                          ),
                        ),
                      );
                    }
                  ),
                )
              ],
              
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40.0, left: 20),
            child: Column(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width * 0.4 - 10,
                    height: MediaQuery.of(context).size.width * 0.4 - 10,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(game2System.getBtnColor("X")),
                          ),
                          onPressed: () {
                            if(game2System.isBtnClickPhase()){
                              game2System.onBtnClick("X");
                            }else{
                              null;
                            }
                          },
                          child: const Text(
                            "X",
                            style: TextStyle(color: Colors.black, fontSize: 30),
                          )
                        ),
                      )
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.4 - 10,
                  height: (MediaQuery.of(context).size.width * 0.4 - 10)/4 + 15,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: (MediaQuery.of(context).size.width * 0.4 - 10) / 4,
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Visibility(
                            visible: game2System.isUserValid("X", 0, index),
                            child: Column(children: [
                              Image.asset('images/test.png', width: (MediaQuery.of(context).size.width * 0.4 - 10) / 4, height: (MediaQuery.of(context).size.width * 0.4 - 10) / 4),
                              Text(game2System.getUserName("X", 0, index),
                                maxLines:1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 6,
                                    color: Colors.black
                                )
                              )
                            ]),
                          ),
                        ),
                      );
                    }
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.4 - 10,
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: (MediaQuery.of(context).size.width * 0.4 - 10) / 4,
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Visibility(
                            visible: game2System.isUserValid("X", 1, index),
                            child: Column(children: [
                              Image.asset('images/test.png', width: (MediaQuery.of(context).size.width * 0.4 - 10) / 4, height: (MediaQuery.of(context).size.width * 0.4 - 10) / 4),
                              Text(game2System.getUserName("X", 1, index),
                                maxLines:1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 6,
                                    color: Colors.black
                                )
                              )
                            ]),
                          ),
                        ),
                      );
                    }
                  ),
                )
              ],
            ),
          ),
        ]),
      ]),
    );
  }
}
