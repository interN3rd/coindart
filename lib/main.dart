import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:coindart/screens/coindart.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp( const Coindart() );

}
