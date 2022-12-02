import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = "welcome_screen";
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  double opacity;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    animation =
        ColorTween(begin: Colors.black, end: Colors.white).animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {});
      print(animation.value);
    });
    // controller.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     controller.reverse(from: 1.0);
    //   } else if (status == AnimationStatus.dismissed) {
    //     controller.forward();
    //   }
    // });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  bool selected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/img.png'),
            fit: BoxFit.cover,
            opacity: controller.value > .7 ? 0.7 : controller.value,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Hero(
                    tag: "logo",
                    child: Container(
                      child: Image.asset('images/logo.png'),
                      height: 50,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 48.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    'Verse',
                    style: TextStyle(
                      fontSize: 45.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 48.0,
              ),
              Hero(
                tag: "login",
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Material(
                    elevation: 5.0,
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.circular(30.0),
                    child: MaterialButton(
                      onPressed: () {
                        //go to login screen
                        Navigator.pushNamed(context, LoginScreen.id);
                      },
                      minWidth: 200.0,
                      height: 42.0,
                      child: Text(
                        'Log In',
                      ),
                    ),
                  ),
                ),
              ),
              Hero(
                tag: "register",
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Material(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(30.0),
                    elevation: 5.0,
                    child: MaterialButton(
                      onPressed: () {
                        //Go to registration screen.
                        Navigator.pushNamed(context, RegistrationScreen.id);
                      },
                      minWidth: 200.0,
                      height: 42.0,
                      child: Text(
                        'Register',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
