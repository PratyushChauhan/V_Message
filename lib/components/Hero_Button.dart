import 'package:flutter/material.dart';

Hero HeroButton(BuildContext context,
    {String tag, Color color, String text, Function onPressed}) {
  return Hero(
    tag: tag.toString(),
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: () {
            //go to login screen
            onPressed();
          },
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    ),
  );
}
