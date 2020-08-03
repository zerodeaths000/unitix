import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FirebaseHome extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<FirebaseHome> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).popUntil(ModalRoute.withName("/"));
        return Future.value(false);
      },
      child: Scaffold(
        appBar: new AppBar(
          
        ),
          body: new Container(
            child: new Column(
              children: <Widget>[

              ],
            ),
          )
      ),
    );
  }
}
