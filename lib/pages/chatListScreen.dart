import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp_clone/fixtures/fakeUserList.dart';
import 'package:whatsapp_clone/pages/chatScreen.dart';
import 'package:whatsapp_clone/widgets/SafeHeader.dart';

import '../fixtures/fakeChatList.dart';
import '../model/Chat.dart';
import '../model/MessageState.dart';
import '../model/User.dart';
import '../widgets/HorizontalLine.dart';
import '../widgets/LeftRightRow.dart';

class ChatListScreen extends StatefulWidget {
  ChatListScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ChatListScreenState createState() => _ChatListScreenState();

  static Widget getHeader() {
    return Column(children: <Widget>[
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
    ]);
  }
}

class _ChatListScreenState extends State<ChatListScreen> {
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
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(218),
        child: SafeHeader(
          child: Column(children: <Widget>[
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
            Column(children: <Widget>[
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
            ])
          ]),
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
