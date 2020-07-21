import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterapp/mocks/firebase_auth_mock.dart';

class AuthService {

  static bool mockAuth = false;
  FirebaseAuth _auth;

  AuthService()
  {
      if (AuthService.mockAuth) {
        if (FirebaseAuthMock.instance == null) {
            FirebaseAuthMock.instance = FirebaseAuthMock();
        }
        _auth = FirebaseAuthMock.instance;
      } else {
        _auth = FirebaseAuth.instance;
      }
  }

  //create user object based on Firebase User
  //This will be useful in the future to return only the needed attributes of the users in the registerWithEmail/signInWithEmail

  //user stream - changes when the user signs in and signs out
  Stream<FirebaseUser> get user {
    return _auth.onAuthStateChanged;
  }

  //Sign In Anon for test; could be opened up as an Option in the future
  // Future signInAnon() async {
  //   try{
  //     AuthResult result = await _auth.signInAnonymously();
  //     FirebaseUser user = result.user;
  //     return user;
  //   }catch(e){
  //     print(e.toString());
  //     return null;
  //   }
  // }

  //register with email and password
  Future registerWithEmail(
      String name, String mobile, String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      Firestore.instance.collection('users').document(user.uid).setData({
        'displayName': name,
        'partnerId': "",
        'email': email,
        'balance': 0,
        'mobile': mobile,
      });
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email and password

  Future signInWithEmail(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
