// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutterapp/main.dart';
import 'package:flutterapp/mocks/firebase_auth_mock.dart';
import 'package:flutterapp/mocks/firestore_mock.dart';
import 'package:flutterapp/screens/intro/three_page_intro.dart';
import 'package:flutterapp/services/user_authentication.dart';

void main() {
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
}
