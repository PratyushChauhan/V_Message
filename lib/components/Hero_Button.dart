import 'package:flutter/material.dart';

Hero HeroButton(BuildContext context,
    {String tag, Color color, String text, String route}) {
  return Hero(
    tag: tag,
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: () {
            //go to login screen
            Navigator.pushNamed(context, route);
          },
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            text,
          ),
        ),
      ),
    ),
  );
}
