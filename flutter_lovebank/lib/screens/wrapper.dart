import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/screens/home/home_with_notification.dart';
import 'package:provider/provider.dart';
import 'package:flutterapp/screens/intro/three_page_intro.dart';
import 'package:flutterapp/screens/home/home_widget.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    print(user);

    // return Home Widget if User is logged in; Authenticate(Sign In/Sign Up) widget otherwise
    if (user == null){
      return ThreePageIntro();
    }
    // write an else if condition to return the Invitation Screen if the user has no partner in the backend

    else{
      //return Home Widget when user has a partner
      return CompleteHome();
    }
  }
}
