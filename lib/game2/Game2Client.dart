import 'package:flutter/material.dart';
import 'package:madground/component/button.dart';
import 'package:madground/menu/StartMenu.dart';
import 'dart:async';
import 'package:madground/socket/SocketSystem.dart';


class Game2System {

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
  

  
  void reloadState(){
    setState((){});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        const Text("Game2"),
        ElevatedButton(
          child: const Text('Back'), 
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const StartMenu()));
          }
        ),
      ]),
    );
  }
}
