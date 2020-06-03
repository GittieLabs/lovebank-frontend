import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterapp/screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:flutterapp/userAuthentication.dart';

void main() => runApp(new LoveApp());

class LoveApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<FirebaseUser>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(), //wrapper class deals with the login status of the user
      ),
    );
  }
}