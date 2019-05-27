import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp_clone/pages/chatScreen.dart';

import '../model/Chat.dart';
import '../model/MessageState.dart';
import '../model/User.dart';
import '../widgets/HorizontalLine.dart';
import '../widgets/LeftRightRow.dart';

class SettingScreen extends StatefulWidget {
  SettingScreen({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final _chatList = [];
  final userList = [];

  @override
  Widget build(BuildContext context) {
    int _currentIndex = 0;

    final _appBarContentKey = GlobalKey();

    final _appBarContent = Column(
      key: _appBarContentKey,
      children: <Widget>[
        LeftRightRow(
          left: Text('Privacy',
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
        Column(children: <Widget>[
          SizedBox(height: 20),
          new HorizontalLine(),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: LeftRightRow(
              left: new InkWell(
                child: new Text('Broadcast Lists',
                    style: TextStyle(color: Colors.blue[600], fontSize: 18.0)),
                onTap: () => {},
              ),
              right: new InkWell(
                child: new Text('New Group',
                    style: TextStyle(color: Colors.blue[600], fontSize: 18.0)),
                onTap: () => {},
              ),
            ),
          ),
          new HorizontalLine(),
        ])
      ],
    );

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
      body: Center(
          child: new ListView.separated(
        separatorBuilder: (BuildContext context, int index) => Divider(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: _chatList.length,
        itemBuilder: (context, index) {
          if (index >= _chatList.length) {
            return null;
          }
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ChatScreen(userId: _chatList[index].toUser),
                ),
              );
            },
            child: getChatListItem(_chatList[index]),
          );
        },
      )),
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
