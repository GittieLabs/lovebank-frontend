import 'package:flutter/material.dart';

///A simple wide button with a few customization options.
class WideButton extends StatelessWidget {
  final String text;
  final Color color;
  final GestureTapCallback onTap;

  WideButton({this.text, this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: 300,
      height: 50,
        child: RaisedButton(
        child: Text(text,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        textColor: Colors.white,
        color: color,
        onPressed: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
    );
  }
}// TODO Implement this library.