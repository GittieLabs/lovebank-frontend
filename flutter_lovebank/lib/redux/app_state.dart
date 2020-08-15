import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterapp/models/local_user.dart';
import 'package:flutterapp/models/local_invite.dart';

class AppState {
  FirebaseUser auth;
  User user;
  User partner;
  Invite invite;

  AppState({this.auth, this.user, this.partner, this.invite});

  AppState copy() {
    return new AppState(
        auth: this.auth,
        user: this.user,
        partner: this.partner,
        invite: this.invite);
  }
}
