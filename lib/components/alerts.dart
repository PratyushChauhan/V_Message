import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void popupError(BuildContext context, String e) {
  print('Alerts: error popup initiated');
  Alert(
    style: AlertStyle(
      animationType: AnimationType.fromBottom,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      backgroundColor: Colors.white,
    ),
    context: context,
    type: AlertType.error,
    title: "ERROR: ",
    desc: "$e",
    buttons: [
      DialogButton(
        color: Colors.blueAccent,
        child: Text(
          "Ok",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        width: 120,
      )
    ],
  ).show();
}

void popupSuccess(BuildContext context, String e) {
  print('Alerts: logout popup initiated');
  Alert(
    style: AlertStyle(
      animationType: AnimationType.fromBottom,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      backgroundColor: Colors.white,
    ),
    context: context,
    type: AlertType.success,
    title: "SUCCESS: ",
    desc: "$e",
    buttons: [
      DialogButton(
        color: Colors.blueAccent,
        child: Text(
          "Ok",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        width: 120,
      )
    ],
  ).show();
}

void popupLogout(BuildContext context, FirebaseAuth _auth) {
  print('Alerts: logout popup initiated');
  Alert(
    style: AlertStyle(
      animationType: AnimationType.fromBottom,
      isCloseButton: true,
      isOverlayTapDismiss: false,
      backgroundColor: Colors.white,
    ),
    context: context,
    type: AlertType.warning,
    title: "ALERT: ",
    desc: "Are you sure you want to logout?",
    buttons: [
      DialogButton(
        color: Colors.blueAccent,
        child: Text(
          "Logout",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        onPressed: () {
          _auth.signOut();
          Navigator.pushNamed(context, WelcomeScreen.id);
        },
        width: 120,
      )
    ],
  ).show();
}
