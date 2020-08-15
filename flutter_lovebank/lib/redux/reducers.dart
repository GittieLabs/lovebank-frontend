import 'package:flutterapp/redux/actions.dart';
import 'package:flutterapp/redux/app_state.dart';

AppState reducer(AppState state, dynamic action) {
    if (action is ChangeAuthDataAction) {
        return state.copy(auth: action.auth);
    }
    if (action is ChangeUserDataAction) {
        return state.copy(user: action.user);
    }
    if (action is ChangePartnerDataAction) {
        return state.copy(partner: action.partner);
    }
    if (action is ChangeInviteDataAction) {
        return state.copy(invite: action.invite);
    }

    // if action not intended, don't change state.
    return state;
}
