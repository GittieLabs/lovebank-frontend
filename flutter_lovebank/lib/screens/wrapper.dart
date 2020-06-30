import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/models/local_user.dart';
import 'package:flutterapp/screens/invitation/invite_page.dart';
import 'package:flutterapp/screens/home/home_with_notification.dart';
import 'package:provider/provider.dart';
import 'package:flutterapp/screens/intro/three_page_intro.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;


class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    FirebaseUser user = Provider.of<FirebaseUser>(context);

    if (user == null) {
      return ThreePageIntro();
    } else {
      Future<User> userDb = fetchUser(user.uid);

      return FutureBuilder<User>(
          future: userDb,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.partnerId == null){
                return InvitePartnerPage();
              } else {
                return CompleteHome();
              }
            } else
            // By default, show a loading spinner.
            return CircularProgressIndicator();
          }
      );
    }
  }
}

