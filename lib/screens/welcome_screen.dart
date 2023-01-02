import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/components/Hero_Button.dart';

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
    controller?.forward();
    controller?.addListener(() {
      setState(() {});
    });
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
                  AnimatedTextKit(animatedTexts: [
                    TypewriterAnimatedText(
                      "Verse",
                      speed: Duration(milliseconds: 500),
                      textStyle: TextStyle(
                        fontSize: 45.0,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                    )
                  ]),
                ],
              ),
              SizedBox(
                height: 48.0,
              ),
              HeroButton(context,
                  tag: "login",
                  text: "Log In",
                  color: Colors.lightBlueAccent, onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              }),
              HeroButton(context,
                  tag: "register",
                  text: "Register",
                  color: Colors.blueAccent, onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
