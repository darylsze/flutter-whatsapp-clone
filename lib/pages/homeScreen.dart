import 'package:flutter/material.dart';
import 'package:whatsapp_clone/pages/settingScreen.dart';

import 'chatListScreen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  List<Widget> _screens = [
    ChatListScreen(),
    Center(),
    Center(),
    Center(),
    SettingScreen(),
  ];

  Widget getHeader(index) {
    final headerComponents = [
      ChatListScreen.getHeader(),
      Center(),
      Center(),
      Center(),
      Center(),
    ];
    return headerComponents[index];
  }

  @override
  Widget build(BuildContext context) {
    final _appBarContent = getHeader(_currentIndex);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(218),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: _appBarContent,
          ),
        ),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.blue[700],
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.filter_tilt_shift),
              title: Title(
                color: Colors.grey,
                child: Text('Status'),
              )),
          BottomNavigationBarItem(
              icon: Icon(Icons.phone),
              title: Title(
                color: Colors.grey,
                child: Text('Calls'),
              )),
          BottomNavigationBarItem(
              icon: Icon(Icons.camera_alt),
              title: Title(
                color: Colors.grey,
                child: Text('Camera'),
              )),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble),
              title: Title(
                color: Colors.grey,
                child: Text('Chats'),
              )),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Title(
                color: Colors.grey,
                child: Text('Settings'),
              )),
        ],
      ),
    );
  }
}
