
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
      // If user is logged in, check its partner status
      return FutureBuilder(
          future: jumpInvitation(),
          builder: (context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == false){
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

  // Check the partner status of the user
  // Return true: user has a linked partner
  // Return false: user hasn't been linked to a partner
  Future<bool> jumpInvitation() async {
    var userId = 41;
    var url = 'http://127.0.0.1:5000/user/$userId';

    var response = await http.get(url);
    if (response.statusCode == 200){
      var jsonResponse = convert.jsonDecode(response.body);
      var linkedStatus = jsonResponse['partner_id'];

      if (linkedStatus == null) {
        return false;
      } else {
        return true;
      }
    } else {
      throw Exception('Failed to fetch user info');
    }
  }

}


