import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Model/UserData.dart';
import 'package:flutterapp/screens/invitation/invite.dart';
import 'package:provider/provider.dart';
import 'package:flutterapp/screens/intro/three_page_intro.dart';
import 'home/home_widget.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class Wrapper extends StatefulWidget {
  Wrapper({Key key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseUser user = Provider.of<FirebaseUser>(context);

    if (user == null) {
      return ThreePageIntro();
    } else {
      Future<User> userDb = fetchUser(user);

      return FutureBuilder<User>(
          future: userDb,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.partnerId != null){
                return InvitePartner();
              } else {
                return Home();
              }
            }
            // By default, show a loading spinner.
            return CircularProgressIndicator();
          }
      );
    }
  }
}
