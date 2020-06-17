import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterapp/screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:flutterapp/services/userAuthentication.dart';
import 'package:flutter/rendering.dart'; //used for debugPaintSizeEnabled
void main() { 
    //debugPaintSizeEnabled = true; //uncomment this line and restart to better see the sizes of elements drawn onscreen
    runApp(new LoveApp());
}

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

 Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
   if (message.containsKey('data')) {
     // Handle data message
     final dynamic data = message['data'];
   }

   if (message.containsKey('notification')) {
     // Handle notification message
     final dynamic notification = message['notification'];
   }

   // Or do other work.
 }
