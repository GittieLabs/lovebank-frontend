import 'package:flutter/gestures.dart';
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
  String fullname = '';
  String email = '';
  String password = '';
  String error = '';
  String mobile = '';

  _RegisterSignInState({this.showSignIn});

  //toggles the showSignIn variable to switch between sign in and sign up screens
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  String validateMobile(String val) {
    Pattern pattern =
        r'/^(\+\d{1,3}[- ]?)?\d{10}$/';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(val))
      return 'Please enter a valid mobile number';
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    String registerImage = "assets/images/intro/sign-up.png";
    String signInImage = "assets/images/intro/sign-in-image.png";

    String registerText1 = "Create your free";
    String registerText2 = "account";
    String registerText3 = "Do you already have an account? ";
    String registerText4 = "Sign in!";

    String signInText1 = "Welcome back!";
    String signInText2 = "Log in now!";
    String signInText3 = "Don't have an account yet? ";
    String signInText4 = "Sign up!";

    double cloudHeight = MediaQuery.of(context).size.height / 4;

    Widget cloudArea = Column(
      children: [
        Container(
          width: 340,
          height: (cloudHeight > 200) ? 200 : cloudHeight,//max: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fitHeight,
                image: ExactAssetImage(
                    (showSignIn) ? signInImage : registerImage)),
          ),
        ),
        Container(
          height: 60,
          padding: EdgeInsets.only(left: 35, right: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text((showSignIn) ? signInText1 : registerText1,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              Text((showSignIn) ? signInText2 : registerText2,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 0),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: (showSignIn) ? signInText3 : registerText3,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      TextSpan(
                        text: (showSignIn) ? signInText4 : registerText4,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = toggleView,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );

    Widget fullNameField = TextFormField(
        style: TextStyle(fontSize: 12),
        decoration: InputDecoration(
          hintText: 'Enter your full name',
          contentPadding: EdgeInsets.only(top: 15),
        ),
        validator: (val) => val.isEmpty ? 'Please enter your full name' : null,
        onChanged: (val) {
          setState(() => fullname = val.trim());
        });

    Widget emailField = TextFormField(
        style: TextStyle(fontSize: 12),
        decoration: InputDecoration(
          hintText: 'Enter your email',
          contentPadding: EdgeInsets.only(top: 15),
        ),
        validator: (showSignIn)
            ? ((val) => val.isEmpty ? 'Please enter a valid email' : null)
            : ((val) => val.isEmpty ? 'Please enter an email' : null),
        onChanged: (val) {
          setState(() => email = val.trim());
        });

    Widget mobileField = TextFormField(
        style: TextStyle(fontSize: 12),
        decoration: InputDecoration(
          hintText: 'Enter your mobile number',
          contentPadding: EdgeInsets.only(top: 15),
        ),
        keyboardType: TextInputType.phone,
        validator: validateMobile,
        onChanged: (val) {
          setState(() => mobile = val.trim());
        });

    Widget passwordField = TextFormField(
        style: TextStyle(fontSize: 12),
        obscureText: true,
        decoration: InputDecoration(
          hintText: 'Enter your password',
          contentPadding: EdgeInsets.only(top: 15),
        ),
        validator: (val) =>
            val.length < 8 ? 'Password should be 8 characters or longer' : null,
        onChanged: (val) {
          setState(() => password = val);
        });

    Widget forgotPassword = Align(
      alignment: Alignment.topRight,
      child: Container(
        padding: EdgeInsets.only(top: 30),
        child: RichText(
          text: TextSpan(
            text: "Forgot your password?",
            style: TextStyle(
              color: Colors.red,
              fontSize: 12,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Material(
                          child: Text("Password reset page placeholder")))),
          ),
        ),
      ),
    );

    Widget form = Container(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 200,
              padding: EdgeInsets.only(left: 35, right: 35),
              child: Stack(
                fit: StackFit.passthrough,
                children: [
                  (!showSignIn) ? Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: fullNameField,
                  ) : Container(),
                  Positioned(
                    top: (showSignIn) ? 0 : 40,
                    left: 0,
                    right: 0,
                    child: emailField,
                  ),
                  (!showSignIn) ? Positioned(
                    top: 80,
                    left: 0,
                    right: 0,
                    child: mobileField,
                  ) : Container(),
                  Positioned(
                    top: (showSignIn) ? 60 : 120,
                    left: 0,
                    right: 0,
                    child: passwordField,
                  ),
                  (showSignIn) ? Positioned(
                    top: 120,
                    left: 0,
                    right: 0,
                    child: forgotPassword,
                  ) : Container(),
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
        child: Column(
            children: [Spacer(), cloudArea, form, Spacer(flex: 2)]),
      ),
    );

    return registerWidget;
  }
}
