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

  // Variables to Store email. password and error message to show up when they are not valid
  // also stores the focusNodes for the form fields and the error state of the fields
  String fullname = '';
  FocusNode nameNode = FocusNode();
  bool nameFocus = false;
  bool nameError = false;

  String email = '';
  FocusNode emailNode = FocusNode();
  bool emailFocus = false;
  bool emailError = false;

  String password = '';
  FocusNode passwordNode = FocusNode();
  bool passwordFocus = false;
  bool passwordError = false;

  String error = '';

  _RegisterSignInState({this.showSignIn});

  @override
  void initState() {
    super.initState();
    nameNode.addListener(_onNameFocus);
    emailNode.addListener(_onEmailFocus);
    passwordNode.addListener(_onPasswordFocus);
    nameError = false;
    emailError = false;
    passwordError = false;
  }

  // toggles the showSignIn variable to switch between sign in and sign up screens
  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
      nameError = false;
      emailError = false;
      passwordError = false;
    });
  }

  void _onNameFocus() {
    setState(() {
      nameFocus = true;
      emailFocus = false;
      passwordFocus = false;
    });
  }

  void _onEmailFocus() {
    setState(() {
      nameFocus = false;
      emailFocus = true;
      passwordFocus = false;
    });
  }

  void _onPasswordFocus() {
    setState(() {
      nameFocus = false;
      emailFocus = false;
      passwordFocus = true;
    });
  }

  // This function builds a formField because they are all essentially the same structure.
  Container buildField(FocusNode node, String hintText, String validatorText,
      dynamic validator, dynamic onChanged, bool invalid, bool obscure) {
    return Container(
      height: 70,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextFormField(
            obscureText: obscure,
            focusNode: node,
            style: TextStyle(fontSize: 12),
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintText: hintText,
              contentPadding: EdgeInsets.only(top: 15),
            ),
            validator: validator,
            onChanged: onChanged,
          ),
          (invalid)
              ? Text(validatorText,
                  style: TextStyle(fontSize: 12, height: 0, color: Colors.red),
                  textAlign: TextAlign.left)
              : Container(),
        ],
      ),
    );
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

    // The cloudArea contains the cloud picture and the text immediately beneath it.
    Widget cloudArea = Column(
      children: [
        Container(
          width: 340,
          height: (cloudHeight > 200) ? 200 : cloudHeight, //max: 200,
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

    // Below is each field of the form
    Widget fullNameField = buildField(
        nameNode, 'Enter your full name', 'Please enter your full name', (val) {
      if (val.isEmpty) {
        setState(() => nameError = true);
        return '';
      } else {
        setState(() => nameError = false);
        return null;
      }
    }, (val) => (setState(() => fullname = val.trim())), nameError, false);

    Widget emailField = buildField(emailNode, 'Enter your email',
        ((showSignIn) ? 'Please enter a valid email' : 'Please enter an email'),
        (val) {
      if (val.isEmpty) {
        setState(() => emailError = true);
        return '';
      } else {
        setState(() => emailError = false);
        return null;
      }
    }, (val) => (setState(() => email = val.trim())), emailError, false);

    Widget passwordField = buildField(passwordNode, 'Enter your password',
        'Password should be 8 characters or longer', (val) {
      if (val.length < 8) {
        setState(() => passwordError = true);
        return '';
      } else {
        setState(() => passwordError = false);
        return null;
      }
    }, (val) => (setState(() => password = val)), passwordError, true);

    Widget forgotPassword = Align(
      alignment: Alignment.topRight,
      child: Container(
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
                          child: Text("Password reset page placeholder")))),
          ),
        ),
      ),
    );

    // The below set of variables is used to move a text field up above the keyboard
    // if the keyboard is up.
    double verticalOffset = (MediaQuery.of(context).size.height / 2.5);
    double keyboardTop = MediaQuery.of(context).viewInsets.bottom;

    bool moveName =
        nameFocus && (MediaQuery.of(context).viewInsets.bottom != 0);
    bool moveEmail =
        emailFocus && (MediaQuery.of(context).viewInsets.bottom != 0);
    bool movePassword =
        passwordFocus && (MediaQuery.of(context).viewInsets.bottom != 0);

    double nameTop = (0 + verticalOffset);
    double emailTop = (((showSignIn) ? 0 : 70) + verticalOffset);
    double passwordTop = (((showSignIn) ? 70 : 140) + verticalOffset);

    moveName = moveName && (nameTop > keyboardTop);
    moveEmail = moveEmail && (emailTop > keyboardTop);
    movePassword = movePassword && (passwordTop > keyboardTop);

    // The list below keeps the fields positioned in the correct way in preparation
    // for being used in a stack for the form.
    List<Widget> formFields = [
      (!showSignIn)
          ? Positioned(
              top: (moveName) ? keyboardTop : nameTop,
              left: 0,
              right: 0,
              child: fullNameField,
            )
          : Container(),
      Positioned(
        top: (moveEmail) ? keyboardTop : emailTop,
        left: 0,
        right: 0,
        child: emailField,
      ),
      Positioned(
        top: (movePassword) ? keyboardTop : passwordTop,
        left: 0,
        right: 0,
        child: passwordField,
      ),
      (showSignIn)
          ? Positioned(
              top: 140 + verticalOffset,
              left: 0,
              right: 0,
              child: forgotPassword,
            )
          : Container(),
    ];


    // The below form has a stack of fields inside of it with a button at the bottom
    Widget form = Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Form(
        key: _formKey,
        child: Stack(
          children: <Widget>[
            Stack(
              fit: StackFit.passthrough,
              children: formFields,
            ),
            Positioned(
              bottom: 30,
              child: WideButton(
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
            ),
            Text(error, style: TextStyle(color: Colors.red, fontSize: 10)),
          ],
        ),
      ),
    );

    // The below widget is the above pieces put together.
    Widget registerWidget = Material(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
        child: Stack(
          children: [
            Positioned(top: 10, left: 0, right: 0, child: cloudArea),
            form,
          ],
        ),
      ),
    );

    return registerWidget;
  }
}
