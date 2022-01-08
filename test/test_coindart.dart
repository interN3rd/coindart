import 'package:coindart/screens/coindart.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:coindart/components/testing/mock.dart';

void main() {

  // setup ---------------------------------------------------------------------

  // before testing a firebase app we have to initialize a firebase app
  // since we don't want to rely on an actual online-only firebase instance,
  // we make use of a mock. Please see mock.dart
  setupFirebaseAuthMocks();
  setUpAll( () async {
    await Firebase.initializeApp();
  });

  // actual testing begins here ------------------------------------------------
  testWidgets( 'CoinDart has a title', (WidgetTester tester ) async {

    const Coindart authService = Coindart();

    await tester.pumpWidget( authService );
    await tester.idle();
    await tester.pump();

    final titleFinder = find.text( 'CoinDart - Your Next Bull\'s Eye Trade' );

    expect( titleFinder, findsOneWidget );
  });

  testWidgets( 'CoinDart has a welcome message', (WidgetTester tester ) async {

    const Coindart authService = Coindart();

    await tester.pumpWidget( authService );
    await tester.idle();
    await tester.pump();

    final messageFinder = find.text( "Welcome to CoinDart! We provide you every extra bit of information that helps you hitting Bull's Eye with your next trade." );

    expect( messageFinder, findsOneWidget );
  });

  testWidgets( 'CoinDart has a login button', (WidgetTester tester ) async {

    const Coindart authService = Coindart();

    await tester.pumpWidget( authService );
    await tester.idle();
    await tester.pump();

    final loginButtonFinder = find.byKey(const ValueKey("loginButton") );

    expect( loginButtonFinder, findsWidgets );
  });

  testWidgets( 'CoinDart has a login button', (WidgetTester tester ) async {

    const Coindart authService = Coindart();

    await tester.pumpWidget( authService );
    await tester.idle();
    await tester.pump();

    final loginButtonFinder = find.byKey(const ValueKey("registerButton") );

    expect( loginButtonFinder, findsWidgets );
  });

  testWidgets( 'CoinDart has a footer menu', (WidgetTester tester ) async {

    const Coindart authService = Coindart();

    await tester.pumpWidget( authService );
    await tester.idle();
    await tester.pump();

    final footerMenuFinder = find.byKey(const ValueKey("footer menu") );

    expect( footerMenuFinder, findsWidgets );
  });
}