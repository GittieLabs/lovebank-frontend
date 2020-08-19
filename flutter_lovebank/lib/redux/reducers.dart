import 'package:flutterapp/redux/actions.dart';
import 'package:flutterapp/redux/app_state.dart';

AppState reducer(AppState state, dynamic action) {
    if (action is ChangeAuthDataAction) {
        AppState cp =  state.copy();
        cp = cp.setAuth(action.auth);
        if (action.auth == null) {
            cp = cp.setUser(null);
            cp = cp.setPartner(null);
            cp = cp.setInvite(null);
        }
        return cp;
    }
    if (action is ChangeUserDataAction) {
        AppState cp =  state.copy();
        cp = cp.setUser(action.user);
        return cp;
    }
    if (action is ChangePartnerDataAction) {
        AppState cp =  state.copy();
        cp = cp.setPartner(action.partner);
        return cp;
    }
    if (action is ChangeInviteDataAction) {
        AppState cp =  state.copy();
        cp = cp.setInvite(action.invite);
        return cp;
    }

    // if action not intended, don't change state.
    return state;
}
