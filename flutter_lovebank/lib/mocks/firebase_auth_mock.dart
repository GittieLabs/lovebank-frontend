import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';

class FirebaseAuthMock extends Mock implements FirebaseAuth {

    static FirebaseAuthMock instance;
    dynamic stream = UserLoginLogout();
    dynamic users = [];

    @override
    Stream<FirebaseUser> get onAuthStateChanged {
        return stream.stream;
    }

    @override
    Future<AuthResult> createUserWithEmailAndPassword({String email, String password}) async {
        dynamic x = MockAuthResult(email: email, password: password);
        debugPrint("creating user");
        users.append(x);
        debugPrint(users);
        debugPrint("done");
        return x;
    }

    @override
    Future<AuthResult> signInWithEmailAndPassword({String email, String password}) async {
        num i = 0;
        for(i = 0; i < users.length; i++){
            if (users[i].email == email && users[i].password == password) {
                stream.user = MockAuthResult(userIn: users[i]);
                stream.updated = true;
                debugPrint("logged in");
                return MockAuthResult(userIn: users[i]);
            }
        }
        debugPrint("not logged in");
        return MockAuthResult(nullUser: true);
    }

    @override
    Future<void> signOut() async {
        stream.user = null;
        stream.updated = true;
    }


}

class UserLoginLogout {
    UserLoginLogout() {
        Timer.periodic(Duration(seconds: 1), (t) {
            if (updated) {
                debugPrint("updating stream");
                _controller.sink.add(user);
                updated = false;
            }
        });
    }
    bool updated = false;
    FirebaseUser user;
    final _controller = StreamController<FirebaseUser>();

    Stream<FirebaseUser> get stream => _controller.stream;
}

class MockAuthResult extends Mock implements AuthResult {
    FirebaseUser user;

    MockAuthResult({email="x@y", password="1234", userIn, nullUser}) {
        if (nullUser) {
            user = null;
        } else if (userIn) {
            user = userIn;
        } else {
            user = MockFirebaseUser(email: email, password: password);
        }
    }

}

class MockFirebaseUser extends Mock implements FirebaseUser {
    String name;
    String pass;

    MockFirebaseUser({email, password}) {
        name = email;
        pass = password;
    }
    @override
    String get email => name;

    String get password => pass;

    @override
    String get displayName => name;

    @override
    String get uid => pass;
}
