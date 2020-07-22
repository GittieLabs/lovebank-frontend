import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget{
  final String imagePath;

  CircleImage({this.imagePath});

  @override
  Widget build(BuildContext context){
    return CircleAvatar(
      radius: 43.0,
      backgroundColor: Color(0xff9e00ff),
      child: CircleAvatar(
        radius: 40,
        backgroundImage: AssetImage(imagePath),
      ),
    );

  }
}