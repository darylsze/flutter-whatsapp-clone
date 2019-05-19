import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp_clone/fixtures/fakeUserList.dart';

import 'fixtures/fakeChatList.dart';
import 'model/Chat.dart';
import 'model/MessageState.dart';
import 'model/User.dart';
import 'widgets/HorizontalLine.dart';
import 'widgets/LeftRightRow.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.white,
        indicatorColor: Colors.white,
        primaryIconTheme: IconThemeData(
          color: Colors.white,
        ),
        textTheme: TextTheme(
          title: TextStyle(color: Colors.white),
        ),
      ),
      home: MyHomePage(title: 'WhatsApp Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  StreamController<Chat> _chatsStreamController = new StreamController();
  List<Chat> _chatList = [];
  List<User> userList = [];

  @override
  void initState() {
    super.initState();

    userList.addAll(fakeUserList);

    _chatsStreamController.stream
        .listen((chat) => setState(() => _chatList.add(chat)));

    // order by update time
    fakeChatList
      ..sort(([chat1, chat2]) => chat2.updatedAt.compareTo(chat1.updatedAt))
      ..forEach((chat) {
        _chatsStreamController.add(chat);
      });
  }

  @override
  void dispose() {
    super.dispose();
    _chatsStreamController.close();
  }

  @override
  Widget build(BuildContext context) {
    int _currentIndex = 0;

    final _appBarContentKey = GlobalKey();

    final _appBarContent = Column(
      key: _appBarContentKey,
      children: <Widget>[
        LeftRightRow(
          left: Text('Edit',
              style: TextStyle(fontSize: 18, color: Colors.blue[800])),
          right: Icon(Icons.edit),
        ),
        SizedBox(
          height: 20,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Chats",
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: new TextField(
            textAlign: TextAlign.left,
            decoration: new InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                size: 26.0,
                color: Colors.grey,
              ),
              fillColor: Colors.grey[200],
              filled: true,
              hintText: 'Search',
              hintStyle: TextStyle(fontSize: 18),
              border: UnderlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ),
      ],
    );

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(150),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: _appBarContent,
            ),
          ),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              new HorizontalLine(),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: LeftRightRow(
                  left: new InkWell(
                    child: new Text('Broadcast Lists',
                        style:
                            TextStyle(color: Colors.blue[600], fontSize: 18.0)),
                    onTap: () => {},
                  ),
                  right: new InkWell(
                    child: new Text('New Group',
                        style:
                            TextStyle(color: Colors.blue[600], fontSize: 18.0)),
                    onTap: () => {},
                  ),
                ),
              ),
              new HorizontalLine(),
              new ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: _chatList.length,
                itemBuilder: (context, index) {
                  if (index >= _chatList.length) {
                    return null;
                  }
                  return getChatListItem(_chatList[index]);
                },
              )
//              new StreamBuilder(
//                stream: _chatsStreamController.stream,
//                builder: (BuildContext context, snapshot) {
//                  switch (snapshot.connectionState) {
//                    case ConnectionState.none:
//                    case ConnectionState.waiting:
//                      return Text('Loading...');
//                    case ConnectionState.active:
//                    case ConnectionState.done:
//                      if (snapshot.hasError) {
//                        return Text('Fetch Data Error');
//                      } else {
//                        return new ListTile(
//                          title: Text(snapshot.data.message),
//                          subtitle: Text(snapshot.data.message),
//                        );
//                      }
//                  }
//                },
//              )
            ],
          ),
        ),
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
        ));
  }

  Widget getChatListItem(Chat chat) {
    final User fromUser =
        userList.firstWhere((user) => user.uid == chat.fromUser);
    final User toUser = userList.firstWhere((user) => user.uid == chat.toUser);

    assert(fromUser != null);
    assert(toUser != null);

    final getDisplaySentTime = (date) {
      final is24HrsBefore = DateTime.now().difference(date).inHours >= 24;
      if (is24HrsBefore) {
        final dayDiff = DateTime.now().difference(date).inDays;
        if (dayDiff == 1) {
          return 'Yesterday';
        } else {
          return DateFormat('EEEE').format(date);
        }
      } else {
        return DateFormat('dd:mm').format(date);
      }
    };

    return new ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(toUser.iconImage),
      ),
      title: LeftRightRow(
        left: Text(toUser.username,
            style: TextStyle(fontSize: 18, color: Colors.black)),
        right: Text(
          getDisplaySentTime(chat.updatedAt),
          style: TextStyle(color: Colors.grey[600]),
        ),
      ),
      subtitle: Padding(
        padding: EdgeInsets.only(top: 10),
        child: Row(
          children: <Widget>[
            getMessageState(chat.messageState),
            SizedBox(width: 5),
            Text(
              chat.message,
              style: TextStyle(fontSize: 19),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
      trailing: Icon(
        Icons.keyboard_arrow_right,
        color: Colors.grey[400],
      ),
    );
  }
}
