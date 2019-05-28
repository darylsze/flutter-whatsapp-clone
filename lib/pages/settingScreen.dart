import 'package:flutter/material.dart';
import 'package:whatsapp_clone/fixtures/fakeUserList.dart';
import 'package:whatsapp_clone/widgets/HorizontalLine.dart';
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
      new Empty(),
      new GroupedList(items: [
        GroupedListItem(iconHref: '', title: 'Help'),
        GroupedListItem(iconHref: '', title: 'Tell a Friend'),
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
      body: Container(
        decoration: new BoxDecoration(color: Color.fromRGBO(239, 239, 244, 1)),
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
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
                return Container(
                  decoration: new BoxDecoration(color: Colors.white),
                  child: Column(
                    children: _renderSettingGroup(list),
                  ),
                );
              default:
                throw new Exception("not implemented");
            }
          },
        ),
      ),
    );
  }

  List<Widget> _renderSettingGroup(List<GroupedListItem> items) {
    return items
        .asMap()
        .map((index, item) {
          final isLast = index == items.length - 1;
          return MapEntry(index, _renderSettingGroupItem(item, isLast));
        })
        .values
        .toList();
  }

  Widget _renderProfile(Profile item) {
    return Container(
      decoration: new BoxDecoration(color: Colors.white),
      child: Row(
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
            child: Container(
              height: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Daryl SZE',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Do not afraid to try'),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Icon(
              Icons.arrow_forward_ios,
              size: 20,
              color: Colors.grey[350],
            ),
          ),
        ],
      ),
    );
  }

  Widget _renderSettingGroupItem(GroupedListItem item, bool isLast) {
    final components = <Widget>[
      Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
            child: Icon(
              Icons.star,
              size: 30,
            ),
          ),
          Expanded(
            child: Text(
              item.title,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Icon(
              Icons.arrow_forward_ios,
              size: 20,
              color: Colors.grey[350],
            ),
          ),
        ],
      ),
    ];

    if (!isLast) {
      components.add(
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
              width: MediaQuery.of(context).size.width - 60,
              child: HorizontalLine()),
        ),
      );
    }

    return Column(children: components);
  }
}
