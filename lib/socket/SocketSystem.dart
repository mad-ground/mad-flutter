import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:madground/game1/Game1Client.dart';


class SocketSystem{
  static late IO.Socket socket;
  static late Game1System game1System;
  static void connectServer(){
    
    socket = IO.io('http://172.10.5.147:80',IO.OptionBuilder().setTransports(['websocket']).build());
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

    socket.on('game1_userInit', (data) => game1System.userInit(data["userList"]));

    socket.on('game1_turn', (data) => game1System.setCurrentTurn(data["userId"], data["num"]));

    socket.on("game1_userSelection", (data) => game1System.showSelection(data["selection"]));

    socket.on("game1_gameOver", (data) => game1System.gameOver(data["userId"], data["gameEnd"]));

    socket.on("game1_gameEnd", (data) => game1System.gameEnd());

    // Game1System End

  }

  static void emitMessage(String key, data){
      socket.emit(key, data);
  }
}