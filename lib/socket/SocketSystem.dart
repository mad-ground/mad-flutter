import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketSystem{
  static late IO.Socket socket;
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
  }
}