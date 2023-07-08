import 'package:flutter/material.dart';
import 'package:madground/component/button.dart';
import 'package:madground/menu/GameMenuScene.dart';

class GameMenuScene extends StatefulWidget {
  final String userName;
  const GameMenuScene({required this.userName});
  @override
  State<StatefulWidget> createState() => _GameMenuScene(userName: userName);
}

class _GameMenuScene extends State<GameMenuScene> {
  String userName;
  
  final List<Widget> _pages = [
    HomePage(),
    const ProfilePage(userName: ""),
    SettingsPage(),
  ];

  _GameMenuScene({required this.userName}){
    _pages[1] = ProfilePage(userName: userName);
  }

  int _selectedIndex = 0;

  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primaryColor: Colors.black,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 24, color: Colors.black),
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Color(0xff48ff54),
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('My App'),
          backgroundColor: Colors.black,
        ),
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final List<String> items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [MyListView(items: items)],
    );
  }
}

class MyListView extends StatelessWidget {
  final List<String> items;

  const MyListView({required this.items});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index]),
          );
        },
      ),
    );
  }
}

class ProfilePage extends StatefulWidget {
  final String userName;
  const ProfilePage({required this.userName});
  @override
  State<ProfilePage> createState() => _ProfilePageState(userName: userName);
}

class _ProfilePageState extends State<ProfilePage> {
  String userName = "retro3014";
  _ProfilePageState({required this.userName});
  @override
  String getUserName(){
    return userName;
  }

  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Profile Page',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              'User Name : ${getUserName()}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          'Settings Page',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
