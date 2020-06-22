
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Model/UserData.dart';
import 'package:flutterapp/screens/invitation/invite.dart';
import 'package:provider/provider.dart';
import 'package:flutterapp/screens/intro/three_page_intro.dart';
import 'home/home_widget.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);

    if (user == null) {
      // If user hasn't login, display intro screen
      return ThreePageIntro();
    } else {
      Future<User> databaseUser = fetchUser(user.uid);

      // If user is logged in, check its partner status
      return FutureBuilder<User>(
          future: databaseUser,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.partnerId == null) {
                // If user hasn't been linked to a partner, display invite screen
                return InvitePartner();
              } else {
                // If user has a linked partner, display home screen
                return Home();
              }
            }
            return CircularProgressIndicator();
          }
      );
    }
  }
}


