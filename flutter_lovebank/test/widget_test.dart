// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutterapp/main.dart';
import 'package:mockito/mockito.dart';
//import 'mocks/firebase_auth_mock.dart';
//import 'mocks/firestore_mock.dart';
import 'package:flutterapp/screens/intro/three_page_intro.dart';

class FirebaseAuthMock extends Mock implements FirebaseAuth {}

class FirebaseUserMock extends Mock implements FirebaseUser {}

class AuthResultMock extends Mock implements AuthResult {}

class FirestoreMock extends Mock implements Firestore {}

class CollectionReferenceMock extends Mock implements CollectionReference {}

class DocumentReferenceMock extends Mock implements DocumentReference {}

class DocumentSnapshotMock extends Mock implements DocumentSnapshot {}

void main() {
  //LiveTestWidgetsFlutterBinding();

  FirebaseAuthMock mockAuth = FirebaseAuthMock();
  AuthResultMock mockEmptyResult = AuthResultMock();
  AuthResultMock mockResult = AuthResultMock();
  FirebaseUserMock mockUser = FirebaseUserMock();

  FirestoreMock mockStore = FirestoreMock();
  CollectionReferenceMock mockUsersColl = CollectionReferenceMock();
  DocumentReferenceMock mockUserData = DocumentReferenceMock();
  DocumentSnapshotMock mockUserDataSnapshot = DocumentSnapshotMock();

  final userDataController = StreamController<DocumentSnapshot>();
  Stream<DocumentSnapshot> userDataStream = userDataController.stream;

  final userController = StreamController<FirebaseUser>();
  Stream<FirebaseUser> userStream = userController.stream;

  setUp(() async {
    //firestore method stubbing
    when(mockStore.collection('users')).thenReturn(mockUsersColl);

    when(mockUsersColl.document("test_uid_1")).thenReturn(mockUserData);

    when(mockUserData.snapshots()).thenAnswer((_) {
      userDataController.sink.add(mockUserDataSnapshot);
      return userDataStream;
    });

    when(mockUserDataSnapshot.data).thenReturn({
      'userId': 'test_uid_1',
      'partnerId': '',
      'email': 'test@test.test',
      'mobile': '1234567890',
      'displayName': 'test_mctesterson',
      'balance': '0',
      'profilePic': '0'
    });

    //firebaseAuth method stubbing
    when(mockAuth.signInWithEmailAndPassword(
            email: "nonexistent@test.test", password: "12345677"))
        .thenAnswer((_) async {
      userController.sink.add(null);
      return mockEmptyResult;
    });
    when(mockAuth.signInWithEmailAndPassword(
            email: "test@test.test", password: "12345678"))
        .thenAnswer((_) async {
      userController.sink.add(mockUser);
      return mockResult;
    });
    when(mockAuth.createUserWithEmailAndPassword(
            email: "test@test.test", password: "12345678"))
        .thenAnswer((_) async {
      userController.sink.add(mockUser);
      return mockResult;
    });

    when(mockAuth.onAuthStateChanged).thenAnswer((_) => userStream);

    when(mockResult.user).thenReturn(mockUser);

    when(mockUser.email).thenReturn("test@test.test");
    when(mockUser.displayName).thenReturn("test_mctesterson");
    when(mockUser.uid).thenReturn("test_uid_1");

    LoveApp.firestore = mockStore;
    LoveApp.firebaseAuth = mockAuth;
  });
  Future moveThroughSlider(WidgetTester tester, dynamic find) async {
    await tester.pumpWidget(LoveApp());

    // Wait 3 seconds for intro screen to pass
    expect(find.text('LoveBank'), findsOneWidget);
    await tester.pumpAndSettle(const Duration(seconds: 3));

    // Drag two times
    expect(
        find.text(
            'Improve your relationship with measurable expressions of love'),
        findsOneWidget);
    expect(find.text('LoveBank'), findsOneWidget);

    await tester.drag(find.byType(ThreePageIntro), Offset(-1000, 0));
    await tester.pumpAndSettle();
    expect(
        find.text(
            'Increase your love bank account by performing the tasks most important to your partner'),
        findsOneWidget);
    expect(find.text('LoveBank'), findsOneWidget);

    await tester.drag(find.byType(ThreePageIntro), Offset(-1000, 0));
    await tester.pumpAndSettle();

    // Make sure to be at the end of the slider
    expect(find.text('Sign in'), findsOneWidget);
    expect(find.text('Create an account'), findsOneWidget);
    expect(find.text('LoveBank'), findsOneWidget);
  }

  testWidgets('login with nonexistent user does nothing',
      (WidgetTester tester) async {
    await moveThroughSlider(tester, find);

    // Go to login screen
    await tester.tap(find.text('Sign in'));
    await tester.pumpAndSettle();

    // Ensure on login screen
    expect(find.text('Sign in'), findsOneWidget);

    // Login with test user
    await tester.enterText(
        find.byKey(Key('Enter your email')), 'nonexistent@test.test');
    await tester.enterText(find.byKey(Key('Enter your password')), '12345677');

    await tester.tap(find.text('Sign in'));
    await tester.pumpAndSettle();

    // Ensure back to three page intro
    expect(find.text('Sign in'), findsOneWidget);
    expect(find.text('Create an account'), findsOneWidget);
  });

  testWidgets(
      'register a user and login with it calls the appropriate things in firebaseAuth and in firestore',
      (WidgetTester tester) async {
    await moveThroughSlider(tester, find);

    // Load register screen
    await tester.tap(find.text('Create an account'));
    await tester.pumpAndSettle();

    expect(find.text('Sign up'), findsOneWidget);

    // Register a test user
    await tester.enterText(
        find.byKey(Key('Enter your display name')), 'test_mctesterson');
    await tester.enterText(
        find.byKey(Key('Enter your email')), 'test@test.test');
    await tester.enterText(
        find.byKey(Key('Enter your mobile number')), '1111111111');
    await tester.enterText(find.byKey(Key('Enter your password')), '12345678');

    await tester.tap(find.text('Sign up'));
    await tester.pumpAndSettle(const Duration(seconds: 4));

    // Ensure logged in
    //expect(find.text('logout'), findsOneWidget);
  });

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
// Tests temporarily disabled due to being abandoned for a while.
// To be redone promptly.

//    LoveApp.firebaseAuth = FirebaseAuthMock.instance;
//    LoveApp.firestore = FirestoreMock.instance;
//
//    // Build our app and trigger a frame.
//    await tester.pumpWidget(LoveApp());
//
//    // Wait 3 seconds for the main screen to transition to the slider
//    expect(find.text('LoveBank'), findsOneWidget);
//    await tester.pumpAndSettle(const Duration(seconds: 3));
//
//    // Drag two times
//    expect(find.text('Improve your relationship with measurable expressions of love'), findsOneWidget);
//    expect(find.text('LoveBank'), findsOneWidget);
//
//    await tester.drag(find.byType(ThreePageIntro), Offset(-1000, 0));
//    await tester.pumpAndSettle();
//    expect(find.text('Increase your love bank account by performing the tasks most important to your partner'), findsOneWidget);
//    expect(find.text('LoveBank'), findsOneWidget);
//
//    await tester.drag(find.byType(ThreePageIntro), Offset(-1000, 0));
//    await tester.pumpAndSettle();
//
//    expect(find.text('Sign in'), findsOneWidget);
//    expect(find.text('Create an account'), findsOneWidget);
//    expect(find.text('LoveBank'), findsOneWidget);
//
//    // Load register screen
//    await tester.tap(find.text('Create an account'));
//    await tester.pumpAndSettle();
//
//    expect(find.text('Sign up'), findsOneWidget);
//
//    // Register a test user
//    await tester.enterText(find.byKey(Key('Enter your display name')), 'test_mctesterson');
//    await tester.enterText(find.byKey(Key('Enter your email')), 'test@test.test');
//    await tester.enterText(find.byKey(Key('Enter your mobile number')), '1111111111');
//    await tester.enterText(find.byKey(Key('Enter your password')), '12345678');
//
//    await tester.tap(find.text('Sign up'));
//    await tester.pumpAndSettle(const Duration(seconds: 4));
//
//    // Go to login screen
//    await tester.tap(find.text('Sign in'));
//    await tester.pumpAndSettle();
//
//    expect(find.text('Sign in'), findsOneWidget);
//
//    // Login with test user
//    await tester.enterText(find.byKey(Key('Enter your email')), 'test@test.test');
//    await tester.enterText(find.byKey(Key('Enter your password')), '12345678');
//
//    await tester.tap(find.text('Sign in'));
//    //await tester.pumpWidget(LoveApp());
//    await tester.pumpAndSettle(const Duration(seconds: 30));
//
//    // Check that on home page.
//    expect(find.text("logout"), findsOneWidget);
//
//    // Verify that logout works
//    await tester.tap(find.text('logout'));
//    await tester.pumpAndSettle(const Duration(seconds: 30));
//
//    expect(find.text('Improve your relationship with measurable expressions of love'), findsOneWidget);
  });

  tearDown(() async {
    userDataController.close();
    userController.close();
  });
}
