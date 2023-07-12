import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:madground/game1/Game1Client.dart';
import 'package:madground/game2/Game2Client.dart';
import 'package:madground/game3/managers/game_manager.dart';
import 'package:madground/menu/LoadingMenu.dart';

class SocketSystem {
  static late IO.Socket socket;
  static late Game1System game1System;
  static late Game2System game2System;
  static late GameManager gameManager;
  static late LoadingMenuSystem loadingMenuSystem;
  static String currentState = "";
  static void connectServer(userId){

    var id = userId;

    //socket = IO.io('http://172.10.5.147:80',IO.OptionBuilder().setTransports(['websocket']).build());
    socket = IO.io(
        'http://172.10.5.147:80',
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
    

    // Game1System Start

    socket.on(
        'game1_userInit',
        (data) => {
              if (currentState == "Game1")
                {game1System.setUserList(data["userList"], data["userName"])}
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
                {game1System.gameOver(data["userId"], data["gameEnd"])}
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
                      data["userList"], data["userNameList"], data["question"])
                }
            });

    socket.on(
        "game2_updateSelection",
        (data) => {
              if (currentState == "Game2")
                {game2System.updateSelection(data["userId"], data["selection"])}
            });

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


    
  }

  static void emitMessage(String key, data) {
    socket.emit(key, data);
  }

  static void setCurrentState(String currentState) {
    SocketSystem.currentState = currentState;
  }

  static void disconnectSocket() {
    socket.disconnect();
  }
}
