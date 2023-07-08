import 'package:flutter/material.dart';
import 'package:madground/component/button.dart';
import 'package:madground/menu/StartMenu.dart';

class Game1System {
  Game1System();

  

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

class Game1Page extends StatelessWidget {
  const Game1Page({Key? key}) : super(key: key);
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
        const Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Text(
            '10',
            style: TextStyle(color: Colors.red, fontSize: 20),
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
              child: const Text(
                '31',
                style: TextStyle(color: Colors.white, fontSize: 50),
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
                    primary: Colors.red, // Set the desired background color
                  ),
                  child: const Text('1',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  onPressed: () {
                    // Code for button 1 onPressed event
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
                    primary: Colors.yellow, // Set the desired background color
                  ),
                  child: const Text('2',
                      style: TextStyle(color: Colors.black, fontSize: 20)),
                  onPressed: () {
                    // Code for button 2 onPressed event
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
                    primary: Colors.green, // Set the desired background color
                  ),
                  child: const Text('3',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  onPressed: () {
                    // Code for button 3 onPressed event
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
