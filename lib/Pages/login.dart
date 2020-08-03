import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_particle_background/flutter_particle_background.dart';
import 'package:unitix/Pages/signUpPage.dart';
import 'HomeUnitixRoot.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class LoginPage extends StatefulWidget{
  @override
  State createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin{

  LiquidCircularProgressIndicator liquidInd = LiquidCircularProgressIndicator(
  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
  backgroundColor: Colors.white,
  borderColor: Colors.purple,
  center: new Text("Logging in..."),
  borderWidth: 3.0,
  direction: Axis.horizontal,
  );

  String _username, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AnimationController _iconAnimationController;
  Animation<double> _iconAnimation;

  @override
  void initState(){
    super.initState();
    _iconAnimationController = new AnimationController(
        vsync: this,
        duration: new Duration(milliseconds: 1000)
    );
    _iconAnimation = new CurvedAnimation(
        parent: _iconAnimationController,
        curve: Curves.easeOut
    );
    _iconAnimation.addListener(()=> this.setState((){}));
    _iconAnimationController.forward();
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      backgroundColor: Colors.black,
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Image(
            image: new AssetImage("assets/tower.jpg"),
            fit: BoxFit.cover,
            color: Colors.black87,
            colorBlendMode: BlendMode.darken,
          ),
          new ParticleBackground(
            numberOfParticles: 150,
            particleColor: Colors.blueAccent,
            biggestSize: 4,
            allFilled: false,
            blur: true,
            highestSpeed: 1,
            multiColor: false,
            smallestSize: 3,
            slowestSpeed: 0.7,
            blurIntensity: 1,
            backgroundColor: Colors.transparent,
          ),
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              new Image(
                image: new AssetImage("assets/unitixRun.png"),
                height: _iconAnimation.value * 175,
                width: _iconAnimation.value * 175,
              ),
              new Form(
                  key: _formKey,
                  child: Theme(
                    data: new ThemeData(
                        brightness: Brightness.dark,
                        primarySwatch: Colors.teal,
                        inputDecorationTheme: new InputDecorationTheme(
                            labelStyle: new TextStyle(
                                color: Colors.teal,
                                fontSize: 20.0
                            )
                        )
                    ),
                    child: new Container(
                      padding: const EdgeInsets.only(top: 150.0, left: 40.0, right: 40.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new TextFormField(
                            validator: (input){
                              if(input.isEmpty){
                                return 'Please type your username';
                              }
                            },
                            onSaved: (input) => _username = input,
                            decoration: new InputDecoration(
                              hintText: "Enter Username",
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          new TextFormField(
                            validator: (input){
                              if(input.isEmpty){
                                return 'Please type your password';
                              }
                            },
                            onSaved: (input) => _password = input,
                            decoration: new InputDecoration(
                              hintText: "Enter Password",
                            ),
                            keyboardType: TextInputType.text,
                            obscureText: true,
                          ),
                          new AnimatedPadding(
                            padding: new EdgeInsets.all(20.0),
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                            child: new Container(
                              color: Colors.green,
                            ),
                          ),
                          new MaterialButton(
                            height: 40.0,
                            minWidth: 110.0,
                            color: Colors.teal,
                            textColor: Colors.white,
                            child: new Icon(Icons.lock_open),
                            onPressed: signIn,
                            hoverColor: Colors.green,
                            onLongPress: signUpNav,
                            splashColor: Colors.orange,
                          ),
                        ],
                      ),
                    ),
                  )
              )
            ],
          )
        ],
      ),
    );
  }

  Future<void> signIn() async {
    final formState = _formKey.currentState;
    if(formState.validate()){
      formState.save();
      try{
        // ignore: unnecessary_statements
        liquidInd;
        AuthResult user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _username, password: _password);
        Navigator.push(context, PageRouteBuilder(
            transitionDuration: new Duration(milliseconds: 100),
            transitionsBuilder: (BuildContext context, Animation<double> anim, Animation<double> secAnim, Widget child) {
              anim = new CurvedAnimation(parent: anim, curve: Curves.easeInCirc);
              return ScaleTransition(
                  alignment: Alignment.center,
                  scale: anim,
                  child: child
              );
            },
            fullscreenDialog: true,
            pageBuilder: (BuildContext context, Animation<double> anim, Animation<double> secAnim){
              return FirebaseHome();
            }
        ));
      } catch(e){
        print(e.message);
      }
    }
  }

  void signUpNav(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
  }
}