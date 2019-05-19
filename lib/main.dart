import 'package:flutter/material.dart';

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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    int _currentIndex = 0;
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(300),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Column(
                children: <Widget>[
                  LeftRightRow(
                    left: Text('Edit',
                        style:
                            TextStyle(fontSize: 18, color: Colors.blue[800])),
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
              ),
            ),
          ),
        ),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(),
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
}
