import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterapp/redux/actions.dart';
import 'package:flutterapp/redux/app_state.dart';
import 'package:flutterapp/services/userAuthentication.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutterapp/models/local_user.dart';
import 'package:flutterapp/models/local_invite.dart';



Stream<dynamic> userChangesEpic(Stream<dynamic> actions, EpicStore<AppState> store) {
    Stream<dynamic> userListenRequests = actions.whereType<ListenToUserAction>();
    Stream<dynamic> userChangeActions = userListenRequests.switchMap(
        (dynamic requestAction) {
            return Firestore.instance.collection("users").document(requestAction.id).snapshots()
                .map((x) => ChangeUserDataAction(User.fromJson(x.data)))
                .takeUntil(actions.whereType<DontListenToUserAction>());
        }
    );
    return userChangeActions;
}

Stream<dynamic> partnerChangesEpic(Stream<dynamic> actions, EpicStore<AppState> store) {
    Stream<dynamic> partnerListenRequests = actions.whereType<ListenToPartnerAction>();
    Stream<dynamic> partnerChangeActions = partnerListenRequests.switchMap(
        (dynamic requestAction) {
            return Firestore.instance.collection("users").document(requestAction.id).snapshots()
                .map((x) => ChangePartnerDataAction(User.fromJson(x.data)))
                .takeUntil(actions.whereType<DontListenToPartnerAction>());
        }
    );
    return partnerChangeActions;
}

Stream<dynamic> inviteChangesEpic(Stream<dynamic> actions, EpicStore<AppState> store) {
    Stream<dynamic> inviteListenRequests = actions.whereType<ListenToInviteAction>();
    Stream<dynamic> inviteChangeActions = inviteListenRequests.switchMap(
        (dynamic requestAction) {
            return Firestore.instance.collection("invites").document(requestAction.id).snapshots()
                .map((x) => ChangeInviteDataAction(Invite.fromJson(x.data)))
                .takeUntil(actions.whereType<DontListenToInviteAction>());
        }
    );
    return inviteChangeActions;
}

Stream<dynamic> registerEpic(Stream<dynamic> actions, EpicStore<AppState> store) {
    Stream<dynamic> registerRequests = actions.whereType<RegisterAction>();
    Stream<dynamic> authTokenStream = registerRequests.switchMap(
        (dynamic requestAction) {
            return Stream.fromFuture(AuthService().registerWithEmail(requestAction.name, requestAction.mobile, requestAction.email, requestAction.password))
                    .map((x) => ChangeAuthDataAction(x));
        }
    );
    return authTokenStream;
}

Stream<dynamic> loginEpic(Stream<dynamic> actions, EpicStore<AppState> store) {
    Stream<dynamic> loginRequests = actions.whereType<LoginAction>();
    Stream<dynamic> authTokenStream = loginRequests.switchMap(
        (dynamic requestAction) {
            return Stream.fromFuture(AuthService().signInWithEmail(requestAction.email, requestAction.password))
                    .map((x) => ChangeAuthDataAction(x));
        }
    );
    return authTokenStream;
}

Stream<dynamic> logoutEpic(Stream<dynamic> actions, EpicStore<AppState> store) {
    Stream<dynamic> logoutRequests = actions.whereType<LogoutAction>();
    Stream<dynamic> authTokenStream = logoutRequests.switchMap(
        (dynamic requestAction) {
            return Stream.fromFuture(AuthService().signOut())
                    .map((x) => ChangeAuthDataAction(null));
        }
    );
    return authTokenStream;
}
