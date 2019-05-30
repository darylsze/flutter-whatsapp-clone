import 'package:flutter/material.dart';

class TakeImageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        new Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("images/wallpaper-clear.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned.fill(
          child: new AppBar(
            leading: IconButton(
              iconSize: 30,
              icon: Icon(
                Icons.close,
                color: Colors.white,
              ),
              onPressed: null,
            ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            actions: <Widget>[
              IconButton(
                iconSize: 30,
                icon: Icon(Icons.wb_cloudy, color: Colors.white),
              ),
              IconButton(
                iconSize: 30,
                icon: Icon(Icons.flash_off, color: Colors.white),
              ),
            ],
          ),
        ),
        new Positioned(
          child: new Align(
            alignment: FractionalOffset.bottomCenter,
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Icon(
                          Icons.image,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                            border: new Border.all(
                              color: Colors.white,
                              width: 5,
                              style: BorderStyle.solid,
                            ),
                            shape: BoxShape.circle,
                            color: Colors.transparent),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 15),
                        child: Icon(
                          Icons.camera_alt,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Material(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text(
                        'Hold for video, tap for photo',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
