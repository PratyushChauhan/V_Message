import 'package:flash_chat/components/Hero_Button.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';

class LoginScreen extends StatefulWidget {
  static String id = "login_screen";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: "logo",
              child: Container(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
            // SizedBox(
            //   height: 48.0,
            // ),
            TextField(
              style: TextStyle(color: Colors.black),
              onChanged: (value) {
                //TODO Do something with the user input.
              },
              decoration: kEmailInputDecoration,
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              style: TextStyle(color: Colors.black),
              onChanged: (value) {
                //TODO Do something with the user input.
              },
              decoration: kPasswordInputDecoration,
            ),
            SizedBox(
              height: 24.0,
            ),
            HeroButton(
              context,
              tag: "login",
              color: Colors.lightBlueAccent,
              text: "Log In",
              onPressed: () {
                //Implement login functionality.
              },
            ),
          ],
        ),
      ),
    );
  }
}
