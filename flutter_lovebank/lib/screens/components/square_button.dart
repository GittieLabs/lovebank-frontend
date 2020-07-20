import 'package:flutter/material.dart';

///A simple wide button with a few customization options.
class SquareButton extends StatelessWidget {
  final String text;
  final Color color;
  final GestureTapCallback onPressed;

  SquareButton({this.color, this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: 212,
      height: 36,
      child: RaisedButton(
        child: Text(text,
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Roboto'
          ),
        ),
        textColor: Colors.white,
        color: color,
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
      ),
    );
  }
}
