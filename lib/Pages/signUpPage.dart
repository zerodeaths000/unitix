// ignore: unnecessary_statements
// ignore: missing_return
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:unitix/Pages/HomeUnitixRoot.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with SingleTickerProviderStateMixin {

  AnimationController _firebaseController;
  Animation<double> _firebaseAnim;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email, _password, _confirm;

  @override
  void initState(){
    super.initState();
    _firebaseController = new AnimationController(
      vsync: this,
      duration: new Duration(milliseconds: 700)
    );
    _firebaseAnim = new CurvedAnimation(
      parent: _firebaseController,
      curve: Curves.easeOut,
    );
    _firebaseAnim.addListener(()=> this.setState((){}));
    _firebaseController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Sign Up"),
        backgroundColor: Colors.orange,
      ),
      backgroundColor: Colors.black,
      body: new Stack(
          fit: StackFit.expand,
        children: <Widget>[
          new Column(
              mainAxisAlignment: MainAxisAlignment.center,
            children: [
              new Image(
                image: new AssetImage("assets/firebase.png"),
                height: _firebaseAnim.value * 150,
                width: _firebaseAnim.value * 150,
              ),
              new Theme(
                data: new ThemeData(
                  backgroundColor: Colors.white,
                  brightness: Brightness.dark,
                  primarySwatch: Colors.orange,
                  inputDecorationTheme: new InputDecorationTheme(
                    labelStyle: new TextStyle(
                      color: Colors.orange,
                      fontSize: 20.0
                    )
                  )
                ),
                    child: new Form(
                      key: _formKey,
                      child: new Container(
                        padding: new EdgeInsets.only(left: 40.0, right: 40.0, top: 80.0),
                        child: new Column(
                          children: [
                            new TextFormField(
                              validator: (input){
                                if(input.isEmpty){
                                  return 'Reqiured';
                                }
                              },
                                onSaved: (input) => _email = input,
                              decoration: new InputDecoration(
                                hintText: "New Email"
                              )
                            ),
                            new TextFormField(
                              validator: (input){
                                if(input.isEmpty){
                                  return 'Required';
                                }
                              },
                              onSaved: (input) => _password = input,
                              decoration: new InputDecoration(
                                hintText: "New Password"
                              ),
                              obscureText: true,
                            ),
                            new Padding(padding: EdgeInsets.all(30.0)),
                            new MaterialButton(
                              color: Colors.orange,
                              textColor: Colors.white,
                              height: 40.0,
                              minWidth: 110.0,
                              child: new Text("Register User"),
                              onPressed: signUpTech,
                            ),
                          ],
                        )
                      ),
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void popCont(){
    Navigator.of(context).pop();
  }

  void signUpTech() async {
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      try{
        AlertDialog alert = new AlertDialog(
          title: new Text("Registered!"),
          content: new Text("Registration Complete!"),
          actions: [
            new FlatButton(onPressed: (){
              Navigator.of(context).pop();
              Navigator.push(context, MaterialPageRoute(builder: (context) => FirebaseHome()));
              //popCont();
              }, child: new Text("OK"))
          ],
          backgroundColor: Colors.white,
        );
        AuthResult newser = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
        showDialog(
          context: context,
          builder: (_) => alert,
          barrierDismissible: true,
        );
      } catch(e){
        print(e.message);
      }
    }
  }
}

