import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterapp/models/local_user.dart';
import 'package:flutterapp/models/local_invite.dart';

class AppState {
  final FirebaseUser auth;
  final User user;
  final User partner;
  final Invite invite;

  AppState({this.auth, this.user, this.partner, this.invite});

  AppState copy({FirebaseAuth auth, User user, User partner, Invite invite}) {
    return new AppState(
        auth: auth ?? this.auth,
        user: user ?? this.user,
        partner: partner ?? this.partner,
        invite: invite ?? this.invite);
  }
}
