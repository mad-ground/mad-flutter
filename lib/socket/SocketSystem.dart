import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:madground/game1/Game1Client.dart';
import 'package:madground/game2/Game2Client.dart';
import 'package:madground/game3/managers/game_manager.dart';
import 'package:madground/menu/LoadingMenu.dart';
import 'package:flutter/material.dart';
import 'package:madground/menu/GameOverMenu.dart';
import 'package:madground/providers/user_provider.dart';
import 'package:madground/type/user.dart';

class SocketSystem {
  static late IO.Socket socket;
  static late Game1System game1System;
  static late Game2System game2System;
  static late GameManager gameManager;
  static late GameOverMenuSystem gameOverMenuSystem;
  static late LoadingMenuSystem loadingMenuSystem;
  static String currentState = "";
  static late int roomId;
  static late BuildContext context;
  static int PORT_NO = 80;
  static late User user;

  static void connectServer(userId){
    
    var id = userId;

    //socket = IO.io('http://172.10.5.147:80',IO.OptionBuilder().setTransports(['websocket']).build());
    socket = IO.io(
        'http://172.10.5.147:${SocketSystem.PORT_NO}',
        IO.OptionBuilder()
            .setTransports(['websocket']).setQuery({'userId': id}).build());
    print("SERVER TEST");

    if (!socket.connected) {
      socket.connect();
      print('connecting....');
    }
    socket.onConnect((_) {
      print('connect');
      socket.emit('message', 'test');
    });
    socket.onDisconnect((_) => print('disconnect'));
    socket.on('message', (_) => print(_));
    socket.on('newUser', (_) => print(_));
    

    // Game1System Start

    socket.on(
        'game1_userInit',
        (data) => {
              if (currentState == "Game1")
                {game1System.setUserList(List<String>.from(data["userList"]), List<String>.from(data["userName"]))}
            });

    socket.on(
        'game1_turn',
        (data) => {
          if (currentState == "Game1")
            {game1System.setCurrentTurn(data["userId"], data["num"])}
        });

    socket.on(
        "game1_userSelection",
        (data) => {
              if (currentState == "Game1")
                {game1System.showSelection(data["selection"])}
            });

    socket.on(
        "game1_gameOver",
        (data) => {
              if (currentState == "Game1")
                {game1System.gameOver(data["userId"])}
            });

    socket.on(
        "game1_gameEnd",
        (data) => {
              if (currentState == "Game1") {game1System.gameEnd()}
            });

    // Game1System End

    // Game2System Start

    socket.on(
        "game2_initQuestion",
        (data) => {
              if (currentState == "Game2")
                {
                  game2System.initQuestion(
                      List<String>.from(data["userList"]), List<String>.from(data["userNameList"]), data["question"])
                }
            });

    socket.on(
      "game2_updateSelection",
      (data) => {
        if (currentState == "Game2"){
          game2System.updateSelection(data["userId"], data["selection"])
        }
      });

    socket.on(
      "game2_finalResult",
      (data) => {
        if(currentState == "Game2"){
          game2System.finalResult(List<String>.from(data["userNameList"]), List<String>.from(data["userSelectionList"]), data["answer"])
        }
      }
    );

    socket.on(
      "game2_gameEnd",
      (data) => {
        if(currentState == "Game2"){
          game2System.gameEnd()
        }
      }
    );

    // Game2System End


    // Game3System Start
    socket.on("game3_userInit", (data)=> {
      if(currentState=="Game3"){
        gameManager.initUserList(data["userList"], data["userName"])
      }
    });

    socket.on("game3_userGameOver", (data) => {
      if(currentState=="Game3"){
        gameManager.userGameOver(data["userId"], data["rank"])
      }
    });

    // Game3System End

    // LoadingMenu Start

    socket.on("loading_startLoading", (_) => {
      if(currentState==""){
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoadingMenuPage()))
      }
    });

    socket.on("loading_nextGame", (data) => {
      if(currentState=="LoadingMenu"){
        loadingMenuSystem.setNextGame(data["gameNo"])
      }
    });

    socket.on("loading_gameStart", (_) => {
      if(currentState=="LoadingMenu"){
        loadingMenuSystem.gameStart()
      }
    });

    // LoadingMenu End
    
  }

  static void emitMessage(String key, data) {
    print("emitMessage $key $data"); 
    socket.emit(key, data);
  }

  static void setCurrentState(String currentState) {
    SocketSystem.currentState = currentState;
  }

  static void disconnectSocket() {
    socket.disconnect();
  }

  static void startGame(int roomId){
    emitMessage("game_start", roomId);
  }
}
