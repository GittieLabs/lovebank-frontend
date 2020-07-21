import 'package:cloud_firestore/cloud_firestore.dart';
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
  User futureUser;

  @override
  void initState() {
    updateUserListener('tyKTkRKzczvhXhtCKB9m');
    super.initState();
  }

  void updateUserListener(String id){
    DocumentReference reference = Firestore.instance.collection('users').document(id);
    reference.snapshots().listen((snapshot){
      if (snapshot.data.isNotEmpty) {
        setState(() {
          futureUser = User.fromJson(snapshot.data);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    FirebaseUser user = Provider.of<FirebaseUser>(context);

    if (user == null) {
      return ThreePageIntro();
    } else {
      if (futureUser == null) return Container();

      if (futureUser.partnerId == null){
        return InvitePartnerPage(futureUser);
      } else {
        return CompleteHome(futureUser);
      }
    }
  }
}

