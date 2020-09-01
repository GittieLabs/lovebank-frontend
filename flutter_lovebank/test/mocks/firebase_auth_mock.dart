import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class FirebaseAuthMock extends Mock implements FirebaseAuth {

    //The constructor and factory code below makes this a singleton
    FirebaseAuthMock._privateConstructor();

    static final FirebaseAuthMock instance = FirebaseAuthMock._privateConstructor();

    factory FirebaseAuthMock() {
        return instance;
    }
    //end


    dynamic stream = UserLoginLogout();
    dynamic users = [];

    @override
    Stream<FirebaseUser> get onAuthStateChanged {
        return stream.stream;
    }

    @override
    Future<AuthResult> createUserWithEmailAndPassword({String email, String password}) async {
        dynamic x = MockAuthResult(email: email, password: password);
        users.add(x.user);
        return x;
    }

    @override
    Future<AuthResult> signInWithEmailAndPassword({String email, String password}) async {
        num i = 0;
        for(i = 0; i < users.length; i++){
            if (users[i].email == email && users[i].password == password) {
                stream.pushData(MockAuthResult(userIn: users[i]).user);
                return MockAuthResult(userIn: users[i]);
            }
        }
        return MockAuthResult(nullUser: true);
    }

    @override
    Future<void> signOut() async {
        stream.pushData(null);
    }
}

class UserLoginLogout {

    void pushData(user) {
        _controller.sink.add(user);
    }

    bool updated = false;
    FirebaseUser user;
    final _controller = StreamController<FirebaseUser>();

    Stream<FirebaseUser> get stream => _controller.stream;

    void dispose() {
        _controller.close();
    }
}

class MockAuthResult extends Mock implements AuthResult {
    FirebaseUser user;

    MockAuthResult({email="test@test", password="12345678", userIn, nullUser}) {
        if (nullUser != null) {
            user = null;
        } else {
            if (userIn != null) {
                user = userIn;
            } else {
                user = MockFirebaseUser(email: email, password: password);
            }
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
