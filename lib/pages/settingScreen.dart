import 'package:flutter/material.dart';
import 'package:whatsapp_clone/fixtures/fakeUserList.dart';
import 'package:whatsapp_clone/widgets/LeftRightRow.dart';
import 'package:whatsapp_clone/widgets/SafeHeader.dart';

class SettingScreen extends StatefulWidget {
  SettingScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

enum RowType { PROFILE, EMPTY, GROUPED_LIST }

abstract class _Row {}

class Profile extends _Row {
  String iconHref, displayName, userStatus;

  Profile({this.iconHref, this.displayName, this.userStatus});
}

class Empty extends _Row {}

class GroupedList extends _Row {
  List<GroupedListItem> items;

  GroupedList({this.items});
}

class GroupedListItem {
  String iconHref;
  String title;
  String linkTo;

  GroupedListItem({this.iconHref, this.title, this.linkTo});
}

class _SettingScreenState extends State<SettingScreen> {
  List<_Row> rows = [];

  @override
  void initState() {
    super.initState();
    rows.addAll([
      new Empty(),
      new Profile(
          iconHref: '',
          displayName: 'Daryl SZE',
          userStatus: 'Flutter is good!'),
      new Empty(),
      new GroupedList(items: [
        GroupedListItem(iconHref: '', title: 'Starred Messages'),
        GroupedListItem(iconHref: '', title: 'WhatsApp Web/Desktop'),
      ]),
      new Empty(),
      new GroupedList(items: [
        GroupedListItem(iconHref: '', title: 'Account'),
        GroupedListItem(iconHref: '', title: 'Chats'),
        GroupedListItem(iconHref: '', title: 'Notifcations'),
        GroupedListItem(iconHref: '', title: 'Date and Storage Usage'),
      ]),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: SafeHeader(
          child: Column(children: <Widget>[
            LeftRightRow(
              left: Text('Privacy',
                  style: TextStyle(fontSize: 18, color: Colors.blue[800])),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Settings",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ]),
        ),
      ),
      body: ListView.builder(
        itemCount: rows.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final item = rows[index];
          switch (item.runtimeType) {
            case Profile:
              return _renderProfile(item);
            case Empty:
              return new Container(
                height: 35.0,
                color: Color.fromRGBO(239, 239, 244, 1),
              );
            case GroupedList:
              final list = (item as GroupedList).items;
              return Column(
                children: _renderSettingGroup(list),
              );
            default:
              throw new Exception("not implemented");
          }
        },
      ),
    );
  }

  List<Widget> _renderSettingGroup(List<GroupedListItem> items) {
    return items.map((item) {
      return Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            child: Icon(
              Icons.star,
              size: 24,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                item.title,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Icon(Icons.arrow_forward_ios),
          )
        ],
      );
    }).toList();
  }

  Widget _renderProfile(Profile item) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(fakeUserList[0].iconImage),
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Daryl SZE',
                textAlign: TextAlign.start,
              ),
              Text('Do not fail to try'),
            ],
          ),
        )
      ],
    );
  }
}
