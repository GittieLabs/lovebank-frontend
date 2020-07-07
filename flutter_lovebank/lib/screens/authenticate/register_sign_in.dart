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

  // Variables to Store name, email, and password
  String fullname = '';
  String email = '';
  String password = '';
  String error = '';
  String mobile = '';

  _RegisterSignInState({this.showSignIn});

  // toggles the showSignIn variable to switch between sign in and sign up screens
  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  // This function builds a formField because they are all essentially the same structure.
  Widget buildField(
      String hintText, dynamic validator, dynamic onChanged, bool obscure) {
    return TextFormField(
      obscureText: obscure,
      style: TextStyle(fontSize: 12),
      decoration: InputDecoration(
        fillColor: Theme.of(context).backgroundColor,
        filled: true,
        hintText: hintText,
        contentPadding: EdgeInsets.only(top: 15),
      ),
      validator: validator,
      onChanged: onChanged,
    );
  }

  String validateMobile(String val) {
    Pattern pattern =
        r'^(\+?\d{1,3}[- ]?)?([(]\d{3}[)]|\d{3})[- ]?\d{3}[- ]?\d{4}$';
    RegExp regex = new RegExp(pattern);
    if (regex.hasMatch(val))
      return null;
    else
      return 'Please enter a valid mobile number';
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

    double verticalPadding = 15;
    double horizontalPadding = 25;

    double mainSectionHeight =
        MediaQuery.of(context).size.height - (verticalPadding * 2);
    double mainSectionWidth =
        MediaQuery.of(context).size.width - (horizontalPadding * 2);

    double formHeight = mainSectionHeight * 0.55;

    // The below set of variables is used to move a text field up above the keyboard
    // if the keyboard is up.
    double keyboardTop = MediaQuery.of(context).viewInsets.bottom;

    // The cloudArea contains the cloud picture and the text immediately beneath it.
    Widget cloudArea = Column(
      children: [
        Container(
          width: 340,
          height: (cloudHeight > 200) ? 200 : cloudHeight, // max: 200,
          decoration: (keyboardTop > 0)
              ? BoxDecoration()
              : BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fitHeight,
                      image: ExactAssetImage(
                          (showSignIn) ? signInImage : registerImage)),
                ),
        ),
        (keyboardTop > 0)
            ? Container()
            : Container(
                height: 60,
                padding: EdgeInsets.only(left: 35, right: 35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text((showSignIn) ? signInText1 : registerText1,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    Text((showSignIn) ? signInText2 : registerText2,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
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
                              recognizer: TapGestureRecognizer()
                                ..onTap = toggleView,
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

    // Below is each field of the form
    Widget fullNameField = buildField('Enter your full name', (val) {
      if (val.isEmpty) {
        return 'Please enter your full name';
      } else {
        return null;
      }
    }, (val) => (setState(() => fullname = val.trim())), false);

    Widget emailField = buildField('Enter your email', (val) {
      if (val.isEmpty) {
        return ((showSignIn)
            ? 'Please enter a valid email'
            : 'Please enter an email');
      } else {
        return null;
      }
    }, (val) => (setState(() => email = val.trim())), false);

    Widget mobileField = buildField('Enter your mobile number', validateMobile,
        (val) => (setState(() => mobile = val.trim())), false);

    Widget passwordField = buildField('Enter your password', (val) {
      if (val.length < 8) {
        return 'Password should be 8 characters or longer';
      } else {
        return null;
      }
    }, (val) => (setState(() => password = val)), true);

    Widget forgotPassword = Container(
      padding: EdgeInsets.only(top: 30),
      child: RichText(
        text: TextSpan(
          text: "forgot your password?",
          style: TextStyle(
            color: Colors.red,
            fontSize: 12,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Material(
                      child: Text("Password reset page placeholder"),
                    ),
                  ),
                ),
        ),
      ),
    );

    Widget submitButton = WideButton(
        color: Theme.of(context).primaryColor,
        text: (showSignIn) ? ('Sign in') : ('Sign up'),
        onTap: () async {
          if (_formKey.currentState.validate()) {
            dynamic result;
            if (showSignIn) {
              result = await _authentication.signInWithEmail(email, password);
            } else {
              result = await _authentication.registerWithEmail(
                  fullname, mobile, email, password);
            }
            if (result == null) {
              ///Error with signin or registration.
            } else {
              Navigator.pop(context);
            }
          }
        });

    // The list below keeps the fields positioned in the correct way in preparation
    // for being used in a stack for the form.
    List<Widget> formFields = [
      (!showSignIn) ? fullNameField : Container(),
      emailField,
      (!showSignIn) ? mobileField : Container(),
      passwordField,
      (showSignIn)
          ? Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [forgotPassword],
            )
          : Container(),
      Spacer(flex: 2),
      submitButton,
      Spacer(flex: 2),
    ];

    // The below form has a stack of fields inside of it
    Widget form = Container(
      height: mainSectionHeight,
      width: mainSectionWidth,
      child: Form(
        key: _formKey,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Positioned(
              bottom: (keyboardTop > 0) ? keyboardTop : 30,
              child: Container(
                height: formHeight,
                width: mainSectionWidth,
                color: Theme.of(context).backgroundColor,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: formFields,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    // The below widget is the above pieces put together.
    Widget registerWidget = Material(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Theme.of(context).backgroundColor,
        padding: EdgeInsets.symmetric(
            vertical: verticalPadding, horizontal: horizontalPadding),
        child: Stack(
          children: [
            Positioned(
              top: mainSectionHeight / 25,
              left: 0,
              right: 0,
              child: cloudArea,
            ),
            form,
          ],
        ),
      ),
    );

    return registerWidget;
  }
}
