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
import 'package:stacked/stacked.dart';

class InviteWrapper extends StatefulWidget {
  String uid;
  InviteWrapper(this.uid);

  @override
  _InviteWrapperState createState() => _InviteWrapperState();
}

class _InviteWrapperState extends State<InviteWrapper> {
  User localUser;

  @override
  void initState() {
    super.initState();
    updateUserListener(widget.uid);
  }

  void updateUserListener(String id) {
    DocumentReference reference =
        Firestore.instance.collection('users').document(id);
    reference.snapshots().listen((snapshot) {
      if (snapshot.data.isNotEmpty) {
        setState(() {
          localUser = User.fromJson(snapshot.data);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (localUser == null) return Container();

    if (localUser.partnerId == null) {
      return InvitePartnerPage(localUser);
    } else {
      return CompleteHome(localUser);
    }
  }
}
