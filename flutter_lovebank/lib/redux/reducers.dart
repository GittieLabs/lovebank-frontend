import 'package:flutterapp/redux/actions.dart';
import 'package:flutterapp/redux/app_state.dart';

AppState reducer(AppState state, dynamic action) {
    if (action is ChangeAuthDataAction) {
        AppState cp =  state.copy();
        cp.auth = action.auth;
        if (action.auth == null) {
            cp.user = null;
            cp.partner = null;
            cp.invite = null;
        }
        return cp;
    }
    if (action is ChangeUserDataAction) {
        AppState cp =  state.copy();
        cp.user = action.user;
        return cp;
    }
    if (action is ChangePartnerDataAction) {
        AppState cp =  state.copy();
        cp.partner = action.partner;
        return cp;
    }
    if (action is ChangeInviteDataAction) {
        AppState cp =  state.copy();
        cp.invite = action.invite;
        return cp;
    }

    // if action not intended, don't change state.
    return state;
}
