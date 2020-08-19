import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterapp/models/local_user.dart';
import 'package:flutterapp/models/local_invite.dart';

class AppState {
  final FirebaseUser auth;
  final User user;
  final User partner;
  final Invite invite;

  AppState({this.auth, this.user, this.partner, this.invite});

  AppState setAuth(FirebaseUser auth){
    return AppState(auth: auth, user: this.user, partner: this.partner, invite: this.invite);
  }
  AppState setUser(User user){
    return AppState(auth: this.auth, user: user, partner: this.partner, invite: this.invite);
  }
  AppState setPartner(User partner){
    return AppState(auth: this.auth, user: this.user, partner: partner, invite: this.invite);
  }
  AppState setInvite(Invite invite){
    return AppState(auth: this.auth, user: this.user, partner: this.partner, invite: invite);
  }

  AppState copy() {
    return new AppState(
        auth: this.auth,
        user: this.user,
        partner: this.partner,
        invite: this.invite);
  }
}
