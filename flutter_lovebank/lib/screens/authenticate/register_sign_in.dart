import 'package:flutter/material.dart';
import 'package:flutterapp/services/userAuthentication.dart';
import 'package:flutterapp/screens/components/wide_button.dart';

/* Authenticate Class Deals with the task of presenting the Sign In/ Register Screen as requested by the User
   Default is the Sign In Screen
*/

class RegisterSignIn extends StatefulWidget {
  final bool showSignIn;
  RegisterSignIn({this.showSignIn});

  @override
  _RegisterSignInState createState() =>
      _RegisterSignInState(showSignIn: showSignIn);
}

class _RegisterSignInState extends State<RegisterSignIn> {
  bool showSignIn = true; //shows the sign in page by default
  final AuthService _authentication = AuthService();
  final _formKey = GlobalKey<FormState>();

  //Variables to Store email. password and error message to show up when they are not valid
  String email = '';
  String password = '';
  String error = '';

  _RegisterSignInState({this.showSignIn});

  //toggles the showSignIn variable to switch between sign in and sign up screens
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    Widget form = Container(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 250,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  (!showSignIn)
                      ? TextFormField(
                          decoration:
                              InputDecoration(hintText: 'Enter your full name'),
                          validator: (val) => val.isEmpty
                              ? 'Please enter your full name'
                              : null,
                          onChanged: (val) {
                            setState(() => email = val.trim());
                          })
                      : Container(width: 0, height: 0),
                  TextFormField(
                      decoration: InputDecoration(hintText: 'Enter your email'),
                      validator: (showSignIn)
                          ? ((val) =>
                              val.isEmpty ? 'Please enter a valid email' : null)
                          : ((val) =>
                              val.isEmpty ? 'Please enter an email' : null),
                      onChanged: (val) {
                        setState(() => email = val.trim());
                      }),
                  TextFormField(
                      obscureText: true,
                      decoration:
                          InputDecoration(hintText: 'Enter your password'),
                      validator: (val) => val.length < 8
                          ? 'Password should be 8 characters or longer'
                          : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      }),
                  (showSignIn) 
                          ? Align(alignment: Alignment.topRight, child: Container(padding: EdgeInsets.only(top: 30), child: Text("forgot your password?")))
                          : Container(width: 0, height: 0),
                ],
              ),
            ),
            WideButton(
                color: Theme.of(context).primaryColor,
                text: (showSignIn) ? ('Sign in') : ('Sign up'),
                onTap: () async {
                  if (_formKey.currentState.validate()) {
                    dynamic result;
                    if (showSignIn) {
                      result = await _authentication.signInWithEmail(
                          email, password);
                    } else {
                      result = await _authentication.registerWithEmail(
                          email, password);
                    }
                    if (result == null) {
                      setState(() => error = 'Please enter a valid email');
                    } else {
                      Navigator.pop(context);
                    }
                  }
                }),
            Text(error, style: TextStyle(color: Colors.red, fontSize: 10))
          ],
        ),
      ),
    );

    Widget registerWidget = Material(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
        child: form,
      ),
    );

    return registerWidget;
  }
}
