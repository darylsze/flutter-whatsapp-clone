import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/fixtures/fakeConversation.dart';
import 'package:whatsapp_clone/fixtures/fakeUserList.dart';
import 'package:whatsapp_clone/model/Chat.dart';
import 'package:whatsapp_clone/model/User.dart';

class ChatScreen extends StatefulWidget {
  final userId;

  ChatScreen({key, this.userId});

  @override
  _ChatScreenState createState() {
    final user = fakeUserList.firstWhere((user) => user.uid == userId);
    return _ChatScreenState(friend: user);
  }
}

class _ChatScreenState extends State<ChatScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  final _conversation = List<Chat>();
  final User friend;

  _ChatScreenState({this.friend});

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();

    // fake conversation
    _conversation.addAll(fakeConversation);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(friend.iconImage),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'kaka yiu',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w400),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(Icons.photo_camera, color: Colors.grey),
            SizedBox(width: 13),
            Icon(Icons.phone, color: Colors.grey),
          ],
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: _conversation.length,
          itemBuilder: (context, index) {
            if (index >= _conversation.length) {
              return null;
            }

            // delete
            if (index == 0) {
              return Bubble(
                message: 'Hi there, this is a message',
                time: '12:00',
                delivered: true,
                isMe: true,
              );
            }

            // delete
            if (index == 1) {
              return Bubble(
                message: 'Hi there, this is a message',
                time: '12:00',
                delivered: true,
                isMe: false,
              );
            }

            final chat = _conversation[index];
            if (chat.fromUser == 1) {
              // us
              return Bubble(
                message: 'Hi there, this is a message',
                time: '12:00',
                delivered: true,
                isMe: false,
              );
            } else {
              // our friend
            }
            return null;
          },
        ),
      ),
    );
  }
}

class Bubble extends StatelessWidget {
  Bubble({this.message, this.time, this.delivered, this.isMe});

  final String message, time;
  final delivered, isMe;

  @override
  Widget build(BuildContext context) {
    final bg = isMe ? Colors.white : Color.fromRGBO(220, 248, 198, 1);
    final align = isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end;
    final icon = delivered ? Icons.done_all : Icons.done;
    final radius = isMe
        ? BorderRadius.only(
            topRight: Radius.circular(5.0),
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(5.0),
          )
        : BorderRadius.only(
            topLeft: Radius.circular(5.0),
            bottomLeft: Radius.circular(5.0),
            bottomRight: Radius.circular(10.0),
          );
    return Column(
      crossAxisAlignment: align,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(left: 15, right: 15, top: 7, bottom: 7),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: .5,
                  spreadRadius: 1.0,
                  color: Colors.black.withOpacity(.08))
            ],
            color: bg,
            borderRadius: radius,
          ),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 48.0),
                child: Text(message),
              ),
              Positioned(
                bottom: 0.0,
                right: 0.0,
                child: Row(
                  children: <Widget>[
                    Text(time,
                        style: TextStyle(
                          color: Colors.black38,
                          fontSize: 10.0,
                        )),
                    SizedBox(width: 3.0),
                    Icon(
                      icon,
                      size: 12.0,
                      color: Colors.black38,
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
