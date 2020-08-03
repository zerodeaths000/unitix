import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unitix/Pages/HomeUnitixRoot.dart';
import 'package:unitix/Pages/homeBeforeLogin.dart';
import 'package:unitix/Pages/signUpPage.dart';

import 'Pages/login.dart';

void main()=> runApp(new MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if(!currentFocus.hasPrimaryFocus){
          currentFocus.unfocus();
        }
      },
      child: new MaterialApp(
        home: new homeSwitch(),
        theme: new ThemeData(
          primarySwatch: Colors.blue
        ),
        navigatorObservers: [DismissKeyboardNavigationObserver()],
      ),
    );
  }
}

class DismissKeyboardNavigationObserver extends NavigatorObserver {
  @override
  void didStartUserGesture(Route route, Route previousRoute) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.didStartUserGesture(route, previousRoute);
  }
}

