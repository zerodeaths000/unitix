import 'package:flutter/material.dart';
import 'package:unitix/Pages/login.dart';
import 'package:unitix/Pages/signUpPage.dart';

class homeSwitch extends StatefulWidget {
  @override
  _homeSwitchState createState() => _homeSwitchState();
}

class _homeSwitchState extends State<homeSwitch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Column(
            children: <Widget>[
              new Padding(padding: new EdgeInsets.only(top: 60.0)),
              new Image(
                image: new AssetImage("assets/unitixHomeIcon.png"),
              ),
              new Container(
                padding: new EdgeInsets.all(50.0),
                child: new Column(
                  children: <Widget>[
                    new MaterialButton(
                        onPressed: (){Navigator.push(context, new MaterialPageRoute(builder: (context) => LoginPage()));},
                      child: new Text("Sign In"),
                      height: 40.0,
                      minWidth: 110.0,
                      color: Colors.blueGrey,
                      elevation: 30.0,
                    ),
                    new RichText(
                      text: new TextSpan(
                        style: new TextStyle(
                          fontFamily: "Dosis",
                          color: Colors.black
                        ),
                        children: [
                          TextSpan(text: 'OR')
                        ]
                      )
                    ),
                    new MaterialButton(
                      onPressed: (){Navigator.push(context, new MaterialPageRoute(builder: (context) => SignUp()));},
                      child: new Text("Sign Up"),
                      height: 40.0,
                      minWidth: 110.0,
                      color: Colors.blueGrey,
                      elevation: 30.0,
                    ),
                  ],
                ),
              )
            ],
          ),
        ]
      ),
    );
  }
}
