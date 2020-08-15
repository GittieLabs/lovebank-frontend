import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterapp/models/local_user.dart';
import 'package:flutterapp/models/local_invite.dart';

// The actions below are intended for the middleware
// (to be converted to the other actions)
class RegisterAction {
    final String name;
    final String mobile;
    final String email;
    final String password;
    RegisterAction(this.name, this.mobile, this.email, this.password);
}
class LoginAction {
    final String email;
    final String password;
    LoginAction(this.email, this.password);
}
class LogoutAction {

}


class ListenToUserAction {
    final String id;
    ListenToUserAction(this.id);
}
class ListenToPartnerAction {
    final String id;
    ListenToPartnerAction(this.id);
}
class ListenToInviteAction {
    final String id;
    ListenToInviteAction(this.id);
}


class DontListenToUserAction {
    final String id;
    DontListenToUserAction(this.id);
}
class DontListenToPartnerAction {
    final String id;
    DontListenToPartnerAction(this.id);
}
class DontListenToInviteAction {
    final String id;
    DontListenToInviteAction(this.id);
}
// end



// The actions below are intended for the reducer
// (to be created by the middleware)
class ChangeAuthDataAction {
    final FirebaseAuth auth;
    ChangeAuthDataAction(this.auth);
}
class ChangeUserDataAction {
    final User user;
    ChangeUserDataAction(this.user);
}
class ChangePartnerDataAction {
    final User partner;
    ChangePartnerDataAction(this.partner);
}
class ChangeInviteDataAction {
    final Invite invite;
    ChangeInviteDataAction(this.invite);
}
// end
