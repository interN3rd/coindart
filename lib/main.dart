import 'package:coindart/screens/coindart.dart';
import "package:flutter/material.dart";
import 'package:firebase_core/firebase_core.dart';

void main() async {

  // Google reference: https://firebase.flutter.dev/docs/overview#initializing-flutterfire
  // actually working reference: https://github.com/FirebaseExtended/flutterfire/issues/3384
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( const Coindart() );

}
