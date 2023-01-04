import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/components/Hero_Button.dart';
import 'package:flash_chat/components/alerts.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static String id = "login_screen";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email;
  String password;
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: "logo",
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              // SizedBox(
              //   height: 48.0,
              // ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  email = value;
                },
                decoration: kEmailInputDecoration,
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  password = value;
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
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    if (user != null) {
                      setState(() {
                        showSpinner = false;
                      });
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                  } catch (e) {
                    setState(() {
                      showSpinner = false;
                    });
                    //check if e is firebase auth exception
                    if (e is FirebaseAuthException) {
                      //check if e is user not found
                      if (e.code == "user-not-found") {
                        popupError(context,
                            "User not found.\nCheck email and password.");
                      }
                      //check if e is wrong password
                      else if (e.code == "wrong-password") {
                        popupError(
                            context, "Wrong password.\nPlease try again.");
                      } else {
                        //handle misc errors
                        popupError(context, "${e.code}\n${e.message}");
                      }
                    } else {
                      popupError(context, "${e.toString()}");
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
