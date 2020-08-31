import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterapp/main.dart';
import 'package:flutterapp/redux/actions.dart';
import 'package:flutterapp/redux/app_state.dart';
import 'package:flutterapp/services/user_authentication.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutterapp/models/local_user.dart';
import 'package:flutterapp/models/local_invite.dart';



Stream<dynamic> userChangesEpic(Stream<dynamic> actions, EpicStore<AppState> store) {
    Stream<ListenToUserAction> userListenRequests = actions.whereType<ListenToUserAction>();
    Stream<dynamic> userChangeActions = userListenRequests.switchMap(
        (ListenToUserAction requestAction) {
            return Firestore.instance.collection("users").document(requestAction.id).snapshots()
                .map((x) => ChangeUserDataAction(User.fromJson(x.data)))
                .takeUntil(actions.whereType<DontListenToUserAction>());
        }
    );
    return userChangeActions;
}

Stream<dynamic> partnerChangesEpic(Stream<dynamic> actions, EpicStore<AppState> store) {
    Stream<ListenToPartnerAction> partnerListenRequests = actions.whereType<ListenToPartnerAction>();
    Stream<dynamic> partnerChangeActions = partnerListenRequests.switchMap(
        (ListenToPartnerAction requestAction) {
            return Firestore.instance.collection("users").document(requestAction.id).snapshots()
                .map((x) => ChangePartnerDataAction(User.fromJson(x.data)))
                .takeUntil(actions.whereType<DontListenToPartnerAction>());
        }
    );
    return partnerChangeActions;
}

Stream<dynamic> inviteChangesEpic(Stream<dynamic> actions, EpicStore<AppState> store) {
    Stream<ListenToInviteAction> inviteListenRequests = actions.whereType<ListenToInviteAction>();
    Stream<dynamic> inviteChangeActions = inviteListenRequests.switchMap(
        (ListenToInviteAction requestAction) {
            return Firestore.instance.collection("invites").where("requester_id", isEqualTo: requestAction.id).snapshots()
                .map((x) {
                    if (x.documents.length != 1) {
                        return ChangeInviteDataAction(null);
                    } else {
                        return ChangeInviteDataAction(Invite.fromJson(x.documents[0].data));
                    }
                })
                .takeUntil(actions.whereType<DontListenToInviteAction>());
        }
    );
    return inviteChangeActions;
}

Stream<dynamic> registerEpic(Stream<dynamic> actions, EpicStore<AppState> store) {
    Stream<RegisterAction> registerRequests = actions.whereType<RegisterAction>();
    Stream<dynamic> authTokenStream = registerRequests.switchMap(
        (RegisterAction requestAction) {
            return Stream.fromFuture(AuthService().registerWithEmail(requestAction.name, requestAction.mobile, requestAction.email, requestAction.password))
                    .map((x) {
                        if (x != null) {
                            LoveApp.firestore.collection('users').document(x.uid).setData({
                                'userId': x.uid,
                                'displayName': requestAction.name,
                                'partnerId': "",
                                'email': requestAction.email,
                                'balance': 0,
                                'mobile': requestAction.mobile,
                                'profilePic': ""
                            });
                        }
                        return ChangeAuthDataAction(x);
                    }
            );
        }
    );
    return authTokenStream;
}

Stream<dynamic> loginEpic(Stream<dynamic> actions, EpicStore<AppState> store) {
    Stream<LoginAction> loginRequests = actions.whereType<LoginAction>();
    Stream<dynamic> authTokenStream = loginRequests.switchMap(
        (LoginAction requestAction) {
            return Stream.fromFuture(AuthService().signInWithEmail(requestAction.email, requestAction.password))
                    .map((x) => ChangeAuthDataAction(x));
        }
    );
    return authTokenStream;
}

Stream<dynamic> logoutEpic(Stream<dynamic> actions, EpicStore<AppState> store) {
    Stream<LogoutAction> logoutRequests = actions.whereType<LogoutAction>();
    Stream<dynamic> authTokenStream = logoutRequests.switchMap(
        (LogoutAction requestAction) {
            return Stream.fromFuture(AuthService().signOut())
                    .map((x) => ChangeAuthDataAction(null));
        }
    );
    return authTokenStream;
}
