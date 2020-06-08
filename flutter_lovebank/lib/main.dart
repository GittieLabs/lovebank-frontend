import 'package:flutter/material.dart';
import 'three_page_intro.dart';
import 'package:flutter/rendering.dart'; //used for debugPaintSizeEnabled

void main() {
  //debugPaintSizeEnabled=true;
  runApp(new LoveApp());
}

class LoveApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "LoveBank",
      theme: ThemeData(
        primaryColor: Color(0xffce00e8),
        accentColor: Color(0xfff68dc7),
        backgroundColor: Color(0xff9e00ff),
        fontFamily: 'LiberationSans',
      ),
      home: ThreePageIntro(),
    );
  }
}