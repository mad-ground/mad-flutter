import 'package:flutter/material.dart';
import 'package:madground/component/button.dart';
import 'package:madground/providers/room_provider.dart';
import 'package:madground/screens/room_create_page.dart';
import 'package:madground/screens/room_invite_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_provider/flutter_provider.dart';
import 'package:madground/providers/user_provider.dart';
import 'package:madground/screens/home_page.dart';
import 'package:madground/screens/login_page.dart';
import 'package:madground/screens/room_page.dart';
import 'screens/profile_page.dart';
import 'screens/setting_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => RoomProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      initialRoute: '/login',
      routes: {
        '/': (context) => MainPage(),
        '/main': (context) => MainPage(),
        '/login': (context) => LoginPage(),
      },
      theme: ThemeData(
        primaryColor: Colors.black,
        textTheme: const TextTheme(
          titleMedium: TextStyle(
              fontSize: 20,
              fontFamily: 'ReadexPro',
              color: Colors.white,
              fontWeight: FontWeight.w400),
          bodyLarge: TextStyle(
              fontSize: 20,
              fontFamily: 'ReadexPro',
              color: Colors.black,
              fontWeight: FontWeight.w500),
          bodyMedium: TextStyle(
              fontSize: 16,
              fontFamily: 'ReadexPro',
              color: Color.fromARGB(255, 143, 143, 143),
              fontWeight: FontWeight.w400),
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Color(0xff48ff54),
          textTheme: ButtonTextTheme.primary,
        ),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    HomePage(),
    ProfilePage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MADGROUND'),
        titleTextStyle: const TextStyle(
            fontSize: 20,
            fontFamily: 'ReadexPro',
            color: Colors.white,
            fontWeight: FontWeight.w400),
        backgroundColor: Colors.black,
      ),
      body: _pages[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RoomCreatePage()),
          );
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
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
    );
  }
}
