import 'package:flutter/material.dart';
void main() => runApp(new LoveApp());

class LoveApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Material(
        child: new Center(
          child: new Text("Love Bank"),
        ),
      ),
    );
  }
}