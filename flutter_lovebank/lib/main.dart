import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterapp/screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:flutterapp/services/userAuthentication.dart';
import 'package:flutter/rendering.dart'; //used for debugPaintSizeEnabled
void main() => runApp(new LoveApp());

class LoveApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<FirebaseUser>.value(
      value: AuthService().user,
      child: MaterialApp(
        title: "LoveBank",
        theme: ThemeData(
        primaryColor: Color(0xffce00e8),
        accentColor: Color(0xfff68dc7),
        backgroundColor: Color(0xff9e00ff),
        fontFamily: 'LiberationSans',
        ),
        home: Wrapper(), //wrapper class deals with the login status of the user 
      ),
    );
  }
}
