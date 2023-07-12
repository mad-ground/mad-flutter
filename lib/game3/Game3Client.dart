import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:madground/game3/doodle_dash.dart';
import 'package:madground/game3/util/util.dart';
import 'package:madground/game3/widgets/widgets.dart';


class Game3Home extends StatelessWidget{
  const Game3Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game3',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: const Game3Page(),
    );
  }
}



class Game3Page extends StatefulWidget {
  const Game3Page({Key? key}) : super(key: key);

  @override
  State<Game3Page> createState() => _Game3PageState();
}
final Game game = DoodleDash();

class _Game3PageState extends State<Game3Page> {
  
  void reloadState(){
    if(mounted){
      setState((){});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: LayoutBuilder(builder: (context, constraints) {
          return Container(
            constraints: const BoxConstraints(
              maxWidth: 800,
              minWidth: 550,
            ),
            child: GameWidget(
              game: game,
              overlayBuilderMap: <String, Widget Function(BuildContext, Game)>{
                'gameOverlay': (context, game) => GameOverlay(game),
                //mainMenuOverlay': (context, game) => MainMenuOverlay(game),
                'gameOverOverlay': (context, game) => GameOverOverlay(game),
              },
            ),
          );
        }),
      ),
    );
  }
}