import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterapp/screens/wrapper.dart';
import 'package:flutterapp/services/invite_data_service.dart';
import 'package:provider/provider.dart';
import 'package:flutterapp/services/userAuthentication.dart';
import 'package:flutter/rendering.dart'; //used for debugPaintSizeEnabled
import 'package:flutterapp/models/local_user.dart';
import 'package:flutterapp/models/local_invite.dart';
import 'package:flutterapp/services/user_data_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  //debugPaintSizeEnabled = true; //uncomment this line and restart to better see the sizes of elements drawn onscreen
  runApp(new LoveApp());
}

class LoveApp extends StatelessWidget {
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static Firestore firestore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAuth>(create: (_) => LoveApp.firebaseAuth),
        Provider<Firestore>(create: (_) => LoveApp.firestore),
        StreamProvider<FirebaseUser>.value(value: AuthService().user),
        StreamProvider<User>.value(value: UserDataService().userData),
        StreamProvider<Invite>.value(value: InviteDataService().inviteData),
      ],
      child: MaterialApp(
        title: "LoveBank",
        theme: ThemeData(
          primaryColor: Color(0xffce00e8),
          accentColor: Color(0xfff68dc7),
          backgroundColor: Color(0xfff2f2f2),
          fontFamily: 'LiberationSans',
        ),
        home: Wrapper(), //wrapper class deals with the login status of the user
      ),
    );
  }
}
