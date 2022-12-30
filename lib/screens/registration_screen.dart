import 'package:flash_chat/components/Hero_Button.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = "registration_screen";
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
            //   height: 5,
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
              tag: "register",
              text: "Register",
              color: Colors.blueAccent,
              onPressed: () {
                //TODO Implement registration functionality.
              },
            ),
          ],
        ),
      ),
    );
  }
}
