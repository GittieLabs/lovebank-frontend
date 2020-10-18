import 'package:flutterapp/main.dart';

var _auth = LoveApp.firebaseAuth;

// This method will send the password-reset email
// to the provided email address.
Future<bool> resetPassword(var email) async {
    var emailSent = _auth.sendPasswordResetEmail(email: email)
        .then((val) => true)
        .catchError((e) => false);

    return emailSent;
}

