import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:coindart/screens/coindart.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // CoinDart is to be used in mode 'portrait up' since we provide our users a couple of lists and charts that are best experienced in aforementioned mode
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then( (_) {
        runApp(const Coindart() );
      });
}
