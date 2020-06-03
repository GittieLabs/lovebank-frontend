import 'package:flutter/material.dart';
import 'package:flutterapp/screens/authenticate/sign_in.dart';
import 'package:flutterapp/screens/authenticate/register.dart';

/* Authenticate Class Deals with the task of presenting the Sign In/ Register Screen as requested by the User
   Default is the Sign In Screen
*/

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true; //shows the sign in page by default

  //toggles the showSignIn variable to switch between sign in and sign up screens
  void toggleView(){
    setState(()=> showSignIn = !showSignIn); 
  }

  @override
  Widget build(BuildContext context) {
    
      if (showSignIn) {
        return SignIn(toggleView: toggleView);
      } else{
        return Register(toggleView: toggleView);
      }
      
  }
}